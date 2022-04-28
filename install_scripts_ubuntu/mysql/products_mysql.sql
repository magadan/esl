-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Oct 09, 2014 at 09:22 AM
-- Server version: 5.6.20
-- PHP Version: 5.5.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `esl`
--

CREATE DATABASE IF NOT EXISTS `esl` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `esl`;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE IF NOT EXISTS `products` (
  `NotUsed` varchar(1),
  `ProductId` varchar(5) NOT NULL,
  `Barcode` varchar(40) NOT NULL PRIMARY KEY,
  `Description` varchar(60),
  `Group` varchar(10),
  `StandardPrice` varchar(10),
  `SellPrice` varchar(10),
  `Discount` varchar(10),
  `Content` varchar(20),
  `Unit` varchar(10)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Example Data for table `products`
--

INSERT INTO `products` (`NotUsed`, `ProductId`, `Barcode`, `Description`, `Group`, `StandardPrice`, `SellPrice`, `Discount`, `Content`, `Unit`) VALUES
('','001', '3083680012256', 'BONDUELLE CARROTS ', '93', '0,95', '0,95', '', '180', 'GR'),
('','002', '3083680915816', 'BONDUELLE FANTASIA FESTINI', '93', '0,99', '1,19', '', '400', 'GR'),
('','003', '3083680823609', 'BOND BUNTER MIX', '93', '1,29', '0,89', '31', '400', 'GR'),
('','004', '3083680047760', 'BOND APPEL COMPOTE', '93', '0,79', '0,79', '', '150', 'GR'),
('','005', '24000190257', 'DEL MONTE TOMATO PASTA', '93', '1,82', '1,49', '18', '400', 'GR'),
('','006', '38900014605', 'DOLE PINEAPPLE ON JUICE', '93', '1,75', '1,75', '', '680', 'GR'),
('','007', '3083680844048', 'BOND ITALIAN MIX', '93', '2,10', '2,10', '', '800', 'GR'),
('','008', '8718114412160', 'FRUCTIS 2 IN 1 SHAMPOO', '2', '3,80', '3,80', '', '300', 'ML'),
('','009', '5410091686352', 'SWARZKOPF SHAMPOO PEACH', '2', '2,95', '2,95', '', '400', 'ML'),
('','010', '4005808128600', 'NIVEA FOR MEN SPORT', '2', '3,95', '2,95', '25', '250', 'ML'),
('','011', '5410091666279', 'SWARZKOPF JUNIOR STYLING', '2', '4,50', '3,99', '11', '250', 'ML'),
('','012', '3014260000318', 'GILLETTE SHAVING FOAM', '2', '6,99', '6,99', '', '200', 'ML'),
('','013', '8710402362126', 'PRODENT TOOTHPASTE', '2', '2,05', '2,05', '', '75', 'ML'),
('','014', '5701007022464', 'AQUAFRESH TOOTHPASTE', '2', '1,80', '1,80', '', '75', 'ML'),
('','015', '8714789019468', 'COLGATE SENSATION WHITE', '2', '2,29', '2,29', '', '75', 'ML'),
('','016', '8716800452049', 'ELMEX TOOTHPASTE', '2', '1,65', '1,19', '28', '75', 'ML'),
('','017', '8711000028605', 'PICKWICK FOREST FRUIT', '27', '1,29', '1,29', '', '40', 'GR'),
('','018', '8711000018705', 'PICKWICK TEA MINT ', '27', '1,29', '1,29', '', '40', 'GR'),
('','019', '8711000008737', 'PICKWICK TEA LEMON', '27', '0,89', '0,89', '', '30', 'GR'),
('','020', '8711000003145', 'FOLGERS CLASSIC ROAST', '27', '2,99', '2,48', '17', '250', 'GR'),
('','021', '8711000194553', 'D-E SENSEO REGULAR', '27', '2,49', '2,49', '', '36', 'PCS'),
('','022', '8711000194584', 'D-E SENSEO DARK ROAST', '27', '2,49', '2,49', '', '36', 'PCS'),
('','023', '5410013142003', 'SPA & FRUIT ORANGE', '30', '0,79', '0,79', '', '1,5', 'LT'),
('','024', '5410013142004', 'SPA & FRUIT ORANGE', '30', '0,79', '0,79', '', '1,5', 'LT'),
('','025', '5410013142005', 'SPA & FRUIT ORANGE', '30', '0,79', '0,79', '', '15', 'LT'),
('','026', '8715600227284', '7-UP', '30', '0,95', '0,95', '', '1,5', 'LT'),
('','027', '5410013109679', 'SPA SPARKLING WATER', '30', '0,59', '0,59', '', '1,5', 'LT'),
('','028', '8713500008460', 'HERO CASSIS', '30', '0,79', '0,79', '', '1,25', 'LT'),
('','029', '8713300069340', 'TROPICANA APPEL JUICE', '30', '1,29', '0,99', '23', '1', 'LT'),
('','030', '2076210399997', 'HOUSE WINE WHITE DRY', '30', '3,99', '3,99', '', '2', 'LT'),
('','031', '2076210399993', 'HOUSE WINE RED', '30', '3,99', '3,99', '', '2', 'LT');

-- --------------------------------------------------------

--
-- Table structure for table `Products_Staging`
--
CREATE TABLE IF NOT EXISTS `products_staging` (
  `NotUsed` varchar(1),
  `ProductId` varchar(5) NOT NULL,
  `Barcode` varchar(40) NOT NULL PRIMARY KEY,
  `Description` varchar(60),
  `Group` varchar(10),
  `StandardPrice` varchar(10),
  `SellPrice` varchar(10),
  `Discount` varchar(10),
  `Content` varchar(20),
  `Unit` varchar(10),
  `DELETE` varchar(1)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



