-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: db:3306
-- Generation Time: Nov 09, 2024 at 07:27 PM
-- Server version: 11.5.2-MariaDB-ubu2404
-- PHP Version: 8.2.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mobile_project`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`%` PROCEDURE `cancel_request` ()   BEGIN
    UPDATE mobile_project.bookings
    SET
        bookings.status = IF(bookings.status = 'pending', 'cancel', bookings.status);
END$$

CREATE DEFINER=`root`@`%` PROCEDURE `reset_room_slot` ()   BEGIN
    UPDATE mobile_project.rooms
    SET
        slot_1 = IF(slot_1 = 'disabled', 'disabled', 'free'),
        slot_2 = IF(slot_2 = 'disabled', 'disabled', 'free'),
        slot_3 = IF(slot_3 = 'disabled', 'disabled', 'free'),
        slot_4 = IF(slot_4 = 'disabled', 'disabled', 'free');
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `blacklist`
--

CREATE TABLE `blacklist` (
  `id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `expires_at` timestamp NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `slot` enum('slot_1','slot_2','slot_3','slot_4') NOT NULL,
  `status` enum('pending','approved','rejected','cancel') NOT NULL,
  `approved_by` int(11) DEFAULT NULL,
  `booking_date` date NOT NULL DEFAULT current_timestamp(),
  `reason` varchar(60) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`id`, `user_id`, `room_id`, `slot`, `status`, `approved_by`, `booking_date`, `reason`, `created_at`, `updated_at`) VALUES
(6, 6, 1, 'slot_1', 'pending', NULL, '2024-11-05', 'test', '2024-11-05 22:00:09', '2024-11-05 22:00:09'),
(7, 6, 1, 'slot_1', 'pending', NULL, '2024-11-06', 'test', '2024-11-06 04:47:17', '2024-11-06 04:47:17'),
(8, 7, 1, 'slot_1', 'pending', NULL, '2024-11-06', 'test', '2024-11-06 04:59:53', '2024-11-06 04:59:53');

-- --------------------------------------------------------

--
-- Table structure for table `bookmarks`
--

CREATE TABLE `bookmarks` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `id` int(11) NOT NULL,
  `room_name` varchar(40) NOT NULL,
  `desc` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `slot_1` enum('free','pending','reserved','disabled') NOT NULL,
  `slot_2` enum('free','pending','reserved','disabled') NOT NULL,
  `slot_3` enum('free','pending','reserved','disabled') NOT NULL,
  `slot_4` enum('free','pending','reserved','disabled') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`id`, `room_name`, `desc`, `image`, `slot_1`, `slot_2`, `slot_3`, `slot_4`, `created_at`, `updated_at`) VALUES
(1, 'room_001', 'test', '1730831045996-toa-heftiba-FV3GConVSss-unsplash.jpg', 'pending', 'free', 'free', 'free', '2024-11-05 18:24:06', '2024-11-05 18:33:14'),
(2, 'room_002', 'test', '1730831288742-toa-heftiba-FV3GConVSss-unsplash.jpg', 'free', 'free', 'free', 'free', '2024-11-05 18:28:08', '2024-11-05 18:31:53'),
(3, 'room_003', 'test', '1730831292454-toa-heftiba-FV3GConVSss-unsplash.jpg', 'free', 'free', 'free', 'free', '2024-11-05 18:28:12', '2024-11-05 18:31:53'),
(4, 'room_004', 'test', '1730831295186-toa-heftiba-FV3GConVSss-unsplash.jpg', 'free', 'free', 'free', 'free', '2024-11-05 18:28:15', '2024-11-05 18:31:53'),
(5, 'room_005', 'test', '1730831297780-toa-heftiba-FV3GConVSss-unsplash.jpg', 'free', 'free', 'free', 'free', '2024-11-05 18:28:17', '2024-11-05 18:31:53'),
(6, 'room_006', 'test', '1730831568987-toa-heftiba-FV3GConVSss-unsplash.jpg', 'free', 'free', 'free', 'free', '2024-11-05 18:32:48', '2024-11-05 18:32:48'),
(7, 'room_007', 'test', '1730868296158-toa-heftiba-FV3GConVSss-unsplash.jpg', 'free', 'free', 'free', 'free', '2024-11-06 04:44:56', '2024-11-06 04:44:56');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `role` enum('student','staff','approver') NOT NULL DEFAULT 'student',
  `username` varchar(60) NOT NULL,
  `password` varchar(60) NOT NULL,
  `email` varchar(60) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `role`, `username`, `password`, `email`, `created_at`, `updated_at`) VALUES
(6, 'student', 'stu', '$2b$10$2A8Agtt9JaVDc/ZCwEKrDeLiZnFSZyML/GUgyjgLHlQObP2qRQBda', 'student@lamduan.mfu.ac.th', '2024-11-05 20:31:34', '2024-11-05 20:31:34'),
(7, 'student', 'student', '$2b$10$arkEKG.RaB8f6u0cOOErVe91sWlGAWkg0w6k.rf5MaHnIW8Y7rvAW', 'student12@lamduan.mfu.ac.th', '2024-11-06 04:42:39', '2024-11-06 04:42:39'),
(8, 'student', 'student_1', '$2b$10$1.m1ffqbGpvfyAX8l1zaz.A18hpjW5iC0OG81aYr2NvkG3DAN6uaK', 'student12@lamduan.mfu.ac.th', '2024-11-08 15:45:31', '2024-11-08 15:45:31'),
(9, 'approver', 'lec', '$2b$10$P2vKJZpSzZdTiJdodR3MW.z5l8IuXlsvD9x09E3zxUL/OZAe7AFGe', 'student12@lamduan.mfu.ac.th', '2024-11-08 16:13:02', '2024-11-08 16:13:44'),
(10, 'staff', 'staff', '$2b$10$HItUWq3SiulmOjFYQemVRehiDEV0iRJCvwJWpObX2hLhqfRQqag4K', 'student12@lamduan.mfu.ac.th', '2024-11-08 16:13:09', '2024-11-08 16:13:44'),
(11, 'student', 'test', '$2b$10$k7vlxc7K9xLI/i9PJCwsi.638vw5HhR/Ay140mLBO8zjzTpKQz/i2', 'test@lamduan.mfu.ac.th', '2024-11-09 12:01:51', '2024-11-09 12:01:51'),
(12, 'student', 'test1', '$2b$10$g0smjHpcZvTWoDMmfyyeJOF/R/oNHuH07EviwaExoZdr/8XoAW/vu', 'test@lamduan.mfu.ac.th', '2024-11-09 12:04:37', '2024-11-09 12:04:37'),
(13, 'student', 'test2', '$2b$10$m/JwiFh4J6pB8EEQBNzqJ.6GZkR5GMwNGKJb6IJFSJRtgGvyBe47G', 'test@lamduan.mfu.ac.th', '2024-11-09 12:05:37', '2024-11-09 12:05:37');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `blacklist`
--
ALTER TABLE `blacklist`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `room_id` (`room_id`),
  ADD KEY `approved_by` (`approved_by`);

--
-- Indexes for table `bookmarks`
--
ALTER TABLE `bookmarks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `room_id` (`room_id`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `blacklist`
--
ALTER TABLE `blacklist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `bookmarks`
--
ALTER TABLE `bookmarks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_approved_by_fk` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `bookings_room_fk` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bookings_user_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `bookmarks`
--
ALTER TABLE `bookmarks`
  ADD CONSTRAINT `bookmarks_room_fk` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bookmarks_user_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`root`@`%` EVENT `dairy_reset` ON SCHEDULE EVERY 1 DAY STARTS '2024-11-01 00:00:00' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
CALL reset_room_slots();
CALL cancel_request();
END$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
