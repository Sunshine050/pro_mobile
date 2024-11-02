-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 02, 2024 at 08:46 PM
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
-- Database: `mobile_project`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `approved_by` int(11) DEFAULT NULL,
  `room_id` int(11) NOT NULL,
  `slot` enum('slot_1','slot_2','slot_3','slot_4') NOT NULL,
  `status` enum('pending','approved','rejected','cancel') NOT NULL,
  `reason` varchar(255) NOT NULL,
  `booking_date` date NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`id`, `user_id`, `approved_by`, `room_id`, `slot`, `status`, `reason`, `booking_date`, `created_at`, `updated_at`) VALUES
(6, 4, NULL, 1, 'slot_1', 'cancel', '', '2024-11-02', '2024-11-02 07:28:14', '2024-11-02 13:44:41'),
(7, 5, NULL, 1, 'slot_2', 'pending', '', '2024-11-02', '2024-11-02 11:37:21', '2024-11-02 12:45:11'),
(9, 4, NULL, 1, 'slot_1', 'pending', 'test', '2024-11-03', '2024-11-02 19:35:12', '2024-11-02 19:35:12');

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
(1, 4, 1, '2024-11-02 11:48:55', '2024-11-02 11:48:55');

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
(1, 'hello', 'test2', '1730573043102-toa-heftiba-FV3GConVSss-unsplash.jpg', 'pending', 'pending', 'free', 'disabled', '2024-11-01 13:45:17', '2024-11-02 19:34:29'),
(2, 'test', 'test', '1730569047279-toa-heftiba-FV3GConVSss-unsplash.jpg', 'free', 'free', 'free', 'free', '2024-11-02 17:39:31', '2024-11-02 17:39:31'),
(3, 'test', 'test', '1730569241398-toa-heftiba-FV3GConVSss-unsplash.jpg', 'free', 'free', 'free', 'free', '2024-11-02 17:40:41', '2024-11-02 17:40:41'),
(4, 'test', 'test', '1730572738669-toa-heftiba-FV3GConVSss-unsplash.jpg', 'free', 'free', 'free', 'free', '2024-11-02 18:38:58', '2024-11-02 18:38:58');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `role` enum('student','staff','approver') NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `role`, `username`, `password`, `email`, `created_at`, `updated_at`) VALUES
(2, 'staff', 'test2_1', '$2a$08$li6exSM0bsHQXEduwAGDGeTn5N8/fr4053BXNH1.ZxGCnNzmRHhGi', 'student@gmail.com', '2024-10-25 16:36:11', '2024-10-25 16:40:04'),
(4, 'student', 'test', '$2b$10$sR7KTipFYIeEs2qpUbw8vO5dKX6OlwKi70nhFUeahYHwk5WyE1JDe', 'student@gmail.com', '2024-11-01 14:18:19', '2024-11-01 14:18:19'),
(5, 'staff', 'staff', '$2b$10$XjMo49U7zCsSKcX/foQFyeJWVrPnBNkuVF9cKDJwwhiHZXLgOuorO', 'staff@gmail.com', '2024-11-01 15:33:23', '2024-11-01 15:33:23');

--
-- Indexes for dumped tables
--

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
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `bookmarks`
--
ALTER TABLE `bookmarks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`),
  ADD CONSTRAINT `bookings_ibfk_3` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `bookmarks`
--
ALTER TABLE `bookmarks`
  ADD CONSTRAINT `bookmarks_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `bookmarks_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
