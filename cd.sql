-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 10, 2020 at 07:53 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cd`
--

-- --------------------------------------------------------

--
-- Table structure for table `barang`
--

CREATE TABLE `barang` (
  `id_barang` int(11) NOT NULL,
  `judul_cd` varchar(50) NOT NULL,
  `Stock` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `barang`
--

INSERT INTO `barang` (`id_barang`, `judul_cd`, `Stock`) VALUES
(1, 'Wonder Woman 1984', 13),
(2, 'Harley Quinn: Birds of Prey', 99),
(3, 'Black Widow 2020', 6),
(4, 'Bad Boys for Life', 10),
(5, 'No Time to Die', 99),
(6, 'A Quiet Place 2', 21),
(7, 'The Invisible Man', 10);

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `NRP` int(11) NOT NULL,
  `Password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`NRP`, `Password`) VALUES
(1, '1'),
(171111020, 'a'),
(171111021, 'arema');

-- --------------------------------------------------------

--
-- Table structure for table `peminjaman`
--

CREATE TABLE `peminjaman` (
  `ID_Peminjaman` int(11) NOT NULL,
  `Tgl_Pinjam` date NOT NULL,
  `JmlPinjam` int(11) NOT NULL,
  `id_barang` int(11) DEFAULT NULL,
  `NRP` int(11) DEFAULT NULL,
  `Tgl_Kembali` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `peminjaman`
--

INSERT INTO `peminjaman` (`ID_Peminjaman`, `Tgl_Pinjam`, `JmlPinjam`, `id_barang`, `NRP`, `Tgl_Kembali`) VALUES
(24, '2020-05-10', 1, 5, 171111020, '2020-05-13'),
(30, '2020-05-11', 4, 3, 171111020, '2020-05-14');

--
-- Triggers `peminjaman`
--
DELIMITER $$
CREATE TRIGGER `pinjam_brg` AFTER INSERT ON `peminjaman` FOR EACH ROW UPDATE barang SET barang.Stock=barang.Stock-new.JmlPinjam WHERE ID_barang=new.ID_barang
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `pengembalian`
--

CREATE TABLE `pengembalian` (
  `ID_Kembali` int(11) NOT NULL,
  `Tgl_Pinjam` date DEFAULT NULL,
  `ID_barang` int(11) DEFAULT NULL,
  `NRP` int(11) DEFAULT NULL,
  `JmlPinjam` int(11) DEFAULT NULL,
  `Tgl_Kembali` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pengembalian`
--

INSERT INTO `pengembalian` (`ID_Kembali`, `Tgl_Pinjam`, `ID_barang`, `NRP`, `JmlPinjam`, `Tgl_Kembali`) VALUES
(6, '2018-12-02', 4, 171111020, 1, '2018-12-02'),
(7, '2020-05-10', 3, 1, 2, '2020-05-10'),
(8, '2018-12-02', 3, 171111020, 1, '2020-05-10'),
(9, '2018-12-02', 1, 171111020, 30, '2020-05-10'),
(10, '2020-05-11', 7, 171111020, 8, '2020-05-11'),
(11, '2020-05-11', 6, 171111020, 3, '2020-05-11'),
(12, '2020-05-10', 2, 171111020, 14, '2020-05-11'),
(13, '2020-05-11', 2, 171111020, 9, '2020-05-11'),
(14, '2020-05-11', 4, 1, 6, '2020-05-11');

--
-- Triggers `pengembalian`
--
DELIMITER $$
CREATE TRIGGER `kembali` AFTER INSERT ON `pengembalian` FOR EACH ROW UPDATE barang SET Stock=Stock+new.JmlPinjam WHERE ID_Barang=new.ID_Barang
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`id_barang`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`NRP`);

--
-- Indexes for table `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD PRIMARY KEY (`ID_Peminjaman`),
  ADD KEY `ID_barang` (`id_barang`),
  ADD KEY `NRP` (`NRP`);

--
-- Indexes for table `pengembalian`
--
ALTER TABLE `pengembalian`
  ADD PRIMARY KEY (`ID_Kembali`),
  ADD KEY `ID_barang` (`ID_barang`),
  ADD KEY `NRP` (`NRP`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `barang`
--
ALTER TABLE `barang`
  MODIFY `id_barang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `login`
--
ALTER TABLE `login`
  MODIFY `NRP` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=171111022;

--
-- AUTO_INCREMENT for table `peminjaman`
--
ALTER TABLE `peminjaman`
  MODIFY `ID_Peminjaman` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `pengembalian`
--
ALTER TABLE `pengembalian`
  MODIFY `ID_Kembali` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD CONSTRAINT `peminjaman_ibfk_1` FOREIGN KEY (`id_barang`) REFERENCES `barang` (`id_barang`),
  ADD CONSTRAINT `peminjaman_ibfk_2` FOREIGN KEY (`NRP`) REFERENCES `login` (`NRP`);

--
-- Constraints for table `pengembalian`
--
ALTER TABLE `pengembalian`
  ADD CONSTRAINT `pengembalian_ibfk_1` FOREIGN KEY (`ID_barang`) REFERENCES `barang` (`id_barang`),
  ADD CONSTRAINT `pengembalian_ibfk_2` FOREIGN KEY (`NRP`) REFERENCES `login` (`NRP`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
