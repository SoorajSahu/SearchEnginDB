-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 21, 2020 at 09:15 AM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.2.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `davabazar_search_engine`
--

-- --------------------------------------------------------

--
-- Table structure for table `davabazar_store_contact`
--

CREATE TABLE `davabazar_store_contact` (
  `uid` varchar(18) NOT NULL,
  `phone_num1` varchar(13) NOT NULL,
  `phone_num2` varchar(13) NOT NULL,
  `phone_num3` varchar(13) NOT NULL,
  `email` varchar(40) NOT NULL,
  `state` varchar(39) NOT NULL,
  `city` varchar(45) NOT NULL,
  `zip` varchar(8) NOT NULL,
  `location` varchar(130) NOT NULL,
  `landmark` varchar(50) NOT NULL,
  `store_address` varchar(100) NOT NULL,
  `pharma_bio` varchar(500) NOT NULL DEFAULT '',
  `spacility` varchar(70) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `davabazar_store_main_detail`
--

CREATE TABLE `davabazar_store_main_detail` (
  `uid_regis_id` varchar(18) NOT NULL,
  `store_name` varchar(45) NOT NULL,
  `store_gst_num` varchar(40) NOT NULL,
  `store_owner_name` varchar(35) NOT NULL,
  `drug_l_num` varchar(34) NOT NULL,
  `store_password` varchar(60) DEFAULT NULL,
  `verification` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `medicines_of_store`
--

CREATE TABLE `medicines_of_store` (
  `medical_str_reg_num` varchar(18) NOT NULL,
  `medicine_id` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `medicine_info_table`
--

CREATE TABLE `medicine_info_table` (
  `medicine_id` varchar(20) NOT NULL,
  `medicine_name` varchar(50) NOT NULL,
  `medicine_name2` varchar(50) NOT NULL,
  `medicine_comp` varchar(40) NOT NULL,
  `medicine_type` varchar(40) NOT NULL,
  `medicine_catagory` varchar(35) NOT NULL,
  `prod_type` varchar(35) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Triggers `medicine_info_table`
--
DELIMITER $$
CREATE TRIGGER `unique_medicine_id` BEFORE INSERT ON `medicine_info_table` FOR EACH ROW set new.medicine_id  = CONCAT('MDID',SUBSTRING(uuid_short(),8))
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `searcher_info`
--

CREATE TABLE `searcher_info` (
  `searcher_email` varchar(60) NOT NULL,
  `searcher_name` varchar(50) NOT NULL,
  `searcher_pass` varchar(70) NOT NULL,
  `date_of_signup` date DEFAULT current_timestamp(),
  `time_of_signup` time DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `searches`
--

CREATE TABLE `searches` (
  `search_id` varchar(20) NOT NULL DEFAULT concat('SID',substr(uuid_short(),3)),
  `searches` varchar(95) NOT NULL,
  `search_date` date NOT NULL DEFAULT current_timestamp(),
  `search_time` time NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user_searches`
--

CREATE TABLE `user_searches` (
  `searcher_email` varchar(60) DEFAULT NULL,
  `search_id` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `davabazar_store_contact`
--
ALTER TABLE `davabazar_store_contact`
  ADD PRIMARY KEY (`uid`);

--
-- Indexes for table `davabazar_store_main_detail`
--
ALTER TABLE `davabazar_store_main_detail`
  ADD PRIMARY KEY (`uid_regis_id`);

--
-- Indexes for table `medicines_of_store`
--
ALTER TABLE `medicines_of_store`
  ADD KEY `medical_str_reg_num` (`medical_str_reg_num`),
  ADD KEY `medicine_id` (`medicine_id`);

--
-- Indexes for table `medicine_info_table`
--
ALTER TABLE `medicine_info_table`
  ADD PRIMARY KEY (`medicine_id`);

--
-- Indexes for table `searcher_info`
--
ALTER TABLE `searcher_info`
  ADD PRIMARY KEY (`searcher_email`);

--
-- Indexes for table `searches`
--
ALTER TABLE `searches`
  ADD PRIMARY KEY (`search_id`);

--
-- Indexes for table `user_searches`
--
ALTER TABLE `user_searches`
  ADD KEY `searcher_email` (`searcher_email`),
  ADD KEY `search_id` (`search_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `davabazar_store_contact`
--
ALTER TABLE `davabazar_store_contact`
  ADD CONSTRAINT `davabazar_store_contact_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `davabazar_store_main_detail` (`uid_regis_id`);

--
-- Constraints for table `medicines_of_store`
--
ALTER TABLE `medicines_of_store`
  ADD CONSTRAINT `medicines_of_store_ibfk_1` FOREIGN KEY (`medical_str_reg_num`) REFERENCES `davabazar_store_main_detail` (`uid_regis_id`),
  ADD CONSTRAINT `medicines_of_store_ibfk_2` FOREIGN KEY (`medicine_id`) REFERENCES `medicine_info_table` (`medicine_id`);

--
-- Constraints for table `user_searches`
--
ALTER TABLE `user_searches`
  ADD CONSTRAINT `user_searches_ibfk_1` FOREIGN KEY (`searcher_email`) REFERENCES `searcher_info` (`searcher_email`),
  ADD CONSTRAINT `user_searches_ibfk_2` FOREIGN KEY (`search_id`) REFERENCES `searches` (`search_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
