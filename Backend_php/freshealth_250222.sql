-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- 主机： localhost:8889
-- 生成日期： 2025-02-22 05:35:14
-- 服务器版本： 8.0.35
-- PHP 版本： 8.2.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `freshealth`
--

-- --------------------------------------------------------

--
-- 表的结构 `ActDb`
--

CREATE TABLE `ActDb` (
  `id` int NOT NULL,
  `recID` int NOT NULL,
  `aid` int NOT NULL,
  `count` float(5,2) NOT NULL,
  `time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `ActDb`
--

INSERT INTO `ActDb` (`id`, `recID`, `aid`, `count`, `time`) VALUES
(2, 1, 49, 1.00, '2025-02-20 15:54:09'),
(1, 2, 22, 12.00, '2025-02-20 16:24:22'),
(1, 3, 4, 1.00, '2025-02-20 16:24:35'),
(1, 4, 49, 2.00, '2025-02-20 18:19:31'),
(1, 5, 11, 1.00, '2025-02-20 19:06:49'),
(1, 6, 11, 1.20, '2025-02-20 19:07:22'),
(1, 7, 54, 1.00, '2025-02-20 19:07:54'),
(1, 8, 21, 1.00, '2025-02-20 19:08:05'),
(1, 9, 21, 10.00, '2025-02-20 19:08:09'),
(1, 10, 31, 2.00, '2025-02-21 11:52:17'),
(8, 11, 41, 1.00, '2025-02-21 12:02:39'),
(1, 12, 1, 1.00, '2025-02-21 14:02:44'),
(1, 13, 57, 1.00, '2025-02-21 14:03:33');

-- --------------------------------------------------------

--
-- 表的结构 `ActInfoDb`
--

CREATE TABLE `ActInfoDb` (
  `aid` int NOT NULL,
  `type` int NOT NULL COMMENT 'type0:food type1:sport',
  `name` varchar(100) NOT NULL,
  `description` varchar(100) NOT NULL,
  `calorie` float(5,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- 转存表中的数据 `ActInfoDb`
--

INSERT INTO `ActInfoDb` (`aid`, `type`, `name`, `description`, `calorie`) VALUES
(1, 1, 'Running', 'High-intensity cardio exercise.', -600.00),
(2, 1, 'Swimming', 'Full-body water workout.', -500.00),
(3, 1, 'Cycling', 'Cardio on a bike.', -480.00),
(4, 1, 'Jump Rope', 'High-intensity cardio.', -700.00),
(5, 1, 'Rowing', 'Full-body rowing workout.', -600.00),
(6, 1, 'Hiking', 'Outdoor walking exercise.', -400.00),
(7, 1, 'Aerobics', 'Group cardio workout.', -450.00),
(8, 1, 'Tennis', 'Racket sport.', -400.00),
(9, 1, 'Basketball', 'Team sport with a ball.', -500.00),
(10, 1, 'Soccer', 'Team sport with a ball.', -600.00),
(11, 1, 'Boxing', 'High-intensity combat sport.', -700.00),
(12, 1, 'Dancing', 'Rhythmic body movements.', -400.00),
(13, 1, 'Yoga', 'Mind-body practice.', -200.00),
(14, 1, 'Pilates', 'Core-strengthening workout.', -300.00),
(15, 1, 'Weightlifting', 'Strength training.', -300.00),
(16, 1, 'Martial Arts', 'Combat sport.', -700.00),
(17, 1, 'Golf', 'Outdoor sport with clubs.', -300.00),
(18, 1, 'Skiing', 'Winter sport on snow.', -500.00),
(19, 1, 'Surfing', 'Water sport on waves.', -300.00),
(20, 1, 'Rock Climbing', 'Vertical climbing sport.', -600.00),
(21, 0, 'Cucumber', 'Hydrating, crunchy vegetable.', 16.00),
(22, 0, 'Lettuce', 'Leafy, low-calorie green.', 5.00),
(23, 0, 'Celery', 'Crisp, fibrous stalks.', 10.00),
(24, 0, 'Tomato', 'Juicy, red fruit.', 22.00),
(25, 0, 'Spinach', 'Nutrient-rich leafy green.', 23.00),
(26, 0, 'Zucchini', 'Mild, versatile squash.', 17.00),
(27, 0, 'Broccoli', 'Crunchy, green vegetable.', 55.00),
(28, 0, 'Cauliflower', 'White, cruciferous veggie.', 25.00),
(29, 0, 'Bell Pepper', 'Sweet, colorful veggie.', 24.00),
(30, 0, 'Mushroom', 'Earthy, umami fungi.', 15.00),
(31, 0, 'Strawberries', 'Sweet, red berries.', 53.00),
(32, 0, 'Blueberries', 'Small, sweet berries.', 57.00),
(33, 0, 'Grapefruit', 'Tart, citrus fruit.', 52.00),
(34, 0, 'Watermelon', 'Juicy, hydrating fruit.', 30.00),
(35, 0, 'Peach', 'Sweet, juicy stone fruit.', 59.00),
(36, 0, 'Plum', 'Sweet, tart stone fruit.', 46.00),
(37, 0, 'Raspberries', 'Tart, red berries.', 64.00),
(38, 0, 'Blackberries', 'Sweet, dark berries.', 43.00),
(39, 0, 'Cantaloupe', 'Sweet, orange melon.', 60.00),
(40, 0, 'Papaya', 'Sweet, tropical fruit.', 68.00),
(41, 0, 'Avocado', 'Creamy, nutrient-rich fruit.', 234.00),
(42, 0, 'Granola', 'Crunchy, sweet cereal.', 597.00),
(43, 0, 'Peanut Butter', 'Creamy, nutty spread.', 180.00),
(44, 0, 'Cheese', 'Rich, aged dairy.', 113.00),
(45, 0, 'Dark Chocolate', 'Rich, bittersweet treat.', 170.00),
(46, 0, 'Nuts', 'Crunchy, healthy snack.', 160.00),
(47, 0, 'Olive Oil', 'Rich, healthy fat.', 119.00),
(48, 0, 'Butter', 'Creamy, rich dairy.', 102.00),
(49, 0, 'Bacon', 'Savory, crispy meat.', 42.00),
(50, 0, 'Ice Cream', 'Sweet, creamy dessert.', 207.00),
(51, 0, 'Pizza', 'Savory, cheesy dish.', 298.00),
(52, 0, 'Burger', 'Juicy, savory sandwich.', 354.00),
(53, 0, 'Pasta', 'Classic Italian dish.', 221.00),
(54, 0, 'Bagel', 'Dense, chewy bread.', 245.00),
(55, 0, 'Croissant', 'Flaky, buttery pastry.', 231.00),
(56, 0, 'Fried Chicken', 'Crispy, savory meat.', 320.00),
(57, 0, 'Steak', 'Juicy, tender meat.', 679.00),
(58, 0, 'Pork Ribs', 'Savory, tender meat.', 288.00),
(59, 0, 'Lasagna', 'Layered, cheesy pasta.', 336.00),
(60, 0, 'Milkshake', 'Sweet, creamy drink.', 350.00);

-- --------------------------------------------------------

--
-- 表的结构 `BioDb`
--

CREATE TABLE `BioDb` (
  `id` int NOT NULL,
  `calorie` float(7,2) NOT NULL,
  `water` int NOT NULL,
  `passed` tinyint(1) NOT NULL DEFAULT '0',
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `BioDb`
--

INSERT INTO `BioDb` (`id`, `calorie`, `water`, `passed`, `date`) VALUES
(1, 200.40, 3, 1, '2025-02-19 14:39:03'),
(2, 2000.00, 9, 1, '2025-02-19 20:33:51'),
(3, 4000.00, 5, 0, '2025-02-19 20:33:51'),
(4, 0.00, 0, 0, '2025-02-19 12:29:27'),
(5, 0.00, 0, 0, '2025-02-20 01:07:11'),
(6, -188.00, 3, 0, '2025-02-20 01:14:12'),
(7, 0.00, 0, 0, '2025-02-20 01:25:20'),
(8, 234.00, 2, 0, '2025-02-21 04:00:35');

--
-- 触发器 `BioDb`
--
DELIMITER $$
CREATE TRIGGER `before_insert_bioDb` BEFORE INSERT ON `BioDb` FOR EACH ROW BEGIN
    IF NEW.calorie > 2000 THEN
        SET NEW.passed = 0;
    ELSEIF NEW.water >= 8 THEN
        SET NEW.passed = 1;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_update_bioDb` BEFORE UPDATE ON `BioDb` FOR EACH ROW BEGIN
    IF NEW.calorie > 2000 THEN
        SET NEW.passed = 0;
    ELSEIF NEW.water >= 8 THEN
        SET NEW.passed = 1;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- 表的结构 `CommentDb`
--

CREATE TABLE `CommentDb` (
  `id` int NOT NULL,
  `postid` int NOT NULL,
  `comid` int NOT NULL,
  `plink` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `content` text COLLATE utf8mb4_general_ci NOT NULL,
  `like` int NOT NULL,
  `time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `CommentDb`
--

INSERT INTO `CommentDb` (`id`, `postid`, `comid`, `plink`, `content`, `like`, `time`) VALUES
(1, 1, 1, NULL, 'Hello it is a comment', 2, '2025-02-19 06:37:15');

-- --------------------------------------------------------

--
-- 表的结构 `PostDb`
--

CREATE TABLE `PostDb` (
  `id` int NOT NULL,
  `postid` int NOT NULL,
  `title` text COLLATE utf8mb4_general_ci NOT NULL,
  `content` text COLLATE utf8mb4_general_ci NOT NULL,
  `like` int NOT NULL,
  `time` datetime NOT NULL,
  `photo` text COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `PostDb`
--

INSERT INTO `PostDb` (`id`, `postid`, `title`, `content`, `like`, `time`, `photo`) VALUES
(1, 1, 'Hello it is FresHealth', 'Hello it is content', 5, '2025-02-19 05:53:52', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `UserDb`
--

CREATE TABLE `UserDb` (
  `id` int NOT NULL,
  `username` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `permission` int NOT NULL,
  `avatar` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `weight` float(5,2) NOT NULL,
  `height` float(5,2) NOT NULL,
  `expectWeight` float(5,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `UserDb`
--

INSERT INTO `UserDb` (`id`, `username`, `password`, `email`, `permission`, `avatar`, `weight`, `height`, `expectWeight`) VALUES
(1, 'test', 'test', 'test@mail.com', 1, 'http://localhost:8888/freshealth/photo/avatar/1_avatar.png', 85.00, 180.00, 70.00),
(2, 'example', 'example!', 'ex@am.ple', 1, NULL, 222.00, 111.00, 333.00),
(3, 'FYP', '1234!!!!', 'fyp@fyp.fyp', 1, 'http://localhost:8888/freshealth/photo/avatar/3_avatar.png', 80.00, 180.00, 70.00),
(4, 'fff', 'ffff@@@@', 'fff@fff.fff', 1, NULL, 11.00, 11.00, 11.00),
(5, 'aaa', 'aaaaaaa!', 'aaaa@aaa.aa', 1, NULL, 12.00, 12.00, 12.00),
(6, 'bb', 'bbbbbbb@', 'bbb@bb.bb', 1, NULL, 12.00, 12.00, 12.00),
(7, '222', '1111111!', '22@22.cc', 1, NULL, 11.00, 11.00, 11.00),
(8, 'tttt', 'ddddddd!', 'tt@ttt.tt', 1, 'http://localhost:8888/freshealth/photo/avatar/8_avatar.png', 111.00, 111.00, 111.00);

--
-- 转储表的索引
--

--
-- 表的索引 `ActDb`
--
ALTER TABLE `ActDb`
  ADD PRIMARY KEY (`recID`),
  ADD KEY `aid` (`aid`),
  ADD KEY `id` (`id`),
  ADD KEY `time` (`time`);

--
-- 表的索引 `ActInfoDb`
--
ALTER TABLE `ActInfoDb`
  ADD PRIMARY KEY (`aid`),
  ADD KEY `aid` (`aid`);

--
-- 表的索引 `BioDb`
--
ALTER TABLE `BioDb`
  ADD PRIMARY KEY (`id`),
  ADD KEY `date` (`date`);

--
-- 表的索引 `CommentDb`
--
ALTER TABLE `CommentDb`
  ADD PRIMARY KEY (`comid`),
  ADD KEY `id` (`id`),
  ADD KEY `postid` (`postid`),
  ADD KEY `time` (`time`);

--
-- 表的索引 `PostDb`
--
ALTER TABLE `PostDb`
  ADD PRIMARY KEY (`postid`),
  ADD UNIQUE KEY `id` (`id`),
  ADD UNIQUE KEY `postid` (`postid`),
  ADD KEY `time` (`time`);

--
-- 表的索引 `UserDb`
--
ALTER TABLE `UserDb`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `ActInfoDb`
--
ALTER TABLE `ActInfoDb`
  MODIFY `aid` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- 使用表AUTO_INCREMENT `PostDb`
--
ALTER TABLE `PostDb`
  MODIFY `postid` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
