-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 02, 2018 at 02:25 PM
-- Server version: 10.1.36-MariaDB
-- PHP Version: 5.6.38

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `peminjaman_brg`
--

-- --------------------------------------------------------

--
-- Table structure for table `barang`
--

CREATE TABLE `barang` (
  `ID_Barang` int(11) NOT NULL,
  `nama_barang` varchar(50) NOT NULL,
  `Stock` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `barang`
--

INSERT INTO `barang` (`ID_Barang`, `nama_barang`, `Stock`) VALUES
(1, 'SAPU', 100),
(2, 'CIKRAK', 90),
(3, 'LCD', 100),
(4, 'KAIN PEL', 101);

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
  `ID_barang` int(11) DEFAULT NULL,
  `NRP` int(11) DEFAULT NULL,
  `Tgl_Kembali` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `peminjaman`
--

INSERT INTO `peminjaman` (`ID_Peminjaman`, `Tgl_Pinjam`, `JmlPinjam`, `ID_barang`, `NRP`, `Tgl_Kembali`) VALUES
(11, '2018-12-02', 19, 1, 171111020, '2018-12-05'),
(13, '2018-12-02', 4, 1, 171111020, '2018-12-05'),
(14, '2018-12-02', 1, 1, 171111020, '2018-12-05'),
(16, '2018-12-02', 1, 1, 171111020, '2018-12-05'),
(17, '2018-12-02', 3, 1, 171111020, '2018-12-05'),
(18, '2018-12-02', 1, 3, 171111020, '2018-12-05'),
(19, '2018-12-02', 2, 1, 171111020, '2018-12-05');

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
(6, '2018-12-02', 4, 171111020, 1, '2018-12-02');

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
  ADD PRIMARY KEY (`ID_Barang`);

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
  ADD KEY `ID_barang` (`ID_barang`),
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
  MODIFY `ID_Barang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `login`
--
ALTER TABLE `login`
  MODIFY `NRP` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=171111022;

--
-- AUTO_INCREMENT for table `peminjaman`
--
ALTER TABLE `peminjaman`
  MODIFY `ID_Peminjaman` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `pengembalian`
--
ALTER TABLE `pengembalian`
  MODIFY `ID_Kembali` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD CONSTRAINT `peminjaman_ibfk_1` FOREIGN KEY (`ID_barang`) REFERENCES `barang` (`ID_Barang`),
  ADD CONSTRAINT `peminjaman_ibfk_2` FOREIGN KEY (`NRP`) REFERENCES `login` (`NRP`);

--
-- Constraints for table `pengembalian`
--
ALTER TABLE `pengembalian`
  ADD CONSTRAINT `pengembalian_ibfk_1` FOREIGN KEY (`ID_barang`) REFERENCES `barang` (`ID_Barang`),
  ADD CONSTRAINT `pengembalian_ibfk_2` FOREIGN KEY (`NRP`) REFERENCES `login` (`NRP`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
