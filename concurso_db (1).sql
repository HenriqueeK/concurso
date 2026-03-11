-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 11/03/2026 às 11:49
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
  `empresa` varchar(100) NOT NULL,
  `nome` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `candidatas`
--

INSERT INTO `candidatas` (`codcandidatas`, `empresa`, `nome`) VALUES
(1, 'Espaço Afrodite', 'Alice Inês Fischer'),
(2, 'Francine Berté Pilates', 'Dienifer Maciel'),
(4, 'Kondor Turismo', 'Djenifer Kamili Hatmann'),
(5, 'Autoelétrica Clarear', 'Emili Taíssa Angnes'),
(6, 'Edufut', 'Emilyn Dandara Petry'),
(7, 'Gosto Colonial', 'Gabriele Taís Alves'),
(8, 'Invita Soluções Imobiliárias', 'Isadora Immich'),
(9, 'Reference Centro Profissional', 'Jenifer Sandrine Rodrigues'),
(10, 'Construtora MGS Ltda', 'Milena Schulz'),
(11, 'CC Esquadrias Ltda', 'Mônica Zanotteli'),
(12, 'Pizzaria Pervincas', 'Paola Cristine Gomes'),
(13, 'D\'casa Móveis', 'Rafaela Scherer'),
(14, 'Ass. Moradores RS - 413', 'Sabrina Ohlweiler Gottselig');

-- --------------------------------------------------------

--
-- Estrutura para tabela `jurados`
--

CREATE TABLE `jurados` (
  `codjurados` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `jurados`
--

INSERT INTO `jurados` (`codjurados`, `nome`, `senha`, `is_admin`) VALUES
(1, 'Jurado1', 'jurado123', 0),
(2, 'Jurado2', 'jurado234', 0),
(3, 'Jurado3', 'jurado345', 0),
(4, 'Jurado4', 'jurado456', 0),
(5, 'Jurado5', 'jurado567', 0),
(6, 'admin', 'admin2025', 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `nota`
--

CREATE TABLE `nota` (
  `codnota` int(11) NOT NULL,
  `jurado_id` int(11) NOT NULL,
  `candidata_id` int(11) NOT NULL,
  `nota1_teorica` decimal(3,1) NOT NULL,
  `nota2_video` decimal(3,1) NOT NULL,
  `nota3_entrevista` decimal(3,1) NOT NULL,
  `nota4_desfile` decimal(3,1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `nota`
--

INSERT INTO `nota` (`codnota`, `jurado_id`, `candidata_id`, `nota1_teorica`, `nota2_video`, `nota3_entrevista`, `nota4_desfile`) VALUES
(1, 2, 14, 6.0, 10.0, 10.0, 10.0);

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `candidatas`
--
ALTER TABLE `candidatas`
  ADD PRIMARY KEY (`codcandidatas`),
  ADD UNIQUE KEY `empresa` (`empresa`);

--
-- Índices de tabela `jurados`
--
ALTER TABLE `jurados`
  ADD PRIMARY KEY (`codjurados`);

--
-- Índices de tabela `nota`
--
ALTER TABLE `nota`
  ADD PRIMARY KEY (`codnota`),
  ADD UNIQUE KEY `unique_avaliacao` (`jurado_id`,`candidata_id`),
  ADD KEY `fk_nota_candidata` (`candidata_id`);

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
-- AUTO_INCREMENT de tabela `nota`
--
ALTER TABLE `nota`
  MODIFY `codnota` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `nota`
--
ALTER TABLE `nota`
  ADD CONSTRAINT `fk_nota_candidata` FOREIGN KEY (`candidata_id`) REFERENCES `candidatas` (`codcandidatas`),
  ADD CONSTRAINT `fk_nota_jurado` FOREIGN KEY (`jurado_id`) REFERENCES `jurados` (`codjurados`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
