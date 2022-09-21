-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mer. 21 sep. 2022 à 19:32
-- Version du serveur : 10.4.24-MariaDB
-- Version de PHP : 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `inspire`
--

-- --------------------------------------------------------

--
-- Structure de la table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(80) NOT NULL,
  `valid` varchar(7) NOT NULL,
  `phone` varchar(12) NOT NULL,
  `picture` text NOT NULL,
  `code` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `admin`
--

INSERT INTO `admin` (`id`, `name`, `email`, `password`, `valid`, `phone`, `picture`, `code`) VALUES
(1, 'Maouia', 'maaouia0@gmail.com', '$2b$14$q9dOJakTXhYGAXBTp2g/lefoy7mMRdd5zXS945/f.yzZ/4HyiTnwe', 'true', '54585464', '1663110962204download.jpg', ''),
(27, 'moya', 'maaouia550@gmail.com', '$2b$14$byaeFmcaEP7KnDpq6A4TYOQsmXeZPkBxhUnaNPJlw.to5UNqunWtK', 'true', '12345678', 'avatar.png', '2105841');

-- --------------------------------------------------------

--
-- Structure de la table `bookmarks`
--

CREATE TABLE `bookmarks` (
  `id_bookmarks` int(11) NOT NULL,
  `id_etudiant` int(11) NOT NULL,
  `id_formation` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

CREATE TABLE `categories` (
  `category_name` varchar(200) COLLATE utf8_bin NOT NULL,
  `id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Déchargement des données de la table `categories`
--

INSERT INTO `categories` (`category_name`, `id`) VALUES
('Web Development ', 1),
('tyuziuaze', 2),
('test', 3);

-- --------------------------------------------------------

--
-- Structure de la table `employee`
--

CREATE TABLE `employee` (
  `EmpID` int(11) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `EmpCode` varchar(50) NOT NULL,
  `Salary` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `employee`
--

INSERT INTO `employee` (`EmpID`, `Name`, `EmpCode`, `Salary`) VALUES
(11, 'abcd', '1234475', 'grergerg');

-- --------------------------------------------------------

--
-- Structure de la table `enroulement`
--

CREATE TABLE `enroulement` (
  `id_enroulement` int(11) NOT NULL,
  `id_formation` int(11) NOT NULL,
  `id_etudiant` int(11) NOT NULL,
  `id_format` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `enroulement`
--

INSERT INTO `enroulement` (`id_enroulement`, `id_formation`, `id_etudiant`, `id_format`) VALUES
(2, 26, 22, 10);

-- --------------------------------------------------------

--
-- Structure de la table `formateur`
--

CREATE TABLE `formateur` (
  `id_formateur` int(11) NOT NULL,
  `firstName` varchar(100) CHARACTER SET utf8 NOT NULL,
  `lastName` varchar(100) CHARACTER SET utf8 NOT NULL,
  `trainerName` varchar(255) NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `gender` varchar(10) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `cin` varchar(8) NOT NULL,
  `birthday` date NOT NULL,
  `avatar` varchar(255) NOT NULL,
  `role` varchar(100) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `formateur`
--

INSERT INTO `formateur` (`id_formateur`, `firstName`, `lastName`, `trainerName`, `email`, `gender`, `password`, `phone`, `cin`, `birthday`, `avatar`, `role`) VALUES
(10, 'BenMrad ', 'Bilel', 'BenMrad Bilel', 'BenMrad@gmail.com', 'F', '$2a$10$nVY6yV6BgEJeBywzOHZKHuGJdiN.SbAap4KPtlT7FtSskLcdKclja', '12345678', '12345678', '0000-00-00', 'avatar-1663774797604.jpg', 'trainer');

-- --------------------------------------------------------

--
-- Structure de la table `formation`
--

CREATE TABLE `formation` (
  `id_form` int(11) NOT NULL,
  `nom_form` varchar(255) NOT NULL,
  `thubmnail` varchar(255) NOT NULL,
  `nb_videos` int(11) NOT NULL,
  `duree` varchar(255) NOT NULL,
  `date_creation` text NOT NULL,
  `description` text NOT NULL,
  `id_formateur` int(11) NOT NULL,
  `prix` double NOT NULL,
  `courseSpecialization` varchar(200) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `formation`
--

INSERT INTO `formation` (`id_form`, `nom_form`, `thubmnail`, `nb_videos`, `duree`, `date_creation`, `description`, `id_formateur`, `prix`, `courseSpecialization`) VALUES
(26, 'JavaScript', 'thubmnail-1663774632535.png', 3, '00:00', '2022-09-21', 'From Zero To Hero', 10, 300, 'Js');

-- --------------------------------------------------------

--
-- Structure de la table `message`
--

CREATE TABLE `message` (
  `id_message` int(11) NOT NULL,
  `id_etudiant` int(11) NOT NULL,
  `id_formateur` int(11) NOT NULL,
  `contenu` text NOT NULL,
  `whosTheSender` int(11) NOT NULL,
  `time` varchar(100) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `payement`
--

CREATE TABLE `payement` (
  `id_payement` int(11) NOT NULL,
  `code_payement` varchar(255) NOT NULL,
  `somme` double NOT NULL,
  `commentaire` text NOT NULL,
  `photo_payement` varchar(255) NOT NULL,
  `etat` varchar(255) NOT NULL,
  `id_etudiant` int(11) NOT NULL,
  `date` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `payement`
--

INSERT INTO `payement` (`id_payement`, `code_payement`, `somme`, `commentaire`, `photo_payement`, `etat`, `id_etudiant`, `date`) VALUES
(1, 'fff2264412', 50, 'ergrgrgerrgget', 'fdfdbfdbfbf.jpg', 'accepted', 19, '2022-08-17'),
(2, 'hgjhgh5522', 60, 'tyjjtukukukuk', 'uutjutujt.jpg', 'rejected', 19, '2022-08-16'),
(3, 'thhtht21032', 20, 'ryhyttyjytj', 'ytyjtyjyt.jpg', 'rejected', 19, '2022-08-09'),
(10, 'dgdggdg523', 60, 'rrrrrrrrrrrrrr', 'img1.jpg', 'accepted', 19, '2022-08-02'),
(12, 'dgdggdg523', 70, 'hnhngngnhg', 'photo_payement-1659632613146.jpeg', 'pending', 19, '2022-08-02'),
(13, 'dgdggdg523', 74, 'dfvdbgbgdbgb', 'photo_payement-1659632736928.jpeg', 'pending', 19, '2022-08-02'),
(18, 'dgdggdg523', 786, 'tttttrhthth', 'photo_payement-1659633444185.jpeg', 'pending', 19, '2022-08-04'),
(22, 'dgdggdg523', 70, 'ttttt', 'photo_payement-1659635410251.jpeg', 'pending', 19, '2022-08-04'),
(23, 'dgdggdg523', 5423, 'tttttt', 'photo_payement-1659635439318.jpeg', 'pending', 19, '2022-08-04'),
(24, 'dgdggdg523', 600, 'ggggggggggggggggggg', 'photo_payement-1659635484680.jpeg', 'rejected', 19, '2022-08-04'),
(25, 'dgdggdg523', 60, 'par poste', 'photo_payement-1659690275211.jpeg', 'rejected', 19, '2022-08-05');

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `userName` varchar(255) NOT NULL,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `phone` varchar(8) DEFAULT NULL,
  `gender` varchar(10) NOT NULL,
  `avatar` varchar(255) NOT NULL,
  `levelOfStudy` varchar(255) NOT NULL,
  `solde` int(11) NOT NULL,
  `password` text NOT NULL,
  `role` varchar(100) CHARACTER SET utf8 NOT NULL,
  `birthday` date NOT NULL,
  `cin` char(8) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `email`, `userName`, `firstName`, `lastName`, `phone`, `gender`, `avatar`, `levelOfStudy`, `solde`, `password`, `role`, `birthday`, `cin`) VALUES
(22, 'Bilel@gmail.com', 'BenMrad Bilel', 'BenMrad', 'Bilel', '12345678', 'M', '', 'faculté', 700, '$2a$10$C9kwhs2g9eGquSMQE56APOw.rQrZbJsIOb8hRFfePDkhAo3I0kDou', 'student', '2022-09-07', '12345678');

-- --------------------------------------------------------

--
-- Structure de la table `videos`
--

CREATE TABLE `videos` (
  `id_video` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `creation` date NOT NULL,
  `video_URL` varchar(255) NOT NULL,
  `trainer_id` int(11) NOT NULL,
  `videoRank` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `videos`
--

INSERT INTO `videos` (`id_video`, `course_id`, `creation`, `video_URL`, `trainer_id`, `videoRank`) VALUES
(10, 26, '2022-09-21', 'video_URL-1663776489951.mp4', 10, 1),
(11, 26, '2022-09-21', 'video_URL-1663776496544.mp4', 10, 2),
(16, 26, '2022-09-21', 'video_URL-1663777312184.mp4', 10, 3);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone` (`phone`);

--
-- Index pour la table `bookmarks`
--
ALTER TABLE `bookmarks`
  ADD PRIMARY KEY (`id_bookmarks`),
  ADD KEY `id_etudiant` (`id_etudiant`),
  ADD KEY `id_formation` (`id_formation`);

--
-- Index pour la table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `category_name` (`category_name`);

--
-- Index pour la table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`EmpID`);

--
-- Index pour la table `enroulement`
--
ALTER TABLE `enroulement`
  ADD PRIMARY KEY (`id_enroulement`),
  ADD KEY `id_etudiant` (`id_etudiant`),
  ADD KEY `id_formation` (`id_formation`),
  ADD KEY `id_format` (`id_format`);

--
-- Index pour la table `formateur`
--
ALTER TABLE `formateur`
  ADD PRIMARY KEY (`id_formateur`),
  ADD UNIQUE KEY `email_formateur` (`email`),
  ADD UNIQUE KEY `phone_formateur` (`phone`);

--
-- Index pour la table `formation`
--
ALTER TABLE `formation`
  ADD PRIMARY KEY (`id_form`);

--
-- Index pour la table `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`id_message`),
  ADD KEY `id_etudiant` (`id_etudiant`),
  ADD KEY `id_formateur` (`id_formateur`);

--
-- Index pour la table `payement`
--
ALTER TABLE `payement`
  ADD PRIMARY KEY (`id_payement`),
  ADD KEY `payement_ibfk_1` (`id_etudiant`);

--
-- Index pour la table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `videos`
--
ALTER TABLE `videos`
  ADD PRIMARY KEY (`id_video`),
  ADD UNIQUE KEY `videoRank` (`videoRank`),
  ADD KEY `fk` (`course_id`),
  ADD KEY `FK_2` (`trainer_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT pour la table `bookmarks`
--
ALTER TABLE `bookmarks`
  MODIFY `id_bookmarks` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `employee`
--
ALTER TABLE `employee`
  MODIFY `EmpID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT pour la table `enroulement`
--
ALTER TABLE `enroulement`
  MODIFY `id_enroulement` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `formateur`
--
ALTER TABLE `formateur`
  MODIFY `id_formateur` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `formation`
--
ALTER TABLE `formation`
  MODIFY `id_form` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT pour la table `message`
--
ALTER TABLE `message`
  MODIFY `id_message` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT pour la table `videos`
--
ALTER TABLE `videos`
  MODIFY `id_video` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `bookmarks`
--
ALTER TABLE `bookmarks`
  ADD CONSTRAINT `bookmarks_ibfk_1` FOREIGN KEY (`id_etudiant`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `bookmarks_ibfk_2` FOREIGN KEY (`id_formation`) REFERENCES `formation` (`id_form`);

--
-- Contraintes pour la table `enroulement`
--
ALTER TABLE `enroulement`
  ADD CONSTRAINT `enroulement_ibfk_1` FOREIGN KEY (`id_etudiant`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `enroulement_ibfk_2` FOREIGN KEY (`id_formation`) REFERENCES `formation` (`id_form`),
  ADD CONSTRAINT `enroulement_ibfk_3` FOREIGN KEY (`id_format`) REFERENCES `formateur` (`id_formateur`);

--
-- Contraintes pour la table `videos`
--
ALTER TABLE `videos`
  ADD CONSTRAINT `FK_2` FOREIGN KEY (`trainer_id`) REFERENCES `formateur` (`id_formateur`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk` FOREIGN KEY (`course_id`) REFERENCES `formation` (`id_form`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
