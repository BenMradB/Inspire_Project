-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : ven. 19 août 2022 à 13:40
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
-- Base de données : `db`
--

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
(42, 7, 30, 5),
(43, 5, 30, 5),
(44, 6, 30, 5),
(45, 8, 30, 5),
(50, 9, 30, 5),
(51, 10, 30, 5),
(52, 5, 29, 5),
(53, 8, 29, 5),
(54, 9, 29, 5),
(55, 7, 29, 5),
(56, 9, 28, 5),
(57, 8, 28, 5),
(58, 10, 28, 5),
(59, 6, 28, 5);

-- --------------------------------------------------------

--
-- Structure de la table `formateur`
--

CREATE TABLE `formateur` (
  `id_formateur` int(11) NOT NULL,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `email` varchar(100) CHARACTER SET utf8 NOT NULL,
  `trainerName` varchar(255) NOT NULL,
  `phone` varchar(8) NOT NULL,
  `cin` varchar(8) NOT NULL,
  `birthday` date NOT NULL,
  `avatar` varchar(255) NOT NULL,
  `password` varchar(255) CHARACTER SET utf8 NOT NULL,
  `gender` char(1) CHARACTER SET utf8 NOT NULL,
  `role` varchar(100) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `formateur`
--

INSERT INTO `formateur` (`id_formateur`, `firstName`, `lastName`, `email`, `trainerName`, `phone`, `cin`, `birthday`, `avatar`, `password`, `gender`, `role`) VALUES
(5, 'BenMrad   ', 'Bilel', 'bolbolpubg2001@gmail.com', 'BenMrad Bilel', '50802634', '12345678', '2022-08-10', 'avatar-1660128907262.jpg', '$2a$10$cw9fF823EdkQ0CfElmv0/eRjvlnzHJKFyRaUu1HHUs6xedt9gncIy', 'M', 'trainer');

-- --------------------------------------------------------

--
-- Structure de la table `formation`
--

CREATE TABLE `formation` (
  `id_form` int(11) NOT NULL,
  `nom_form` varchar(255) NOT NULL,
  `courseSpecialization` varchar(100) CHARACTER SET utf8 NOT NULL,
  `thubmnail` varchar(255) NOT NULL,
  `nb_videos` int(11) NOT NULL,
  `duree` varchar(255) NOT NULL,
  `date_creation` date NOT NULL,
  `description` text NOT NULL,
  `id_formateur` int(11) NOT NULL,
  `prix` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `formation`
--

INSERT INTO `formation` (`id_form`, `nom_form`, `courseSpecialization`, `thubmnail`, `nb_videos`, `duree`, `date_creation`, `description`, `id_formateur`, `prix`) VALUES
(5, 'Full-Stack', 'Full Stack', 'thubmnail-1660213317430.jpg', 3, '01:30 m', '2022-08-06', 'Full Stack Course Learn And Become A great Full-Stack Developper', 5, 100),
(6, 'From Zero To Hero', 'Web Design', 'thubmnail-1660215806679.jpg', 0, '00:00', '2022-08-10', 'This Is A CSS3 Crash-Course', 5, 50),
(7, 'HTML5', 'HTML5', 'thubmnail-1660212728619.png', 0, '00:00', '2022-08-10', 'This Is A HTML5 Crash-Course', 5, 30),
(8, 'React.js', 'Reactjs', 'thubmnail-1660213243110.jpg', 1, '00:00', '2022-08-11', 'This is A React Crash Course With Bilel', 5, 50),
(9, 'JavaScript', 'Js', 'thubmnail-1660213735395.png', 1, '00:00', '2022-08-11', 'Learen Java Script From zero To Hero', 5, 80),
(10, 'NodeJs', 'Node.js', 'thubmnail-1660214713782.jpg', 1, '00:00', '2022-08-11', 'This Is A Backend Course : Node.js, express.js', 5, 300);

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
  `date` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
  `cin` char(8) CHARACTER SET utf8 NOT NULL,
  `gender` varchar(10) NOT NULL,
  `avatar` varchar(255) NOT NULL,
  `levelOfStudy` varchar(255) NOT NULL,
  `birthday` date DEFAULT NULL,
  `solde` int(11) NOT NULL,
  `password` text NOT NULL,
  `role` varchar(100) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `email`, `userName`, `firstName`, `lastName`, `phone`, `cin`, `gender`, `avatar`, `levelOfStudy`, `birthday`, `solde`, `password`, `role`) VALUES
(28, 'Yassine@gmail.com', 'BenJeddou Yassine', 'BenJeddou', 'Yassine', '50802634', '14406987', 'M', 'avatar-1660129016759.JPG', 'faculté  ', '2022-09-03', 520, '$2a$10$cAFqL4xfwQzRtcHygYFdqOMu22fD16Ybj3CTdWPGM6HXrWiw6kZJm', 'student'),
(29, 'Samar@gmail.com', 'BenMrad Samar', 'BenMrad ', 'Samar', '50802634', '14406987', 'M', 'avatar-1660129046941.jpg', 'faculté ', '2022-08-10', 2240, '$2a$10$3ao0AJxW86E6353TG.TfP.NZKgY6mUbUxY4NK6VqKaIYRpX..C.N.', 'student'),
(30, 'khorchef@gmail.com', 'Khrchef Saifeddine', 'Khorchef', 'Saifeddine', '12345678', '12345678', 'M', 'avatar-1660130278406.jpg', 'faculté', '2022-08-19', 6880, '$2a$10$0jNpQnc9dPauyoECooMaLe5AtXs7HgSl7DEfQy1meQupR/YnV1ww6', 'student');

-- --------------------------------------------------------

--
-- Structure de la table `videos`
--

CREATE TABLE `videos` (
  `video_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `trainer_id` int(11) NOT NULL,
  `creation` date NOT NULL,
  `video_URL` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `videos`
--

INSERT INTO `videos` (`video_id`, `course_id`, `trainer_id`, `creation`, `video_URL`) VALUES
(5, 9, 5, '2022-08-11', 'video_URL-1660213770792.mp4'),
(6, 8, 5, '2022-08-11', 'video_URL-1660213822957.mp4'),
(7, 10, 5, '2022-08-11', 'video_URL-1660214851932.mp4'),
(8, 5, 5, '2022-08-13', 'video_URL-1660408825497.mp4'),
(9, 5, 5, '2022-08-13', 'video_URL-1660408856197.mp4'),
(10, 5, 5, '2022-08-13', 'video_URL-1660408863548.mp4');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `bookmarks`
--
ALTER TABLE `bookmarks`
  ADD PRIMARY KEY (`id_bookmarks`),
  ADD KEY `id_etudiant` (`id_etudiant`),
  ADD KEY `id_formation` (`id_formation`);

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
  ADD KEY `enroulement_ibfk_3` (`id_format`);

--
-- Index pour la table `formateur`
--
ALTER TABLE `formateur`
  ADD PRIMARY KEY (`id_formateur`);

--
-- Index pour la table `formation`
--
ALTER TABLE `formation`
  ADD PRIMARY KEY (`id_form`),
  ADD KEY `formation_ibfk_1` (`id_formateur`);

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
  ADD PRIMARY KEY (`video_id`),
  ADD KEY `fk1` (`course_id`),
  ADD KEY `fk2` (`trainer_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `bookmarks`
--
ALTER TABLE `bookmarks`
  MODIFY `id_bookmarks` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `employee`
--
ALTER TABLE `employee`
  MODIFY `EmpID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT pour la table `enroulement`
--
ALTER TABLE `enroulement`
  MODIFY `id_enroulement` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT pour la table `formateur`
--
ALTER TABLE `formateur`
  MODIFY `id_formateur` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `formation`
--
ALTER TABLE `formation`
  MODIFY `id_form` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `message`
--
ALTER TABLE `message`
  MODIFY `id_message` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT pour la table `payement`
--
ALTER TABLE `payement`
  MODIFY `id_payement` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT pour la table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT pour la table `videos`
--
ALTER TABLE `videos`
  MODIFY `video_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

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
  ADD CONSTRAINT `enroulement_ibfk_2` FOREIGN KEY (`id_formation`) REFERENCES `formation` (`id_form`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `enroulement_ibfk_3` FOREIGN KEY (`id_format`) REFERENCES `formateur` (`id_formateur`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `formation`
--
ALTER TABLE `formation`
  ADD CONSTRAINT `formation_ibfk_1` FOREIGN KEY (`id_formateur`) REFERENCES `formateur` (`id_formateur`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `message`
--
ALTER TABLE `message`
  ADD CONSTRAINT `message_ibfk_1` FOREIGN KEY (`id_etudiant`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `message_ibfk_2` FOREIGN KEY (`id_formateur`) REFERENCES `formateur` (`id_formateur`);

--
-- Contraintes pour la table `payement`
--
ALTER TABLE `payement`
  ADD CONSTRAINT `payement_ibfk_1` FOREIGN KEY (`id_etudiant`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `videos`
--
ALTER TABLE `videos`
  ADD CONSTRAINT `fk1` FOREIGN KEY (`course_id`) REFERENCES `formation` (`id_form`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk2` FOREIGN KEY (`trainer_id`) REFERENCES `formateur` (`id_formateur`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
