-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 15, 2022 at 03:05 PM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 7.3.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `jd_id2`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `barangLaku` (IN `name` VARCHAR(50))  SELECT nama_produk, SUM(kuantitas_barang) FROM produk
            JOIN TOTAL_HARGA_PRODUK ON (produk.id_produk = TOTAL_HARGA_PRODUK.id_produk)
            WHERE nama_produk=name$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `kurir` (IN `kurir` CHAR(20))  SELECT alamat_penjual from pengiriman
            where jenis_kurir = kurir$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `kategori_harga` (`harga` INT) RETURNS VARCHAR(30) CHARSET utf8mb4 BEGIN
                DECLARE kategori VARCHAR (30);
                
                IF (harga > 500000) THEN
                    SET kategori = 'Sangat Mahal';
                ELSEIF (harga BETWEEN 100000 AND 500000) THEN
                    SET kategori = 'Mahal';
                ELSEIF (harga BETWEEN  50000 AND 100000) THEN
                    SET kategori = 'Cukup Mahal';
                ELSEIF (harga BETWEEN  20000 AND 50000) THEN
                    SET kategori = 'Cukup Murah';
                ELSEIF (harga BETWEEN  10000 AND 20000) THEN
                    SET kategori = 'Murah';
                ELSEIF (harga BETWEEN 1 AND 10000) THEN
                    SET kategori = 'Sangat Murah';
                    ELSE SET kategori = 'Tidak Ada';
                END IF;
                RETURN kategori;
                END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `status_penjual` (`rating` FLOAT(10,2)) RETURNS VARCHAR(30) CHARSET utf8mb4 BEGIN
                DECLARE status VARCHAR (30);
                    IF (rating > 4.5) THEN
                        SET status = 'Pelayanan Sangat Baik';
                    ELSEIF (rating BETWEEN 4.0 AND 4.5) THEN
                        SET status = 'Pelayanan Baik';
                    ELSEIF  (rating BETWEEN 3.5 AND 4.0) THEN
                        SET status = 'Pelayanan Cukup Baik';
                    ELSEIF (rating BETWEEN 3.0 AND 3.5) THEN
                        SET status = 'Pelayanan Kurang Baik';
                    ELSEIF (rating BETWEEN 2.5 AND 3.0) THEN
                        SET status = 'Pelayanan Cukup Buruk';
                    ELSEIF (rating BETWEEN 2.0 AND 2.5) THEN
                        SET status = 'Pelayanan Buruk';
                    ELSEIF (rating BETWEEN 0.1 AND 2.0) THEN
                        SET status = 'Pelayanan Sangat Buruk';
                END IF;
                RETURN status;
                END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE `address` (
  `alamat` varchar(50) NOT NULL,
  `id_user` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `address`
--

INSERT INTO `address` (`alamat`, `id_user`) VALUES
('Perum Citra Jaya Sentosa Gordah B.21 Garut', 'Devasa'),
('Jl. Kabupaten No. 199 Jakarta Pusat', 'Feroputraa'),
('Kp. Dunia Runtuh Bandung', 'Julisukmawan'),
('Jl. Jend. Ahmad Yani No.10 Bandung', 'Junoo021'),
('Komplek Aglaonema Blok A No. 2 Bogor', 'Kanayanto'),
('Jl. Kembar Selatan No. 6 Bandung', 'Meirashaf'),
('Jl. Hompimpa No. 78 Jakarta Barat', 'Putrososro'),
('Kp. Jatisari Garut Selatan', 'Sadewa'),
('Perumnas blok Y Jl. Kresna 9 No. 94 Karawang', 'Salsabilak28'),
('Kp. Randukurung Limbangan Tengah', 'Sukmajuliantii');

-- --------------------------------------------------------

--
-- Table structure for table `berat`
--

CREATE TABLE `berat` (
  `id_produk` char(20) DEFAULT NULL,
  `berat` float(3,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `berat`
--

INSERT INTO `berat` (`id_produk`, `berat`) VALUES
('098765FGH09FGH', 2.00),
('111222ABC11ABC', 0.60),
('113113IJK11IJK', 0.70),
('123456GHI12GHI', 1.10),
('145146KLM14KLM', 0.30),
('223344DEF22DEF', 0.80),
('272727EFG27EFG', 1.00),
('300300MNO30MNO', 0.90),
('320320NOP32NOP', 0.85),
('345345OPQ34OPQ', 4.00),
('404040LMN40LMN', 0.50),
('656565HIJ65HIJ', 0.20),
('900109PQR90PQR', 0.15),
('929394CDE92CDE', 0.10),
('987654JKL98JKL', 0.40);

-- --------------------------------------------------------

--
-- Table structure for table `harga`
--

CREATE TABLE `harga` (
  `id_produk` char(20) DEFAULT NULL,
  `harga` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `harga`
--

INSERT INTO `harga` (`id_produk`, `harga`) VALUES
('111222ABC11ABC', 15000),
('929394CDE92CDE', 18500),
('223344DEF22DEF', 45000),
('272727EFG27EFG', 50000),
('098765FGH09FGH', 74500),
('123456GHI12GHI', 70000),
('656565HIJ65HIJ', 60000),
('113113IJK11IJK', 35000),
('987654JKL98JKL', 99000),
('145146KLM14KLM', 30000),
('404040LMN40LMN', 120000),
('300300MNO30MNO', 350000),
('320320NOP32NOP', 55000),
('345345OPQ34OPQ', 150000),
('900109PQR90PQR', 5000);

-- --------------------------------------------------------

--
-- Table structure for table `log_pelanggan`
--

CREATE TABLE `log_pelanggan` (
  `uname` varchar(30) NOT NULL,
  `nampang` varchar(20) DEFAULT NULL,
  `pass` char(8) DEFAULT NULL,
  `jenkel` char(10) DEFAULT NULL,
  `tanglah` date DEFAULT NULL,
  `gmail` varchar(30) DEFAULT NULL,
  `notel` char(20) DEFAULT NULL,
  `waktu_perubahan` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `log_pelanggan`
--

INSERT INTO `log_pelanggan` (`uname`, `nampang`, `pass`, `jenkel`, `tanglah`, `gmail`, `notel`, `waktu_perubahan`) VALUES
('Kucingputih00', 'kupu', 'kupukupu', 'Perempuan', '2001-04-29', 'kupu69@cmail.com', '082314567890', '2021-06-10 09:44:58'),
('Kucingputih69', 'kupu', 'kupukupu', 'Perempuan', '2001-04-29', 'kupu69@cmail.com', '082314567890', '2021-06-10 02:26:17');

-- --------------------------------------------------------

--
-- Table structure for table `ongkir`
--

CREATE TABLE `ongkir` (
  `berat_produk` float(10,2) DEFAULT NULL,
  `kuantitas` int(11) NOT NULL,
  `total_berat` float(10,2) DEFAULT NULL,
  `alamat_pelanggan` varchar(50) DEFAULT NULL,
  `alamat_penjual` varchar(50) DEFAULT NULL,
  `id_order` char(20) DEFAULT NULL,
  `biaya_ongkir` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ongkir`
--

INSERT INTO `ongkir` (`berat_produk`, `kuantitas`, `total_berat`, `alamat_pelanggan`, `alamat_penjual`, `id_order`, `biaya_ongkir`) VALUES
(0.60, 2, 1.20, 'Perum Citra Jaya Sentosa Gordah B.21 Garut', 'Jakarta Barat', '111222ABC12ABC#1', 20000),
(0.60, 2, 1.20, 'Kp. Jatisari Garut Selatan', 'Jakarta Barat', '111222ABC12ABC#2', 20000),
(0.60, 2, 1.20, 'Jl. Jend. Ahmad Yani No.10 Bandung', 'Jakarta Barat', '111222ABC12ABC#3', 12000),
(0.10, 2, 0.20, 'Kp. Randukurung Limbangan Tengah', 'Bogor', '929394CDE92CDE#1', 18000),
(0.10, 2, 0.20, 'Perumnas blok Y Jl. Kresna 9 No. 94 Karawang', 'Bogor', '929394CDE92CDE#2', 20000),
(0.80, 2, 1.60, 'Jl. Kembar Selatan No. 6 Bandung', 'Jakarta Selatan', '223344DEF22DEF#1', 44000),
(0.80, 1, 0.80, 'Jl. Kabupaten No. 199 Jakarta Pusat', 'Jakarta Selatan', '223344DEF22DEF#2', 28000),
(1.00, 2, 2.00, 'Kp. Dunia Runtuh Bandung', 'Bandung', '272727EFG27EFG#1', 32000),
(2.00, 1, 2.00, 'Komplek Aglaonema Blok A No. 2 Bogor', 'Tangerang', '098765FGH09FGH#1', 40000),
(1.10, 2, 2.20, 'Jl. Hompimpa No. 78 Jakarta Barat', 'Bangka Belitung', '123456GHI12GHI#1', 28000),
(0.20, 1, 0.20, 'Perum Citra Jaya Sentosa Gordah B.21 Garut', 'Bekasi', '656565HIJ65HIJ#1', 20000),
(0.20, 1, 0.20, 'Kp. Randukurung Limbangan Tengah', 'Bekasi', '656565HIJ65HIJ#2', 14000),
(0.20, 1, 0.20, 'Perumnas blok Y Jl. Kresna 9 No. 94 Karawang', 'Bekasi', '656565HIJ65HIJ#4', 20000),
(0.20, 1, 0.20, 'Jl. Kembar Selatan No. 6 Bandung', 'Bekasi', '656565HIJ65HIJ#3', 22000),
(0.70, 2, 1.40, 'Kp. Jatisari Garut Selatan', 'Cilegon', '113113IJK11IJK#1', 11000),
(0.70, 2, 1.40, 'Kp. Dunia Runtuh Bandung', 'Cilegon', '113113IJK11IJK#2', 17000),
(0.70, 2, 1.40, 'Jl. Kabupaten No. 199 Jakarta Pusat', 'Cilegon', '113113IJK11IJK#3', 13000),
(0.40, 1, 0.40, 'Jl. Hompimpa No. 78 Jakarta Barat', 'Cimahi', '987654JKL98JKL#1', 14000),
(0.30, 1, 0.30, 'Perum Citra Jaya Sentosa Gordah B.21 Garut', 'Jakarta Utara', '145146KLM14KLM#1', 22000),
(0.30, 1, 0.30, 'Kp. Randukurung Limbangan Tengah', 'Jakarta Utara', '145146KLM14KLM#2', 14000),
(0.50, 1, 0.50, 'Perumnas blok Y Jl. Kresna 9 No. 94 Karawang', 'Bantul', '404040LMN40LMN#2', 30000),
(0.50, 1, 0.50, 'Jl. Kembar Selatan No. 6 Bandung', 'Bantul', '404040LMN40LMN#1', 23000),
(0.90, 1, 0.90, 'Kp. Jatisari Garut Selatan', 'Jakarta Pusat', '300300MNO30MNO#1', 30000),
(0.85, 1, 0.85, 'Komplek Aglaonema Blok A No. 2 Bogor', 'Malang', '320320NOP32NOP#1', 20000),
(4.00, 1, 4.00, 'Perum Citra Jaya Sentosa Gordah B.21 Garut ', 'Tasikmalaya', '345345OPQ34OPQ#1', 88000),
(4.00, 1, 4.00, 'Kp. Randukurung Limbangan Tengah', 'Tasikmalaya', '345345OPQ34OPQ#2', 80000),
(4.00, 1, 4.00, 'Perumnas blok Y Jl. Kresna 9 No. 94 Karawang', 'Tasikmalaya', '345345OPQ34OPQ#4', 64000),
(4.00, 1, 4.00, 'Jl. Kembar Selatan No. 6 Bandung', 'Tasikmalaya', '345345OPQ34OPQ#3', 56000),
(0.15, 1, 0.15, 'Jl. Hompimpa No. 78 Jakarta Barat', 'Bandung Barat', '900109PQR90PQR#1', 14000),
(0.15, 1, 0.00, 'Jl. Jend. Ahmad Yani No.10 Bandung', 'Bandung Barat', '900109PQR90PQR#2', 10000);

-- --------------------------------------------------------

--
-- Table structure for table `pelanggan`
--

CREATE TABLE `pelanggan` (
  `username` varchar(30) NOT NULL,
  `nama_panggilan` varchar(20) DEFAULT NULL,
  `password` char(8) DEFAULT NULL,
  `gender` char(10) DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `nomor_telepon` char(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pelanggan`
--

INSERT INTO `pelanggan` (`username`, `nama_panggilan`, `password`, `gender`, `tanggal_lahir`, `email`, `nomor_telepon`) VALUES
('Devasa', 'Dev', 'devs123#', 'Perempuan', '2003-04-09', 'devasa@upi.edu', '082219865050'),
('Feroputraa', 'Fero', 'ferputr@', 'Laki-Laki', '2001-03-21', 'feroput@cmail.com', '087765463222'),
('Julisukmawan', 'Juli', 'julijun$', 'Laki-Laki', '2000-07-06', 'julisukmawan@cmail.com', '082233674566'),
('Junoo021', 'Juno', '120jun01', 'Laki-Laki', '2002-09-12', 'junojuni@cmail.com', '085234561123'),
('Kanayanto', 'Yanto', 'y@nt0123', 'Laki-Laki', '2002-06-29', 'kanaynto@cmail.com', '081789090278'),
('Kucingputih00', 'kupu', 'kupukupu', 'Perempuan', '2001-04-29', 'kupu69@cmail.com', '082314567890'),
('Kucingputih69', 'kupu', 'kupukupu', 'Perempuan', '2001-04-29', 'kupu69@cmail.com', '082314567890'),
('Meirashaf', 'Shaf', 'shafmei5', 'Perempuan', '2002-05-13', 'shafameira@upi.edu', '081804566611'),
('Putrososro', 'Sosro', 's0sr9999', 'Laki-Laki', '2001-06-26', 'sosroputro@cmail.com', '085876589357'),
('Sadewa', 'Dewa', '!dewadew', 'Laki-Laki', '2000-08-13', 'sadewa@cmail.com', '089604381727'),
('Salsabilak28', 'Sal', 'salsala&', 'Perempuan', '2001-12-28', 'salsabilak28@upi.edu', '081380260922'),
('Sukmajuliantii', 'Uma', 'umacans4', 'Perempuan', '2002-07-27', 'sukmajulianti@upi.edu', '089630609272');

--
-- Triggers `pelanggan`
--
DELIMITER $$
CREATE TRIGGER `after_insert_pelanggan` AFTER INSERT ON `pelanggan` FOR EACH ROW BEGIN 
                        INSERT into log_pelanggan(uname, nampang, pass, jenkel, tanglah, gmail, notel)
                        VALUES(new.username, new.nama_panggilan, new.password, new.gender, new.tanggal_lahir, new.email, new.nomor_telepon);
            END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `pengiriman`
--

CREATE TABLE `pengiriman` (
  `jenis_kurir` char(20) DEFAULT NULL,
  `resi_produk` char(20) DEFAULT NULL,
  `status` char(10) DEFAULT NULL,
  `alamat_pelanggan` varchar(50) DEFAULT NULL,
  `alamat_penjual` varchar(50) DEFAULT NULL,
  `id_order` char(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pengiriman`
--

INSERT INTO `pengiriman` (`jenis_kurir`, `resi_produk`, `status`, `alamat_pelanggan`, `alamat_penjual`, `id_order`) VALUES
('JNE', '111222333444555', 'Selesai', 'Perum Citra Jaya Sentosa Gordah B.21 Garut', 'Jakarta Barat', '111222ABC12ABC#1'),
('JNT', '111222333444555', 'Selesai', 'Kp. Jatisari Garut Selatan', 'Jakarta Barat', '111222ABC12ABC#2'),
('SiCepat', '111222333444555', 'Selesai', 'Jl. Jend. Ahmad Yani No.10 Bandung', 'Jakarta Barat', '111222ABC12ABC#3'),
('JNT', '929394959697989', 'Selesai', 'Kp. Randukurung Limbangan Tengah', 'Bogor', '929394CDE92CDE#1'),
('Tiki', '929394959697989', 'Selesai', 'Perumnas blok Y Jl. Kresna 9 No. 94 Karawang', 'Bogor', '929394CDE92CDE#2'),
('SiCepat', '223344556677880', 'Selesai', 'Jl. Kembar Selatan No. 6 Bandung', 'Jakarta Selatan', '223344DEF22DEF#1'),
('JNE', '223344556677880', 'Selesai', 'Jl. Kabupaten No. 199 Jakarta Pusat', 'Jakarta Selatan', '223344DEF22DEF#2'),
('Tiki', '272727272727272', 'Selesai', 'Kp. Dunia Runtuh Bandung', 'Bandung', '272727EFG27EFG#1'),
('JX -Express', '098765432112345', 'Selesai', 'Komplek Aglaonema Blok A No. 2 Bogor', 'Tangerang', '098765FGH09FGH#1'),
('JNE', '123456789098765', 'Selesai', 'Jl. Hompimpa No. 78 Jakarta Barat', 'Bangka Belitung', '123456GHI12GHI#1'),
('JNT', '656565656565656', 'Selesai', 'Perum Citra Jaya Sentosa Gordah B.21 Garut ', 'Bekasi', '656565HIJ65HIJ#1'),
('JNE', '656565656565656', 'Selesai', 'Kp. Randukurung Limbangan Tengah', 'Bekasi', '656565HIJ65HIJ#2'),
('SiCepat', '656565656565656', 'Selesai', 'Jl. Kembar Selatan No. 6 Bandung', 'Bekasi', '656565HIJ65HIJ#3'),
('Tiki', '656565656565656', 'Selesai', 'Perumnas blok Y Jl. Kresna 9 No. 94 Karawang', 'Bekasi', '656565HIJ65HIJ#4'),
('JNE', '113113113113113', 'Selesai', 'Kp. Jatisari Garut Selatan', 'Cilegon', '113113IJK11IJK#1'),
('JNT', '113113113113113', 'Selesai', 'Kp. Dunia Runtuh Bandung', 'Cilegon', '113113IJK11IJK#2'),
('JX -Express', '113113113113113', 'Selesai', 'Jl. Kabupaten No. 199 Jakarta Pusat', 'Cilegon', '113113IJK11IJK#3'),
('JNT', '987654321098765', 'Selesai', 'Jl. Hompimpa No. 78 Jakarta Barat', 'Cimahi', '987654JKL98JKL#1'),
('SiCepat', '145146147148149', 'Selesai', 'Perum Citra Jaya Sentosa Gordah B.21 Garut ', 'Jakarta Utara', '145146KLM14KLM#1'),
('JNE', '145146147148149', 'Selesai', 'Kp. Randukurung Limbangan Tengah', 'Jakarta Utara', '145146KLM14KLM#2'),
('Tiki', '404040404040404', 'Selesai', 'Jl. Kembar Selatan No. 6 Bandung', 'Bantul', '404040LMN40LMN#1'),
('JNT', '404040404040404', 'Selesai', 'Perumnas blok Y Jl. Kresna 9 No. 94 Karawang', 'Bantul', '404040LMN40LMN#2'),
('JX -Express', '300300300300300', 'Selesai', 'Kp. Jatisari Garut Selatan', 'Jakarta Pusat', '300300MNO30MNO#1'),
('JNE', '320320320320320', 'Selesai', 'Komplek Aglaonema Blok A No. 2 Bogor', 'Malang', '320320NOP32NOP#1'),
('SiCepat', '345345345345345', 'Selesai', 'Perum Citra Jaya Sentosa Gordah B.21 Garut ', 'Tasikmalaya', '345345OPQ34OPQ#1'),
('JNT', '345345345345345', 'Selesai', 'Kp. Randukurung Limbangan Tengah', 'Tasikmalaya', '345345OPQ34OPQ#2'),
('JNE', '345345345345345', 'Selesai', 'Jl. Kembar Selatan No. 6 Bandung', 'Tasikmalaya', '345345OPQ34OPQ#3'),
('Tiki', '345345345345345', 'Selesai', 'Perumnas blok Y Jl. Kresna 9 No. 94 Karawang', 'Tasikmalaya', '345345OPQ34OPQ#4'),
('JNT', '900109001090010', 'Selesai', 'Jl. Hompimpa No. 78 Jakarta Barat', 'Bandung Barat', '900109PQR90PQR#1'),
('JNE', '900109001090010', 'Selesai', 'Jl. Jend. Ahmad Yani No.10 Bandung', 'Bandung Barat', '900109PQR90PQR#2');

-- --------------------------------------------------------

--
-- Table structure for table `penjual`
--

CREATE TABLE `penjual` (
  `username` varchar(30) DEFAULT NULL,
  `nama_toko` varchar(20) DEFAULT NULL,
  `alamat` varchar(50) NOT NULL,
  `total_pesanan` int(11) NOT NULL,
  `rating` float(10,2) DEFAULT NULL,
  `id_produk` char(20) DEFAULT NULL,
  `penilaian_toko` char(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `penjual`
--

INSERT INTO `penjual` (`username`, `nama_toko`, `alamat`, `total_pesanan`, `rating`, `id_produk`, `penilaian_toko`) VALUES
('haesweetty', 'haesweetty.official', 'Bandung', 2, 4.70, '272727EFG27EFG', '92%'),
('cooldesocks', 'CoolDeSocks Official', 'Bandung Barat', 2, 4.90, '900109PQR90PQR', '73%'),
('marshallofficial', 'Marshall Official Sh', 'Bangka Belitung', 2, 4.80, '123456GHI12GHI', '45%'),
('lavvela', 'Lavvela', 'Bantul', 2, 4.50, '404040LMN40LMN', '72%'),
('editbysociolla.official', 'Edit by Sociolla Off', 'Bekasi', 4, 4.90, '656565HIJ65HIJ', '72%'),
('pasificcase', 'pasificcase', 'Bogor', 4, 4.80, '929394CDE92CDE', '100%'),
('swilujengcards', 'FreshBaked.ID', 'Cilegon', 6, 5.00, '113113IJK11IJK', '58%'),
('jaketcelanakemeja', 'jaketcelanakemeja', 'Cimahi', 1, 4.50, '987654JKL98JKL', '66%'),
('jvacc', 'JV ACC', 'Jakarta Barat', 6, 4.60, '111222ABC11ABC', '76%'),
('logitechstore', 'Logitech Official Sh', 'Jakarta Pusat', 1, 4.90, '300300MNO30MNO', '60%'),
('synccollection_', 'synccollection_', 'Jakarta Selatan', 3, 4.70, '223344DEF22DEF', '92%'),
('simroam', 'simroam', 'Jakarta Utara', 2, 4.80, '145146KLM14KLM', '82%'),
('iluviahome', 'iluviahome', 'Malang', 1, 4.90, '320320NOP32NOP', '98%'),
('starlight1688', 'Starlight1688', 'Tangerang', 1, 4.80, '098765FGH09FGH', '95%'),
('zavier_shop', 'Zavier Shop', 'Tasikmalaya', 4, 4.80, '345345OPQ34OPQ', '91%');

-- --------------------------------------------------------

--
-- Table structure for table `produk`
--

CREATE TABLE `produk` (
  `nama_produk` varchar(50) DEFAULT NULL,
  `stock` int(11) NOT NULL,
  `foto_produk` varchar(10) DEFAULT NULL,
  `bintang` float(2,1) DEFAULT NULL,
  `ulasan` varchar(50) DEFAULT NULL,
  `informasi_produk` varchar(100) DEFAULT NULL,
  `kota_penjual` varchar(20) DEFAULT NULL,
  `diskon` int(11) DEFAULT NULL,
  `id_produk` char(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `produk`
--

INSERT INTO `produk` (`nama_produk`, `stock`, `foto_produk`, `bintang`, `ulasan`, `informasi_produk`, `kota_penjual`, `diskon`, `id_produk`) VALUES
('Starlight Meja Belajar Laptop', 1628, 'Ada', 4.8, 'Kualitas sesuai Harga', 'Meja Lipat Serbaguna ini merupakan meja portable yang sempurna yang dapat digunakan sebagai meja lap', 'Tangerang', 4500, '098765FGH09FGH'),
('Transformers Holder Handphone', 174, 'Ada', 4.6, 'Produk Original', 'Ready Stock! Tersedia 2 Warna Black dan White. Mohon beli sesuai varian yang diinginkan ya :)', 'Jakarta Barat', NULL, '111222ABC11ABC'),
('Cheese Roll Premium', 27, 'Ada', 5.0, 'Pengiriman Cepat', 'Fresh Baked Cheese Roll, bake everyday, 1 pack isi 12 pcs.', 'Cilegon', NULL, '113113IJK11IJK'),
('Speaker Wireless Bluetooth', 106, 'Ada', 4.9, 'Pesanan Sesuai', 'Speaker Wireless Bluetooth ini memberikan suara yang Hi-Power dengan bass dan mid level kaya, perang', 'Bangka Belitung', NULL, '123456GHI12GHI'),
('Masker Hijab Dakbil Headloop 3 ply Kemenkes isi 10', 185, 'Ada', 4.8, 'Produk Original', 'Masker Duckbill nyaman dan trendy, model headloop/hijab, orlee original 100% Indonesia, izin edar Ke', 'Jakarta Utara', NULL, '145146KLM14KLM'),
('Kaos Turtleneck Pria Wanita Leher Tinggi Rib Premi', 2321, 'Ada', 4.7, 'Puas Belanja di JD', 'Kaos Turtleneck yang kami jual terbuat dari material kain Cotton Rib yang halus, tebal, lentur dan m', 'Jakarta Selatan', NULL, '223344DEF22DEF'),
('Kaos Hoodie Kupluk Polos Distro Lengan Pendek Pria', 574, 'Ada', 4.5, 'Dijamin ORI', 'Hoodie kupluk kekinian lengan pendek pria-wanita, bahan baby terry, ukuran allsize, bahan lembut, si', 'Bandung', NULL, '272727EFG27EFG'),
('Logitech Keyboard K380 Bluetooth', 352, 'Ada', 4.8, 'Produk Original', 'Minimalis, modern, dan mobile. K380 Multi-Device keyboard yang tipis dan ringan dilengkapi dengan Bl', 'Jakarta Pusat', 20000, '300300MNO30MNO'),
('Reed Diffuser 100 mL', 47, 'Ada', 4.9, 'Kecepatan Pengiriman Sangat Baik', 'Reed diffuser merupakan pewangi ruangan yang ramah lingkungan karena tidak menggunakan baterai, tida', 'Malang', 3000, '320320NOP32NOP'),
('Standing Mirror Cermin UK 127 x 35.5 cm Cermin Ber', 28, 'Ada', 5.0, 'Produk Sesuai Gambar', 'Cermin Standing Kualitas Ekspor, UK 127 x 35.5 cm ukuran termasuk bingkai, sangat cocok untuk memper', 'Tasikmalaya', 10000, '345345OPQ34OPQ'),
('Oversize Cardigan Bahan Rajut', 220, 'Ada', 4.7, 'Dijamin ORI', 'Barang 100% REAL PICT, Kualitas terbaik di jamin, bahan rajut tebal, jahitan terbaik, ukuran bisa sa', 'Bantul', 15000, '404040LMN40LMN'),
('Cosrx Facial Wash Low pH', 222, 'Ada', 4.9, 'Dijamin ORI', 'Sudah terdaftar BPOM, Isi bersih 150 ml. Bentuk sabun wajah yang berupa gel dan memiliki pH rendah (', 'Bekasi', 5000, '656565HIJ65HIJ'),
('Kaos Kaki Casual Pria', 117, 'Ada', 4.9, 'Produk Sesuai Pesanan', 'Kaos Kaki Panjang Pria Cowok Laki Dewasa Kuzatura KZS 846. Kaos kaki ini dibuat menggunakan bahan PE', 'Bandung Barat', NULL, '900109PQR90PQR'),
('Hardcase All Type Smartphone', 200, 'Ada', 4.8, 'Kualitas Produk Sangat Baik', 'Hardcase Full Body Printing bahan hardcase, lebih slim, kuat, elegan, mewah harga murah tetapi tidak', 'Bogor', NULL, '929394CDE92CDE'),
('Kemeja Flanel Jumbo Big Size XXL-XXXL', 22, 'Ada', 5.0, 'Puas Belanja di JD', ' Kualitas produk dijamin tidak kalah dengan UNIQLO, tangan pertama konveksi langsung, bahan katun fl', 'Cimahi', 10000, '987654JKL98JKL');

--
-- Triggers `produk`
--
DELIMITER $$
CREATE TRIGGER `after_update` AFTER UPDATE ON `produk` FOR EACH ROW BEGIN
                    IF OLD.stock <> NEW.stock THEN 
                        INSERT INTO updatestok(kode_produk, nama_produk, before_stock, after_stock)
                        VALUES(old.id_produk, old.nama_produk, old.stock, new.stock);
                    END IF;     
                END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `total_harga_produk`
--

CREATE TABLE `total_harga_produk` (
  `id_produk` char(20) NOT NULL,
  `kuantitas_barang` int(11) NOT NULL,
  `subtotal` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `total_harga_produk`
--

INSERT INTO `total_harga_produk` (`id_produk`, `kuantitas_barang`, `subtotal`) VALUES
('111222ABC11ABC', 6, 90000),
('929394CDE92CDE', 4, 74000),
('223344DEF22DEF', 3, 135000),
('272727EFG27EFG', 2, 100000),
('098765FGH09FGH', 1, 74500),
('123456GHI12GHI', 2, 140000),
('656565HIJ65HIJ', 4, 240000),
('113113IJK11IJK', 6, 210000),
('987654JKL98JKL', 1, 99000),
('145146KLM14KLM', 2, 60000),
('404040LMN40LMN', 2, 240000),
('300300MNO30MNO', 1, 350000),
('320320NOP32NOP', 1, 55000),
('345345OPQ34OPQ', 4, 600000),
('900109PQR90PQR', 2, 10000),
('098765FGH09FGH', 3, 447000),
('098765FGH09FGH', 6, 447000);

--
-- Triggers `total_harga_produk`
--
DELIMITER $$
CREATE TRIGGER `newStock` AFTER INSERT ON `total_harga_produk` FOR EACH ROW BEGIN
                    UPDATE PRODUK
                        SET stock = stock - new.kuantitas_barang
                        WHERE `id_produk` = new.id_produk;
                END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `transaksi`
--

CREATE TABLE `transaksi` (
  `uname_pelanggan` varchar(30) DEFAULT NULL,
  `tanggal_pemesanan` date DEFAULT NULL,
  `waktu_pemesanan` time DEFAULT NULL,
  `tipe_pembayaran` varchar(15) DEFAULT NULL,
  `catatan_pemesanan` char(20) DEFAULT NULL,
  `id_order` char(20) NOT NULL,
  `kode_voucher` char(15) DEFAULT NULL,
  `total_pembayaran` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `transaksi`
--

INSERT INTO `transaksi` (`uname_pelanggan`, `tanggal_pemesanan`, `waktu_pemesanan`, `tipe_pembayaran`, `catatan_pemesanan`, `id_order`, `kode_voucher`, `total_pembayaran`) VALUES
('Kanayanto', '2021-05-15', '22:32:11', 'Instant Payment', '-', '098765FGH09FGH#1', 'STRL1GHT00', 110000),
('Devasa', '2021-04-02', '17:35:35', 'BNI', 'Warna Black 2', '111222ABC12ABC#1', 'THOLD3R111', 48000),
('Sadewa', '2021-04-04', '14:29:21', 'BJB', 'White 2', '111222ABC12ABC#2', 'THOLD3R111', 48000),
('Junoo021', '2021-04-06', '09:00:38', 'Toko Ritel', 'Warna black 1 white', '111222ABC12ABC#3', 'THOLD3R111', 40000),
('Sadewa', '2021-04-04', '14:31:01', 'BJB', 'Keju (2)', '113113IJK11IJK#1', 'CHEESER100', 79000),
('Julisukmawan', '2021-05-10', '15:11:49', 'COD', 'Choco Cheese (2)', '113113IJK11IJK#2', 'CHEESER100', 85000),
('Feroputraa', '2021-05-05', '20:47:00', 'Kartu Debit', 'Mix (2)', '113113IJK11IJK#3', 'CHEESER100', 81000),
('Putrososro', '2021-05-20', '16:38:31', 'Gopay', 'warna hitam', '123456GHI12GHI#1', '5P34K3RW12', 126000),
('Devasa', '2021-04-02', '17:40:10', 'BNI', '-', '145146KLM14KLM#1', 'DACKBILL200', 51800),
('Sukmajuliantii', '2021-04-05', '12:38:41', 'Mandiri', '-', '145146KLM14KLM#2', 'DACKBILL200', 43800),
('Meirashaf', '2021-04-09', '06:20:18', 'BCA', 'allsize', '223344DEF22DEF#1', 'K4057U1RNC', 129000),
('Feroputraa', '2021-05-05', '20:46:10', 'Kartu Debit', 'ukuran L', '223344DEF22DEF#2', 'K4057U1RNC', 68000),
('Julisukmawan', '2021-05-10', '15:11:49', 'COD', 'ukuran L', '272727EFG27EFG#1', 'K405H02D13', 125000),
('Sadewa', '2021-04-04', '14:34:21', 'BJB', 'Blue', '300300MNO30MNO#1', 'L091373CHK', 375500),
('Kanayanto', '2021-05-15', '22:35:31', 'Instant Payment', '-', '320320NOP32NOP#1', 'R33D1FU53R', 73000),
('Devasa', '2021-04-02', '17:45:54', 'BNI', '-', '345345OPQ34OPQ#1', 'S74ND1N9MC', 228000),
('Sukmajuliantii', '2021-04-05', '12:40:01', 'Mandiri', '-', '345345OPQ34OPQ#2', 'S74ND1N9MC', 220000),
('Salsabilak28', '2021-04-07', '10:26:57', 'BRI', '-', '345345OPQ34OPQ#3', 'S74ND1N9MC', 204000),
('Meirashaf', '2021-04-09', '06:27:12', 'BCA', '-', '345345OPQ34OPQ#4', 'S74ND1N9MC', 196000),
('Salsabilak28', '2021-04-07', '10:25:29', 'BRI', 'Size L', '404040LMN40LMN#1', 'CARDIOV3SZ', 125000),
('Meirashaf', '2021-04-09', '06:25:27', 'BCA', 'Size M', '404040LMN40LMN#2', 'CARDIOV3SZ', 118000),
('Devasa', '2021-04-02', '17:37:30', 'BNI', '-', '656565HIJ65HIJ#1', 'COSRXXFW99', 75000),
('Sukmajuliantii', '2021-04-05', '12:35:31', 'Mandiri', '-', '656565HIJ65HIJ#2', 'COSRXXFW99', 69000),
('Salsabilak28', '2021-04-07', '10:21:59', 'BRI', '-', '656565HIJ65HIJ#3', 'COSRXXFW99', 75000),
('Meirashaf', '2021-04-09', '06:22:07', 'BCA', '-', '656565HIJ65HIJ#4', 'COSRXXFW99', 77000),
('Putrososro', '2021-05-20', '16:41:24', 'Gopay', 'Putih', '900109PQR90PQR#1', 'K05K4K1900', 23100),
('Junoo021', '2021-04-06', '09:05:53', 'Toko Ritel', 'Hitam', '900109PQR90PQR#2', 'K05K4K1900', 19100),
('Sukmajuliantii', '2021-04-05', '12:34:30', 'Mandiri', 'untuk hp Vivo Y91C', '929394CDE92CDE#1', 'PACICASE90', 51500),
('Salsabilak28', '2021-04-07', '10:20:13', 'BRI', 'untuk hp Iphone 8', '929394CDE92CDE#2', 'PACICASE90', 53500),
('Putrososro', '2021-05-20', '16:39:57', 'Gopay', 'Size XXL', '987654JKL98JKL#1', 'FLANELBIG$', 104000);

-- --------------------------------------------------------

--
-- Table structure for table `updatestok`
--

CREATE TABLE `updatestok` (
  `kode_produk` varchar(20) DEFAULT NULL,
  `nama_produk` varchar(50) DEFAULT NULL,
  `before_stock` int(11) DEFAULT NULL,
  `after_stock` int(11) DEFAULT NULL,
  `waktu_perubahan` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `updatestok`
--

INSERT INTO `updatestok` (`kode_produk`, `nama_produk`, `before_stock`, `after_stock`, `waktu_perubahan`) VALUES
('113113IJK11IJK', 'Cheese Roll Premium', 40, 50, '2021-06-10 02:24:59'),
('987654JKL98JKL', 'Kemeja Flanel Jumbo Big Size XXL-XXXL', 60, 65, '2021-06-10 02:24:59'),
('345345OPQ34OPQ', 'Standing Mirror Cermin UK 127 x 35.5 cm Cermin Ber', 15, 30, '2021-06-10 02:24:59'),
('113113IJK11IJK', 'Cheese Roll Premium', 50, 30, '2021-06-10 09:43:10'),
('987654JKL98JKL', 'Kemeja Flanel Jumbo Big Size XXL-XXXL', 65, 25, '2021-06-10 09:43:10'),
('345345OPQ34OPQ', 'Standing Mirror Cermin UK 127 x 35.5 cm Cermin Ber', 30, 31, '2021-06-10 09:43:10'),
('098765FGH09FGH', 'Starlight Meja Belajar Laptop', 1637, 1634, '2021-06-11 09:34:47'),
('111222ABC11ABC', 'Transformers Holder Handphone', 177, 174, '2021-06-11 09:34:47'),
('113113IJK11IJK', 'Cheese Roll Premium', 30, 27, '2021-06-11 09:34:47'),
('123456GHI12GHI', 'Speaker Wireless Bluetooth', 109, 106, '2021-06-11 09:34:47'),
('145146KLM14KLM', 'Masker Hijab Dakbil Headloop 3 ply Kemenkes isi 10', 188, 185, '2021-06-11 09:34:47'),
('223344DEF22DEF', 'Kaos Turtleneck Pria Wanita Leher Tinggi Rib Premi', 2324, 2321, '2021-06-11 09:34:47'),
('272727EFG27EFG', 'Kaos Hoodie Kupluk Polos Distro Lengan Pendek Pria', 577, 574, '2021-06-11 09:34:47'),
('300300MNO30MNO', 'Logitech Keyboard K380 Bluetooth', 355, 352, '2021-06-11 09:34:47'),
('320320NOP32NOP', 'Reed Diffuser 100 mL', 50, 47, '2021-06-11 09:34:47'),
('345345OPQ34OPQ', 'Standing Mirror Cermin UK 127 x 35.5 cm Cermin Ber', 31, 28, '2021-06-11 09:34:47'),
('404040LMN40LMN', 'Oversize Cardigan Bahan Rajut', 223, 220, '2021-06-11 09:34:47'),
('656565HIJ65HIJ', 'Cosrx Facial Wash Low pH', 225, 222, '2021-06-11 09:34:47'),
('900109PQR90PQR', 'Kaos Kaki Casual Pria', 120, 117, '2021-06-11 09:34:47'),
('929394CDE92CDE', 'Hardcase All Type Smartphone', 203, 200, '2021-06-11 09:34:47'),
('987654JKL98JKL', 'Kemeja Flanel Jumbo Big Size XXL-XXXL', 25, 22, '2021-06-11 09:34:47'),
('098765FGH09FGH', 'Starlight Meja Belajar Laptop', 1634, 1628, '2021-06-11 09:38:53');

-- --------------------------------------------------------

--
-- Table structure for table `voucher`
--

CREATE TABLE `voucher` (
  `kode` char(15) NOT NULL,
  `nominal` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `voucher`
--

INSERT INTO `voucher` (`kode`, `nominal`) VALUES
('5P34K3RW12', 2000),
('CARDIOV3SZ', 25000),
('CHEESER100', 2000),
('COSRXXFW99', 5000),
('DACKBILL200', 200),
('FLANELBIG$', 9000),
('K05K4K1900', 900),
('K4057U1RNC', 5000),
('K405H02D13', 7000),
('L091373CHK', 4500),
('PACICASE90', 3500),
('R33D1FU53R', 2000),
('S74ND1N9MC', 10000),
('STRL1GHT00', 4500),
('THOLD3R111', 2000);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`alamat`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `berat`
--
ALTER TABLE `berat`
  ADD PRIMARY KEY (`berat`),
  ADD KEY `id_produk` (`id_produk`);

--
-- Indexes for table `harga`
--
ALTER TABLE `harga`
  ADD KEY `id_produk` (`id_produk`);

--
-- Indexes for table `log_pelanggan`
--
ALTER TABLE `log_pelanggan`
  ADD PRIMARY KEY (`uname`);

--
-- Indexes for table `ongkir`
--
ALTER TABLE `ongkir`
  ADD KEY `alamat_penjual` (`alamat_penjual`),
  ADD KEY `berat_produk` (`berat_produk`),
  ADD KEY `alamat_pelanggan` (`alamat_pelanggan`),
  ADD KEY `id_order` (`id_order`);

--
-- Indexes for table `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pengiriman`
--
ALTER TABLE `pengiriman`
  ADD KEY `alamat_pelanggan` (`alamat_pelanggan`),
  ADD KEY `alamat_penjual` (`alamat_penjual`),
  ADD KEY `id_order` (`id_order`);

--
-- Indexes for table `penjual`
--
ALTER TABLE `penjual`
  ADD PRIMARY KEY (`alamat`),
  ADD KEY `id_produk` (`id_produk`);

--
-- Indexes for table `produk`
--
ALTER TABLE `produk`
  ADD PRIMARY KEY (`id_produk`);

--
-- Indexes for table `total_harga_produk`
--
ALTER TABLE `total_harga_produk`
  ADD KEY `id_produk` (`id_produk`);

--
-- Indexes for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id_order`),
  ADD KEY `kode_voucher` (`kode_voucher`),
  ADD KEY `uname_pelanggan` (`uname_pelanggan`);

--
-- Indexes for table `voucher`
--
ALTER TABLE `voucher`
  ADD PRIMARY KEY (`kode`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `address`
--
ALTER TABLE `address`
  ADD CONSTRAINT `address_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `pelanggan` (`username`);

--
-- Constraints for table `berat`
--
ALTER TABLE `berat`
  ADD CONSTRAINT `berat_ibfk_1` FOREIGN KEY (`id_produk`) REFERENCES `produk` (`id_produk`);

--
-- Constraints for table `harga`
--
ALTER TABLE `harga`
  ADD CONSTRAINT `harga_ibfk_1` FOREIGN KEY (`id_produk`) REFERENCES `produk` (`id_produk`);

--
-- Constraints for table `ongkir`
--
ALTER TABLE `ongkir`
  ADD CONSTRAINT `ongkir_ibfk_1` FOREIGN KEY (`alamat_penjual`) REFERENCES `penjual` (`alamat`),
  ADD CONSTRAINT `ongkir_ibfk_2` FOREIGN KEY (`berat_produk`) REFERENCES `berat` (`berat`),
  ADD CONSTRAINT `ongkir_ibfk_3` FOREIGN KEY (`alamat_pelanggan`) REFERENCES `address` (`alamat`),
  ADD CONSTRAINT `ongkir_ibfk_4` FOREIGN KEY (`id_order`) REFERENCES `transaksi` (`id_order`);

--
-- Constraints for table `pengiriman`
--
ALTER TABLE `pengiriman`
  ADD CONSTRAINT `pengiriman_ibfk_1` FOREIGN KEY (`alamat_pelanggan`) REFERENCES `address` (`alamat`),
  ADD CONSTRAINT `pengiriman_ibfk_2` FOREIGN KEY (`alamat_penjual`) REFERENCES `penjual` (`alamat`),
  ADD CONSTRAINT `pengiriman_ibfk_3` FOREIGN KEY (`id_order`) REFERENCES `transaksi` (`id_order`);

--
-- Constraints for table `penjual`
--
ALTER TABLE `penjual`
  ADD CONSTRAINT `penjual_ibfk_1` FOREIGN KEY (`id_produk`) REFERENCES `produk` (`id_produk`);

--
-- Constraints for table `total_harga_produk`
--
ALTER TABLE `total_harga_produk`
  ADD CONSTRAINT `total_harga_produk_ibfk_1` FOREIGN KEY (`id_produk`) REFERENCES `produk` (`id_produk`);

--
-- Constraints for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `transaksi_ibfk_1` FOREIGN KEY (`kode_voucher`) REFERENCES `voucher` (`kode`),
  ADD CONSTRAINT `transaksi_ibfk_2` FOREIGN KEY (`uname_pelanggan`) REFERENCES `pelanggan` (`username`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
