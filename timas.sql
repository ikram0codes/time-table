-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jun 27, 2023 at 09:30 PM
-- Server version: 10.3.28-MariaDB-log
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `simasco_timas`
--

-- --------------------------------------------------------

--
-- Table structure for table `block`
--

CREATE TABLE `block` (
  `block_no` varchar(20) NOT NULL,
  `block_name` varchar(40) DEFAULT NULL,
  `date_registered` timestamp NOT NULL DEFAULT current_timestamp(),
  `registrar` varchar(13) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `combination_courses`
--

CREATE TABLE `combination_courses` (
  `combination` varchar(10) NOT NULL,
  `course_code` varchar(10) NOT NULL,
  `date_registered` timestamp NOT NULL DEFAULT current_timestamp(),
  `registrar` varchar(13) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `combination_courses`
--

INSERT INTO `combination_courses` (`combination`, `course_code`, `date_registered`, `registrar`) VALUES
('MT+IS', 'IS 353', '2017-05-08 16:33:12', '00207');

-- --------------------------------------------------------

--
-- Table structure for table `computed`
--

CREATE TABLE `computed` (
  `id` varchar(40) DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `computed`
--

INSERT INTO `computed` (`id`, `date`) VALUES
('magashi80@gmail.com', '2017-05-08 17:19:59'),
('magashi80@gmail.com', '2017-05-11 09:22:19');

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `course_code` varchar(10) NOT NULL,
  `course_name` varchar(40) DEFAULT NULL,
  `units` int(1) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `semester` int(1) DEFAULT NULL,
  `yos` int(1) DEFAULT NULL,
  `date_registered` timestamp NOT NULL DEFAULT current_timestamp(),
  `registrar` varchar(13) DEFAULT NULL,
  `dept_no` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `course`
--

INSERT INTO `course` (`course_code`, `course_name`, `units`, `type`, `semester`, `yos`, `date_registered`, `registrar`, `dept_no`) VALUES
('IS 353', 'Database Implementation', 3, 'Core', 2, 3, '2017-05-08 16:32:46', '00207', 'IS');

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `dept_no` varchar(10) NOT NULL,
  `dept_name` varchar(100) DEFAULT NULL,
  `fac_code` varchar(10) DEFAULT NULL,
  `date_registered` timestamp NOT NULL DEFAULT current_timestamp(),
  `registrar` varchar(13) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`dept_no`, `dept_name`, `fac_code`, `date_registered`, `registrar`) VALUES
('IS', 'Informatics', 'FOSC', '2017-05-08 16:20:49', '00207'),
('MT', 'Mathematics', 'FOSC', '2017-05-08 16:21:22', '00207'),
('PH', 'Physics', 'FOSC', '2017-05-08 16:21:47', '00207');

-- --------------------------------------------------------

--
-- Table structure for table `faculty`
--

CREATE TABLE `faculty` (
  `fac_code` varchar(10) NOT NULL,
  `fac_name` varchar(100) DEFAULT NULL,
  `date_registered` timestamp NOT NULL DEFAULT current_timestamp(),
  `registrar` varchar(13) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `faculty`
--

INSERT INTO `faculty` (`fac_code`, `fac_name`, `date_registered`, `registrar`) VALUES
('FOED', 'Faculty of Education', '2017-05-08 14:57:33', '00207'),
('FOHSS', 'Faculty of Humanities and Social Science', '2017-05-08 14:58:15', '00207'),
('FOSC', 'Faculty of Science', '2017-05-08 14:56:47', '00207');

-- --------------------------------------------------------

--
-- Table structure for table `programme`
--

CREATE TABLE `programme` (
  `prog_code` varchar(20) NOT NULL,
  `prog_name` varchar(100) DEFAULT NULL,
  `fac_code` varchar(10) DEFAULT NULL,
  `date_registered` timestamp NOT NULL DEFAULT current_timestamp(),
  `registrar` varchar(13) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `programme`
--

INSERT INTO `programme` (`prog_code`, `prog_name`, `fac_code`, `date_registered`, `registrar`) VALUES
('B.A.(Ed)', 'Bachelor of Arts with Education', 'FOHSS', '2017-05-08 15:07:29', '00207'),
('B.Ed.(Arts)', 'Bachelor of Arts in Education', 'FOED', '2017-05-08 15:05:54', '00207'),
('B.Ed.(Science)', 'Bachelor of Arts in Science', 'FOED', '2017-05-08 15:06:32', '00207'),
('B.Sc.(Ed.)', 'Bachelor of Science with Education', 'FOSC', '2017-05-08 14:59:42', '00207');

-- --------------------------------------------------------

--
-- Table structure for table `room`
--

CREATE TABLE `room` (
  `room_no` int(4) NOT NULL,
  `block_no` varchar(20) NOT NULL,
  `room_name` varchar(20) DEFAULT NULL,
  `capacity` int(5) DEFAULT NULL,
  `date_registered` timestamp NOT NULL DEFAULT current_timestamp(),
  `registrar` varchar(13) DEFAULT NULL,
  `purpose` varchar(40) DEFAULT 'Teaching'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `semesterisation`
--

CREATE TABLE `semesterisation` (
  `ac_year` varchar(10) NOT NULL,
  `semester` int(1) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `date_registered` timestamp NOT NULL DEFAULT current_timestamp(),
  `registrar` varchar(13) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `semesterisation`
--

INSERT INTO `semesterisation` (`ac_year`, `semester`, `start_date`, `end_date`, `date_registered`, `registrar`) VALUES
('2016/2017', 2, '2017-02-10', '2017-07-09', '2017-05-08 16:12:49', '00207');

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `staff_id` varchar(20) NOT NULL,
  `fname` varchar(20) DEFAULT NULL,
  `mname` varchar(20) DEFAULT NULL,
  `lname` varchar(20) DEFAULT NULL,
  `phone` varchar(13) DEFAULT NULL,
  `home_address` varchar(100) DEFAULT NULL,
  `designation` varchar(40) DEFAULT NULL,
  `marital` varchar(10) DEFAULT NULL,
  `gender` varchar(6) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `date_registered` timestamp NOT NULL DEFAULT current_timestamp(),
  `email` varchar(40) DEFAULT 'nill',
  `type` varchar(20) DEFAULT 'user',
  `status` varchar(10) DEFAULT 'Unblocked'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`staff_id`, `fname`, `mname`, `lname`, `phone`, `home_address`, `designation`, `marital`, `gender`, `dob`, `password`, `title`, `date_registered`, `email`, `type`, `status`) VALUES
('00207', 'Cosmas', 'Herman', 'Magashi', '0754433075', 'P. O Box 1674 IRINGA', 'Assistant Lecturer', 'Married', 'Male', '1980-04-23', '*72871C7AA43C196F65C29C4EAD9DF8A030675324', 'Mr.', '2017-05-08 16:23:27', 'magashi80@gmail.com', 'Administrator', 'Unblocked'),
('00209', 'Jonas', 'Kato', 'Makubo', '0754433077', 'P. O Box 1674 IRINGA', 'Assistant Lecturer', 'Married', 'Male', '1980-04-23', '*72871C7AA43C196F65C29C4EAD9DF8A030675324', 'Mr.', '2017-05-08 17:33:35', 'MAGASHI80@YAHOO.COM', 'user', 'Unblocked');

-- --------------------------------------------------------

--
-- Table structure for table `staff_department`
--

CREATE TABLE `staff_department` (
  `staff_id` varchar(20) NOT NULL,
  `dept_no` varchar(10) NOT NULL,
  `date_registered` timestamp NOT NULL DEFAULT current_timestamp(),
  `category` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `staff_department`
--

INSERT INTO `staff_department` (`staff_id`, `dept_no`, `date_registered`, `category`) VALUES
('00207', 'IS', '2017-05-08 16:23:27', 'Academic'),
('00209', 'IS', '2017-05-08 17:33:35', 'Academic');

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `reg_no` varchar(13) NOT NULL,
  `fname` varchar(20) DEFAULT NULL,
  `mname` varchar(20) DEFAULT NULL,
  `lname` varchar(20) DEFAULT NULL,
  `phone` varchar(13) DEFAULT NULL,
  `email` varchar(40) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `home_address` varchar(100) DEFAULT NULL,
  `marital` varchar(10) DEFAULT NULL,
  `gender` varchar(6) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `date_registered` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` varchar(10) DEFAULT 'Unblocked'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`reg_no`, `fname`, `mname`, `lname`, `phone`, `email`, `dob`, `home_address`, `marital`, `gender`, `password`, `date_registered`, `status`) VALUES
('2006-04-03798', 'Nancy', 'Cosmas', 'Magashi', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2017-05-08 17:21:24', 'Unblocked');

-- --------------------------------------------------------

--
-- Table structure for table `student_course`
--

CREATE TABLE `student_course` (
  `reg_no` varchar(13) NOT NULL,
  `course_code` varchar(10) NOT NULL,
  `date_registered` timestamp NOT NULL DEFAULT current_timestamp(),
  `registrar` varchar(13) DEFAULT NULL,
  `ac_year` varchar(10) DEFAULT NULL,
  `semester` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `student_programme`
--

CREATE TABLE `student_programme` (
  `reg_no` varchar(13) NOT NULL,
  `prog_code` varchar(20) NOT NULL,
  `date_registered` timestamp NOT NULL DEFAULT current_timestamp(),
  `registrar` varchar(13) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `timetable`
--

CREATE TABLE `timetable` (
  `course_code` varchar(10) NOT NULL,
  `lesson_type` varchar(10) NOT NULL,
  `day` varchar(10) NOT NULL,
  `start_time` int(4) DEFAULT NULL,
  `end_time` int(4) DEFAULT NULL,
  `ac_year` varchar(10) NOT NULL,
  `semester` int(1) NOT NULL,
  `registrar` varchar(10) DEFAULT NULL,
  `block_no` varchar(20) DEFAULT NULL,
  `room_no` int(5) DEFAULT NULL,
  `date_registered` timestamp NOT NULL DEFAULT current_timestamp(),
  `room_name` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tmatrix`
--

CREATE TABLE `tmatrix` (
  `course_code` varchar(10) NOT NULL,
  `staff_id` varchar(20) NOT NULL,
  `ac_year` varchar(10) NOT NULL,
  `semester` int(1) NOT NULL,
  `assigner` varchar(20) DEFAULT NULL,
  `date_assigned` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `block`
--
ALTER TABLE `block`
  ADD PRIMARY KEY (`block_no`);

--
-- Indexes for table `combination_courses`
--
ALTER TABLE `combination_courses`
  ADD PRIMARY KEY (`combination`,`course_code`),
  ADD KEY `course_code` (`course_code`);

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`course_code`),
  ADD KEY `dept_no` (`dept_no`);

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`dept_no`),
  ADD KEY `fac_code` (`fac_code`);

--
-- Indexes for table `faculty`
--
ALTER TABLE `faculty`
  ADD PRIMARY KEY (`fac_code`);

--
-- Indexes for table `programme`
--
ALTER TABLE `programme`
  ADD PRIMARY KEY (`prog_code`),
  ADD KEY `fac_code` (`fac_code`);

--
-- Indexes for table `room`
--
ALTER TABLE `room`
  ADD PRIMARY KEY (`room_no`,`block_no`),
  ADD KEY `block_no` (`block_no`);

--
-- Indexes for table `semesterisation`
--
ALTER TABLE `semesterisation`
  ADD PRIMARY KEY (`ac_year`,`semester`,`start_date`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`staff_id`),
  ADD UNIQUE KEY `phone` (`phone`);

--
-- Indexes for table `staff_department`
--
ALTER TABLE `staff_department`
  ADD PRIMARY KEY (`staff_id`,`dept_no`),
  ADD KEY `dept_no` (`dept_no`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`reg_no`),
  ADD UNIQUE KEY `phone` (`phone`);

--
-- Indexes for table `student_course`
--
ALTER TABLE `student_course`
  ADD PRIMARY KEY (`reg_no`,`course_code`),
  ADD KEY `course_code` (`course_code`),
  ADD KEY `ac_year` (`ac_year`,`semester`);

--
-- Indexes for table `student_programme`
--
ALTER TABLE `student_programme`
  ADD PRIMARY KEY (`reg_no`,`prog_code`),
  ADD KEY `prog_code` (`prog_code`);

--
-- Indexes for table `timetable`
--
ALTER TABLE `timetable`
  ADD PRIMARY KEY (`course_code`,`day`,`lesson_type`,`ac_year`,`semester`),
  ADD KEY `ac_year` (`ac_year`,`semester`),
  ADD KEY `registrar` (`registrar`),
  ADD KEY `room_no` (`room_no`,`block_no`);

--
-- Indexes for table `tmatrix`
--
ALTER TABLE `tmatrix`
  ADD PRIMARY KEY (`course_code`,`staff_id`,`ac_year`,`semester`),
  ADD KEY `staff_id` (`staff_id`),
  ADD KEY `ac_year` (`ac_year`,`semester`),
  ADD KEY `assigner` (`assigner`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `combination_courses`
--
ALTER TABLE `combination_courses`
  ADD CONSTRAINT `combination_courses_ibfk_1` FOREIGN KEY (`course_code`) REFERENCES `course` (`course_code`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `course`
--
ALTER TABLE `course`
  ADD CONSTRAINT `course_ibfk_1` FOREIGN KEY (`dept_no`) REFERENCES `department` (`dept_no`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `department`
--
ALTER TABLE `department`
  ADD CONSTRAINT `department_ibfk_1` FOREIGN KEY (`fac_code`) REFERENCES `faculty` (`fac_code`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `programme`
--
ALTER TABLE `programme`
  ADD CONSTRAINT `programme_ibfk_1` FOREIGN KEY (`fac_code`) REFERENCES `faculty` (`fac_code`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `room`
--
ALTER TABLE `room`
  ADD CONSTRAINT `room_ibfk_1` FOREIGN KEY (`block_no`) REFERENCES `block` (`block_no`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `staff_department`
--
ALTER TABLE `staff_department`
  ADD CONSTRAINT `staff_department_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `staff_department_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `department` (`dept_no`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `student_course`
--
ALTER TABLE `student_course`
  ADD CONSTRAINT `student_course_ibfk_1` FOREIGN KEY (`reg_no`) REFERENCES `student` (`reg_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `student_course_ibfk_2` FOREIGN KEY (`course_code`) REFERENCES `course` (`course_code`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `student_course_ibfk_3` FOREIGN KEY (`ac_year`,`semester`) REFERENCES `semesterisation` (`ac_year`, `semester`);

--
-- Constraints for table `student_programme`
--
ALTER TABLE `student_programme`
  ADD CONSTRAINT `student_programme_ibfk_1` FOREIGN KEY (`reg_no`) REFERENCES `student` (`reg_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `student_programme_ibfk_2` FOREIGN KEY (`prog_code`) REFERENCES `programme` (`prog_code`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `timetable`
--
ALTER TABLE `timetable`
  ADD CONSTRAINT `timetable_ibfk_1` FOREIGN KEY (`course_code`) REFERENCES `course` (`course_code`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `timetable_ibfk_2` FOREIGN KEY (`ac_year`,`semester`) REFERENCES `semesterisation` (`ac_year`, `semester`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `timetable_ibfk_3` FOREIGN KEY (`registrar`) REFERENCES `staff` (`staff_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `timetable_ibfk_4` FOREIGN KEY (`room_no`,`block_no`) REFERENCES `room` (`room_no`, `block_no`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tmatrix`
--
ALTER TABLE `tmatrix`
  ADD CONSTRAINT `tmatrix_ibfk_1` FOREIGN KEY (`course_code`) REFERENCES `course` (`course_code`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tmatrix_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tmatrix_ibfk_3` FOREIGN KEY (`ac_year`,`semester`) REFERENCES `semesterisation` (`ac_year`, `semester`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tmatrix_ibfk_4` FOREIGN KEY (`assigner`) REFERENCES `staff` (`staff_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
