-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 23, 2025 at 11:05 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_perpusabdu`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `balikin_buku` (IN `p_id_peminjaman` INT)   BEGIN
    DECLARE p_id_buku INT;
    
    SELECT id_buku INTO p_id_buku FROM peminjaman WHERE id_peminjaman = p_id_peminjaman;
    
    UPDATE buku SET stok = stok + 1 WHERE id_buku = p_id_buku;
    
    UPDATE peminjaman SET status = 'Dikembalikan', tanggal_kembali = CURRENT_DATE WHERE id_peminjaman = p_id_peminjaman;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `bukuMasuk` (`Pjudul_buku` VARCHAR(100), `Ppenulis` VARCHAR(50), `Pkategori` VARCHAR(50), `Pstok` INT)   BEGIN
	INSERT INTO tb_buku (judul_buku, penulis, kategori, stok)
    VALUES (Pjudul_buku, Ppenulis, Pkategori, Pstok);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteBuku` (`Pid_buku` INT)   BEGIN
    DELETE FROM tb_buku WHERE id_buku = Pid_buku;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deletePeminjaman` (`Pid_peminjaman` INT)   BEGIN
    DELETE FROM tb_peminjaman WHERE id_peminjaman = Pid_peminjaman;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteSiswa` (`Pid_siswa` INT)   BEGIN
    DELETE FROM tb_siswa WHERE id_siswa = Pid_siswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_book` (`Pjudul_buku` VARCHAR(100), `Ppenulis` VARCHAR(50), `Pkategori` VARCHAR(50), `Pstok` INT(11))   BEGIN
	INSERT INTO tb_buku (judul_buku, penulis, kategori, stok)
    VALUES (Pjudul_buku, Ppenulis, Pkategori, Pstok);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `kembalikan_buku` (IN `p_id_peminjaman` INT)   BEGIN
    DECLARE p_id_buku INT;
    
    SELECT id_buku INTO p_id_buku FROM peminjaman WHERE id_peminjaman = p_id_peminjaman;
    UPDATE buku SET stok = stok + 1 WHERE id_buku = p_id_buku;
    UPDATE peminjaman SET status = 'Dikembalikan', tanggal_kembali = CURRENT_DATE WHERE id_peminjaman = p_id_peminjaman;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `peminjamanMasuk` (`Pid_siswa` INT, `Pid_buku` INT, `Ptanggal_peminjaman` DATE, `Ptanggal_kembali` DATE, `Pstatus` VARCHAR(50))   BEGIN
    INSERT INTO tb_peminjaman (id_siswa, id_buku, tanggal_peminjaman, tanggal_kembali, status)
    VALUES (Pid_siswa, Pid_buku, Ptanggal_peminjaman, Ptanggal_kembali, Pstatus);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pinjam_buku` (IN `p_id_peminjaman` INT, IN `p_id_siswa` INT, IN `p_id_buku` INT, IN `p_tanggal_pinjam` DATE, IN `p_tanggal_kembali` DATE, IN `p_status` VARCHAR(50))   BEGIN
    INSERT INTO peminjaman (id_peminjaman, id_siswa, id_buku, tanggal_pinjam, tanggal_kembali, status)
    VALUES (p_id_peminjaman, p_id_siswa, p_id_buku, p_tanggal_pinjam, p_tanggal_kembali, p_status);
    
    UPDATE buku SET stok = stok - 1 WHERE id_buku = p_id_buku;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `showDataTable` ()   BEGIN
    SELECT * FROM tb_buku;
    
    SELECT * FROM tb_siswa;
    
    SELECT * FROM tb_peminjaman;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `siswaMasuk` (`Pnama` VARCHAR(100), `Pkelas` VARCHAR(50))   BEGIN
	INSERT INTO tb_siswa (nama, kelas)
    VALUES (Pnama, Pkelas);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tampilkan_all_buku` ()   BEGIN
    SELECT b.id_buku, b.judul_buku, b.penulis, b.kategori, b.stok
    FROM buku b
    LEFT JOIN peminjaman p ON b.id_buku = p.id_buku
    WHERE p.id_buku IS NULL OR p.status = 'Dipinjam';
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tampilkan_all_siswa` ()   BEGIN
    SELECT s.id_siswa, s.nama, s.kelas
    FROM siswa s
    LEFT JOIN peminjaman p ON s.id_siswa = p.id_siswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tampilkan_semua_buku` ()   BEGIN
    SELECT * FROM buku;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tampilkan_semua_peminjaman` ()   BEGIN
    SELECT * FROM peminjaman;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tampilkan_semua_siswa` ()   BEGIN
    SELECT * FROM siswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tampilkan_siswa_meminjam` ()   BEGIN
    SELECT DISTINCT s.id_siswa, s.nama, s.kelas
    FROM siswa s
    JOIN peminjaman p ON s.id_siswa = p.id_siswa
    WHERE p.status = 'Dikembalikan' OR p.status = 'Dipinjam';
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updatePeminjaman` (`Pid_peminjaman` INT, `Pid_siswa` INT, `Pid_buku` INT, `Ptanggal_peminjaman` DATE, `Ptanggal_kembali` DATE, `Pstatus` VARCHAR(20))   BEGIN
    UPDATE tb_peminjaman
    SET id_siswa = Pid_siswa, id_buku = Pid_buku, tanggal_peminjaman = Ptanggal_peminjaman, tanggal_kembali = Ptanggal_kembali, status = Pstatus
    WHERE id_peminjaman = Pid_peminjaman;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateSiswa` (`Pid_siswa` INT, `Pnama_siswa` VARCHAR(50), `Pkelas` VARCHAR(10))   BEGIN
    UPDATE tb_siswa
    SET nama_siswa = Pnama_siswa, kelas = Pkelas
    WHERE id_siswa = Pid_siswa;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tb_buku`
--

CREATE TABLE `tb_buku` (
  `id_buku` int(11) NOT NULL,
  `judul_buku` varchar(100) DEFAULT NULL,
  `penulis` varchar(50) DEFAULT NULL,
  `kategori` varchar(50) DEFAULT NULL,
  `stok` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_buku`
--

INSERT INTO `tb_buku` (`id_buku`, `judul_buku`, `penulis`, `kategori`, `stok`) VALUES
(1, 'Algoritma dan Pemrograman', 'Andi Wijaya', 'Teknologi', 5),
(2, 'Dasar-dasar Database', 'Budi Santoso', 'Teknologi', 7),
(3, 'Matematika Diskrit', 'Rina Sari', 'Matematika', 4),
(4, 'Sejarah Dunia', 'John Smith', 'Sejarah', 3),
(5, 'Pemrograman Web dengan PHP', 'Eko Prasetyo', 'Teknologi', 8),
(6, 'Sistem Operasi', 'Dian Kurniawan', 'Teknologi', 6),
(7, 'Jaringan Komputer', 'Ahmad Fauzi', 'Teknologi', 5),
(8, 'Cerita Rakyat Nusantara', 'Lestari Dewi', 'Sastra', 9),
(9, 'Bahasa Inggris untuk Pemula', 'Jane Doe', 'Bahasa', 10),
(10, 'Biologi Dasar', 'Budi Rahman', 'Sains', 7),
(11, 'Kimia Organik', 'Siti Aminah', 'Sains', 5),
(12, 'Teknik Elektro', 'Ridwan Hakim', 'Teknik', 6),
(13, 'Fisika Modern', 'Albert Einstein', 'Sains', 4),
(14, 'Manajemen Waktu', 'Steven Covey', 'Pengembangan', 8),
(15, 'Strategi Belajar Efektif', 'Tony Buzan', 'Pendidikan', 6);

-- --------------------------------------------------------

--
-- Table structure for table `tb_peminjaman`
--

CREATE TABLE `tb_peminjaman` (
  `id_peminjaman` int(11) NOT NULL,
  `id_siswa` int(11) DEFAULT NULL,
  `id_buku` int(11) DEFAULT NULL,
  `tanggal_peminjaman` date DEFAULT NULL,
  `tanggal_kembali` date DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_peminjaman`
--

INSERT INTO `tb_peminjaman` (`id_peminjaman`, `id_siswa`, `id_buku`, `tanggal_peminjaman`, `tanggal_kembali`, `status`) VALUES
(1, 11, 2, '2025-02-01', '2025-02-08', 'Dipinjam'),
(2, 2, 5, '2025-01-28', '2025-02-04', 'Dikembalikan'),
(3, 3, 8, '2025-02-02', '2025-02-09', 'Dipinjam'),
(4, 4, 10, '2025-01-30', '2025-02-06', 'Dikembalikan'),
(5, 5, 3, '2025-01-25', '2025-02-01', 'Dikembalikan'),
(6, 15, 7, '2025-02-01', '2025-02-08', 'Dipinjam'),
(7, 7, 1, '2025-01-29', '2025-02-05', 'Dikembalikan'),
(8, 8, 9, '2025-02-03', '2025-02-10', 'Dipinjam'),
(9, 13, 4, '2025-01-27', '2025-02-03', 'Dikembalikan'),
(10, 10, 11, '2025-02-01', '2025-02-08', 'Dipinjam');

-- --------------------------------------------------------

--
-- Table structure for table `tb_siswa`
--

CREATE TABLE `tb_siswa` (
  `id_siswa` int(11) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `kelas` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_siswa`
--

INSERT INTO `tb_siswa` (`id_siswa`, `nama`, `kelas`) VALUES
(1, 'Andi Saputra', 'X-RPL'),
(2, 'Budi Wijaya', 'X-TKJ'),
(3, 'Citra Lestari', 'XI-RPL'),
(4, 'Dewi Kurniawan', 'XI-TKJ'),
(5, 'Eko Prasetyo', 'XII-RPL'),
(6, 'Farhan Maulana', 'XII-TKJ'),
(7, 'Gita Permata', 'X-RPL'),
(8, 'Hadi Sucipto', 'X-TKJ'),
(9, 'Intan Permadi', 'XI-RPL'),
(10, 'Joko Santoso', 'XI-TKJ'),
(11, 'Kartika Sari', 'XII-RPL'),
(12, 'Lintang Putri', 'XII-TKJ'),
(13, 'Muhammad Rizky', 'X-RPL'),
(14, 'Novi Andriana', 'X-TKJ'),
(15, 'Olivia Hernanda', 'XI-RPL');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_buku`
--
ALTER TABLE `tb_buku`
  ADD PRIMARY KEY (`id_buku`);

--
-- Indexes for table `tb_peminjaman`
--
ALTER TABLE `tb_peminjaman`
  ADD PRIMARY KEY (`id_peminjaman`);

--
-- Indexes for table `tb_siswa`
--
ALTER TABLE `tb_siswa`
  ADD PRIMARY KEY (`id_siswa`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tb_buku`
--
ALTER TABLE `tb_buku`
  MODIFY `id_buku` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `tb_peminjaman`
--
ALTER TABLE `tb_peminjaman`
  MODIFY `id_peminjaman` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `tb_siswa`
--
ALTER TABLE `tb_siswa`
  MODIFY `id_siswa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
