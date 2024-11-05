-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: db:3306
-- Generation Time: Nov 05, 2024 at 01:46 PM
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
  `token` varchar(512) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `expires_at` timestamp NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `blacklist`
--

INSERT INTO `blacklist` (`id`, `token`, `created_at`, `expires_at`) VALUES
(2, '$2b$10$3bv8KjWp0.VR/i/EsLwhdeF1OHxgv8Ko8CSV1ai0b5nikNa1en1My', '2024-11-05 11:46:14', '2024-11-06 11:06:55'),
(20, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InN0YWZmIiwicm9sZSI6InN0YWZmIiwiaWF0IjoxNzMwODEwOTYzLCJleHAiOjE3MzA4OTczNjN9.WgX0OuF3y1yrhWA4S9SAXQdHdjVZ9g-ZpQREkcCaUPw', '2024-11-05 13:18:40', '2024-11-06 12:49:23'),
(21, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InN0YWZmIiwicm9sZSI6InN0YWZmIiwiaWF0IjoxNzMwODEwOTYzLCJleHAiOjE3MzA4OTczNjN9.WgX0OuF3y1yrhWA4S9SAXQdHdjVZ9g-ZpQREkcCaUPw', '2024-11-05 13:22:27', '2024-11-06 12:49:23'),
(22, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InN0YWZmIiwicm9sZSI6InN0YWZmIiwiaWF0IjoxNzMwODEwOTYzLCJleHAiOjE3MzA4OTczNjN9.WgX0OuF3y1yrhWA4S9SAXQdHdjVZ9g-ZpQREkcCaUPw', '2024-11-05 13:22:39', '2024-11-06 12:49:23'),
(23, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InN0YWZmIiwicm9sZSI6InN0YWZmIiwiaWF0IjoxNzMwODEwOTYzLCJleHAiOjE3MzA4OTczNjN9.WgX0OuF3y1yrhWA4S9SAXQdHdjVZ9g-ZpQREkcCaUPw', '2024-11-05 13:22:58', '2024-11-06 12:49:23'),
(24, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InN0YWZmIiwicm9sZSI6InN0YWZmIiwiaWF0IjoxNzMwODEwOTYzLCJleHAiOjE3MzA4OTczNjN9.WgX0OuF3y1yrhWA4S9SAXQdHdjVZ9g-ZpQREkcCaUPw', '2024-11-05 13:23:53', '2024-11-06 12:49:23'),
(25, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InN0YWZmIiwicm9sZSI6InN0YWZmIiwiaWF0IjoxNzMwODEwOTYzLCJleHAiOjE3MzA4OTczNjN9.WgX0OuF3y1yrhWA4S9SAXQdHdjVZ9g-ZpQREkcCaUPw', '2024-11-05 13:25:10', '2024-11-06 12:49:23'),
(26, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InN0YWZmIiwicm9sZSI6InN0YWZmIiwiaWF0IjoxNzMwODEwOTYzLCJleHAiOjE3MzA4OTczNjN9.WgX0OuF3y1yrhWA4S9SAXQdHdjVZ9g-ZpQREkcCaUPw', '2024-11-05 13:25:24', '2024-11-06 12:49:23'),
(27, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InN0YWZmIiwicm9sZSI6InN0YWZmIiwiaWF0IjoxNzMwODEwOTYzLCJleHAiOjE3MzA4OTczNjN9.WgX0OuF3y1yrhWA4S9SAXQdHdjVZ9g-ZpQREkcCaUPw', '2024-11-05 13:25:38', '2024-11-06 12:49:23'),
(28, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InN0YWZmIiwicm9sZSI6InN0YWZmIiwiaWF0IjoxNzMwODEwOTYzLCJleHAiOjE3MzA4OTczNjN9.WgX0OuF3y1yrhWA4S9SAXQdHdjVZ9g-ZpQREkcCaUPw', '2024-11-05 13:29:11', '2024-11-06 12:49:23'),
(29, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InN0YWZmIiwicm9sZSI6InN0YWZmIiwiaWF0IjoxNzMwODEwOTYzLCJleHAiOjE3MzA4OTczNjN9.WgX0OuF3y1yrhWA4S9SAXQdHdjVZ9g-ZpQREkcCaUPw', '2024-11-05 13:29:56', '2024-11-06 12:49:23'),
(30, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InN0YWZmIiwicm9sZSI6InN0YWZmIiwiaWF0IjoxNzMwODEwOTYzLCJleHAiOjE3MzA4OTczNjN9.WgX0OuF3y1yrhWA4S9SAXQdHdjVZ9g-ZpQREkcCaUPw', '2024-11-05 13:30:14', '2024-11-06 12:49:23'),
(31, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InN0YWZmIiwicm9sZSI6InN0YWZmIiwiaWF0IjoxNzMwODEwOTYzLCJleHAiOjE3MzA4OTczNjN9.WgX0OuF3y1yrhWA4S9SAXQdHdjVZ9g-ZpQREkcCaUPw', '2024-11-05 13:31:01', '2024-11-06 12:49:23'),
(32, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InN0YWZmIiwicm9sZSI6InN0YWZmIiwiaWF0IjoxNzMwODEwOTYzLCJleHAiOjE3MzA4OTczNjN9.WgX0OuF3y1yrhWA4S9SAXQdHdjVZ9g-ZpQREkcCaUPw', '2024-11-05 13:31:36', '2024-11-06 12:49:23'),
(33, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InN0YWZmIiwicm9sZSI6InN0YWZmIiwiaWF0IjoxNzMwODEwOTYzLCJleHAiOjE3MzA4OTczNjN9.WgX0OuF3y1yrhWA4S9SAXQdHdjVZ9g-ZpQREkcCaUPw', '2024-11-05 13:31:42', '2024-11-06 12:49:23'),
(34, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InN0YWZmIiwicm9sZSI6InN0YWZmIiwiaWF0IjoxNzMwODEwOTYzLCJleHAiOjE3MzA4OTczNjN9.WgX0OuF3y1yrhWA4S9SAXQdHdjVZ9g-ZpQREkcCaUPw', '2024-11-05 13:34:03', '2024-11-06 12:49:23'),
(35, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InN0YWZmIiwicm9sZSI6InN0YWZmIiwiaWF0IjoxNzMwODEwOTYzLCJleHAiOjE3MzA4OTczNjN9.WgX0OuF3y1yrhWA4S9SAXQdHdjVZ9g-ZpQREkcCaUPw', '2024-11-05 13:35:19', '2024-11-06 12:49:23'),
(36, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InN0YWZmIiwicm9sZSI6InN0YWZmIiwiaWF0IjoxNzMwODEwOTYzLCJleHAiOjE3MzA4OTczNjN9.WgX0OuF3y1yrhWA4S9SAXQdHdjVZ9g-ZpQREkcCaUPw', '2024-11-05 13:35:47', '2024-11-06 12:49:23'),
(37, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InN0YWZmIiwicm9sZSI6InN0YWZmIiwiaWF0IjoxNzMwODEwOTYzLCJleHAiOjE3MzA4OTczNjN9.WgX0OuF3y1yrhWA4S9SAXQdHdjVZ9g-ZpQREkcCaUPw', '2024-11-05 13:38:21', '2024-11-06 12:49:23'),
(38, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InN0YWZmIiwicm9sZSI6InN0YWZmIiwiaWF0IjoxNzMwODEwOTYzLCJleHAiOjE3MzA4OTczNjN9.WgX0OuF3y1yrhWA4S9SAXQdHdjVZ9g-ZpQREkcCaUPw', '2024-11-05 13:39:32', '2024-11-06 12:49:23'),
(39, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InN0YWZmIiwicm9sZSI6InN0YWZmIiwiaWF0IjoxNzMwODEwOTYzLCJleHAiOjE3MzA4OTczNjN9.WgX0OuF3y1yrhWA4S9SAXQdHdjVZ9g-ZpQREkcCaUPw', '2024-11-05 13:41:11', '2024-11-06 12:49:23'),
(40, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InN0YWZmIiwicm9sZSI6InN0YWZmIiwiaWF0IjoxNzMwODEwOTYzLCJleHAiOjE3MzA4OTczNjN9.WgX0OuF3y1yrhWA4S9SAXQdHdjVZ9g-ZpQREkcCaUPw', '2024-11-05 13:41:51', '2024-11-06 12:49:23'),
(41, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InN0YWZmIiwicm9sZSI6InN0YWZmIiwiaWF0IjoxNzMwODEwOTYzLCJleHAiOjE3MzA4OTczNjN9.WgX0OuF3y1yrhWA4S9SAXQdHdjVZ9g-ZpQREkcCaUPw', '2024-11-05 13:42:13', '2024-11-06 12:49:23');

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
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `reason` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`id`, `user_id`, `room_id`, `slot`, `status`, `approved_by`, `booking_date`, `created_at`, `updated_at`, `reason`) VALUES
(1, 1, 1, 'slot_1', 'cancel', NULL, '2024-11-03', '2024-11-02 19:29:47', '2024-11-05 12:37:25', NULL),
(2, 1, 2, 'slot_1', 'approved', NULL, '2024-11-03', '2024-11-02 19:44:24', '2024-11-05 12:37:20', 'test');

-- --------------------------------------------------------

--
-- Table structure for table `bookmarks`
--

CREATE TABLE `bookmarks` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookmarks`
--

INSERT INTO `bookmarks` (`id`, `user_id`, `room_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2024-11-02 20:32:10', '2024-11-02 20:32:10');

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `id` int(11) NOT NULL,
  `room_name` varchar(255) NOT NULL,
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
(1, 'test2', 'test2', '1730572812582-toa-heftiba-FV3GConVSss-unsplash.jpg', 'free', 'disabled', 'disabled', 'free', '2024-11-02 18:40:12', '2024-11-05 12:40:20'),
(2, 'staff', 'staff', '1730573614790-toa-heftiba-FV3GConVSss-unsplash.jpg', 'free', 'free', 'disabled', 'disabled', '2024-11-02 18:53:34', '2024-11-05 12:40:20'),
(3, 'staff', 'staff', '1730573629246-toa-heftiba-FV3GConVSss-unsplash.jpg', 'disabled', 'disabled', 'free', 'free', '2024-11-02 18:53:49', '2024-11-05 12:40:20');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `role` enum('student','staff','approver') NOT NULL DEFAULT 'student',
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `confirm_password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `role`, `username`, `password`, `email`, `created_at`, `updated_at`, `confirm_password`) VALUES
(1, 'student', 'aaa', '$2b$10$Ibz55fxxZTMVPm8ConOB4.ERsGsd2mUdDZiyDi0H8K.UogPzwVIrK', 'student@lamduan.mfu.ac.th', '2024-11-02 17:49:09', '2024-11-02 17:49:09', '$2b$10$Ibz55fxxZTMVPm8ConOB4.ERsGsd2mUdDZiyDi0H8K.UogPzwVIrK'),
(2, 'staff', 'bbb', '$2b$10$2EfNyzhnR9KjoLyeqMMM2eE58iVvC0ZCFuBWE.tzAgluTRdVVvXiy', 'staff@lamduan.mfu.ac.th', '2024-11-02 17:50:09', '2024-11-02 17:50:09', '$2b$10$2EfNyzhnR9KjoLyeqMMM2eE58iVvC0ZCFuBWE.tzAgluTRdVVvXiy'),
(3, 'approver', 'ccc', '$2b$10$r2wfY/9.dia2zhtItff5IugHOc4FOUCCKMsICUOe7yINrIoz1zIVS', 'approver@lamduan.mfu.ac.th', '2024-11-02 17:50:37', '2024-11-02 17:50:37', '$2b$10$r2wfY/9.dia2zhtItff5IugHOc4FOUCCKMsICUOe7yINrIoz1zIVS'),
(5, 'staff', 'staff', '$2b$10$lLjDrcUrsp67mOvvQ/dJhulC6i7S8Fny.Eby1eWFhZTksepjt2dyq', 'staff@lamduan.mfu.ac.th', '2024-11-04 11:02:41', '2024-11-04 11:03:02', NULL);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `bookmarks`
--
ALTER TABLE `bookmarks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
