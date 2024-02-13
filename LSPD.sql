-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:8889
-- Généré le : mar. 13 fév. 2024 à 17:09
-- Version du serveur : 5.7.39
-- Version de PHP : 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `LSPD`
--

-- --------------------------------------------------------

--
-- Structure de la table `lspd_actualite`
--

CREATE TABLE `lspd_actualite` (
  `id` int(11) NOT NULL,
  `date_heure` datetime NOT NULL,
  `photo` varchar(500) NOT NULL,
  `titre` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `lspd_actualite`
--

INSERT INTO `lspd_actualite` (`id`, `date_heure`, `photo`, `titre`) VALUES
(1, '2024-02-12 14:14:54', 'https://media.discordapp.net/attachments/1159207143837278347/1201278281085894847/Capture_decran_2024-01-28_221543.png?ex=65dbb194&is=65c93c94&hm=54babe710d1fa8d3af5b45efb9cd7afaea58228d1c5ca6de9eda231f2e5bbf7d&=&format=webp&quality=lossless&width=1854&height=1064', 'Photo de famille\r\n'),
(2, '2024-02-12 14:15:15', 'https://media.discordapp.net/attachments/1159207008185094154/1203836482041679872/image.png?ex=65dbc597&is=65c95097&hm=e57c011ae4da32a6d9fdc4d9e236d8fd147892b4292b0c99cfe2eafad7ee049b&=&format=webp&quality=lossless&width=1476&height=1064', 'Résumé dispatch du 11/02/24');

-- --------------------------------------------------------

--
-- Structure de la table `lspd_code_radio`
--

CREATE TABLE `lspd_code_radio` (
  `id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL,
  `libelle` varchar(250) NOT NULL,
  `importance` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `lspd_code_radio`
--

INSERT INTO `lspd_code_radio` (`id`, `code`, `libelle`, `importance`) VALUES
(1, '10-01', 'Pause de service', 0),
(2, '10-3', 'Fin Transmission/ Chgmt Canal', 0),
(3, '10-4', 'Bien reçu', 1),
(4, '10-5', 'A relayer', 0),
(5, '10-6', 'Agent Occupé mais à l\'écoute', 0),
(6, '10-7', 'Fin de service', 0),
(7, '10-8', 'Reprise du service', 0),
(8, '10-9', 'Répéter le dernier message', 1),
(9, '10-10', 'Négatif', 1),
(10, '10-11', 'Parlez plus lentement', 0),
(11, '10-12', 'Présence de visiteurs / Standby', 1),
(12, '10-14', 'Escorte / convoi', 1),
(13, '10-15', 'Désignation d\'un suspect', 1),
(14, '10-16', 'Coupure de la Radio', 1),
(15, '10-17', 'Récupérer un Supect/Documents', 0),
(16, '10-18', 'Urgent', 1),
(17, '10-19', 'En route vers le poste de police', 1),
(18, '10-20', 'Position/Localisation', 1),
(19, '10-21', 'Contacter par téléphone', 0),
(20, '10-22', 'Annulation du dernier call radio', 0),
(21, '10-23', 'Arrivé sur les lieux', 1),
(22, '10-24', 'Demande de Renfort', 1),
(23, '10-30', 'Refus d\'Obtempérer / Délit de Fuite', 0),
(24, '10-31', 'Crime en cours', 0),
(25, '10-32', 'Individu recherché', 0),
(26, '10-37', 'Fouille d\'un Véhicule suspect', 0),
(27, '10-41', 'Début de la Patrouille', 1),
(28, '10-42', 'Fin de la Patrouille', 1),
(29, '10-43', 'Demande d’informations (SITREP)', 1),
(30, '10-46', 'Besoin d\'une unité Mary', 0),
(31, '10-48', 'Début d\'un contrôle', 1),
(32, '10-50', 'Accident de la circulation', 1),
(33, '10-51', 'Demande dépanneuse', 1),
(34, '10-52', 'Demande ambulance', 1),
(35, '10-53', 'Route bloquée', 0),
(36, '10-60', 'En attente de Dispatch', 1),
(37, '10-73', 'Vente de Stupéfiants', 1),
(38, '10-74', 'Vol en cours', 0),
(39, '10-75', 'Shot Fire / Coup de feu', 0),
(40, '10-76', 'En route vers ..', 1),
(41, '10-77', 'Agent à terre', 0),
(42, '10-80', 'Course poursuite en cours', 1),
(43, '10-90', 'Braquage de banque / bijouterie', 1),
(44, '10-91', 'Braquage de supérette/ATM', 1),
(45, '10-93', 'Etablir un barrage', 0),
(46, '10-97', 'Cas tactique (nécessite une unité DAVID)', 0),
(47, '10-98', 'Evasion de prison / Code 9', 0),
(48, '10-99', 'Appel d’urgence à toutes les unités / Code 99', 1),
(49, '11-8', 'Civil à terre', 0),
(50, 'ETA', 'Estimated Arrival Time : Temps avant arrivée', 1);

-- --------------------------------------------------------

--
-- Structure de la table `lspd_individu_recherche`
--

CREATE TABLE `lspd_individu_recherche` (
  `id` int(11) NOT NULL,
  `photo` varchar(250) NOT NULL,
  `prenom` varchar(250) NOT NULL,
  `nom` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `lspd_individu_recherche`
--

INSERT INTO `lspd_individu_recherche` (`id`, `photo`, `prenom`, `nom`) VALUES
(1, 'https://cdn.discordapp.com/attachments/1159207187332202627/1167534501900067028/NA.png?ex=65d8e7bc&is=65c672bc&hm=c4e8de7424132dd79e5018b9283fe6a41470f51845a9fb18945187ef7c45d312&', 'Mechant', '1'),
(2, 'https://cdn.discordapp.com/attachments/1159207187332202627/1167534428352950393/01.png?ex=65d8e7ab&is=65c672ab&hm=2c28ff079e346bf07f033d9c6cf413d4763fa469b3a8a7bb5ec117a87f4fd32a&', 'Mechant', '2');

-- --------------------------------------------------------

--
-- Structure de la table `lspd_utilisateurs`
--

CREATE TABLE `lspd_utilisateurs` (
  `id` int(11) NOT NULL,
  `logo` varchar(500) NOT NULL,
  `id_grade` int(11) NOT NULL,
  `prenom` varchar(255) NOT NULL,
  `nom` varchar(255) NOT NULL,
  `matricule` varchar(50) NOT NULL,
  `numero_telephone` varchar(20) DEFAULT NULL,
  `date_arrivee` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `lspd_utilisateurs`
--

INSERT INTO `lspd_utilisateurs` (`id`, `logo`, `id_grade`, `prenom`, `nom`, `matricule`, `numero_telephone`, `date_arrivee`) VALUES
(1, 'https://cdn.discordapp.com/attachments/1187370101280866404/1205595119617839124/file.webp?ex=65d8f0f3&is=65c67bf3&hm=e195eb23ebe5efebd145f4f58eb26677282255d8f4d3124cd5d827a6e7af6732&', 16, 'John', 'Kinsley', '75', '1234', '2024-01-31'),
(2, '', 12, 'Eros', 'Mondero', '10', '123', '2024-02-08'),
(3, '', 14, 'Mike', 'Davis', '62', '123', '2024-02-08'),
(4, 'https://cdn.discordapp.com/attachments/1159207187332202627/1167534501900067028/NA.png?ex=65d8e7bc&is=65c672bc&hm=c4e8de7424132dd79e5018b9283fe6a41470f51845a9fb18945187ef7c45d312&', 4, 'Lawson', 'Richardson', '45', NULL, '2024-02-09');

-- --------------------------------------------------------

--
-- Structure de la table `lspd_utilisateurs_connexion`
--

CREATE TABLE `lspd_utilisateurs_connexion` (
  `id` int(11) NOT NULL,
  `matricule` varchar(50) NOT NULL,
  `mot_de_passe_hash` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `lspd_utilisateurs_connexion`
--

INSERT INTO `lspd_utilisateurs_connexion` (`id`, `matricule`, `mot_de_passe_hash`) VALUES
(1, '75', '$2b$10$ACkKQ08ST4A8xTUnP4QXMeRNpSpcUbFKe15mSb7MFxOqPu5Iad5j.'),
(2, '62', '$2b$10$ACkKQ08ST4A8xTUnP4QXMeRNpSpcUbFKe15mSb7MFxOqPu5Iad5j.'),
(3, '45', '$2b$10$ACkKQ08ST4A8xTUnP4QXMeRNpSpcUbFKe15mSb7MFxOqPu5Iad5j.');

-- --------------------------------------------------------

--
-- Structure de la table `lspd_utilisateurs_en_service`
--

CREATE TABLE `lspd_utilisateurs_en_service` (
  `id` int(11) NOT NULL,
  `matricule` varchar(255) DEFAULT NULL,
  `status` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `lspd_utilisateurs_en_service`
--

INSERT INTO `lspd_utilisateurs_en_service` (`id`, `matricule`, `status`) VALUES
(57, 'undefined', NULL),
(62, '75', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `lspd_utilisateurs_grades`
--

CREATE TABLE `lspd_utilisateurs_grades` (
  `id` int(11) NOT NULL,
  `code_grade` varchar(20) NOT NULL,
  `lib_grade` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `lspd_utilisateurs_grades`
--

INSERT INTO `lspd_utilisateurs_grades` (`id`, `code_grade`, `lib_grade`) VALUES
(1, 'CHI', 'Chief'),
(2, 'ACH', 'Assistant-Chief'),
(3, 'DCH', 'Deputy-Chief'),
(4, 'CMD', 'Commander'),
(5, 'CPT', 'Captain'),
(6, 'LTN I', 'Lieutenant'),
(7, 'SGT II', 'Sergeant II\n'),
(8, 'SGT I', 'Sergeant I'),
(9, 'DET III', 'Detective III'),
(10, 'DET II', 'Detective II'),
(11, 'DET I', 'Detective I'),
(12, 'SLO', 'Senior Lead Officer'),
(13, 'OFF III', 'Police Officer III'),
(14, 'OFF II', 'Police Officer II'),
(15, 'OFF I', 'Police Officer - Rookie '),
(16, 'CDT', 'Cadet');

-- --------------------------------------------------------

--
-- Structure de la table `lspd_utilisateurs_notification`
--

CREATE TABLE `lspd_utilisateurs_notification` (
  `id` int(11) NOT NULL,
  `matricule` int(11) NOT NULL,
  `titre` varchar(250) NOT NULL,
  `message` varchar(250) NOT NULL,
  `lu` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `lspd_utilisateurs_perms`
--

CREATE TABLE `lspd_utilisateurs_perms` (
  `id` int(11) NOT NULL,
  `nom_droit` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `lspd_actualite`
--
ALTER TABLE `lspd_actualite`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `lspd_code_radio`
--
ALTER TABLE `lspd_code_radio`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `lspd_individu_recherche`
--
ALTER TABLE `lspd_individu_recherche`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `lspd_utilisateurs`
--
ALTER TABLE `lspd_utilisateurs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `matricule` (`matricule`);

--
-- Index pour la table `lspd_utilisateurs_connexion`
--
ALTER TABLE `lspd_utilisateurs_connexion`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `matricule` (`matricule`);

--
-- Index pour la table `lspd_utilisateurs_en_service`
--
ALTER TABLE `lspd_utilisateurs_en_service`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `matricule` (`matricule`);

--
-- Index pour la table `lspd_utilisateurs_grades`
--
ALTER TABLE `lspd_utilisateurs_grades`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `lspd_utilisateurs_notification`
--
ALTER TABLE `lspd_utilisateurs_notification`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `lspd_utilisateurs_perms`
--
ALTER TABLE `lspd_utilisateurs_perms`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nom_droit` (`nom_droit`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `lspd_actualite`
--
ALTER TABLE `lspd_actualite`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `lspd_code_radio`
--
ALTER TABLE `lspd_code_radio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT pour la table `lspd_individu_recherche`
--
ALTER TABLE `lspd_individu_recherche`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `lspd_utilisateurs`
--
ALTER TABLE `lspd_utilisateurs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `lspd_utilisateurs_connexion`
--
ALTER TABLE `lspd_utilisateurs_connexion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `lspd_utilisateurs_en_service`
--
ALTER TABLE `lspd_utilisateurs_en_service`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT pour la table `lspd_utilisateurs_grades`
--
ALTER TABLE `lspd_utilisateurs_grades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT pour la table `lspd_utilisateurs_notification`
--
ALTER TABLE `lspd_utilisateurs_notification`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `lspd_utilisateurs_perms`
--
ALTER TABLE `lspd_utilisateurs_perms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
