const express = require("express");
const bcrypt = require("bcrypt");
const mysql = require("mysql");
const jwt = require("jsonwebtoken");
const cookieParser = require("cookie-parser");
const cors = require("cors");

const app = express();
app.use(express.json());
app.use(cookieParser());
app.use(cors());

const connection = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "root",
  database: "LSPD",
  port: 8889,
});

connection.connect((err) => {
  if (err) {
    console.error("Erreur de connexion à la base de données:", err);
    return;
  }
  console.log("\n\nConnexion à la base de données établie avec succès");
});

app.post("/api/login", (req, res) => {
  const { matricule, password } = req.body;
  console.log("\n\nTentative de connexion avec le matricule :", matricule);

  connection.query(
    "SELECT * FROM lspd_utilisateurs_connexion as lspd_sign JOIN lspd_utilisateurs ON lspd_sign.matricule = lspd_utilisateurs.matricule WHERE lspd_sign.matricule = ?",
    [matricule],
    (error, results) => {
      if (error) {
        console.error("Erreur lors de la requête SQL :", error);
        return res.status(500).json({ message: "Erreur du serveur" });
      }

      if (results.length === 0) {
        console.log(
          "\n\nAucun utilisateur trouvé avec le matricule :",
          matricule
        );
        return res.status(401).json({ message: "Identifiants incorrects" });
      }

      const user = results[0];
      bcrypt.compare(password, user.mot_de_passe_hash, (err, result) => {
        if (err) {
          console.error(
            "Erreur lors de la comparaison des mots de passe :",
            err
          );
          return res.status(500).json({ message: "Erreur du serveur" });
        }

        if (!result) {
          console.log(
            "\n\nMot de passe incorrect pour le matricule :",
            matricule
          );
          return res.status(401).json({ message: "Identifiants incorrects" });
        }

        console.log("\n\nConnexion réussie pour le matricule :", matricule);
        const payload = { matricule: user.matricule, prenom: user.prenom };
        const token = jwt.sign(payload, "43BmN!{uA#vT}rE9Q)dZ5wS7tP*y", {
          expiresIn: "1h",
        });

        res.json({ message: "Connexion réussie", token });
      });
    }
  );
});
app.post("/api/logout", (req, res) => {
  res
    .clearCookie("token")
    .json({ message: "Utilisateur déconnecté avec succès" });
});
app.get("/api/users", (req, res) => {
  connection.query("SELECT * FROM lspd_utilisateurs", (error, results) => {
    if (error) {
      console.error("Erreur lors de la requête SQL :", error);
      return res.status(500).json({ message: "Erreur du serveur" });
    }

    res.json(results);
  });
});
app.get("/api/actualite", (req, res) => {
  connection.query("SELECT * FROM lspd_actualite", (error, results) => {
    if (error) {
      console.error("Erreur lors de la requête SQL :", error);
      return res.status(500).json({ message: "Erreur du serveur" });
    }

    res.json(results);
  });
});

app.get("/api/suspect", (req, res) => {
  connection.query(
    "SELECT * FROM lspd_individu_recherche",
    (error, results) => {
      if (error) {
        console.error("Erreur lors de la requête SQL :", error);
        return res.status(500).json({ message: "Erreur du serveur" });
      }

      res.json(results);
    }
  );
});
const verifyToken = (req, res, next) => {
  const token = req.headers.authorization;

  if (!token) {
    return res.status(401).json({ message: "Token non fourni" });
  }

  jwt.verify(
    token.split(" ")[1],
    "43BmN!{uA#vT}rE9Q)dZ5wS7tP*y",
    (err, decoded) => {
      if (err) {
        return res.status(401).json({ message: "Token non valide" });
      }
      req.user = decoded;
      next();
    }
  );
};
app.get("/api/user", verifyToken, (req, res) => {
  const user = req.user; // L'utilisateur authentifié est disponible dans req.user
  connection.query(
    "SELECT lu.matricule,lu.logo, lu.prenom, lu.nom, lug.lib_grade, luen.id as enService  FROM lspd_utilisateurs lu JOIN lspd_utilisateurs_grades lug ON lug.id = lu.id_grade left join lspd_utilisateurs_en_service luen ON luen.matricule = lu.matricule WHERE lu.matricule = ?",
    [user.matricule],
    (error, results) => {
      if (error) {
        console.error("Erreur lors de la requête SQL :", error);
        return res.status(500).json({ message: "Erreur du serveur" });
      }

      res.json(results);
    }
  );
});
app.get("/api/en_service", (req, res) => {
  connection.query(
    "SELECT lspd_es.*, lspd_utilisateurs_grades.code_grade, lspd_utilisateurs.prenom, lspd_utilisateurs.nom, lspd_es.status FROM lspd_utilisateurs_en_service as lspd_es JOIN  lspd_utilisateurs ON lspd_es.matricule = lspd_utilisateurs.matricule JOIN lspd_utilisateurs_grades ON lspd_utilisateurs_grades.id = lspd_utilisateurs.id_grade ORDER BY lspd_utilisateurs_grades.id ASC",
    (error, results) => {
      if (error) {
        console.error("Erreur lors de la requête SQL :", error);
        return res.status(500).json({ message: "Erreur du serveur" });
      }

      res.json(results);
    }
  );
});
app.delete("/api/delete-user-service/:matricule", (req, res) => {
  const matricule = req.params.matricule;

  connection.query(
    "DELETE FROM lspd_utilisateurs_en_service WHERE matricule = ?",
    [matricule],
    (error, results) => {
      if (error) {
        console.error("Erreur lors de la requête SQL :", error);
        return res.status(500).json({ message: "Erreur du serveur" });
      }

      if (results.affectedRows === 0) {
        return res
          .status(404)
          .json({ message: "Aucun enregistrement trouvé avec ce matricule" });
      }

      res.json({ message: "L'enregistrement a été supprimé avec succès" });
    }
  );
});
app.post("/api/add-agent-in-service/:matricule", (req, res) => {
  const matricule = req.params.matricule;

  connection.query(
    "INSERT INTO lspd_utilisateurs_en_service (matricule) VALUES (?)",
    [matricule],
    (error, results) => {
      if (error) {
        console.error("Erreur lors de l'ajout de l'agent en service :", error);
        return res.status(500).json({ message: "Erreur du serveur" });
      }
      res.json({ message: "Agent ajouté en service avec succès" });
    }
  );
});
app.get("/api/notification/:matricule", (req, res) => {
  const matricule = req.params.matricule;

  connection.query(
    "SELECT * FROM lspd_utilisateurs_notification WHERE matricule = ? and lu != 1",
    [matricule],
    (error, results) => {
      if (error) {
        console.error("Erreur lors de la requête SQL :", error);
        return res.status(500).json({ message: "Erreur du serveur" });
      }
      res.json(results);
    }
  );
});

app.put("/api/clear-notification/:idNotification", (req, res) => {
  const idNotification = req.params.idNotification;

  connection.query(
    "UPDATE lspd_utilisateurs_notification SET lu = 1 WHERE id = ?",
    [idNotification],
    (error, results) => {
      if (error) {
        console.error("Erreur lors de la requête SQL :", error);
        return res.status(500).json({ message: "Erreur du serveur" });
      }
      res.json(results);
    }
  );
});
app.get("/api/code_radio", (req, res) => {
  connection.query("SELECT * FROM lspd_code_radio", (error, results) => {
    if (error) {
      console.error("Erreur lors de la requête SQL :", error);
      return res.status(500).json({ message: "Erreur du serveur" });
    }
    res.json(results);
  });
});

const PORT = process.env.PORT || 9000;
app.listen(PORT, () => console.log(`Serveur démarré sur le port ${PORT}`));
