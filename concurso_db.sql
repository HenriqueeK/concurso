-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 23/03/2026 às 12:56
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `concurso_db`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `candidatas`
--

CREATE TABLE `candidatas` (
  `codcandidatas` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `empresa` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Candidatas do concurso';

--
-- Despejando dados para a tabela `candidatas`
--

INSERT INTO `candidatas` (`codcandidatas`, `nome`, `empresa`) VALUES
(1, 'Alice Inês Fischer', 'Espaço Afrodite'),
(2, 'Dienifer Maciel', 'Francine Berté Pilates'),
(4, 'Djenifer Kamili Hatmann', 'Kondor Turismo'),
(5, 'Emili Taíssa Angnes', 'Autoelétrica Clarear'),
(6, 'Emilyn Dandara Petry', 'Edufut'),
(7, 'Gabriele Taís Alves', 'Gosto Colonial'),
(8, 'Isadora Immich', 'Invita Soluções Imobiliárias'),
(9, 'Jenifer Sandrine Rodrigues', 'Reference Centro Profissional'),
(10, 'Milena Schulz', 'Construtora MGS Ltda'),
(11, 'Mônica Zanotteli', 'CC Esquadrias Ltda'),
(12, 'Paola Cristine Gomes', 'Pizzaria Pervincas'),
(13, 'Rafaela Scherer', 'D\'casa Móveis'),
(14, 'Sabrina Ohlweiler Gottselig', 'Ass. Moradores RS - 413');

-- --------------------------------------------------------

--
-- Estrutura para tabela `jurados`
--

CREATE TABLE `jurados` (
  `codjurados` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `senha` varchar(255) NOT NULL COMMENT 'Em produção usar password_hash()',
  `is_admin` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0=jurado, 1=admin'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Jurados e administradores do concurso';

--
-- Despejando dados para a tabela `jurados`
--

INSERT INTO `jurados` (`codjurados`, `nome`, `senha`, `is_admin`) VALUES
(1, 'Ana Paula Quinot', 'Ana1234', 0),
(2, 'Daniel Sechi', 'Daniel1234', 0),
(3, 'Dionei Soares', 'Dionei1234', 0),
(4, 'Jamile Sehn', 'Jamile1234', 0),
(5, 'Luiza de Azeredo', 'Luiza1234', 0),
(6, 'admin', 'admin2025', 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `log_atividades`
--

CREATE TABLE `log_atividades` (
  `id` int(11) UNSIGNED NOT NULL,
  `jurado_id` int(11) NOT NULL,
  `candidata_id` int(11) NOT NULL,
  `acao` enum('inseriu','atualizou','parcial','teorica_lancada') NOT NULL,
  `notas_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Snapshot das notas salvas' CHECK (json_valid(`notas_json`)),
  `ip` varchar(45) DEFAULT NULL COMMENT 'IP do dispositivo',
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Histórico de todas as ações dos jurados';

--
-- Despejando dados para a tabela `log_atividades`
--

INSERT INTO `log_atividades` (`id`, `jurado_id`, `candidata_id`, `acao`, `notas_json`, `ip`, `created_at`) VALUES
(1, 6, 11, 'teorica_lancada', '{\"nota1_teorica\":10}', '192.168.88.230', '2026-03-12 13:38:05'),
(2, 6, 8, 'teorica_lancada', '{\"nota1_teorica\":10}', '192.168.88.230', '2026-03-12 13:38:17'),
(3, 6, 9, 'teorica_lancada', '{\"nota1_teorica\":9}', '192.168.88.230', '2026-03-12 13:38:41'),
(4, 6, 14, 'teorica_lancada', '{\"nota1_teorica\":10}', '192.168.88.230', '2026-03-12 13:39:10'),
(5, 6, 6, 'teorica_lancada', '{\"nota1_teorica\":10}', '192.168.88.230', '2026-03-12 13:39:24'),
(6, 6, 1, 'teorica_lancada', '{\"nota1_teorica\":9}', '192.168.88.230', '2026-03-12 13:39:45'),
(7, 6, 12, 'teorica_lancada', '{\"nota1_teorica\":10}', '192.168.88.230', '2026-03-12 13:40:00'),
(8, 6, 13, 'teorica_lancada', '{\"nota1_teorica\":10}', '192.168.88.230', '2026-03-12 13:40:13'),
(9, 6, 10, 'teorica_lancada', '{\"nota1_teorica\":9}', '192.168.88.230', '2026-03-12 13:40:36'),
(10, 6, 4, 'teorica_lancada', '{\"nota1_teorica\":9}', '192.168.88.230', '2026-03-12 13:41:07'),
(11, 6, 5, 'teorica_lancada', '{\"nota1_teorica\":10}', '192.168.88.230', '2026-03-12 13:41:19'),
(12, 6, 7, 'teorica_lancada', '{\"nota1_teorica\":9}', '192.168.88.230', '2026-03-12 13:41:38'),
(13, 6, 2, 'teorica_lancada', '{\"nota1_teorica\":9}', '192.168.88.230', '2026-03-12 13:41:53'),
(14, 5, 1, 'atualizou', '{\"nota2_video\":\"6.5\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-15 14:48:27'),
(15, 5, 1, 'atualizou', '{\"nota2_video\":\"6.5\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-15 14:48:36'),
(16, 5, 2, 'atualizou', '{\"nota2_video\":\"7.5\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-15 14:51:41'),
(17, 5, 2, 'atualizou', '{\"nota2_video\":\"7.5\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-15 14:51:44'),
(18, 5, 4, 'atualizou', '{\"nota2_video\":\"7.5\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-15 14:55:11'),
(19, 5, 5, 'atualizou', '{\"nota2_video\":\"9\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-15 14:58:10'),
(20, 5, 5, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-15 14:58:13'),
(21, 5, 6, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-15 15:01:16'),
(22, 5, 7, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-15 15:03:26'),
(23, 5, 8, 'atualizou', '{\"nota2_video\":\"8\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-15 15:05:43'),
(24, 5, 9, 'atualizou', '{\"nota2_video\":\"9\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-15 15:08:07'),
(25, 5, 9, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-15 15:08:10'),
(26, 5, 10, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-15 15:10:23'),
(27, 5, 10, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-15 15:10:26'),
(28, 5, 11, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-15 15:12:21'),
(29, 5, 12, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-15 15:15:15'),
(30, 5, 13, 'atualizou', '{\"nota2_video\":\"9\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-15 15:17:27'),
(31, 5, 5, 'atualizou', '{\"nota2_video\":\"10\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-15 15:17:50'),
(32, 5, 13, 'atualizou', '{\"nota2_video\":\"9.5\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-15 15:18:08'),
(33, 5, 8, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-15 15:18:36'),
(34, 5, 14, 'atualizou', '{\"nota2_video\":\"8\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-15 15:20:37'),
(35, 5, 2, 'atualizou', '{\"nota2_video\":\"8\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-15 15:20:54'),
(36, 5, 4, 'atualizou', '{\"nota2_video\":\"8\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-15 15:21:29'),
(37, 1, 1, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-17 13:40:52'),
(38, 1, 2, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-17 13:41:34'),
(39, 1, 4, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-17 13:41:57'),
(40, 1, 4, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-17 13:42:27'),
(41, 1, 5, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-17 13:42:50'),
(42, 1, 6, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-17 13:43:20'),
(43, 1, 7, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-17 13:43:48'),
(44, 1, 8, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-17 13:44:14'),
(45, 1, 8, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-17 13:44:31'),
(46, 1, 9, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-17 13:44:57'),
(47, 1, 10, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-17 13:45:16'),
(48, 1, 11, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-17 13:45:34'),
(49, 1, 12, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-17 13:45:55'),
(50, 1, 13, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-17 13:46:15'),
(51, 1, 14, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-17 13:46:35'),
(52, 4, 1, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-19 09:49:35'),
(53, 4, 1, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-19 09:49:42'),
(54, 4, 2, 'atualizou', '{\"nota2_video\":\"9\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-19 09:50:09'),
(55, 4, 2, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-19 09:50:15'),
(56, 4, 4, 'atualizou', '{\"nota2_video\":\"10\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-19 09:50:30'),
(57, 4, 5, 'atualizou', '{\"nota2_video\":\"9\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-19 09:50:49'),
(58, 4, 6, 'atualizou', '{\"nota2_video\":\"10\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-19 09:51:06'),
(59, 4, 7, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-19 09:51:21'),
(60, 4, 8, 'atualizou', '{\"nota2_video\":\"10\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-19 09:51:37'),
(61, 4, 9, 'atualizou', '{\"nota2_video\":\"10\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-19 09:51:50'),
(62, 4, 10, 'atualizou', '{\"nota2_video\":\"10\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-19 09:52:49'),
(63, 4, 11, 'atualizou', '{\"nota2_video\":\"9\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-19 09:53:00'),
(64, 4, 12, 'atualizou', '{\"nota2_video\":\"10\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-19 09:53:16'),
(65, 4, 13, 'atualizou', '{\"nota2_video\":\"10\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-19 09:53:29'),
(66, 4, 14, 'atualizou', '{\"nota2_video\":\"10\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-19 09:53:43'),
(67, 3, 1, 'atualizou', '{\"nota2_video\":\"7\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-19 22:32:49'),
(68, 3, 1, 'atualizou', '{\"nota2_video\":\"7.0\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-19 22:33:13'),
(69, 3, 2, 'atualizou', '{\"nota2_video\":\"7.5\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-19 22:33:28'),
(70, 3, 4, 'atualizou', '{\"nota2_video\":\"8\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-19 22:33:53'),
(71, 3, 5, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-19 22:34:15'),
(72, 3, 6, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-19 22:34:34'),
(73, 3, 7, 'atualizou', '{\"nota2_video\":\"9\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-19 22:34:52'),
(74, 3, 8, 'atualizou', '{\"nota2_video\":\"9.5\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-19 22:35:08'),
(75, 3, 9, 'atualizou', '{\"nota2_video\":\"9.5\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-19 22:35:24'),
(76, 3, 10, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-19 22:35:39'),
(77, 3, 11, 'atualizou', '{\"nota2_video\":\"9\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-19 22:35:50'),
(78, 3, 12, 'atualizou', '{\"nota2_video\":\"10\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-19 22:36:06'),
(79, 3, 13, 'atualizou', '{\"nota2_video\":\"9\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-19 22:36:26'),
(80, 3, 14, 'atualizou', '{\"nota2_video\":\"9.5\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-19 22:36:37'),
(81, 2, 1, 'atualizou', '{\"nota2_video\":\"8\",\"nota3_entrevista\":null,\"nota4_desfile\":null}', '192.168.88.230', '2026-03-21 16:24:33'),
(82, 5, 1, 'atualizou', '{\"nota2_video\":\"6.5\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":null}', '192.168.0.212', '2026-03-21 16:38:56'),
(83, 4, 1, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":\"9\",\"nota4_desfile\":null}', '192.168.0.216', '2026-03-21 16:38:56'),
(84, 4, 1, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":\"9\",\"nota4_desfile\":null}', '192.168.0.216', '2026-03-21 16:39:08'),
(85, 3, 1, 'atualizou', '{\"nota2_video\":\"7.0\",\"nota3_entrevista\":\"8\",\"nota4_desfile\":null}', '192.168.0.213', '2026-03-21 16:40:30'),
(86, 2, 2, 'atualizou', '{\"nota2_video\":\"7\",\"nota3_entrevista\":\"8\",\"nota4_desfile\":null}', '192.168.0.217', '2026-03-21 16:42:47'),
(87, 2, 2, 'atualizou', '{\"nota2_video\":\"7.0\",\"nota3_entrevista\":\"8.0\",\"nota4_desfile\":null}', '192.168.0.217', '2026-03-21 16:42:51'),
(88, 2, 2, 'atualizou', '{\"nota2_video\":\"7.0\",\"nota3_entrevista\":\"8.0\",\"nota4_desfile\":null}', '192.168.0.217', '2026-03-21 16:42:58'),
(89, 2, 1, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"7\",\"nota4_desfile\":null}', '192.168.0.217', '2026-03-21 16:43:22'),
(90, 2, 1, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"7.0\",\"nota4_desfile\":null}', '192.168.0.217', '2026-03-21 16:43:26'),
(91, 2, 2, 'atualizou', '{\"nota2_video\":\"8\",\"nota3_entrevista\":\"9\",\"nota4_desfile\":null}', '192.168.0.217', '2026-03-21 16:44:10'),
(92, 2, 2, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"9.0\",\"nota4_desfile\":null}', '192.168.0.217', '2026-03-21 16:44:14'),
(93, 3, 2, 'atualizou', '{\"nota2_video\":\"7.5\",\"nota3_entrevista\":\"9\",\"nota4_desfile\":null}', '192.168.0.213', '2026-03-21 16:48:23'),
(94, 4, 2, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"9.5\",\"nota4_desfile\":null}', '192.168.0.216', '2026-03-21 16:48:34'),
(95, 4, 2, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"9.5\",\"nota4_desfile\":null}', '192.168.0.216', '2026-03-21 16:48:38'),
(96, 5, 2, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8\",\"nota4_desfile\":null}', '192.168.0.212', '2026-03-21 16:48:41'),
(97, 2, 1, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"7.5\",\"nota4_desfile\":null}', '192.168.0.217', '2026-03-21 16:49:03'),
(98, 2, 4, 'atualizou', '{\"nota2_video\":\"9\",\"nota3_entrevista\":\"9\",\"nota4_desfile\":null}', '192.168.0.217', '2026-03-21 16:55:42'),
(99, 3, 4, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"9\",\"nota4_desfile\":null}', '192.168.0.213', '2026-03-21 16:55:48'),
(100, 5, 4, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"7\",\"nota4_desfile\":null}', '192.168.0.212', '2026-03-21 16:55:54'),
(101, 4, 4, 'atualizou', '{\"nota2_video\":\"10.0\",\"nota3_entrevista\":\"9.5\",\"nota4_desfile\":null}', '192.168.0.216', '2026-03-21 16:56:26'),
(102, 2, 5, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":\"9\",\"nota4_desfile\":null}', '192.168.0.217', '2026-03-21 17:05:03'),
(103, 4, 4, 'atualizou', '{\"nota2_video\":\"10.0\",\"nota3_entrevista\":\"9.0\",\"nota4_desfile\":null}', '192.168.0.216', '2026-03-21 17:06:19'),
(104, 4, 4, 'atualizou', '{\"nota2_video\":\"10.0\",\"nota3_entrevista\":\"9.0\",\"nota4_desfile\":null}', '192.168.0.216', '2026-03-21 17:06:23'),
(105, 5, 5, 'atualizou', '{\"nota2_video\":\"10.0\",\"nota3_entrevista\":\"10\",\"nota4_desfile\":null}', '192.168.0.212', '2026-03-21 17:06:23'),
(106, 3, 5, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":\"9\",\"nota4_desfile\":null}', '192.168.0.213', '2026-03-21 17:06:28'),
(107, 4, 5, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"10\",\"nota4_desfile\":null}', '192.168.0.216', '2026-03-21 17:06:40'),
(108, 4, 5, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"10.0\",\"nota4_desfile\":null}', '192.168.0.216', '2026-03-21 17:07:15'),
(109, 3, 6, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":\"6\",\"nota4_desfile\":null}', '192.168.0.213', '2026-03-21 17:12:38'),
(110, 2, 6, 'atualizou', '{\"nota2_video\":\"8\",\"nota3_entrevista\":\"9\",\"nota4_desfile\":null}', '192.168.0.217', '2026-03-21 17:13:48'),
(111, 4, 6, 'atualizou', '{\"nota2_video\":\"10.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":null}', '192.168.0.216', '2026-03-21 17:13:52'),
(112, 5, 6, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":\"7\",\"nota4_desfile\":null}', '192.168.0.212', '2026-03-21 17:14:05'),
(113, 4, 7, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":\"9.5\",\"nota4_desfile\":null}', '192.168.0.216', '2026-03-21 17:22:51'),
(114, 3, 7, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"9\",\"nota4_desfile\":null}', '192.168.0.213', '2026-03-21 17:22:51'),
(115, 2, 7, 'atualizou', '{\"nota2_video\":\"8\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":null}', '192.168.0.217', '2026-03-21 17:22:53'),
(116, 4, 7, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":\"9.5\",\"nota4_desfile\":null}', '192.168.0.216', '2026-03-21 17:22:57'),
(117, 5, 7, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":\"9.5\",\"nota4_desfile\":null}', '192.168.0.212', '2026-03-21 17:22:57'),
(118, 3, 8, 'atualizou', '{\"nota2_video\":\"9.5\",\"nota3_entrevista\":\"10\",\"nota4_desfile\":null}', '192.168.0.213', '2026-03-21 17:32:27'),
(119, 2, 8, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":\"9\",\"nota4_desfile\":null}', '192.168.0.217', '2026-03-21 17:32:29'),
(120, 4, 8, 'atualizou', '{\"nota2_video\":\"10.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":null}', '192.168.0.216', '2026-03-21 17:32:30'),
(121, 5, 8, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":null}', '192.168.0.212', '2026-03-21 17:32:33'),
(122, 3, 9, 'atualizou', '{\"nota2_video\":\"9.5\",\"nota3_entrevista\":\"7\",\"nota4_desfile\":null}', '192.168.0.213', '2026-03-21 17:49:45'),
(123, 4, 9, 'atualizou', '{\"nota2_video\":\"10.0\",\"nota3_entrevista\":\"9.0\",\"nota4_desfile\":null}', '192.168.0.216', '2026-03-21 17:49:47'),
(124, 5, 9, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"9.5\",\"nota4_desfile\":null}', '192.168.0.212', '2026-03-21 17:49:49'),
(125, 2, 9, 'atualizou', '{\"nota2_video\":\"8\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":null}', '192.168.0.217', '2026-03-21 17:49:50'),
(126, 4, 9, 'atualizou', '{\"nota2_video\":\"10.0\",\"nota3_entrevista\":\"10\",\"nota4_desfile\":null}', '192.168.0.216', '2026-03-21 17:50:08'),
(127, 4, 9, 'atualizou', '{\"nota2_video\":\"9.5\",\"nota3_entrevista\":\"10.0\",\"nota4_desfile\":null}', '192.168.0.216', '2026-03-21 17:50:19'),
(128, 1, 8, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"10\",\"nota4_desfile\":null}', '192.168.0.218', '2026-03-21 17:50:39'),
(129, 1, 5, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"10\",\"nota4_desfile\":null}', '192.168.0.218', '2026-03-21 17:50:58'),
(130, 1, 9, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":null}', '192.168.0.218', '2026-03-21 17:52:54'),
(131, 3, 10, 'atualizou', '{\"nota2_video\":\"7\",\"nota3_entrevista\":\"6\",\"nota4_desfile\":null}', '192.168.0.213', '2026-03-21 17:53:00'),
(132, 1, 1, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":null}', '192.168.0.218', '2026-03-21 17:53:58'),
(133, 1, 1, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":null}', '192.168.0.218', '2026-03-21 17:54:07'),
(134, 1, 2, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":null}', '192.168.0.218', '2026-03-21 17:54:35'),
(135, 1, 2, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":null}', '192.168.0.218', '2026-03-21 17:54:38'),
(136, 1, 4, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":null}', '192.168.0.218', '2026-03-21 17:55:07'),
(137, 1, 6, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":null}', '192.168.0.218', '2026-03-21 17:55:33'),
(138, 1, 6, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":null}', '192.168.0.218', '2026-03-21 17:55:34'),
(139, 1, 6, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":null}', '192.168.0.218', '2026-03-21 17:55:40'),
(140, 2, 10, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":\"8\",\"nota4_desfile\":null}', '192.168.0.217', '2026-03-21 17:56:04'),
(141, 1, 7, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":null}', '192.168.0.218', '2026-03-21 17:56:15'),
(142, 5, 10, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":\"7\",\"nota4_desfile\":null}', '192.168.0.212', '2026-03-21 17:56:23'),
(143, 4, 10, 'atualizou', '{\"nota2_video\":\"10.0\",\"nota3_entrevista\":\"8.0\",\"nota4_desfile\":null}', '192.168.0.216', '2026-03-21 17:56:23'),
(144, 4, 10, 'atualizou', '{\"nota2_video\":\"10.0\",\"nota3_entrevista\":\"7.5\",\"nota4_desfile\":null}', '192.168.0.216', '2026-03-21 17:56:32'),
(145, 2, 10, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":null}', '192.168.0.217', '2026-03-21 17:56:36'),
(146, 2, 8, 'atualizou', '{\"nota2_video\":\"9\",\"nota3_entrevista\":\"9.0\",\"nota4_desfile\":null}', '192.168.0.217', '2026-03-21 17:57:04'),
(147, 2, 10, 'atualizou', '{\"nota2_video\":\"9\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":null}', '192.168.0.217', '2026-03-21 17:57:21'),
(148, 1, 10, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"8.0\",\"nota4_desfile\":null}', '192.168.0.218', '2026-03-21 17:57:56'),
(149, 1, 10, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"8.0\",\"nota4_desfile\":null}', '192.168.0.218', '2026-03-21 17:58:08'),
(150, 3, 11, 'atualizou', '{\"nota2_video\":\"7\",\"nota3_entrevista\":\"6\",\"nota4_desfile\":null}', '192.168.0.213', '2026-03-21 18:01:44'),
(151, 1, 11, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8.0\",\"nota4_desfile\":null}', '192.168.0.218', '2026-03-21 18:02:00'),
(152, 2, 11, 'atualizou', '{\"nota2_video\":\"7.5\",\"nota3_entrevista\":\"7\",\"nota4_desfile\":null}', '192.168.0.217', '2026-03-21 18:02:40'),
(153, 4, 11, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"7\",\"nota4_desfile\":null}', '192.168.0.216', '2026-03-21 18:02:42'),
(154, 5, 11, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":\"8\",\"nota4_desfile\":null}', '192.168.0.212', '2026-03-21 18:02:45'),
(155, 1, 12, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":null}', '192.168.0.218', '2026-03-21 18:08:57'),
(156, 1, 12, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":null}', '192.168.0.218', '2026-03-21 18:08:58'),
(157, 5, 12, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":\"8\",\"nota4_desfile\":null}', '192.168.0.212', '2026-03-21 18:09:15'),
(158, 3, 12, 'atualizou', '{\"nota2_video\":\"10.0\",\"nota3_entrevista\":\"10\",\"nota4_desfile\":null}', '192.168.0.213', '2026-03-21 18:09:15'),
(159, 4, 12, 'atualizou', '{\"nota2_video\":\"10.0\",\"nota3_entrevista\":\"7.0\",\"nota4_desfile\":null}', '192.168.0.216', '2026-03-21 18:09:16'),
(160, 5, 12, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":\"8.0\",\"nota4_desfile\":null}', '192.168.0.212', '2026-03-21 18:09:19'),
(161, 2, 12, 'atualizou', '{\"nota2_video\":\"9\",\"nota3_entrevista\":\"9\",\"nota4_desfile\":null}', '192.168.0.217', '2026-03-21 18:09:52'),
(162, 4, 9, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"10.0\",\"nota4_desfile\":null}', '192.168.0.216', '2026-03-21 18:10:20'),
(163, 1, 12, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":null}', '192.168.0.218', '2026-03-21 18:10:25'),
(164, 1, 13, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"10\",\"nota4_desfile\":null}', '192.168.0.218', '2026-03-21 18:15:37'),
(165, 1, 13, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"10.0\",\"nota4_desfile\":null}', '192.168.0.218', '2026-03-21 18:15:42'),
(166, 1, 13, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"10.0\",\"nota4_desfile\":null}', '192.168.0.218', '2026-03-21 18:15:46'),
(167, 5, 13, 'atualizou', '{\"nota2_video\":\"9.5\",\"nota3_entrevista\":\"10\",\"nota4_desfile\":null}', '192.168.0.212', '2026-03-21 18:15:52'),
(168, 3, 13, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"10\",\"nota4_desfile\":null}', '192.168.0.213', '2026-03-21 18:15:53'),
(169, 4, 13, 'atualizou', '{\"nota2_video\":\"10.0\",\"nota3_entrevista\":\"10\",\"nota4_desfile\":null}', '192.168.0.216', '2026-03-21 18:16:04'),
(170, 2, 13, 'atualizou', '{\"nota2_video\":\"9\",\"nota3_entrevista\":\"9\",\"nota4_desfile\":null}', '192.168.0.217', '2026-03-21 18:16:06'),
(171, 4, 13, 'atualizou', '{\"nota2_video\":\"10.0\",\"nota3_entrevista\":\"10\",\"nota4_desfile\":null}', '192.168.0.216', '2026-03-21 18:16:09'),
(172, 2, 13, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"9.0\",\"nota4_desfile\":null}', '192.168.0.217', '2026-03-21 18:16:35'),
(173, 1, 14, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":null}', '192.168.0.218', '2026-03-21 18:19:57'),
(174, 3, 1, 'atualizou', '{\"nota2_video\":\"6\",\"nota3_entrevista\":\"7\",\"nota4_desfile\":null}', '192.168.0.213', '2026-03-21 18:20:55'),
(175, 3, 2, 'atualizou', '{\"nota2_video\":\"7\",\"nota3_entrevista\":\"7\",\"nota4_desfile\":null}', '192.168.0.213', '2026-03-21 18:21:24'),
(176, 3, 6, 'atualizou', '{\"nota2_video\":\"7\",\"nota3_entrevista\":\"6.0\",\"nota4_desfile\":null}', '192.168.0.213', '2026-03-21 18:22:10'),
(177, 3, 7, 'atualizou', '{\"nota2_video\":\"8\",\"nota3_entrevista\":\"8\",\"nota4_desfile\":null}', '192.168.0.213', '2026-03-21 18:22:32'),
(178, 3, 14, 'atualizou', '{\"nota2_video\":\"9.5\",\"nota3_entrevista\":\"9\",\"nota4_desfile\":null}', '192.168.0.213', '2026-03-21 18:23:32'),
(179, 4, 14, 'atualizou', '{\"nota2_video\":\"10.0\",\"nota3_entrevista\":\"10\",\"nota4_desfile\":null}', '192.168.0.216', '2026-03-21 18:23:33'),
(180, 2, 14, 'atualizou', '{\"nota2_video\":\"8\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":null}', '192.168.0.217', '2026-03-21 18:23:34'),
(181, 4, 14, 'atualizou', '{\"nota2_video\":\"10.0\",\"nota3_entrevista\":\"10.0\",\"nota4_desfile\":null}', '192.168.0.216', '2026-03-21 18:23:35'),
(182, 5, 14, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"9.5\",\"nota4_desfile\":null}', '192.168.0.212', '2026-03-21 18:23:36'),
(183, 1, 10, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":null}', '192.168.0.218', '2026-03-21 18:23:37'),
(184, 4, 14, 'atualizou', '{\"nota2_video\":\"10.0\",\"nota3_entrevista\":\"10.0\",\"nota4_desfile\":null}', '192.168.0.216', '2026-03-21 18:23:37'),
(185, 2, 2, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":null}', '192.168.0.217', '2026-03-21 18:23:59'),
(186, 2, 2, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8\",\"nota4_desfile\":null}', '192.168.0.217', '2026-03-21 18:24:06'),
(187, 1, 11, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":null}', '192.168.0.218', '2026-03-21 18:24:19'),
(188, 2, 6, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":null}', '192.168.0.217', '2026-03-21 18:24:27'),
(189, 2, 9, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":null}', '192.168.0.217', '2026-03-21 18:24:57'),
(190, 2, 12, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"9.0\",\"nota4_desfile\":null}', '192.168.0.217', '2026-03-21 18:25:09'),
(191, 1, 1, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":\"8.5\"}', '192.168.88.230', '2026-03-21 20:50:47'),
(192, 4, 1, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":\"9.0\",\"nota4_desfile\":\"7.0\"}', '192.168.88.230', '2026-03-21 20:51:03'),
(193, 5, 1, 'atualizou', '{\"nota2_video\":\"6.5\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":\"7\"}', '192.168.88.230', '2026-03-21 20:51:12'),
(194, 2, 1, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"7.5\",\"nota4_desfile\":\"7.5\"}', '192.168.88.230', '2026-03-21 20:51:17'),
(195, 3, 1, 'atualizou', '{\"nota2_video\":\"7\",\"nota3_entrevista\":\"7.0\",\"nota4_desfile\":\"6\"}', '192.168.88.230', '2026-03-21 20:51:31'),
(196, 2, 2, 'atualizou', '{\"nota2_video\":\"7.5\",\"nota3_entrevista\":\"7.5\",\"nota4_desfile\":\"7\"}', '192.168.88.230', '2026-03-21 20:51:43'),
(197, 1, 2, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":\"8.5\"}', '192.168.88.230', '2026-03-21 20:52:28'),
(198, 1, 2, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":\"8.5\"}', '192.168.88.230', '2026-03-21 20:52:33'),
(199, 4, 2, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"9.5\",\"nota4_desfile\":\"8.0\"}', '192.168.88.230', '2026-03-21 20:52:38'),
(200, 3, 2, 'atualizou', '{\"nota2_video\":\"7.0\",\"nota3_entrevista\":\"7.0\",\"nota4_desfile\":\"7\"}', '192.168.88.230', '2026-03-21 20:52:41'),
(201, 4, 2, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"9.5\",\"nota4_desfile\":\"8.0\"}', '192.168.88.230', '2026-03-21 20:52:44'),
(202, 5, 2, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8.0\",\"nota4_desfile\":\"8\"}', '192.168.88.230', '2026-03-21 20:52:44'),
(203, 1, 4, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":\"9.0\"}', '192.168.88.230', '2026-03-21 20:54:24'),
(204, 5, 4, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"7.0\",\"nota4_desfile\":\"8\"}', '192.168.88.230', '2026-03-21 20:54:25'),
(205, 1, 4, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":\"9.0\"}', '192.168.88.230', '2026-03-21 20:54:30'),
(206, 2, 4, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"9.0\",\"nota4_desfile\":\"8.5\"}', '192.168.88.230', '2026-03-21 20:54:31'),
(207, 3, 4, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"7\",\"nota4_desfile\":\"7\"}', '192.168.88.230', '2026-03-21 20:54:35'),
(208, 4, 4, 'atualizou', '{\"nota2_video\":\"10.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":\"8.5\"}', '192.168.88.230', '2026-03-21 20:54:38'),
(209, 4, 4, 'atualizou', '{\"nota2_video\":\"10.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":\"8.5\"}', '192.168.88.230', '2026-03-21 20:54:44'),
(210, 5, 5, 'atualizou', '{\"nota2_video\":\"10.0\",\"nota3_entrevista\":\"10.0\",\"nota4_desfile\":\"10\"}', '192.168.88.230', '2026-03-21 20:56:05'),
(211, 4, 5, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"10.0\",\"nota4_desfile\":\"10\"}', '192.168.88.230', '2026-03-21 20:56:06'),
(212, 1, 5, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"10.0\",\"nota4_desfile\":\"9.5\"}', '192.168.88.230', '2026-03-21 20:56:08'),
(213, 1, 5, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"10.0\",\"nota4_desfile\":\"9.5\"}', '192.168.88.230', '2026-03-21 20:56:10'),
(214, 2, 5, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":\"9.0\",\"nota4_desfile\":\"9\"}', '192.168.88.230', '2026-03-21 20:56:11'),
(215, 4, 5, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"10.0\",\"nota4_desfile\":\"10.0\"}', '192.168.88.230', '2026-03-21 20:56:14'),
(216, 3, 5, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":\"9\",\"nota4_desfile\":\"9\"}', '192.168.88.230', '2026-03-21 20:56:20'),
(217, 4, 6, 'atualizou', '{\"nota2_video\":\"10.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":\"9.5\"}', '192.168.88.230', '2026-03-21 20:57:40'),
(218, 1, 6, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":\"8.5\"}', '192.168.88.230', '2026-03-21 20:57:42'),
(219, 4, 6, 'atualizou', '{\"nota2_video\":\"10.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":\"9.5\"}', '192.168.88.230', '2026-03-21 20:57:42'),
(220, 5, 6, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":\"7.0\",\"nota4_desfile\":\"7.5\"}', '192.168.88.230', '2026-03-21 20:57:43'),
(221, 3, 6, 'atualizou', '{\"nota2_video\":\"7.0\",\"nota3_entrevista\":\"6.0\",\"nota4_desfile\":\"8\"}', '192.168.88.230', '2026-03-21 20:57:47'),
(222, 2, 6, 'atualizou', '{\"nota2_video\":\"9\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":\"9\"}', '192.168.88.230', '2026-03-21 20:57:50'),
(223, 1, 6, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":\"8.5\"}', '192.168.88.230', '2026-03-21 20:57:52'),
(224, 1, 6, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":\"8.5\"}', '192.168.88.230', '2026-03-21 20:57:54'),
(225, 2, 7, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":\"8\"}', '192.168.88.230', '2026-03-21 20:58:09'),
(226, 1, 7, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":\"9.0\"}', '192.168.88.230', '2026-03-21 20:59:04'),
(227, 1, 7, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":\"9.0\"}', '192.168.88.230', '2026-03-21 20:59:06'),
(228, 2, 7, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":\"9\"}', '192.168.88.230', '2026-03-21 20:59:12'),
(229, 5, 7, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":\"9.5\",\"nota4_desfile\":\"8\"}', '192.168.88.230', '2026-03-21 20:59:13'),
(230, 4, 7, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":\"9.5\",\"nota4_desfile\":\"8.5\"}', '192.168.88.230', '2026-03-21 20:59:16'),
(231, 3, 7, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"7\",\"nota4_desfile\":\"8\"}', '192.168.88.230', '2026-03-21 20:59:19'),
(232, 4, 7, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":\"9.5\",\"nota4_desfile\":\"8.5\"}', '192.168.88.230', '2026-03-21 20:59:21'),
(233, 2, 8, 'atualizou', '{\"nota2_video\":\"9.5\",\"nota3_entrevista\":\"9.0\",\"nota4_desfile\":null}', '192.168.88.230', '2026-03-21 20:59:44'),
(234, 4, 7, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":\"9.5\",\"nota4_desfile\":\"8.5\"}', '192.168.88.230', '2026-03-21 20:59:53'),
(235, 1, 8, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"10.0\",\"nota4_desfile\":\"10\"}', '192.168.88.230', '2026-03-21 21:00:45'),
(236, 1, 8, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"10.0\",\"nota4_desfile\":\"10.0\"}', '192.168.88.230', '2026-03-21 21:00:47'),
(237, 5, 8, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":\"8\"}', '192.168.88.230', '2026-03-21 21:00:48'),
(238, 3, 8, 'atualizou', '{\"nota2_video\":\"9.5\",\"nota3_entrevista\":\"10.0\",\"nota4_desfile\":\"10\"}', '192.168.88.230', '2026-03-21 21:00:49'),
(239, 4, 8, 'atualizou', '{\"nota2_video\":\"10.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":\"8.0\"}', '192.168.88.230', '2026-03-21 21:00:51'),
(240, 2, 8, 'atualizou', '{\"nota2_video\":\"9.5\",\"nota3_entrevista\":\"9.5\",\"nota4_desfile\":\"10\"}', '192.168.88.230', '2026-03-21 21:00:59'),
(241, 2, 8, 'atualizou', '{\"nota2_video\":\"9.5\",\"nota3_entrevista\":\"9.5\",\"nota4_desfile\":\"10.0\"}', '192.168.88.230', '2026-03-21 21:01:03'),
(242, 2, 9, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":\"7\"}', '192.168.88.230', '2026-03-21 21:01:23'),
(243, 2, 9, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8\",\"nota4_desfile\":\"7.0\"}', '192.168.88.230', '2026-03-21 21:01:31'),
(244, 1, 1, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":\"9.0\"}', '192.168.88.230', '2026-03-21 21:01:35'),
(245, 1, 2, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":\"9.0\"}', '192.168.88.230', '2026-03-21 21:01:47'),
(246, 1, 4, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":\"9.0\"}', '192.168.88.230', '2026-03-21 21:01:56'),
(247, 1, 6, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":\"9.0\"}', '192.168.88.230', '2026-03-21 21:02:14'),
(248, 1, 9, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":\"9.0\"}', '192.168.88.230', '2026-03-21 21:02:28'),
(249, 5, 9, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"9.5\",\"nota4_desfile\":\"7.5\"}', '192.168.88.230', '2026-03-21 21:02:41'),
(250, 4, 9, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"10.0\",\"nota4_desfile\":\"7.5\"}', '192.168.88.230', '2026-03-21 21:02:42'),
(251, 3, 9, 'atualizou', '{\"nota2_video\":\"9.5\",\"nota3_entrevista\":\"7.0\",\"nota4_desfile\":\"7\"}', '192.168.88.230', '2026-03-21 21:02:46'),
(252, 1, 10, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":\"8.5\"}', '192.168.88.230', '2026-03-21 21:04:14'),
(253, 4, 10, 'atualizou', '{\"nota2_video\":\"10.0\",\"nota3_entrevista\":\"7.5\",\"nota4_desfile\":\"8.5\"}', '192.168.88.230', '2026-03-21 21:04:17'),
(254, 3, 10, 'atualizou', '{\"nota2_video\":\"7.0\",\"nota3_entrevista\":\"6.0\",\"nota4_desfile\":\"7\"}', '192.168.88.230', '2026-03-21 21:04:18'),
(255, 2, 10, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":\"9\"}', '192.168.88.230', '2026-03-21 21:04:22'),
(256, 5, 10, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":\"7.0\",\"nota4_desfile\":\"8\"}', '192.168.88.230', '2026-03-21 21:04:23'),
(257, 2, 11, 'atualizou', '{\"nota2_video\":\"7.5\",\"nota3_entrevista\":\"7.0\",\"nota4_desfile\":\"7\"}', '192.168.88.230', '2026-03-21 21:04:59'),
(258, 2, 11, 'atualizou', '{\"nota2_video\":\"7.5\",\"nota3_entrevista\":\"7.0\",\"nota4_desfile\":\"7\"}', '192.168.88.230', '2026-03-21 21:05:02'),
(259, 1, 11, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":\"8.5\"}', '192.168.88.230', '2026-03-21 21:06:02'),
(260, 3, 11, 'atualizou', '{\"nota2_video\":\"7.0\",\"nota3_entrevista\":\"6.0\",\"nota4_desfile\":\"7\"}', '192.168.88.230', '2026-03-21 21:06:03'),
(261, 5, 11, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":\"8.0\",\"nota4_desfile\":\"7.5\"}', '192.168.88.230', '2026-03-21 21:06:04'),
(262, 1, 11, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":\"8.5\"}', '192.168.88.230', '2026-03-21 21:06:04'),
(263, 4, 11, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"7.0\",\"nota4_desfile\":\"9.0\"}', '192.168.88.230', '2026-03-21 21:06:05'),
(264, 1, 11, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":\"8.5\"}', '192.168.88.230', '2026-03-21 21:06:06'),
(265, 4, 11, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"7.5\",\"nota4_desfile\":\"9.0\"}', '192.168.88.230', '2026-03-21 21:06:11'),
(266, 5, 11, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":\"8.0\",\"nota4_desfile\":\"7\"}', '192.168.88.230', '2026-03-21 21:06:16'),
(267, 2, 12, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"9.0\",\"nota4_desfile\":\"9.5\"}', '192.168.88.230', '2026-03-21 21:06:50'),
(268, 1, 12, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":\"9.0\"}', '192.168.88.230', '2026-03-21 21:07:25'),
(269, 3, 12, 'atualizou', '{\"nota2_video\":\"10.0\",\"nota3_entrevista\":\"10.0\",\"nota4_desfile\":\"10\"}', '192.168.88.230', '2026-03-21 21:07:25'),
(270, 4, 12, 'atualizou', '{\"nota2_video\":\"10.0\",\"nota3_entrevista\":\"7.5\",\"nota4_desfile\":\"10\"}', '192.168.88.230', '2026-03-21 21:07:27'),
(271, 1, 12, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":\"9.0\"}', '192.168.88.230', '2026-03-21 21:07:27'),
(272, 5, 12, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":\"7.5\",\"nota4_desfile\":\"8.5\"}', '192.168.88.230', '2026-03-21 21:07:29'),
(273, 4, 12, 'atualizou', '{\"nota2_video\":\"10.0\",\"nota3_entrevista\":\"7.5\",\"nota4_desfile\":\"10.0\"}', '192.168.88.230', '2026-03-21 21:07:32'),
(274, 5, 12, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":\"7.5\",\"nota4_desfile\":\"8.5\"}', '192.168.88.230', '2026-03-21 21:07:36'),
(275, 2, 13, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"9.0\",\"nota4_desfile\":\"9.5\"}', '192.168.88.230', '2026-03-21 21:07:50'),
(276, 3, 1, 'atualizou', '{\"nota2_video\":\"6.5\",\"nota3_entrevista\":\"7.0\",\"nota4_desfile\":\"6.0\"}', '192.168.88.230', '2026-03-21 21:07:54'),
(277, 2, 13, 'atualizou', '{\"nota2_video\":\"9.5\",\"nota3_entrevista\":\"9.0\",\"nota4_desfile\":\"9.5\"}', '192.168.88.230', '2026-03-21 21:08:12'),
(278, 3, 2, 'atualizou', '{\"nota2_video\":\"7\",\"nota3_entrevista\":\"6\",\"nota4_desfile\":\"7.0\"}', '192.168.88.230', '2026-03-21 21:08:14'),
(279, 2, 13, 'atualizou', '{\"nota2_video\":\"9.5\",\"nota3_entrevista\":\"9.0\",\"nota4_desfile\":\"9.5\"}', '192.168.88.230', '2026-03-21 21:08:20'),
(280, 2, 13, 'atualizou', '{\"nota2_video\":\"9.5\",\"nota3_entrevista\":\"9.0\",\"nota4_desfile\":\"10\"}', '192.168.88.230', '2026-03-21 21:08:27'),
(281, 1, 13, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"10.0\",\"nota4_desfile\":\"10\"}', '192.168.88.230', '2026-03-21 21:08:40'),
(282, 5, 13, 'atualizou', '{\"nota2_video\":\"9.5\",\"nota3_entrevista\":\"10.0\",\"nota4_desfile\":\"9\"}', '192.168.88.230', '2026-03-21 21:09:00'),
(283, 4, 13, 'atualizou', '{\"nota2_video\":\"10.0\",\"nota3_entrevista\":\"10.0\",\"nota4_desfile\":\"9.5\"}', '192.168.88.230', '2026-03-21 21:09:01'),
(284, 3, 4, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"7\",\"nota4_desfile\":\"7.0\"}', '192.168.88.230', '2026-03-21 21:09:06'),
(285, 2, 4, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"9.0\",\"nota4_desfile\":\"9\"}', '192.168.88.230', '2026-03-21 21:09:09'),
(286, 2, 12, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"9.0\",\"nota4_desfile\":\"9.5\"}', '192.168.88.230', '2026-03-21 21:09:23'),
(287, 3, 13, 'atualizou', '{\"nota2_video\":\"7\",\"nota3_entrevista\":\"8\",\"nota4_desfile\":\"8\"}', '192.168.88.230', '2026-03-21 21:09:40'),
(288, 2, 10, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"9\",\"nota4_desfile\":\"9.5\"}', '192.168.88.230', '2026-03-21 21:09:45'),
(289, 2, 13, 'atualizou', '{\"nota2_video\":\"9.5\",\"nota3_entrevista\":\"9.0\",\"nota4_desfile\":\"10.0\"}', '192.168.88.230', '2026-03-21 21:10:00'),
(290, 2, 14, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":\"8\"}', '192.168.88.230', '2026-03-21 21:10:09'),
(291, 3, 14, 'atualizou', '{\"nota2_video\":\"8\",\"nota3_entrevista\":\"8\",\"nota4_desfile\":\"8\"}', '192.168.88.230', '2026-03-21 21:10:15'),
(292, 1, 14, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":\"8.5\"}', '192.168.88.230', '2026-03-21 21:10:17'),
(293, 1, 14, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":\"9.0\"}', '192.168.88.230', '2026-03-21 21:10:27'),
(294, 5, 14, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"9.5\",\"nota4_desfile\":\"7\"}', '192.168.88.230', '2026-03-21 21:10:30'),
(295, 5, 14, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"9.5\",\"nota4_desfile\":\"7\"}', '192.168.88.230', '2026-03-21 21:10:31'),
(296, 4, 14, 'atualizou', '{\"nota2_video\":\"10.0\",\"nota3_entrevista\":\"10.0\",\"nota4_desfile\":\"8.5\"}', '192.168.88.230', '2026-03-21 21:10:31'),
(297, 2, 14, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":\"8.0\"}', '192.168.88.230', '2026-03-21 21:10:36'),
(298, 4, 14, 'atualizou', '{\"nota2_video\":\"10.0\",\"nota3_entrevista\":\"10.0\",\"nota4_desfile\":\"8.5\"}', '192.168.88.230', '2026-03-21 21:10:40'),
(299, 3, 14, 'atualizou', '{\"nota2_video\":\"7\",\"nota3_entrevista\":\"7.5\",\"nota4_desfile\":\"7\"}', '192.168.88.230', '2026-03-21 21:10:42'),
(300, 3, 1, 'atualizou', '{\"nota2_video\":\"6.5\",\"nota3_entrevista\":\"6.5\",\"nota4_desfile\":\"6.0\"}', '192.168.88.230', '2026-03-21 21:11:00'),
(301, 2, 4, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"9.0\",\"nota4_desfile\":\"9.5\"}', '192.168.88.230', '2026-03-21 21:11:22'),
(302, 5, 2, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8.0\",\"nota4_desfile\":\"8\"}', '192.168.88.230', '2026-03-21 21:11:26'),
(303, 5, 2, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8.0\",\"nota4_desfile\":\"8\"}', '192.168.88.230', '2026-03-21 21:11:26'),
(304, 5, 2, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8.0\",\"nota4_desfile\":\"8\"}', '192.168.88.230', '2026-03-21 21:11:26'),
(305, 3, 2, 'atualizou', '{\"nota2_video\":\"7.0\",\"nota3_entrevista\":\"6.0\",\"nota4_desfile\":\"6\"}', '192.168.88.230', '2026-03-21 21:11:28'),
(306, 5, 2, 'atualizou', '{\"nota2_video\":\"8.0\",\"nota3_entrevista\":\"8.0\",\"nota4_desfile\":\"7.5\"}', '192.168.88.230', '2026-03-21 21:11:33'),
(307, 2, 5, 'atualizou', '{\"nota2_video\":\"8.5\",\"nota3_entrevista\":\"9.0\",\"nota4_desfile\":\"9.5\"}', '192.168.88.230', '2026-03-21 21:11:34'),
(308, 4, 5, 'atualizou', '{\"nota2_video\":\"9.5\",\"nota3_entrevista\":\"10.0\",\"nota4_desfile\":\"10.0\"}', '192.168.88.230', '2026-03-21 21:11:38'),
(309, 2, 6, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"9\",\"nota4_desfile\":\"9.0\"}', '192.168.88.230', '2026-03-21 21:11:44'),
(310, 3, 5, 'atualizou', '{\"nota2_video\":\"8\",\"nota3_entrevista\":\"8\",\"nota4_desfile\":\"8\"}', '192.168.88.230', '2026-03-21 21:12:12'),
(311, 5, 9, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"9\",\"nota4_desfile\":\"7.5\"}', '192.168.88.230', '2026-03-21 21:12:13'),
(312, 2, 8, 'atualizou', '{\"nota2_video\":\"9.5\",\"nota3_entrevista\":\"10\",\"nota4_desfile\":\"10.0\"}', '192.168.88.230', '2026-03-21 21:12:47'),
(313, 5, 9, 'atualizou', '{\"nota2_video\":\"9.0\",\"nota3_entrevista\":\"8.5\",\"nota4_desfile\":\"7.5\"}', '192.168.88.230', '2026-03-21 21:12:57'),
(314, 3, 13, 'atualizou', '{\"nota2_video\":\"7.0\",\"nota3_entrevista\":\"8.0\",\"nota4_desfile\":\"8.0\"}', '192.168.88.230', '2026-03-21 21:13:10'),
(315, 2, 5, 'atualizou', '{\"nota2_video\":\"9\",\"nota3_entrevista\":\"9.0\",\"nota4_desfile\":\"9.5\"}', '192.168.88.230', '2026-03-21 21:13:12'),
(316, 3, 13, 'atualizou', '{\"nota2_video\":\"7.0\",\"nota3_entrevista\":\"8.0\",\"nota4_desfile\":\"8.0\"}', '192.168.88.230', '2026-03-21 21:13:16'),
(317, 4, 5, 'atualizou', '{\"nota2_video\":\"10\",\"nota3_entrevista\":\"10.0\",\"nota4_desfile\":\"10.0\"}', '192.168.88.230', '2026-03-21 21:14:19'),
(318, 4, 5, 'atualizou', '{\"nota2_video\":\"10.0\",\"nota3_entrevista\":\"10.0\",\"nota4_desfile\":\"10.0\"}', '192.168.88.230', '2026-03-21 21:14:27'),
(319, 3, 8, 'atualizou', '{\"nota2_video\":\"8\",\"nota3_entrevista\":\"8\",\"nota4_desfile\":\"8\"}', '192.168.88.230', '2026-03-21 21:14:28'),
(320, 2, 13, 'atualizou', '{\"nota2_video\":\"9.5\",\"nota3_entrevista\":\"9.5\",\"nota4_desfile\":\"10.0\"}', '192.168.88.230', '2026-03-21 21:15:02'),
(321, 3, 8, 'atualizou', '{\"nota2_video\":\"7.5\",\"nota3_entrevista\":\"7\",\"nota4_desfile\":\"7.5\"}', '192.168.88.230', '2026-03-21 21:15:12'),
(322, 3, 8, 'atualizou', '{\"nota2_video\":\"7.5\",\"nota3_entrevista\":\"7.0\",\"nota4_desfile\":\"7.5\"}', '192.168.88.230', '2026-03-21 21:15:17'),
(323, 3, 5, 'atualizou', '{\"nota2_video\":\"7\",\"nota3_entrevista\":\"7\",\"nota4_desfile\":\"8.0\"}', '192.168.88.230', '2026-03-21 21:20:04'),
(324, 3, 8, 'atualizou', '{\"nota2_video\":\"6\",\"nota3_entrevista\":\"7.0\",\"nota4_desfile\":\"7.5\"}', '192.168.88.230', '2026-03-21 21:20:41'),
(325, 3, 13, 'atualizou', '{\"nota2_video\":\"6\",\"nota3_entrevista\":\"7\",\"nota4_desfile\":\"7\"}', '192.168.88.230', '2026-03-21 21:21:16');

-- --------------------------------------------------------

--
-- Estrutura para tabela `nota`
--

CREATE TABLE `nota` (
  `codnota` int(11) NOT NULL,
  `jurado_id` int(11) NOT NULL,
  `candidata_id` int(11) NOT NULL,
  `nota1_teorica` decimal(3,1) DEFAULT NULL COMMENT 'Admin lança; mesmo valor para todos os jurados',
  `nota2_video` decimal(3,1) DEFAULT NULL COMMENT 'Jurado avalia (5-10)',
  `nota3_entrevista` decimal(3,1) DEFAULT NULL COMMENT 'Jurado avalia (5-10)',
  `nota4_desfile` decimal(3,1) DEFAULT NULL COMMENT 'Jurado avalia (5-10)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Notas dos jurados por candidata';

--
-- Despejando dados para a tabela `nota`
--

INSERT INTO `nota` (`codnota`, `jurado_id`, `candidata_id`, `nota1_teorica`, `nota2_video`, `nota3_entrevista`, `nota4_desfile`) VALUES
(1, 1, 11, 10.0, 8.0, 8.5, 8.5),
(2, 2, 11, 10.0, 7.5, 7.0, 7.0),
(3, 3, 11, 10.0, 7.0, 6.0, 7.0),
(4, 4, 11, 10.0, 9.0, 7.5, 9.0),
(5, 5, 11, 10.0, 8.5, 8.0, 7.0),
(8, 1, 8, 10.0, 9.0, 10.0, 10.0),
(9, 2, 8, 10.0, 9.5, 10.0, 10.0),
(10, 3, 8, 10.0, 6.0, 7.0, 7.5),
(11, 4, 8, 10.0, 10.0, 8.5, 8.0),
(12, 5, 8, 10.0, 8.5, 8.5, 8.0),
(15, 1, 9, 9.0, 8.0, 8.5, 9.0),
(16, 2, 9, 9.0, 8.0, 8.0, 7.0),
(17, 3, 9, 9.0, 9.5, 7.0, 7.0),
(18, 4, 9, 9.0, 9.0, 10.0, 7.5),
(19, 5, 9, 9.0, 9.0, 8.5, 7.5),
(22, 1, 14, 10.0, 9.0, 8.5, 9.0),
(23, 2, 14, 10.0, 8.0, 8.5, 8.0),
(24, 3, 14, 10.0, 7.0, 7.5, 7.0),
(25, 4, 14, 10.0, 10.0, 10.0, 8.5),
(26, 5, 14, 10.0, 8.0, 9.5, 7.0),
(29, 1, 6, 10.0, 8.0, 8.5, 9.0),
(30, 2, 6, 10.0, 9.0, 9.0, 9.0),
(31, 3, 6, 10.0, 7.0, 6.0, 8.0),
(32, 4, 6, 10.0, 10.0, 8.5, 9.5),
(33, 5, 6, 10.0, 8.5, 7.0, 7.5),
(36, 1, 1, 9.0, 8.0, 8.5, 9.0),
(37, 2, 1, 9.0, 8.0, 7.5, 7.5),
(38, 3, 1, 9.0, 6.5, 6.5, 6.0),
(39, 4, 1, 9.0, 8.5, 9.0, 7.0),
(40, 5, 1, 9.0, 6.5, 8.5, 7.0),
(43, 1, 12, 10.0, 9.0, 8.5, 9.0),
(44, 2, 12, 10.0, 9.0, 9.0, 9.5),
(45, 3, 12, 10.0, 10.0, 10.0, 10.0),
(46, 4, 12, 10.0, 10.0, 7.5, 10.0),
(47, 5, 12, 10.0, 8.5, 7.5, 8.5),
(50, 1, 13, 10.0, 9.0, 10.0, 10.0),
(51, 2, 13, 10.0, 9.5, 9.5, 10.0),
(52, 3, 13, 10.0, 6.0, 7.0, 7.0),
(53, 4, 13, 10.0, 10.0, 10.0, 9.5),
(54, 5, 13, 10.0, 9.5, 10.0, 9.0),
(57, 1, 10, 9.0, 9.0, 8.5, 8.5),
(58, 2, 10, 9.0, 9.0, 9.0, 9.5),
(59, 3, 10, 9.0, 7.0, 6.0, 7.0),
(60, 4, 10, 9.0, 10.0, 7.5, 8.5),
(61, 5, 10, 9.0, 8.5, 7.0, 8.0),
(64, 1, 4, 9.0, 9.0, 8.5, 9.0),
(65, 2, 4, 9.0, 9.0, 9.0, 9.5),
(66, 3, 4, 9.0, 8.0, 7.0, 7.0),
(67, 4, 4, 9.0, 10.0, 8.5, 8.5),
(68, 5, 4, 9.0, 8.0, 7.0, 8.0),
(71, 1, 5, 10.0, 9.0, 10.0, 9.5),
(72, 2, 5, 10.0, 9.0, 9.0, 9.5),
(73, 3, 5, 10.0, 7.0, 7.0, 8.0),
(74, 4, 5, 10.0, 10.0, 10.0, 10.0),
(75, 5, 5, 10.0, 10.0, 10.0, 10.0),
(78, 1, 7, 9.0, 8.0, 8.5, 9.0),
(79, 2, 7, 9.0, 8.0, 8.5, 9.0),
(80, 3, 7, 9.0, 8.0, 7.0, 8.0),
(81, 4, 7, 9.0, 8.5, 9.5, 8.5),
(82, 5, 7, 9.0, 8.5, 9.5, 8.0),
(85, 1, 2, 9.0, 8.0, 8.5, 9.0),
(86, 2, 2, 9.0, 7.5, 7.5, 7.0),
(87, 3, 2, 9.0, 7.0, 6.0, 6.0),
(88, 4, 2, 9.0, 9.0, 9.5, 8.0),
(89, 5, 2, 9.0, 8.0, 8.0, 7.5);

-- --------------------------------------------------------

--
-- Estrutura para tabela `nota_teorica_global`
--

CREATE TABLE `nota_teorica_global` (
  `candidata_id` int(11) NOT NULL,
  `nota` decimal(3,1) NOT NULL COMMENT '0 a 10, múltiplo de 0.5',
  `lancada_em` datetime NOT NULL DEFAULT current_timestamp(),
  `lancada_por` int(11) NOT NULL COMMENT 'jurado_id do admin'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Nota da prova teórica — global por candidata, lançada só pelo admin';

--
-- Despejando dados para a tabela `nota_teorica_global`
--

INSERT INTO `nota_teorica_global` (`candidata_id`, `nota`, `lancada_em`, `lancada_por`) VALUES
(1, 9.0, '2026-03-12 13:39:45', 6),
(2, 9.0, '2026-03-12 13:41:53', 6),
(4, 9.0, '2026-03-12 13:41:07', 6),
(5, 10.0, '2026-03-12 13:41:19', 6),
(6, 10.0, '2026-03-12 13:39:24', 6),
(7, 9.0, '2026-03-12 13:41:38', 6),
(8, 10.0, '2026-03-12 13:38:17', 6),
(9, 9.0, '2026-03-12 13:38:41', 6),
(10, 9.0, '2026-03-12 13:40:36', 6),
(11, 10.0, '2026-03-12 13:38:05', 6),
(12, 10.0, '2026-03-12 13:40:00', 6),
(13, 10.0, '2026-03-12 13:40:13', 6),
(14, 10.0, '2026-03-12 13:39:10', 6);

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `candidatas`
--
ALTER TABLE `candidatas`
  ADD PRIMARY KEY (`codcandidatas`);

--
-- Índices de tabela `jurados`
--
ALTER TABLE `jurados`
  ADD PRIMARY KEY (`codjurados`),
  ADD UNIQUE KEY `uq_nome` (`nome`);

--
-- Índices de tabela `log_atividades`
--
ALTER TABLE `log_atividades`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_jurado` (`jurado_id`),
  ADD KEY `idx_candidata` (`candidata_id`),
  ADD KEY `idx_data` (`created_at`);

--
-- Índices de tabela `nota`
--
ALTER TABLE `nota`
  ADD PRIMARY KEY (`codnota`),
  ADD UNIQUE KEY `uq_avaliacao` (`jurado_id`,`candidata_id`),
  ADD KEY `fk_nota_candidata` (`candidata_id`);

--
-- Índices de tabela `nota_teorica_global`
--
ALTER TABLE `nota_teorica_global`
  ADD PRIMARY KEY (`candidata_id`),
  ADD KEY `fk_ntg_admin` (`lancada_por`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `candidatas`
--
ALTER TABLE `candidatas`
  MODIFY `codcandidatas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de tabela `jurados`
--
ALTER TABLE `jurados`
  MODIFY `codjurados` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `log_atividades`
--
ALTER TABLE `log_atividades`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=326;

--
-- AUTO_INCREMENT de tabela `nota`
--
ALTER TABLE `nota`
  MODIFY `codnota` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=402;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `log_atividades`
--
ALTER TABLE `log_atividades`
  ADD CONSTRAINT `fk_log_candidata` FOREIGN KEY (`candidata_id`) REFERENCES `candidatas` (`codcandidatas`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_log_jurado` FOREIGN KEY (`jurado_id`) REFERENCES `jurados` (`codjurados`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `nota`
--
ALTER TABLE `nota`
  ADD CONSTRAINT `fk_nota_candidata` FOREIGN KEY (`candidata_id`) REFERENCES `candidatas` (`codcandidatas`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_nota_jurado` FOREIGN KEY (`jurado_id`) REFERENCES `jurados` (`codjurados`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `nota_teorica_global`
--
ALTER TABLE `nota_teorica_global`
  ADD CONSTRAINT `fk_ntg_admin` FOREIGN KEY (`lancada_por`) REFERENCES `jurados` (`codjurados`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_ntg_candidata` FOREIGN KEY (`candidata_id`) REFERENCES `candidatas` (`codcandidatas`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
