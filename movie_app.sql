-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 04, 2024 at 10:15 AM
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
-- Database: `movie_app`
--

-- --------------------------------------------------------

--
-- Table structure for table `answers`
--

CREATE TABLE `answers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `answerable_id` int(11) NOT NULL,
  `answerable_type` varchar(255) NOT NULL,
  `comment_id` bigint(20) UNSIGNED NOT NULL,
  `text` varchar(255) NOT NULL,
  `isExpoile` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `movie_id` bigint(20) UNSIGNED NOT NULL,
  `text` varchar(255) NOT NULL,
  `isExpoile` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `genres`
--

CREATE TABLE `genres` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `genres`
--

INSERT INTO `genres` (`id`, `title`, `created_at`, `updated_at`) VALUES
(1, 'اکشن', '2024-06-08 08:29:09', '2024-06-08 08:29:09'),
(2, 'جنایی', '2024-06-08 08:29:09', '2024-06-08 08:29:09'),
(3, 'هیجان انگیز', '2024-06-08 08:29:31', '2024-06-08 08:29:31'),
(4, 'ماجراجویی', '2024-06-08 08:49:15', '2024-06-08 08:49:15'),
(5, 'درام', '2024-06-08 09:03:49', '2024-06-08 09:03:49'),
(6, 'بیوگرافی', '2024-06-08 09:16:32', '2024-06-08 09:16:32'),
(7, 'ترسناک', '2024-06-08 09:29:39', '2024-06-08 09:29:39'),
(8, 'کمدی', '2024-06-08 10:04:08', '2024-06-08 10:04:08'),
(9, 'انیمیشن', '2024-06-08 10:40:03', '2024-06-08 10:40:03'),
(10, 'خانوادگی', '2024-06-08 10:40:03', '2024-06-08 10:40:03'),
(11, 'رازآلود', '2024-06-08 10:40:28', '2024-06-08 10:40:28'),
(12, 'عاشقانه', '2024-06-08 10:57:18', '2024-06-08 10:57:18'),
(13, 'فانتزی', NULL, NULL),
(14, 'علمی تخیلی', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `genre_movie`
--

CREATE TABLE `genre_movie` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `movie_id` bigint(20) UNSIGNED NOT NULL,
  `genre_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `genre_movie`
--

INSERT INTO `genre_movie` (`id`, `movie_id`, `genre_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2024-06-08 08:29:57', '2024-06-08 08:29:57'),
(2, 1, 2, '2024-06-08 08:29:57', '2024-06-08 08:29:57'),
(3, 1, 3, '2024-06-08 08:30:20', '2024-06-08 08:30:20'),
(4, 2, 1, '2024-06-08 08:49:29', '2024-06-08 08:49:29'),
(5, 2, 2, '2024-06-08 08:49:29', '2024-06-08 08:49:29'),
(10, 2, 4, '2024-06-08 08:50:14', '2024-06-08 08:50:14'),
(11, 3, 2, '2024-06-08 09:04:00', '2024-06-08 09:04:00'),
(12, 3, 5, '2024-06-08 09:04:00', '2024-06-08 09:04:00'),
(13, 3, 3, '2024-06-08 09:04:27', '2024-06-08 09:04:27'),
(14, 4, 6, '2024-06-08 09:16:47', '2024-06-08 09:16:47'),
(15, 4, 2, '2024-06-08 09:16:47', '2024-06-08 09:16:47'),
(16, 4, 5, '2024-06-08 09:17:16', '2024-06-08 09:17:16'),
(17, 4, 4, '2024-06-08 09:17:16', '2024-06-08 09:17:16'),
(18, 5, 7, '2024-06-08 09:34:22', '2024-06-08 09:34:22'),
(19, 5, 2, '2024-06-08 09:34:22', '2024-06-08 09:34:22'),
(20, 5, 3, '2024-06-08 09:34:42', '2024-06-08 09:34:42'),
(21, 6, 6, '2024-06-08 09:46:57', '2024-06-08 09:46:57'),
(22, 6, 2, '2024-06-08 09:46:57', '2024-06-08 09:46:57'),
(23, 6, 5, '2024-06-08 09:47:17', '2024-06-08 09:47:17'),
(24, 7, 1, '2024-06-08 10:04:23', '2024-06-08 10:04:23'),
(25, 7, 2, '2024-06-08 10:04:23', '2024-06-08 10:04:23'),
(26, 7, 8, '2024-06-08 10:04:44', '2024-06-08 10:04:44'),
(27, 8, 1, '2024-06-08 10:23:37', '2024-06-08 10:23:37'),
(28, 8, 2, '2024-06-08 10:23:37', '2024-06-08 10:23:37'),
(29, 8, 8, '2024-06-08 10:23:57', '2024-06-08 10:23:57'),
(30, 9, 9, '2024-06-08 10:40:47', '2024-06-08 10:40:47'),
(31, 9, 2, '2024-06-08 10:40:47', '2024-06-08 10:40:47'),
(32, 9, 10, '2024-06-08 10:41:19', '2024-06-08 10:41:19'),
(33, 9, 11, '2024-06-08 10:41:37', '2024-06-08 10:41:37'),
(34, 9, 4, '2024-06-08 10:41:52', '2024-06-08 10:41:52'),
(35, 11, 1, '2024-06-08 10:57:31', '2024-06-08 10:57:31'),
(36, 11, 2, '2024-06-08 10:57:31', '2024-06-08 10:57:31'),
(37, 11, 11, '2024-06-08 10:57:58', '2024-06-08 10:57:58'),
(38, 11, 12, '2024-06-08 10:58:08', '2024-06-08 10:58:08'),
(39, 11, 8, '2024-06-08 10:58:19', '2024-06-08 10:58:19'),
(40, 12, 1, '2024-06-08 17:12:47', '2024-06-08 17:12:47'),
(41, 12, 2, '2024-06-08 17:12:47', '2024-06-08 17:12:47'),
(42, 12, 8, '2024-06-08 17:13:07', '2024-06-08 17:13:07'),
(43, 13, 1, '2024-06-08 17:25:36', '2024-06-08 17:25:36'),
(44, 13, 2, '2024-06-08 17:25:36', '2024-06-08 17:25:36'),
(45, 13, 3, '2024-06-08 17:25:56', '2024-06-08 17:25:56'),
(46, 14, 1, NULL, NULL),
(47, 14, 2, NULL, NULL),
(48, 14, 8, NULL, NULL),
(49, 15, 7, NULL, NULL),
(50, 15, 5, NULL, NULL),
(51, 15, 11, NULL, NULL),
(52, 16, 7, NULL, NULL),
(53, 18, 7, NULL, NULL),
(54, 18, 4, NULL, NULL),
(55, 18, 3, NULL, NULL),
(56, 19, 2, NULL, NULL),
(57, 19, 5, NULL, NULL),
(58, 19, 8, NULL, NULL),
(59, 20, 1, NULL, NULL),
(60, 20, 7, NULL, NULL),
(61, 20, 4, NULL, NULL),
(62, 21, 1, NULL, NULL),
(63, 21, 2, NULL, NULL),
(64, 21, 4, NULL, NULL),
(65, 22, 7, NULL, NULL),
(66, 22, 5, NULL, NULL),
(67, 22, 13, NULL, NULL),
(68, 23, 1, NULL, NULL),
(69, 24, 1, NULL, NULL),
(70, 24, 3, NULL, NULL),
(71, 25, 1, NULL, NULL),
(72, 25, 4, NULL, NULL),
(73, 25, 14, NULL, NULL),
(74, 26, 7, NULL, NULL),
(75, 26, 11, NULL, NULL),
(76, 27, 14, NULL, NULL),
(77, 27, 3, NULL, NULL),
(78, 28, 1, NULL, NULL),
(79, 28, 13, NULL, NULL),
(80, 29, 1, NULL, NULL),
(81, 29, 4, NULL, NULL),
(82, 29, 3, NULL, NULL),
(83, 30, 6, NULL, NULL),
(84, 30, 5, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `likes`
--

CREATE TABLE `likes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `movie_id` bigint(20) UNSIGNED NOT NULL,
  `isliked` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2024_06_05_060240_create_personal_access_tokens_table', 1),
(5, '2024_06_06_093625_create_genres_table', 1),
(6, '2024_06_06_093720_create_tags_table', 1),
(7, '2024_06_06_093745_create_movies_table', 1),
(8, '2024_06_06_095537_create_stars_table', 1),
(9, '2024_06_06_095722_create_movie_links_table', 1),
(10, '2024_06_06_100241_create_seasons_table', 1),
(11, '2024_06_06_100614_create_sections_table', 1),
(12, '2024_06_06_100921_create_series_links_table', 1),
(13, '2024_06_06_101224_create_movie_tag_table', 1),
(14, '2024_06_06_101252_create_genre_movie_table', 1),
(15, '2024_06_06_101321_create_likes_table', 1),
(16, '2024_06_06_101442_create_comments_table', 1),
(17, '2024_06_06_101446_create_answers_table', 1),
(18, '2024_06_06_102014_create_movie_star_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `movies`
--

CREATE TABLE `movies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `title_fa` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `image_bg` varchar(255) NOT NULL,
  `imdb` varchar(255) NOT NULL,
  `populer` varchar(255) NOT NULL DEFAULT '0',
  `year` varchar(255) NOT NULL,
  `text` varchar(255) NOT NULL,
  `type` enum('0','1') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `movies`
--

INSERT INTO `movies` (`id`, `title`, `title_fa`, `image`, `image_bg`, `imdb`, `populer`, `year`, `text`, `type`, `created_at`, `updated_at`) VALUES
(1, 'Yaksha: Ruthless Operations', 'یاکشا: عملیات بی رحمانه', '/images/movies/yaksha-ruthless-operations.jpg', '/images/movies/yaksha-ruthless-operations-bg.jpg', '6.2', '0', '2022', 'رهبر بی‌رحم یک تیم عملیات سیاه‌پوست خارج از کشور که به روح انسان‌خوار ملقب است، یک ماموریت خطرناک را در شهری مملو از جاسوسان انجام می‌دهد.', '0', '2024-06-08 08:28:27', '2024-06-18 13:30:33'),
(2, 'Johnny & Clyde', 'جانی و کلاید', '/images/movies/johnny-clyde.webp', '/images/movies/johnny-clyde-bg.jpg', '4.1', '0', '2023', 'جانی و کلاید دو قاتل زنجیره ای هستند که دیوانه وار عاشق شده و در جنایتی بی پایان قرار دارند. آنها به سرقت از یک کازینو که متعلق به رئیس جنایت آلانا است و توسط یک قاتل اهریمنی که او فرمان می دهد محافظت می شود، می اندیشند...', '0', '2024-06-08 08:47:27', '2024-06-08 08:47:27'),
(3, 'The Guilty', 'گناهکار', '/images/movies/guilty.jpg', '/images/movies/guilt-bg.jpg', '6.3', '0', '2023', 'افسر پلیسی که تنزل درجه یافته، برای انجام یک ماموریت منصوب شده است. وی هنگامی که یک تماس اضطراری از زنی ربوده شده دریافت می‌کند،سردرگم می‌شود و...', '0', '2024-06-08 09:01:33', '2024-06-08 09:01:33'),
(4, 'Papillon', 'پاپیون', '/images/movies/papillion.jpg', '/images/movies/papillion-bg.jpg', '7.2', '0', '2017', 'پاپیون (چارلی هونام) کسی است که جرم خود را قبول ندارد، به همراه دوستش لوئیس دگا (رامی ملک) که به تازگی به جرم جعل اسناد به زندان افتاده به دنبال فرار از زندان فرانسه هستند…', '0', '2024-06-08 09:14:21', '2024-06-08 09:14:21'),
(5, 'Little Bone Lodge', 'کلبه استخوان کوچک', '/images/movies/little-bone-lodge.jpg', '/images/movies/little-bone-lodge-bg.jpg', '6.4', '0', '2023', 'دو برادر جنایتکار که در طول یک طوفان وحشتناک گیر می‌افتند، به یک خانه مزرعه متروک پناه می‌برند. با به اسارت گرفتن خانواده ساکن، آنها متوجه می شوند که خانه اسرار تاریک خود را دارد.', '0', '2024-06-08 09:28:03', '2024-06-08 09:28:03'),
(6, 'The Good Nurse', 'پرستار خوب', '/images/movies/good-nurse.jpg', '/images/movies/good-nurse-bg.jpg', '6.8', '0', '2022', 'امی، یک پرستار دلسوز و مادر مجرد که با یک بیماری قلبی تهدید کننده زندگی دست و پنجه نرم می کند، در شیفت های شبانه سخت و طاقت فرسا در ICU به محدودیت های جسمی و عاطفی خود کشیده می شود.', '0', '2024-06-08 09:45:03', '2024-06-08 09:45:03'),
(7, 'Accident Man: Hitman’s Holiday', 'مرد حادثه آفرین', '/images/movies/Accident-Man.jpg', '/images/movies/Accident-Man-bg.jpg', '5.8', '0', '2022', 'مرد تصادفی بازگشته است و این بار باید قاتلان برتر جهان را شکست دهد تا از پسر ناسپاس یک رئیس مافیا محافظت کند، جان تنها دوستش را نجات دهد و رابطه خود را با پدر دیوانه اش احیا کند.', '0', '2024-06-08 10:02:24', '2024-06-08 10:02:24'),
(8, 'Central Intelligence', 'هوش مرکزی', '/images/movies/centeral-intelligence.jpg', '/images/movies/centeral-intelligence-bg.jpg', '6.3', '0', '2016', 'وقتی (هارد) با دوست دوران مدرسه اش روبرو می شود متوجه می شود که دوستش (جانسون) برای سازمان جاسوسی سیا کار می کند، او همراه با دوستش تصمیم به جاسوسی از یک پرونده ی نظامی را می گیرند که …', '0', '2024-06-08 10:21:51', '2024-06-08 10:21:51'),
(9, 'Zootopia ', 'زوتوپیا', '/images/movies/zotopia.jpg', '/images/movies/zotopia-bg.jpg', '8', '0', '2016', 'داستان شهری به همین نام است که در آن‌ حیوانات مختلف در کنار یکدیگر به صورت مسالمت آمیزی زندگی‌ می‌کنند. شهر زوتوپیا مانند تمام شهرهای مدرن امروزی از مناطق مختلفی‌ تشکیل شده و انواع و اقسام حیوانات در این شهر به کار و زندگی‌ مشغول هستند. اما هنگامی که خرگو', '0', '2024-06-08 10:37:08', '2024-06-08 10:37:08'),
(11, 'Murder Mystery', 'معمای قتل', '/images/movies/Murder-Mystery.jpg', '/images/movies/Murder-Mystery-bg.jpg', '6', '0', '2019', 'یک نیروی پلیس اهل نیویورک به همراه همسرش برای گذراندن تعطیلات اروپایی و همچنین برگزاری مراسم ازدواج با هم راهی سفر می شوند که قتلی بزرگ با یک میلیاردر رخ می دهد ...', '0', '2024-06-08 10:56:02', '2024-06-08 10:56:02'),
(12, 'Hit Man', 'آدمکش', '/images/movies/hit-man.jpg', '/images/movies/hit-man-bg.jpg', '7.4', '15', '2023', 'این فیلم به دنبال گری جانسون، یک بازرس کار است که نقش یک قاتل را بازی می کند تا افرادی را که دستور قتل می دهند، دستگیر کند.', '0', '2024-06-08 17:10:32', '2024-06-08 17:10:32'),
(13, 'Nobody ', 'هیچ‌کس', '/images/movies/nobody.jpg', '/images/movies/nobody-bg.jpg', '7.4', '25', '2021', 'بعد از اینکه یک رهگذر به یک زن که توسط چندین مورد حمله قرار گرفته کمک میکند، تبدیل به هدف انتقام رئیس یک باند قاچاق مواد می‌شود...', '0', '2024-06-08 17:23:34', '2024-06-08 17:23:34'),
(14, 'Murder Mystery 2', 'راز جنایت 2', '/images/movies/Murder-Mystery-2.png', '/images/movies/Murder-Mystery-2-bg.jpg', '5.7', '0', '2023', 'نیک و آدری که اکنون به عنوان کارآگاهان تمام وقت کار می‌کنند، در تلاشند تا آژانس خصوصی خود را راه اندازی کنند. در این میان زمانی که دوست آن‌ها در مراسم عروسی مجلل خود ربوده می‌شود، نیک و آدری خود را در مرکز یک آدم‌ربایی خطرناک می‌بینند و… ', '0', '2024-06-08 17:36:37', '2024-06-08 17:36:37'),
(15, 'Helix', 'منحنی', '/images/movies/Helix.jpg', '/images/movies/Helix-bg.jpg', '6.7', '0', '2022', 'داستان سریال از جایی شروع میشود که دکتر پیتر فاراگات در یک آزمایشگاه سری که در قطب شمال واقع شده در حال آزمایش بر روی یک ویروس ناشناس و بسیار خطرناک میباشد ویروسی که میتواند حیات تمام موجودات روی کره زمین را به خطر بیندازد اما به آن ویروس الوده میشود. ', '1', NULL, NULL),
(16, 'The Walking Dead: Daryl Dixon', 'مردگان متحرک: دریل دیکسون', '/images/movies/Walking-Dead-Daryl-Dixon.jpg', '/images/movies/Walking-Dead-Daryl-Dixon-bg.webp', '7.9', '0', '2023', 'دریل در پاریس (منشا ویروس زامبی) به ساحل می‌رسد و تلاش می‌کند تا چگونگی و دلیل رسیدن به آنجا را متوجه شود. این سریال سفر او را در یک فرانسه شکسته اما انعطاف پذیر دنبال می‌کند، زیرا او امیدوار است راهی برای بازگشت به خانه پیدا کند. با این حال، همانطور که ا', '1', NULL, NULL),
(18, 'The Walking Dead: Dead City', 'مردگان متحرک: شهر مردگان', '/images/movies/MV5BMzczNjBlYmYtMjEwYi00MzJhLWFkOTUtNjViNzEzMGM5YWJmXkEyXkFqcGdeQXVyMTMzOTQyOTk1._V1_.jpg', '/images/movies/wddc.jpg', '7.6', '0', '2023', 'ریال مردگان متحرک: شهر مرده چهارمین اسپین‌آف و به‌طور کلی پنجمین سری از فرنچایز The Walking Dead و اولین دنباله مجموعه تلویزیونی The Walking Dead است. ...', '1', NULL, NULL),
(19, 'Glass Onion: A Knives Out Mystery', 'گلس آنین: یک چاقوکشی اسرارآمیز', '/images/movies/Glass_Onion_poster.jpg', '/images/movies/1671873407270168093.ZARFILM.jpg', '7.4', '0', '2022', 'بنویت بلانک کارآگاه مشهور جنوبی برای آخرین پرونده خود به یونان سفر می کند... ', '0', NULL, NULL),
(20, 'Meg 2: The Trench', 'مگ 2: گودال', '/images/movies/MV5BMTM2NTU1ZTktNjc4YS00NjNhLWE4NmYtOTM2YjFjOGUzNmYzXkEyXkFqcGdeQXVyODE5NzE3OTE@._V1_.jpg', '/images/movies/30441632.webp', '5.5', '0', '2023', 'یک تیم تحقیقاتی در حین کاوش در اعماق اقیانوس با تهدیدات متعددی از جمله یک عملیات معدنکاری بدخواهانه مواجه می شوند.', '0', NULL, NULL),
(21, 'The Last of Us', 'آخرینِ ما', '/images/movies/MV5BZGUzYTI3M2EtZmM0Yy00NGUyLWI4ODEtN2Q3ZGJlYzhhZjU3XkEyXkFqcGdeQXVyNTM0OTY1OQ@@._V1_.jpg', '/images/movies/16738582841900741298.ZARFILM.jpg', '9.9', '98', '2023', 'داستان این سریال 20 سال بعد از نابودی تمدن جریان دارد. جول (پدرو پاسکال) استخدام می‌شود تا دختری 14 ساله به نام الی (بلا رمزی) را از منطقه‌ی قرنطینه خارج کند و به مقصد مورد نظر برساند.', '1', NULL, NULL),
(22, 'Stranger Things', 'چیزهای غریب', '/images/movies/ems.jpg', '/images/movies/1655470971230419106.ZARFILM.jpg', '8.7', '0', '2022', 'داستان در دهه 80 میلادی در شهر ساحلی لانگ ایلند اتفاق می افتد. پس از ناپدید شدن یک پسر جوان، تحقیقات برای پیدا کردن او آغاز میشود...', '1', NULL, NULL),
(23, 'I Am Rage', 'من خشم هستم', '/images/movies/MV5BZTNmZmFkODYtNzBiNS00Mjg2LTg5MDEtOGFlMWRlNTU5NWRkXkEyXkFqcGdeQXVyNTY2OTgxNQ@@._V1_.jpg', '/images/movies/2zzaJ9jzyK1Am8XoS0dFjmP8V0L-scaled.jpg', '3.5', '0', '2019', 'یک فرقه خطرناک که زنی جوان را که برای رسیدن به آرامش به حومه شهر سفر کرده، می‌ربایند. اما آن‌ها با اینکار مرتکب اشتباه بزرگی شده و به زودی با عواقب دردناک تکان‌دهنده روبرو خواهند شد و… ', '0', NULL, NULL),
(24, 'The Covenant', 'پیمان', '/images/movies/MV5BNmQzOWZhOTMtZTcxNC00MTdkLWEwYmUtOWVmOTFhNTdkNjRkXkEyXkFqcGdeQXVyODk2NDQ3MTA@._V1_.jpg', '/images/movies/tt4873118.jpg', '7.5', '0', '2023', 'گروهبان جان کینلی در آخرین سفر خود در افغانستان با مترجمی محلی به نام احمد همراه می‌شود. احمد جان خود را به خطر می‌اندازد تا جان کینلی که مجروح شده را با عبور از مسیرهای طاقت فرسا به مکانی امن منتقل کند... ', '0', NULL, NULL),
(25, 'Furiosa: A Mad Max Saga', 'فیوریوسا: حماسه مکس دیوانه', '/images/movies/Furiosa-A-Mad-Max-Saga-2024-movie-poster.jpg', '/images/movies/Furiosa-A-Mad-Max-Saga-NBPpodcast-scaled.jpg', '8.9', '0', '2024', 'وقتی دنیا به پایان می رسد، فیوریوسا از محل سبز ربوده می‌شود و به دست یک گروه بزرگ موتورسوار به رهبری جنگ سالار دمنتوس می‌افتد...', '0', NULL, NULL),
(26, 'Immaculate', 'معصوم', '/images/movies/Immaculate.jpg', '/images/movies/5-Sydney-Sweeney-in-IMMACULATE_Photo-Courtesy-of-NEON.jpg', '9.7', '0', '2024', 'فیلم معصوم 2024 سیسیلیا (با بازی سیدنی سوئینی) زنی با ایمان است که از طرف یک صومعه سرشناس ایتالیایی کار جدیدی به او پیشنهاد شده و او با کمال میل آن را می‌پذیرد. اما به زودی و با وقوع حوادثی مرموز، سیسیلیا متوجه می‌شود...', '0', NULL, NULL),
(27, 'Venom: The Last Dance', 'ونوم: آخرین رقص', '/images/movies/MV5BNTFkZjdjN2QtOGE5MS00ZTgzLTgxZjAtYzkyZWQ5MjEzYmZjXkEyXkFqcGdeQXVyMTM0NTUzNDIy._V1_.jpg', '/images/movies/Evolve-13-3.webp', '9.5', '0', '2024', 'یک سال پس از وقوع حوادث قسمت قبل، روزنامه نگار تحقیقی ادی براک تلاش می کند زندگی خود را با میزبان بیگانه‌اش ونوم که به وی توانایی‌های فوق بشری داده است، سازگار کند...', '0', NULL, NULL),
(28, 'The Batman', 'بتمن', '/images/movies/the_batman__2022__poster_by_marvelmango_deth59e-fullview.jpg', '/images/movies/IYUD7rAIXzBM91TT3Z5fILUS7n-1200x673.jpg', '9.7', '0', '2022', 'بتمن The Batman در دومین سال مبارزه با جرم و جنایت خود به بررسی رشته ای از قتل ها می پردازد که به بررسی فسادی می پردازد که شهر گاتهام را گرفتار می کند و همچنین اینکه چگونه ممکن است...', '0', NULL, NULL),
(29, 'Ghosted', 'روح شده', '/images/movies/MV5BNGMzYWZlYmYtNTcyMC00ZGVjLThjN2ItMjY4MjkwN2NlMjYwXkEyXkFqcGdeQXVyOTU0NjY1MDM@._V1_.jpg', '/images/movies/ghosted-2023-movies-2880x1800-10753.jpg', '9.8', '0', '2023', 'فیلم روح شده 2023 در مورد مردی به نام کول (با بازی کریس ایوانز) است که زنی مرموز به نام سیدی (با بازی آنا د آرماس) را زیر نظر گرفته و به کشف تکان دهنده‌ای در مورد او می‌رسد، اینکه سیدی یک مامور مخفی است!!', '0', NULL, NULL),
(30, 'Oppenheimer', 'اوپن هایمر', '/images/movies/MV5BMDBmYTZjNjUtN2M1MS00MTQ2LTk2ODgtNzc2M2QyZGE5NTVjXkEyXkFqcGdeQXVyNzAwMjU2MTY@._V1_.jpg', '/images/movies/Oppenheimer.webp', '9.9', '0', '2024', 'داستان بر روی جولیوس رابرت اوپنهایمر، و گروهی از دانشمندان پروژه‌ی منهتن می‌پردازد که بمب‌ های اتم استفاده‌ شده در شهرهای هیروشیما و ناکازاکی را برای ارتش آمریکا تولید کردند... ', '0', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `movie_links`
--

CREATE TABLE `movie_links` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `movie_id` bigint(20) UNSIGNED NOT NULL,
  `url` varchar(255) NOT NULL,
  `resolution` varchar(255) NOT NULL,
  `disk` varchar(255) NOT NULL,
  `quality` varchar(255) NOT NULL,
  `Encoder` varchar(255) NOT NULL,
  `subtitle` varchar(255) NOT NULL,
  `type` enum('0','1','2') NOT NULL,
  `alert` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `movie_links`
--

INSERT INTO `movie_links` (`id`, `movie_id`, `url`, `resolution`, `disk`, `quality`, `Encoder`, `subtitle`, `type`, `alert`, `created_at`, `updated_at`) VALUES
(1, 1, '/Yaksha-Ruthless-Operations/WEB-DL-1080p.txt', '1920x1080', '2.40 گیگابایت', 'WEB-DL 1080p', 'VXT', 'SoftSub', '0', NULL, '2024-06-08 08:34:50', '2024-06-08 08:34:50'),
(2, 1, '/Yaksha-Ruthless-Operations/WEB-DL-1080p-x265.txt', '1920x1080', '2.01 گیگابایت', 'WEB-DL 1080p x265', 'PSA', 'SoftSub', '0', NULL, '2024-06-08 08:34:50', '2024-06-08 08:34:50'),
(3, 1, '/Yaksha-Ruthless-Operations/WEB-DL-720p.txt', '1280x720', '1.12 گیگابایت', 'WEB-DL 720p', 'YIFY', 'SoftSub', '0', NULL, '2024-06-08 08:39:03', '2024-06-08 08:39:03'),
(4, 1, '/Yaksha-Ruthless-Operations/WEB-DL-1080p-fa.txt', '1920x1080', '2.45 گیگابایت', 'WEB-DL 1080p', 'ZarFilm', 'SoftSub', '1', NULL, '2024-06-08 08:39:03', '2024-06-08 08:39:03'),
(5, 1, '/Yaksha-Ruthless-Operations/WEB-DL-720p-fa.txt', '1280x720', '1.26 گیگابایت', 'WEB-DL 720p', 'ZarFilm', 'SoftSub', '1', NULL, '2024-06-08 08:42:18', '2024-06-08 08:42:18'),
(6, 2, '/Johnny-Clyde/BluRay-1080p.txt', '1920x1080', '1.50 گیگابایت', 'BluRay 1080p', 'YTS', 'SoftSub', '0', NULL, '2024-06-08 08:55:20', '2024-06-08 08:55:20'),
(7, 2, '/Johnny-Clyde/BluRay-720p.txt', '1280x720', '1.75 گیگابایت', 'BluRay 720p', 'YTS', 'SoftSub', '0', NULL, '2024-06-08 08:55:20', '2024-06-08 08:55:20'),
(8, 3, '/The-Guilty/WEB-DL-1080p.txt', '1920x1080', '1.40 گیگابایت', 'WEB-DL 1080p', 'GalaxyRG', 'SoftSub', '0', NULL, '2024-06-08 09:08:46', '2024-06-08 09:08:46'),
(9, 3, '/The-Guilty/WEB-DL-720p.txt', '1280x720', '795.87 مگابایت', 'WEB-DL 720p', 'GalaxyRG', 'SoftSub', '0', NULL, '2024-06-08 09:08:46', '2024-06-08 09:08:46'),
(10, 3, '/The-Guilty/WEB-DL-1080p-fa.txt', '1920x1080', '1.14 گیگابایت', 'WEB-DL 1080p', 'ZarFilm', 'SoftSub', '1', NULL, '2024-06-08 09:11:14', '2024-06-08 09:11:14'),
(11, 3, '/The-Guilty/WEB-DL-720p-fa.txt', '1280x720', '784 مگابایت', 'WEB-DL 720p', 'ZarFilm', 'SoftSub', '1', NULL, '2024-06-08 09:11:14', '2024-06-08 09:11:14'),
(12, 4, '/Papillon/BluRay-1080p-Full-HD.txt', '1920x1080', '9.83 گیگابایت', 'BluRay 1080p Full HD', 'ZarFilm', 'SoftSub', '0', NULL, '2024-06-08 09:21:28', '2024-06-08 09:21:28'),
(13, 4, '/Papillon/BluRay-1080p.txt', '1920x1080', '2.11 گیگابایت', 'BluRay 1080p', 'YIFY', 'SoftSub', '0', NULL, '2024-06-08 09:21:28', '2024-06-08 09:21:28'),
(14, 4, '/Papillon/BluRay-720p.txt', '1280x720', '1.12 گیگابایت', 'BluRay 720p', 'YIFY', 'SoftSub', '0', NULL, '2024-06-08 09:23:46', '2024-06-08 09:23:46'),
(15, 4, '/Papillon/BluRay-1080p-fa.txt', '1920x1080', '2.34 گیگابایت', 'BluRay 1080p', 'ZarFilm', 'HardSub', '1', NULL, '2024-06-08 09:25:15', '2024-06-08 09:25:15'),
(16, 4, '/Papillon/BluRay-720p-fa.txt', '1280x720', '1.30 گیگابایت', 'BluRay 720p', 'ZarFilm', 'HardSub', '1', NULL, '2024-06-08 09:25:15', '2024-06-08 09:25:15'),
(17, 5, '/Little-Bone-Lodge/WEB-DL-1080p.txt', '1920x1080', '1.75 گیگابایت', 'WEB-DL 1080p', 'YIFY', 'SoftSub', '0', NULL, '2024-06-08 09:38:43', '2024-06-08 09:38:43'),
(18, 5, '/Little-Bone-Lodge/WEB-DL-720p.txt', '1280x720', '872 مگابایت', 'WEB-DL 720p', 'YIFY', 'SoftSub', '0', NULL, '2024-06-08 09:38:43', '2024-06-08 09:38:43'),
(19, 5, '/Little-Bone-Lodge/WEB-DL-1080p-fa.txt', '1920x1080', '1.83 گیگابایت', 'WEB-DL 1080p', 'ZarFilm', 'SoftSub', '1', NULL, '2024-06-08 09:40:43', '2024-06-08 09:40:43'),
(20, 5, '/Little-Bone-Lodge/WEB-DL-720p-fa.txt', '1280x720', '954 مگابایت', 'WEB-DL 720p', 'ZarFilm', 'SoftSub', '1', NULL, '2024-06-08 09:40:43', '2024-06-08 09:40:43'),
(21, 6, '/Good-Nurse/WEB-DL-1080p.txt', '1920x1080', '2.27 گیکابایت', 'WEB-DL 1080p', 'YIFY', 'SoftSub', '0', NULL, '2024-06-08 09:52:39', '2024-06-08 09:52:39'),
(22, 6, '/Good-Nurse/WEB-DL-1080p-x265-10bit.txt', '1920x1080', '1.50 گیکابایت', 'WEB-DL 1080p x265 10bit', 'PSA', 'SoftSub', '0', 'نسخه های 10bit دارای عمق رنگ بیشتر و وضوح بهتری میباشند.', '2024-06-08 09:52:39', '2024-06-08 09:52:39'),
(27, 6, '/Good-Nurse/WEB-DL-720p.txt', '1280x720', '1.10 گیکابایت', 'WEB-DL 720p', 'YIFY', 'SoftSub', '0', NULL, '2024-06-08 09:55:17', '2024-06-08 09:55:17'),
(28, 6, '/Good-Nurse/WEB-DL-1080p-fa.txt', '1920x1080', '2.38 گیگابایت ', 'WEB-DL 1080p', 'ZarFilm', 'SoftSub', '1', NULL, '2024-06-08 09:55:17', '2024-06-08 09:55:17'),
(29, 6, '/Good-Nurse/WEB-DL-720p-fa.txt', '1280x720', '1.22 گیگابایت', 'WEB-DL 720p', 'ZarFilm', 'SoftSub', '1', NULL, '2024-06-08 09:59:41', '2024-06-08 09:59:41'),
(30, 7, '/Accident-Man/WEB-DL-1080p.txt', '1920x1080', '1.79 گیگابایت', 'WEB-DL 1080p', 'YIFY', 'SoftSub', '0', NULL, '2024-06-08 10:09:51', '2024-06-08 10:09:51'),
(31, 7, '/Accident-Man/WEB-DL-1080p-x265-10bit.txt', '1920x1080', '1.51 گیکابایت ', 'WEB-DL 1080p x265 10bit', 'RARBG', 'SoftSub', '0', 'نسخه های 10bit دارای عمق رنگ بیشتر و وضوح بهتری میباشند.', '2024-06-08 10:09:51', '2024-06-08 10:09:51'),
(32, 7, '/Accident-Man/WEB-DL-720p.txt', '1280x720', '890.05 مگابایت', 'WEB-DL 720p', 'YIFY', 'SoftSub', '0', '', '2024-06-08 10:12:07', '2024-06-08 10:12:07'),
(33, 8, '/Central-Intelligence/BluRay-1080p.txt', '1920x1080', '2.09 گیگابایت', 'BluRay 1080p', 'ShAaNiG', 'SoftSub', '0', NULL, '2024-06-08 10:29:44', '2024-06-08 10:29:44'),
(34, 8, '/Central-Intelligence/BluRay-720p.txt', '1280x720', '1.09 گیگابایت ', 'BluRay 720p', 'ShAaNiG', 'SoftSub', '0', NULL, '2024-06-08 10:29:44', '2024-06-08 10:29:44'),
(35, 8, '/Central-Intelligence/BluRay-1080p-fa.txt', '1920x1080', '2.20 گیگابایت', 'BluRay 1080p', 'ZarFilm', 'SoftSub', '1', NULL, '2024-06-08 10:31:59', '2024-06-08 10:31:59'),
(36, 8, '/Central-Intelligence/BluRay-720p-fa.txt', '1280x720', '1.20 گیگابایت ', 'BluRay 720p', 'ZarFilm', 'SoftSub', '1', NULL, '2024-06-08 10:32:59', '2024-06-08 10:32:59'),
(37, 9, '/Zootopia/BluRay-1080p-3D.txt', '1920x1080', '2.2 گیگابایت', 'BluRay 1080p 3D', 'ShAaNiG', 'SoftSub', '0', 'نسخه سه بعدی دارای دو تصویر می باشد و فقط با عینک مخصوص قابل تماشا می باشد', '2024-06-08 10:47:11', '2024-06-08 10:47:11'),
(38, 9, '/Zootopia/BluRay-1080p-Full-HD.txt', '1920x1080', '5.46 گیگابایت', 'BluRay 1080p Full HD', 'ShAaNiG', 'SoftSub', '0', NULL, '2024-06-08 10:47:11', '2024-06-08 10:47:11'),
(39, 9, '/Zootopia/BluRay-720p.txt', '1280x720', '799.99 مگابایت', 'BluRay 720p', 'YIFY', 'SoftSub', '0', NULL, '2024-06-08 10:49:27', '2024-06-08 10:49:27'),
(40, 9, '/Zootopia/BluRay-1080p-fa.txt', '1920x1080', '1.97 گیگابایت', 'BluRay 1080p', 'ZarFilm', 'HardSub', '1', NULL, '2024-06-08 10:50:30', '2024-06-08 10:50:30'),
(41, 9, '/Zootopia/BluRay-720p-fa.txt', '1280x720', '1.14 گیگابایت ', 'BluRay 720p', 'BluRay 720p', 'HardSub', '1', NULL, '2024-06-08 10:52:34', '2024-06-08 10:52:34'),
(42, 11, '/Murder-Mystery/WEB-DL-1080p-2.txt', '1920x1080', '1.84 گیگابایت ', 'WEB-DL 1080p', 'RARBG', 'SoftSub', '2', NULL, '2024-06-08 11:11:06', '2024-06-08 11:11:06'),
(43, 11, '/Murder-Mystery/WEB-DL-720p-2.txt', '1280x720', '850.44 مگابایت ', 'WEB-DL 720p', 'MkvCage', 'SoftSub', '2', NULL, '2024-06-08 11:11:06', '2024-06-08 11:11:06'),
(44, 11, '/Murder-Mystery/WEB-DL-1080p.txt', '1920x1080', '1.84 گیگابایت ', 'WEB-DL 1080p', 'RARBG', 'SoftSub', '0', NULL, '2024-06-08 11:11:06', '2024-06-08 11:11:06'),
(45, 11, '/Murder-Mystery/WEB-DL-720p.txt', '1280x720', '850.44 مگابایت ', 'WEB-DL 720p', 'MkvCage', 'SoftSub', '0', NULL, '2024-06-08 11:11:06', '2024-06-08 11:11:06'),
(46, 12, '/Hit-Man/WEB-DL-1080p-Full-HD.txt', '1920x1080', '6.75 گیگابایت ', 'WEB-DL 1080p Full HD', 'FLUX', 'SoftSub', '0', NULL, '2024-06-08 17:16:52', '2024-06-08 17:16:52'),
(47, 12, '/Hit-Man/WEB-DL-1080p.txt', '1920x1080', '2.13 گیگابایت ', 'WEB-DL 1080p', 'YIFY', 'SoftSub', '0', NULL, '2024-06-08 17:16:52', '2024-06-08 17:16:52'),
(48, 12, '/Hit-Man/WEB-DL-1080p-x265-10bit.txt', '1920x1080', '2.00 گیگابایت ', 'WEB-DL 1080p x265 10bit', 'PSA', 'SoftSub', '0', 'نسخه های 10bit دارای عمق رنگ بیشتر و وضوح بهتری میباشند.', '2024-06-08 17:19:17', '2024-06-08 17:19:17'),
(49, 12, '/Hit-Man/WEB-DL-720p-HD.txt', '1280x720', '2.14 گیگابایت', 'WEB-DL 720p HD', 'FLUX', 'SoftSub', '0', '', '2024-06-08 17:20:39', '2024-06-08 17:20:39'),
(50, 13, '/Nobody/BluRay-1080p-Full-HD.txt', '1920x1080', '14.46 گیگابایت ', 'BluRay 1080p Full HD', 'EVO', 'SoftSub', '0', NULL, '2024-06-08 17:30:00', '2024-06-08 17:30:00'),
(51, 13, '/Nobody/BluRay-1080p.txt', '1920x1080', '2.14 گیگابایت', 'BluRay 1080p', 'Pahe', 'SoftSub', '0', NULL, '2024-06-08 17:30:00', '2024-06-08 17:30:00'),
(52, 13, '/Nobody/BluRay-720p.txt', '1280x720', '896.87 مگابایت ', 'BluRay 720p', 'Pahe', 'SoftSub', '0', NULL, '2024-06-08 17:31:59', '2024-06-08 17:31:59'),
(53, 13, '/Nobody/BluRay-1080p-fa.txt', '1920x1080', '1.60 گیگابایت', 'BluRay 1080p', 'ZarFilm', 'HardSub', '1', NULL, '2024-06-08 17:32:55', '2024-06-08 17:32:55'),
(54, 13, '/Nobody/BluRay-720p-fa.txt', '1280x720', '913 مگابایت ', 'BluRay 720p', 'ZarFilm', 'HardSub', '1', NULL, '2024-06-08 17:34:04', '2024-06-08 17:34:04'),
(55, 14, '/Murder-Mystery-2/WEB-DL-1080p.txt', '1920x1080', '1.68 گیگابایت', 'WEB-DL 1080p', 'YIFY', 'SoftSub', '0', NULL, NULL, NULL),
(56, 14, '/Murder-Mystery-2/WEB-DL-720p.txt', '1280x720', '834.42 مگابایت', 'WEB-DL 720p', 'YIFY', 'SoftSub', '0', NULL, NULL, NULL),
(57, 14, '/Murder-Mystery-2/WEB-DL-1080p-fa.txt', '1920x1080', '1.84 گیگابایت', 'WEB-DL 1080p', 'ZarFilm', 'SoftSub', '1', NULL, NULL, NULL),
(58, 14, '/Murder-Mystery-2/WEB-DL-720p-fa.txt', '1280x720', '999 مگابایت', 'WEB-DL 720p', 'ZarFilm', 'SoftSub', '1', NULL, NULL, NULL),
(59, 19, '/Glass-Onion/WEB-DL-1080p.txt', '1920x1080', '2.60 گیکابایت ', 'WEB-DL 1080p', 'YIFY', 'SoftSub', '0', NULL, NULL, NULL),
(60, 19, '/Glass-Onion/WEB-DL-720p.txt', '1280x720', '1.26 گیکابایت ', 'WEB-DL 720p', 'YIFY', 'SoftSub', '0', NULL, NULL, NULL),
(61, 19, '/Glass-Onion/WEB-DL-1080p-fa.txt', '1920x1080', '3.59 گیگابایت', 'WEB-DL 1080p', 'ZarFilm', 'SoftSub', '1', NULL, NULL, NULL),
(62, 19, '/Glass-Onion/WEB-DL-720p-fa.txt', '1280x720', '1.69 گیگابایت ', 'WEB-DL 720p', 'ZarFilm', 'SoftSub', '1', NULL, NULL, NULL),
(63, 20, '/Meg-2-The-Trench/BluRay-2160p-x265-4K-2.txt', '3840x2160', '3.98 گیگابایت', 'BluRay 2160p x265 4K', 'PSA', 'SoftSub', '2', NULL, NULL, NULL),
(64, 20, '/Meg-2-The-Trench/BluRay-1080p-10bit-x265.txt', '1920x1080', '2.07 گیگابایت ', 'BluRay 1080p 10bit x265', 'PSA', 'SoftSub', '2', 'نسخه های 10bit دارای عمق رنگ بیشتر و وضوح بهتری میباشند.', NULL, NULL),
(65, 20, '/Meg-2-The-Trench/BluRay-720p-2.txt', '1280x720', '1.09 گیگابایت', 'BluRay 720p', 'Pahe', 'SoftSub', '2', '', NULL, NULL),
(66, 20, '/Meg-2-The-Trench/BluRay-1080p.txt', '1920x1080', '3.38 گیگابایت', 'BluRay 1080p', 'ZarFilm', 'SoftSub', '0', '', NULL, NULL),
(67, 20, '/Meg-2-The-Trench/BluRay-720p.txt', '1280x720', '1.29 گیگابایت ', 'BluRay 720p', 'ZarFilm', 'SoftSub', '0', '', NULL, NULL),
(68, 23, '/I-Am-Rage/WEB-DL-1080p.txt', '1920x1080', '1.62 گیگابایت ', 'WEB-DL 1080p', 'YIFY', 'SoftSub', '0', '', NULL, NULL),
(69, 23, '/I-Am-Rage/WEB-DL-720p.txt', '1280x720', '808 مگابایت ', 'WEB-DL 720p', 'YIFY', 'SoftSub', '0', NULL, NULL, NULL),
(70, 24, '/The-Covenant/BluRay-1080p.txt', '1920x1080', '2.27 گیگابایت', 'BluRay 1080p', 'YIFY', 'SoftSub', '0', NULL, NULL, NULL),
(71, 24, '/The-Covenant/BluRay-1080p-10bit-x265.txt', '1920x1080', '2.56 گیگابایت', 'BluRay 1080p 10bit x265', 'PSA', 'SoftSub', '0', 'نسخه های 10bit دارای عمق رنگ بیشتر و وضوح بهتری میباشند.', NULL, NULL),
(72, 24, '/The-Covenant/BluRay-720p.txt', '1280x720', '1.10 گیگابایت', 'BluRay 720p', 'YIFY', 'SoftSub', '0', '', NULL, NULL),
(73, 24, '/The-Covenant/BluRay-1080p-fa.txt', '1920x1080', '2.50 گیگابایت ', 'BluRay 1080p', 'ZarFilm', 'SoftSub', '1', '', NULL, NULL),
(74, 24, '/The-Covenant/BluRay-720p-fa.txt', '1280x720', '1.22 گیگابایت', 'BluRay 720p', 'ZarFilm', 'SoftSub', '1', '', NULL, NULL),
(75, 25, '/Mad-Max/WEB-DL-1080p-Full-HD.txt', '1920x1080', '4.41 گیگابایت', 'WEB-DL 1080p Full HD', 'ETHEL', 'SoftSub', '0', NULL, NULL, NULL),
(76, 25, '/Mad-Max/WEB-DL-720p-HD.txt', '1280x720', '1.02 گیگابایت ', 'WEB-DL 720p HD', 'YIFY', 'SoftSub', '0', NULL, NULL, NULL),
(77, 26, '/Immaculate/WEB-DL-1080p-Full-HD.txt', '1920x1080', '5.22 گیگابایت', 'WEB-DL 1080p Full HD', 'ZarFilm', 'SoftSub', '0', NULL, NULL, NULL),
(78, 26, '/Immaculate/WEB-DL-720p-x265-10bit.txt', '1280x720', '777 مگابایت', 'WEB-DL 720p x265 10bit', 'PSA', 'SoftSub', '0', 'نسخه های 10bit دارای عمق رنگ بیشتر و وضوح بهتری میباشند.', NULL, NULL),
(79, 26, '/Immaculate/WEB-DL-1080p-Full-HD-fa.txt', '1920x1080', '5.22 گیگابایت ', 'WEB-DL 1080p Full HD', 'ZarFilm', 'SoftSub', '1', NULL, NULL, NULL),
(80, 26, '/Immaculate/WEB-DL-720p-x265-10bit-fa.txt', '1280x720', '932 مگابایت', 'WEB-DL 720p x265 10bit', 'YIFY', 'SoftSub', '1', 'نسخه های 10bit دارای عمق رنگ بیشتر و وضوح بهتری میباشند.', NULL, NULL),
(81, 27, '/Venom/BluRay-1080p.txt', '1920x1080', '1.79 گیگابایت', 'BluRay 1080p', 'YIFI', 'SoftSub', '0', NULL, NULL, NULL),
(82, 27, '/Venom/BluRay-720p.txt', '1280x720', '891.11 مگابایت', 'BluRay 720p', 'YIFY', 'SoftSub', '0', NULL, NULL, NULL),
(83, 27, '/Venom/BluRay-1080p-fa.txt', '1920x1080', '1.96 گیگابایت', 'BluRay 1080p', 'ZarFilm', 'SoftSub', '1', NULL, NULL, NULL),
(84, 27, '/Venom/BluRay-720p-fa.txt', '1280x720', '1 گیگابایت ', 'BluRay 720p', 'ZarFilm', 'SoftSub', '1', NULL, NULL, NULL),
(85, 28, '/Batman/BluRay-1080p-Full-HD.txt', '1920x1080', '16.63 گیگابایت ', 'BluRay 1080p Full HD', 'EVO', 'SoftSub', '0', NULL, NULL, NULL),
(86, 28, '/Batman/BluRay-1080p-10bit-x265.txt', '1920x1080', '1.87 گیگابایت ', 'BluRay 1080p 10bit x265', 'PSA', 'SoftSub', '0', 'نسخه های 10bit دارای عمق رنگ بیشتر و وضوح بهتری میباشند.', NULL, NULL),
(87, 28, '/Batman/BluRay-720p.txt', '1280x720', '1.58 گیگابایت ', 'BluRay 720p', 'YIFI', 'SoftSub', '0', NULL, NULL, NULL),
(88, 29, '/Ghosted/BluRay-1080p-Full-HD.txt', '1920x1080', '16.63 گیگابایت ', 'BluRay 1080p Full HD', 'EVO', 'SoftSub', '0', NULL, NULL, NULL),
(89, 29, '/Ghosted/BluRay-1080p.txt', '1920x1080', '3.24 گیگابایت', 'BluRay 1080p', 'YIFY', 'SoftSub', '0', NULL, NULL, NULL),
(90, 29, '/Ghosted/BluRay-720p.txt', '1280x720', '1.58 گیگابایت', 'BluRay 720p', 'YIFI', 'SoftSub', '0', NULL, NULL, NULL),
(91, 30, '/Oppenheimer/BluRay-REMUX-1080p.txt', '1920x1080', '39.01 گیگابایت', 'BluRay REMUX 1080p', 'ZarFilm', 'SoftSub', '2', NULL, NULL, NULL),
(92, 30, '/Oppenheimer/BluRay-1080p-10bit-x265.txt', '1920x1080', '1.97 گیگابایت', 'BluRay 1080p 10bit x265', 'PSA', 'SoftSub', '0', 'نسخه های 10bit دارای عمق رنگ بیشتر و وضوح بهتری میباشند.', NULL, NULL),
(93, 30, '/Oppenheimer/BluRay-720p.txt', '1280x720', '1.62 گیگابایت', 'BluRay 720p', 'YTS', 'SoftSub', '0', '', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `movie_star`
--

CREATE TABLE `movie_star` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `movie_id` bigint(20) UNSIGNED NOT NULL,
  `star_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `movie_star`
--

INSERT INTO `movie_star` (`id`, `movie_id`, `star_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2024-06-08 08:32:51', '2024-06-08 08:32:51'),
(2, 1, 2, '2024-06-08 08:32:51', '2024-06-08 08:32:51'),
(3, 1, 3, '2024-06-08 08:33:14', '2024-06-08 08:33:14'),
(4, 1, 4, '2024-06-08 08:34:18', '2024-06-08 08:34:18'),
(5, 2, 5, '2024-06-08 08:53:37', '2024-06-08 08:53:37'),
(6, 2, 7, '2024-06-08 08:53:37', '2024-06-08 08:53:37'),
(7, 2, 6, '2024-06-08 08:54:12', '2024-06-08 08:54:12'),
(8, 2, 8, '2024-06-08 08:54:12', '2024-06-08 08:54:12'),
(9, 3, 9, '2024-06-08 09:07:22', '2024-06-08 09:07:22'),
(10, 3, 10, '2024-06-08 09:07:22', '2024-06-08 09:07:22'),
(11, 3, 11, '2024-06-08 09:07:48', '2024-06-08 09:07:48'),
(12, 3, 12, '2024-06-08 09:07:48', '2024-06-08 09:07:48'),
(13, 4, 13, '2024-06-08 09:20:11', '2024-06-08 09:20:11'),
(14, 4, 14, '2024-06-08 09:20:11', '2024-06-08 09:20:11'),
(15, 4, 15, '2024-06-08 09:20:32', '2024-06-08 09:20:32'),
(16, 4, 16, '2024-06-08 09:20:32', '2024-06-08 09:20:32'),
(17, 5, 17, '2024-06-08 09:36:52', '2024-06-08 09:36:52'),
(18, 5, 18, '2024-06-08 09:36:52', '2024-06-08 09:36:52'),
(19, 5, 19, '2024-06-08 09:37:21', '2024-06-08 09:37:21'),
(20, 6, 20, '2024-06-08 09:51:34', '2024-06-08 09:51:34'),
(21, 6, 21, '2024-06-08 09:51:34', '2024-06-08 09:51:34'),
(22, 6, 22, '2024-06-08 09:51:59', '2024-06-08 09:51:59'),
(23, 6, 23, '2024-06-08 09:51:59', '2024-06-08 09:51:59'),
(24, 7, 24, '2024-06-08 10:07:50', '2024-06-08 10:07:50'),
(25, 7, 25, '2024-06-08 10:07:50', '2024-06-08 10:07:50'),
(26, 7, 26, '2024-06-08 10:08:26', '2024-06-08 10:08:26'),
(27, 7, 27, '2024-06-08 10:08:42', '2024-06-08 10:08:42'),
(28, 8, 28, '2024-06-08 10:28:12', '2024-06-08 10:28:12'),
(29, 8, 29, '2024-06-08 10:28:12', '2024-06-08 10:28:12'),
(30, 8, 30, '2024-06-08 10:28:37', '2024-06-08 10:28:37'),
(31, 8, 31, '2024-06-08 10:28:53', '2024-06-08 10:28:53'),
(32, 9, 32, '2024-06-08 10:45:28', '2024-06-08 10:45:28'),
(33, 9, 33, '2024-06-08 10:45:28', '2024-06-08 10:45:28'),
(34, 9, 34, '2024-06-08 10:45:51', '2024-06-08 10:45:51'),
(35, 9, 35, '2024-06-08 10:46:09', '2024-06-08 10:46:09'),
(36, 11, 36, '2024-06-08 11:01:17', '2024-06-08 11:01:17'),
(37, 11, 37, '2024-06-08 11:01:17', '2024-06-08 11:01:17'),
(38, 11, 38, '2024-06-08 11:01:41', '2024-06-08 11:01:41'),
(39, 11, 39, '2024-06-08 11:01:54', '2024-06-08 11:01:54'),
(40, 12, 40, '2024-06-08 17:15:49', NULL),
(41, 12, 41, '2024-06-08 17:15:49', '2024-06-08 17:15:49'),
(42, 12, 42, '2024-06-08 17:16:10', '2024-06-08 17:16:10'),
(43, 13, 43, '2024-06-08 17:28:40', '2024-06-08 17:28:40'),
(44, 13, 44, '2024-06-08 17:28:40', '2024-06-08 17:28:40'),
(45, 13, 45, '2024-06-08 17:29:07', '2024-06-08 17:29:07'),
(46, 13, 46, '2024-06-08 17:29:18', '2024-06-08 17:29:18'),
(50, 14, 36, NULL, NULL),
(51, 14, 37, NULL, NULL),
(52, 14, 47, NULL, NULL),
(53, 15, 4, NULL, NULL),
(54, 15, 48, NULL, NULL),
(55, 15, 49, NULL, NULL),
(56, 16, 31, NULL, NULL),
(57, 16, 50, NULL, NULL),
(58, 16, 51, NULL, NULL),
(59, 18, 8, NULL, NULL),
(60, 18, 52, NULL, NULL),
(61, 18, 53, NULL, NULL),
(62, 18, 54, NULL, NULL),
(63, 19, 55, NULL, NULL),
(64, 19, 56, NULL, NULL),
(65, 19, 57, NULL, NULL),
(66, 19, 58, NULL, NULL),
(67, 20, 59, NULL, NULL),
(68, 20, 60, NULL, NULL),
(69, 20, 61, NULL, NULL),
(70, 21, 27, NULL, NULL),
(71, 21, 62, NULL, NULL),
(72, 21, 63, NULL, NULL),
(73, 21, 64, NULL, NULL),
(74, 22, 46, NULL, NULL),
(75, 22, 65, NULL, NULL),
(76, 22, 66, NULL, NULL),
(77, 22, 67, NULL, NULL),
(78, 23, 68, NULL, NULL),
(79, 23, 69, NULL, NULL),
(80, 23, 70, NULL, NULL),
(81, 23, 71, NULL, NULL),
(82, 24, 9, NULL, NULL),
(83, 24, 72, NULL, NULL),
(84, 24, 73, NULL, NULL),
(85, 25, 4, NULL, NULL),
(86, 25, 36, NULL, NULL),
(87, 25, 60, NULL, NULL),
(88, 26, 8, NULL, NULL),
(89, 26, 74, NULL, NULL),
(90, 26, 16, NULL, NULL),
(91, 27, 4, NULL, NULL),
(92, 27, 72, NULL, NULL),
(93, 27, 33, NULL, NULL),
(94, 28, 4, NULL, NULL),
(95, 28, 48, NULL, NULL),
(96, 28, 20, NULL, NULL),
(97, 29, 63, NULL, NULL),
(98, 29, 28, NULL, NULL),
(99, 29, 4, NULL, NULL),
(100, 30, 27, NULL, NULL),
(101, 30, 11, NULL, NULL),
(102, 30, 62, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `movie_tag`
--

CREATE TABLE `movie_tag` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `movie_id` bigint(20) UNSIGNED NOT NULL,
  `tag_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `movie_tag`
--

INSERT INTO `movie_tag` (`id`, `movie_id`, `tag_id`, `created_at`, `updated_at`) VALUES
(1, 21, 2, NULL, NULL),
(2, 13, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(5, 'App\\Models\\User', 1, 'TOKEN', '02e86216240702ea667add0e854e669ce7dab0118988ec34a364b85e4d95f78d', '[\"*\"]', '2024-06-15 09:06:09', '2024-06-17 08:21:59', '2024-06-15 08:21:59', '2024-06-15 09:06:09');

-- --------------------------------------------------------

--
-- Table structure for table `seasons`
--

CREATE TABLE `seasons` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `movie_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `status` enum('0','1') NOT NULL,
  `isLast` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `seasons`
--

INSERT INTO `seasons` (`id`, `movie_id`, `title`, `status`, `isLast`, `created_at`, `updated_at`) VALUES
(1, 15, 'فصل 1', '1', 0, NULL, NULL),
(2, 15, 'فصل 2', '0', 1, NULL, NULL),
(3, 16, 'فصل 1', '1', 0, NULL, NULL),
(4, 18, 'فصل 1', '1', 0, NULL, NULL),
(5, 18, 'فصل 2', '0', 0, NULL, NULL),
(6, 21, 'فصل 1', '1', 0, NULL, NULL),
(7, 21, 'فصل 2', '0', 0, NULL, NULL),
(8, 22, 'فصل 1', '1', 0, NULL, NULL),
(9, 22, 'فصل 2', '1', 0, NULL, NULL),
(10, 22, 'فصل 3', '0', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sections`
--

CREATE TABLE `sections` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `season_id` bigint(20) UNSIGNED NOT NULL,
  `quality` varchar(255) NOT NULL,
  `disk` varchar(255) NOT NULL,
  `type` enum('0','1','2') NOT NULL,
  `subtitle` varchar(255) NOT NULL DEFAULT 'softhub',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sections`
--

INSERT INTO `sections` (`id`, `season_id`, `quality`, `disk`, `type`, `subtitle`, `created_at`, `updated_at`) VALUES
(1, 1, 'BluRay 720p-Pahe', '300 مگابایت', '0', 'softhub', NULL, NULL),
(2, 1, 'BluRay 480p-ZarFilm', '170 مگابایت', '0', 'softhub', NULL, NULL),
(3, 2, 'BluRay 720p-Pahe', '300 مگابایت', '0', 'softhub', NULL, NULL),
(4, 2, 'BluRay 480p-ZarFilm', '170 مگابایت', '0', 'softhub', NULL, NULL),
(5, 3, 'WEB-DL 1080p FHD DDP5.1 - NTb', '4 گیگابایت', '0', 'softhub', NULL, NULL),
(6, 3, 'WEB-DL 1080p 6CH - ZarFilm ', '4 گیگابایت', '1', 'softhub', NULL, NULL),
(7, 4, 'WEB-DL 1080p - ZarFilm', '1 گیگابایت', '0', 'softhub', NULL, NULL),
(8, 4, 'WEB-DL 1080p x265 10bit - PSA', '1 گیگابایت', '1', 'softhub', NULL, NULL),
(9, 5, 'WEB-DL 1080p - ZarFilm', '2 گیگابایت', '0', 'softhub', NULL, NULL),
(10, 5, 'WEB-DL 1080p x265 10bit - PSA', '2 گیگابایت', '1', 'softhub', NULL, NULL),
(11, 6, 'Blu-ray 1080p DDP.5.1 - PaHe', '1.3 گیگابایت', '0', 'softhub', NULL, NULL),
(12, 6, 'Blu-ray 720p x265 10bit - Pahe', '890 مگابایت', '0', 'softhub', NULL, NULL),
(13, 7, 'WEB-DL 2160p x265 10bit HDR - PSA', '2 گیگابایت', '0', 'softhub', NULL, NULL),
(14, 7, 'Blu-ray 720p - PaHe', '450 مگابایت', '0', 'softhub', NULL, NULL),
(15, 8, 'BluRay 1080p MkvCag', '1.78 گیگابایت', '0', 'softhub', NULL, NULL),
(16, 8, 'BluRay 1080p - ZarFilm', '1.3 گیگابایت', '1', 'softhub', NULL, NULL),
(17, 9, 'BluRay 1080p MkvCage', '1000 مگابایت', '0', 'softhub', NULL, NULL),
(18, 9, 'BluRay 1080p - ZarFilm', '800 مگابایت', '1', 'softhub', NULL, NULL),
(19, 10, 'WEB-DL 1080p - MkvCage', '900 مگابایت', '0', 'softhub', NULL, NULL),
(20, 10, 'WEB-DL 1080p - ZarFilm', '900 مگابایت', '1', 'softhub', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `series_links`
--

CREATE TABLE `series_links` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `section_id` bigint(20) UNSIGNED NOT NULL,
  `url` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `series_links`
--

INSERT INTO `series_links` (`id`, `section_id`, `url`, `title`, `created_at`, `updated_at`) VALUES
(1, 1, '/Helix/1/1/episode-1.txt', 'قسمت 1', NULL, NULL),
(2, 1, '/Helix/1/1/episode-2.txt', 'قسمت 2', NULL, NULL),
(3, 1, '/Helix/1/1/episode-3.txt', 'قسمت 3', NULL, NULL),
(4, 2, '/Helix/1/2/episode-1.txt', 'قسمت 1', NULL, NULL),
(5, 2, '/Helix/1/2/episode-2.txt', 'قسمت 2', NULL, NULL),
(6, 2, '/Helix/1/2/episode-3.txt', 'قسمت 3', NULL, NULL),
(7, 3, '/Helix/2/1/episode-1.txt', 'قسمت 1', NULL, NULL),
(8, 3, '/Helix/2/1/episode-2.txt', 'قسمت 2', NULL, NULL),
(9, 4, '/Helix/2/2/episode-1.txt', 'قسمت 1', NULL, NULL),
(10, 4, '/Helix/2/2/episode-2.txt', 'قسمت 2', NULL, NULL),
(11, 5, '/Walking-Dead-Daryl-Dixon/1/1/episode-1.txt', 'قسمت 1', NULL, NULL),
(12, 5, '/Walking-Dead-Daryl-Dixon/1/1/episode-2.txt', 'قسمت 2', NULL, NULL),
(13, 5, '/Walking-Dead-Daryl-Dixon/1/1/episode-3.txt', 'قسمت 3', NULL, NULL),
(14, 5, '/Walking-Dead-Daryl-Dixon/1/1/episode-4.txt', 'قسمت 4', NULL, NULL),
(15, 5, '/Walking-Dead-Daryl-Dixon/1/1/episode-5.txt', 'قسمت 5', NULL, NULL),
(16, 5, '/Walking-Dead-Daryl-Dixon/1/1/episode-6.txt', 'قسمت 6', NULL, NULL),
(17, 6, '/Walking-Dead-Daryl-Dixon/1/2/episode-1.txt', 'قسمت 1', NULL, NULL),
(18, 6, '/Walking-Dead-Daryl-Dixon/1/2/episode-2.txt', 'قسمت 2', NULL, NULL),
(19, 6, '/Walking-Dead-Daryl-Dixon/1/2/episode-3.txt', 'قسمت 3', NULL, NULL),
(20, 6, '/Walking-Dead-Daryl-Dixon/1/2/episode-4.txt', 'قسمت 4', NULL, NULL),
(21, 6, '/Walking-Dead-Daryl-Dixon/1/2/episode-5.txt', 'قسمت 5', NULL, NULL),
(22, 6, '/Walking-Dead-Daryl-Dixon/1/2/episode-6.txt', 'قسمت 6', NULL, NULL),
(23, 7, '/Walking-Dead-Dead-City/1/1/episode-1.txt', 'قسمت 1', NULL, NULL),
(24, 7, '/Walking-Dead-Dead-City/1/1/episode-2.txt', 'قسمت 2', NULL, NULL),
(25, 8, '/Walking-Dead-Dead-City/1/2/episode-1.txt', 'قسمت 1', NULL, NULL),
(26, 8, '/Walking-Dead-Dead-City/1/2/episode-2.txt', 'قسمت 2', NULL, NULL),
(27, 9, '/Walking-Dead-Dead-City/2/1/episode-1.txt', 'قسمت 1', NULL, NULL),
(28, 9, '/Walking-Dead-Dead-City/2/1/episode-2.txt', 'قسمت 2', NULL, NULL),
(29, 9, '/Walking-Dead-Dead-City/2/1/episode-3.txt', 'قسمت 3', NULL, NULL),
(30, 10, '/Walking-Dead-Dead-City/2/2/episode-1.txt', 'قسمت 1', NULL, NULL),
(31, 10, '/Walking-Dead-Dead-City/2/2/episode-2.txt', 'قسمت 2', NULL, NULL),
(32, 10, '/Walking-Dead-Dead-City/2/2/episode-3.txt', 'قسمت 3', NULL, NULL),
(33, 11, '/The-Last-Of-Us/1/1/episode-1.txt', 'قسمت 1', NULL, NULL),
(34, 11, '/The-Last-Of-Us/1/1/episode-2.txt', 'قسمت 2', NULL, NULL),
(35, 11, '/The-Last-Of-Us/1/1/episode-3.txt', 'قسمت 3', NULL, NULL),
(36, 11, '/The-Last-Of-Us/1/1/episode-4.txt', 'قسمت 4', NULL, NULL),
(37, 11, '/The-Last-Of-Us/1/1/episode-5.txt', 'قسمت 5', NULL, NULL),
(38, 11, '/The-Last-Of-Us/1/1/episode-6.txt', 'قسمت 6', NULL, NULL),
(39, 11, '/The-Last-Of-Us/1/1/episode-7.txt', 'قسمت 7', NULL, NULL),
(40, 11, '/The-Last-Of-Us/1/1/episode-8.txt', 'قسمت 8', NULL, NULL),
(41, 12, '/The-Last-Of-Us/1/2/episode-1.txt', 'قسمت 1', NULL, NULL),
(42, 12, '/The-Last-Of-Us/1/2/episode-2.txt', 'قسمت 2', NULL, NULL),
(43, 12, '/The-Last-Of-Us/1/2/episode-3.txt', 'قسمت 3', NULL, NULL),
(44, 12, '/The-Last-Of-Us/1/2/episode-4.txt', 'قسمت 4', NULL, NULL),
(45, 12, '/The-Last-Of-Us/1/2/episode-5.txt', 'قسمت 5', NULL, NULL),
(46, 12, '/The-Last-Of-Us/1/2/episode-6.txt', 'قسمت 6', NULL, NULL),
(47, 12, '/The-Last-Of-Us/1/2/episode-7.txt', 'قسمت 7', NULL, NULL),
(48, 12, '/The-Last-Of-Us/1/2/episode-8.txt', 'قسمت 8', NULL, NULL),
(49, 13, '/The-Last-Of-Us/2/1/episode-1.txt', 'قسمت 1', NULL, NULL),
(50, 13, '/The-Last-Of-Us/2/1/episode-2.txt', 'قسمت 2', NULL, NULL),
(51, 13, '/The-Last-Of-Us/2/1/episode-3.txt', 'قسمت 3', NULL, NULL),
(52, 13, '/The-Last-Of-Us/2/1/episode-4.txt', 'قسمت 4', NULL, NULL),
(53, 14, '/The-Last-Of-Us/2/2/episode-1.txt', 'قسمت 1', NULL, NULL),
(54, 14, '/The-Last-Of-Us/2/2/episode-2.txt', 'قسمت 2', NULL, NULL),
(55, 14, '/The-Last-Of-Us/2/2/episode-3.txt', 'قسمت 3', NULL, NULL),
(56, 14, '/The-Last-Of-Us/2/2/episode-4.txt', 'قسمت 4', NULL, NULL),
(57, 15, '/stranger-things/1/1/episode-1.txt', 'قسمت 1', NULL, NULL),
(58, 15, '/stranger-things/1/1/episode-2.txt', 'قسمت 2', NULL, NULL),
(59, 15, '/stranger-things/1/1/episode-3.txt', 'قسمت 3', NULL, NULL),
(60, 15, '/stranger-things/1/1/episode-4.txt', 'قسمت 4', NULL, NULL),
(61, 16, '/stranger-things/1/2/episode-1.txt', 'قسمت 1', NULL, NULL),
(62, 16, '/stranger-things/1/2/episode-2.txt', 'قسمت 2', NULL, NULL),
(63, 16, '/stranger-things/1/2/episode-3.txt', 'قسمت 3', NULL, NULL),
(64, 16, '/stranger-things/1/2/episode-4.txt', 'قسمت 4', NULL, NULL),
(65, 17, '/stranger-things/2/1/episode-1.txt', 'قسمت 1', NULL, NULL),
(66, 17, '/stranger-things/2/1/episode-2.txt', 'قسمت 2', NULL, NULL),
(67, 17, '/stranger-things/2/1/episode-3.txt', 'قسمت 3', NULL, NULL),
(68, 17, '/stranger-things/2/1/episode-4.txt', 'قسمت 4', NULL, NULL),
(69, 18, '/stranger-things/2/2/episode-1.txt', 'قسمت 1', NULL, NULL),
(70, 18, '/stranger-things/2/2/episode-2.txt', 'قسمت 2', NULL, NULL),
(71, 18, '/stranger-things/2/2/episode-3.txt', 'قسمت 3', NULL, NULL),
(72, 18, '/stranger-things/2/2/episode-4.txt', 'قسمت 4', NULL, NULL),
(73, 19, '/stranger-things/3/1/episode-1.txt', 'قسمت 1', NULL, NULL),
(74, 19, '/stranger-things/3/1/episode-2.txt', 'قسمت 2', NULL, NULL),
(75, 20, '/stranger-things/3/2/episode-1.txt', 'قسمت 1', NULL, NULL),
(76, 20, '/stranger-things/3/2/episode-2.txt', 'قسمت 2', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('7xUg30iVuyO7nfYPVG4UD6MiKxLzkNkrM6Ir4V0u', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:126.0) Gecko/20100101 Firefox/126.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMjFKRUk1eU1UcVVGcEdyc2duTTRHQnJ4ZnFYc1pXQXJzVFJPVlB5cSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1718009268);

-- --------------------------------------------------------

--
-- Table structure for table `stars`
--

CREATE TABLE `stars` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `type` enum('actor','director') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `stars`
--

INSERT INTO `stars` (`id`, `name`, `image`, `type`, `created_at`, `updated_at`) VALUES
(1, 'Hiroyuki Ikeuchi', '/images/stars/default.png', 'actor', '2024-06-08 08:30:42', '2024-06-08 08:30:42'),
(2, 'Park Hae-soo', '/images/stars/MV5BOTAzYjFiN2EtOTc5YS00NzY4LTg5MWItMTU1YmFkZDdjZGMyXkEyXkFqcGdeQXVyMTExNzQzMDE0._V1_.jpg', 'actor', '2024-06-08 08:31:44', '2024-06-08 08:31:44'),
(3, 'Sol Kyung-gu', '/images/stars/default.png', 'actor', '2024-06-08 08:32:06', '2024-06-08 08:32:06'),
(4, 'Hyeon Na', '/images/stars/default.png', 'director', '2024-06-08 08:33:52', '2024-06-08 08:33:52'),
(5, 'Ajani Russell', '/images/stars/default.png', 'actor', '2024-06-08 08:50:51', '2024-06-08 08:50:51'),
(6, 'Avan Jogia', '/images/stars/MV5BZjBmZjYzZTAtNmFmNC00YWFiLTliMTAtMjZlN2FiMTVhMmQ0XkEyXkFqcGdeQXVyMTA4NTY5Njkx._V1_.jpg', 'actor', '2024-06-08 08:51:29', '2024-06-08 08:51:29'),
(7, 'Megan Fox', '/images/stars/MV5BMTc5MjgyMzk4NF5BMl5BanBnXkFtZTcwODk2OTM4Mg@@._SY600_SX400.jpg', 'actor', '2024-06-08 08:52:44', '2024-06-08 08:52:44'),
(8, 'Tom DeNucci', '/images/stars/default.png', 'director', '2024-06-08 08:52:44', '2024-06-08 08:52:44'),
(9, 'Jake Gyllenhaal', '/images/stars/MV5BNjA0MTU2NDY3MF5BMl5BanBnXkFtZTgwNDU4ODkzMzE@._SY600_SX400.jpg', 'actor', '2024-06-08 09:05:02', '2024-06-08 09:05:02'),
(10, 'Peter Sarsgaard', '/images/stars/MV5BMjE0Mjg0NzE2Nl5BMl5BanBnXkFtZTcwMDE1MTkxMw@@._SY600_SX400.jpg', 'actor', '2024-06-08 09:05:02', '2024-06-08 09:05:02'),
(11, 'Riley Keough', '/images/stars/MV5BMTY2Nzc1ODkzMF5BMl5BanBnXkFtZTgwMDUwNjE5MDI@._SY600_SX400.jpg', 'actor', '2024-06-08 09:06:03', '2024-06-08 09:06:03'),
(12, 'Antoine Fuqua', '/images/stars/MV5BMTM2NDQ4OTkxNV5BMl5BanBnXkFtZTcwMzQ4NzIyMw@@._SY600_SX400.jpg', 'director', '2024-06-08 09:06:03', '2024-06-08 09:06:03'),
(13, 'Charlie Hunnam', '/images/stars/MV5BMjE5NjE5Mzk2MV5BMl5BanBnXkFtZTcwODI5MDE1Ng@@._SY600_SX400.jpg', 'actor', '2024-06-08 09:17:57', '2024-06-08 09:17:57'),
(14, 'Christopher Fairbank', '/images/stars/MV5BMTM0NTc4NDIzM15BMl5BanBnXkFtZTcwODI0NjYxOA@@._SY600_SX400.jpg', 'actor', '2024-06-08 09:17:57', '2024-06-08 09:17:57'),
(15, 'Damijan Oklopdzic', '/images/stars/default.png', 'actor', '2024-06-08 09:19:20', '2024-06-08 09:19:20'),
(16, 'Michael Noer', '/images/stars/MV5BMjAzNTMzOTM4NV5BMl5BanBnXkFtZTcwODg2MDQ0OQ@@._SY600_SX400.jpg', 'director', '2024-06-08 09:19:20', '2024-06-08 09:19:20'),
(17, 'Joely Richardson', '/images/stars/MV5BODgwMjMwMzE2OV5BMl5BanBnXkFtZTcwOTAzMTgxMw@@._SY600_SX400.jpg', 'actor', '2024-06-08 09:35:01', '2024-06-08 09:35:01'),
(18, 'Sadie Soverall', '/images/stars/default.png', 'actor', '2024-06-08 09:35:01', '2024-06-08 09:35:01'),
(19, 'Matthias Hoene', '/images/stars/MV5BNTQzNjcyMjktYzFlMS00YmNkLWIyNTAtZjY3ZmU0YTU5MzE5XkEyXkFqcGdeQXVyNTc3NjQ1Mw@@._SY600_SX400.jpg', 'director', '2024-06-08 09:36:06', '2024-06-08 09:36:06'),
(20, 'Denise Pillott', '/images/stars/MV5BZGIyYjY1ZDQtYmYxOC00OTBlLThhZjItNjI3NmJmMWFlMjBkXkEyXkFqcGdeQXVyMjA3MTE5MDM@._SY600_SX400.jpg', 'actor', '2024-06-08 09:49:05', '2024-06-08 09:49:05'),
(21, 'Eddie Redmayne', '/images/stars/MV5BMTU0MjEyNzQyM15BMl5BanBnXkFtZTcwMTc4ODUxOQ@@._SY600_SX400.jpg', 'actor', '2024-06-08 09:49:05', '2024-06-08 09:49:05'),
(22, 'Jessica Chastain', '/images/stars/MV5BMTU1MDM5NjczOF5BMl5BanBnXkFtZTcwOTY2MDE4OA@@._SY600_SX400.jpg', 'actor', '2024-06-08 09:50:24', '2024-06-08 09:50:24'),
(23, 'Tobias Lindholm', '/images/stars/MV5BMjE0ODExNjY0NV5BMl5BanBnXkFtZTcwMzIxMDc2OQ@@._SY600_SX400.jpg', 'director', '2024-06-08 09:50:24', '2024-06-08 09:50:24'),
(24, 'Perry Benson', '/images/stars/default.png', 'actor', '2024-06-08 10:05:33', '2024-06-08 10:05:33'),
(25, 'Ray Stevenson', '/images/stars/MV5BYzE0YmE5OTUtYjFmOS00OGY4LWE0NmQtMWY4MjA3OWM4MTMwXkEyXkFqcGdeQXVyMTI2Nzk3NzI4._V1_.jpg', 'actor', '2024-06-08 10:05:52', '2024-06-08 10:05:52'),
(26, 'Scott Adkins', '/images/stars/MV5BZjM2MWU1YTEtNDExYS00NWVmLTkzZmQtYTg2ZDI5N2M3ZTE0XkEyXkFqcGdeQXVyMTA2NjI0MQ@@._SY600_SX400.jpg', 'actor', '2024-06-08 10:05:52', '2024-06-08 10:05:52'),
(27, 'Harry Kirby', '/images/stars/MV5BMmI0ODM0N2QtNTFkYi00YmUwLWFjZTYtOWFlNjc1NzBjYTVkXkEyXkFqcGdeQXVyMzUzMTQxNTk@._SY600_SX400.jpg', 'director', '2024-06-08 10:07:01', '2024-06-08 10:07:01'),
(28, 'Danielle Nicolet', '/images/stars/MV5BYmRhMGI2MTAtNGQ3MC00MTk5LWExMGEtYjYyODRkNjE4ZWQ1XkEyXkFqcGdeQXVyMDE4NTY1Mw@@._SY600_SX400.jpg', 'actor', '2024-06-08 10:24:26', '2024-06-08 10:24:26'),
(29, 'Dwayne Johnson', '/images/stars/MV5BMTkyNDQ3NzAxM15BMl5BanBnXkFtZTgwODIwMTQ0NTE@._SY600_SX400.jpg', 'actor', '2024-06-08 10:24:26', '2024-06-08 10:24:26'),
(30, 'Kevin Hart', '/images/stars/MV5BMTY4OTAxMjkxN15BMl5BanBnXkFtZTgwODg5MzYyMTE@._SY600_SX400.jpg', 'actor', '2024-06-08 10:25:13', '2024-06-08 10:25:13'),
(31, 'Rawson Marshall Thurber', '/images/stars/MV5BOTQ1ZTI3ODItODU3OS00YWZiLTkxY2QtYjMxODQ5MWViMmYzXkEyXkFqcGdeQXVyMDI3ODUxMQ@@._SY600_SX400.jpg', 'director', '2024-06-08 10:26:26', '2024-06-08 10:26:26'),
(32, 'Ginnifer Goodwin', '/images/stars/MV5BY2NmODMxNzctYzA3NS00NzFiLTliYWYtMzMzNDlmM2NkMWQxXkEyXkFqcGdeQXVyMTU1MDQ2NTM@._SY600_SX400.jpg', 'actor', '2024-06-08 10:42:51', '2024-06-08 10:42:51'),
(33, 'Idris Elba', '/images/stars/MV5BNzEzMTI2NjEyNF5BMl5BanBnXkFtZTcwNTA0OTE4OA@@._SY600_SX400.jpg', 'actor', '2024-06-08 10:42:51', '2024-06-08 10:42:51'),
(34, 'Jason Bateman', '/images/stars/MV5BMTMwOTQ0MDUyNF5BMl5BanBnXkFtZTcwNTQ1MzY1Mw@@._SY600_SX400.jpg', 'actor', '2024-06-08 10:43:47', '2024-06-08 10:43:47'),
(35, 'Rich Moore', '/images/stars/MV5BMTg2OTA2NTMyNV5BMl5BanBnXkFtZTcwNTQ3NTg2OA@@._SY600_SX400.jpg', 'director', '2024-06-08 10:44:17', '2024-06-08 10:44:17'),
(36, 'Adam Sandler', '/images/stars/MV5BMjQyNzM2MjM1Ml5BMl5BanBnXkFtZTcwMDE5NjI3Mg@@._SY600_SX400.jpg', 'actor', '2024-06-08 10:58:51', '2024-06-08 10:58:51'),
(37, 'Jennifer Aniston', '/images/stars/MV5BNjk1MjIxNjUxNF5BMl5BanBnXkFtZTcwODk2NzM4Mg@@._SY600_SX400.jpg', 'actor', '2024-06-08 10:58:51', '2024-06-08 10:58:51'),
(38, 'Luke Evans', '/images/stars/MV5BNDU1MDI2OTUyNV5BMl5BanBnXkFtZTcwNTA1OTY1OQ@@._SY600_SX400.jpg', 'actor', '2024-06-08 10:59:58', '2024-06-08 10:59:58'),
(39, 'Kyle Newacheck', '/images/stars/MV5BMTA5MDE3MjQyNDBeQTJeQWpwZ15BbWU4MDAwOTM1NzAx._V1_.jpg', 'director', '2024-06-08 11:00:23', '2024-06-08 11:00:23'),
(40, 'Adria Arjona', '/images/stars/MV5BYzEyNTYxMGEtMGZmYi00NGI0LWExMzUtMjhlMzgwNmJlMmYwXkEyXkFqcGdeQXVyMjQwMDg0Ng@@._SY600_SX400.jpg', 'actor', '2024-06-08 17:13:41', '2024-06-08 17:13:41'),
(41, 'Glen Powell', '/images/stars/MV5BMGEzMTIwM2UtYjc5MC00ZGI4LWJiOTAtYzAwZmU0OTYzYWIxXkEyXkFqcGdeQXVyNDg0MzQyNA@@._SY600_SX400.jpg', 'actor', '2024-06-08 17:13:41', '2024-06-08 17:13:41'),
(42, 'Richard Linklater', '/images/stars/MV5BMTQ0Mzc2NzY0Ml5BMl5BanBnXkFtZTcwOTI3OTI5MQ@@._SY600_SX400.jpg', 'director', '2024-06-08 17:14:50', '2024-06-08 17:14:50'),
(43, 'Aleksey Serebryakov', '/images/stars/MV5BNjY3MTE2MjM5MF5BMl5BanBnXkFtZTgwNzY3MjY4MTE@._SY600_SX400.jpg', 'actor', '2024-06-08 17:26:27', '2024-06-08 17:26:27'),
(44, 'Bob Odenkirk', '/images/stars/MV5BOWM5MDJjYTItMTRkNC00NTQ4LThkNjUtNDY3Mzk0YWMwMTBhXkEyXkFqcGdeQXVyNzQzNDYwMA@@._SY600_SX400.jpg', 'actor', '2024-06-08 17:26:27', '2024-06-08 17:26:27'),
(45, 'Connie Nielsen', '/images/stars/MV5BYzZiYTQ4YTAtMzRkMi00ZDZlLWFkZWItNGI2ZTIyODRiYTc4XkEyXkFqcGdeQXVyMjUzMjc2MjE@._SY600_SX400.jpg', 'actor', '2024-06-08 17:27:18', '2024-06-08 17:27:18'),
(46, 'Ilya Naishuller', '/images/stars/MV5BMTE0NjYyNjQ2NDheQTJeQWpwZ15BbWU4MDk0MTM0ODUz._V1_.jpg', 'director', '2024-06-08 17:27:49', '2024-06-08 17:27:49'),
(47, 'Jeremy Garelick', '/images/stars/MV5BNzA2MjI5MTc4M15BMl5BanBnXkFtZTgwMTA1MjU0MDE@._SY600_SX400.jpg', 'director', '2024-06-08 17:42:49', '2024-06-08 17:42:49'),
(48, 'Billy Campbell', '/images/stars/MV5BZWY2Mjc1NGMtYTI1Zi00OWM2LTkwZTgtZWE4OTI2OTdjZjJmXkEyXkFqcGdeQXVyNzg5MzIyOA@@._SY600_SX400.jpg', 'actor', NULL, NULL),
(49, 'Kyra Zagorsky', '/images/stars/MV5BMTk3ODIyOTAyN15BMl5BanBnXkFtZTgwNzU1ODkyMjE@._SY600_SX400.jpg', 'actor', NULL, NULL),
(50, 'Clémence Poésy', '/images/stars/MV5BOTA5MjM1Nzk5N15BMl5BanBnXkFtZTcwODY0Mjg4Mw@@._SY600_SX400.jpg', 'actor', NULL, NULL),
(51, 'Norman Reedus', '/images/stars/MV5BMTQ5ODE4NTgzMl5BMl5BanBnXkFtZTcwODI0MjAwMw@@._SY600_SX400.jpg', 'actor', NULL, NULL),
(52, 'Jeffrey Dean Morgan', '/images/stars/MV5BM2QwNjhkYzMtNjQ5Mi00OTk2LTg4N2ItZjUzYmU4MWViMDkxXkEyXkFqcGdeQXVyODY2NjYzNA@@._SY600_SX400.jpg', 'actor', NULL, NULL),
(53, 'Karina Ortiz', '/images/stars/MV5BMTM5ZmFhNTItODA0Ny00YzlmLTk3YzMtYTU3ZTkwYjdiOGMwXkEyXkFqcGdeQXVyMjQwMDg0Ng@@._SY600_SX400.jpg', 'actor', NULL, NULL),
(54, 'Lauren Cohan', '/images/stars/MV5BMjA1MDg0MzgxOF5BMl5BanBnXkFtZTgwMzM5NDg1MzE@._SY600_SX400.jpg', 'actor', NULL, NULL),
(55, 'Daniel Craig', '/images/stars/MV5BMjEzMjk4NDU4MF5BMl5BanBnXkFtZTcwMDMyNjQzMg@@._SY600_SX400.jpg', 'actor', NULL, NULL),
(56, 'Edward Norton', '/images/stars/MV5BMTYwNjQ5MTI1NF5BMl5BanBnXkFtZTcwMzU5MTI2Mw@@._SY600_SX400.jpg', 'actor', NULL, NULL),
(57, 'Kate Hudson', '/images/stars/MV5BMTA1NTk0MjMyOTFeQTJeQWpwZ15BbWU3MDA4NzEzMTM@._SY600_SX400.jpg', 'actor', NULL, NULL),
(58, 'Rian Johnson', '/images/stars/MV5BMjA3MTQwNjYyM15BMl5BanBnXkFtZTcwNTI5ODUwNQ@@._SY600_SX400.jpg', 'director', NULL, NULL),
(59, 'Jason Statham', '/images/stars/MV5BMTkxMzk2MDkwOV5BMl5BanBnXkFtZTcwMDAxODQwMg@@._SY600_SX400.jpg', 'actor', NULL, NULL),
(60, 'Shuya Sophia Cai', '/images/stars/default.png', 'actor', NULL, NULL),
(61, 'Ben Wheatley', '/images/stars/MV5BMTMyMDAxODIyMl5BMl5BanBnXkFtZTcwOTg5MjUzNA@@._SY600_SX400.jpg', 'director', NULL, NULL),
(62, 'Anna Torv', '/images/stars/MV5BMzQ0NDg0MjQ3NV5BMl5BanBnXkFtZTgwOTI5OTAwODE@._SY600_SX400.jpg', 'actor', NULL, NULL),
(63, 'Bella Ramsey', '/images/stars/MV5BMWJkZWEyMWYtYWI1MS00ZTY0LTg2MTAtYjUzMWIwZDhjNmViXkEyXkFqcGdeQXVyNzI5MjUxNjE@._SY600_SX400.jpg', 'actor', NULL, NULL),
(64, 'Pedro Pascal', '/images/stars/MV5BMGNlYTVlYTMtMjRhMC00YjY5LTkwMzMtZDE4MWQzMzgwYmUzXkEyXkFqcGdeQXVyMjI0OTExNzk@._SY600_SX400.jpg', 'actor', NULL, NULL),
(65, 'Finn Wolfhard', '/images/stars/MV5BYjlkNTdhNjYtYTFhNy00MTUxLWIwNTgtMTE5NTY5Y2I3MDc0XkEyXkFqcGdeQXVyNjY5NDgzNjQ@._SY600_SX400.jpg', 'actor', NULL, NULL),
(66, 'Millie Bobby Brown', '/images/stars/MV5BMjA5NzA0NzQzMF5BMl5BanBnXkFtZTgwMTQxNjUzNjM@._SY600_SX400.jpg', 'actor', NULL, NULL),
(67, 'Winona Ryder', '/images/stars/MV5BMTQ3NzM3MTc2NF5BMl5BanBnXkFtZTcwODMxNjA0NA@@._SY600_SX400.jpg', 'actor', NULL, NULL),
(68, 'Antonia Whillans', '/images/stars/default.png', 'actor', NULL, NULL),
(69, 'Hannaj Bang Bendz', '/images/stars/default.png', 'actor', NULL, NULL),
(70, 'Marta Svetek', '/images/stars/default.png', 'actor', NULL, NULL),
(71, 'David Ryan Keith', '/images/stars/MV5BYTJiNWEyMzAtYTA4Zi00ZTlmLTg2MmYtOWJmNmE5ZmE2ZjUzXkEyXkFqcGdeQXVyNTY2OTgxNQ@@._SY600_SX400.jpg', 'director', NULL, NULL),
(72, 'Dar Salim', '/images/stars/MV5BMzVmYjY4YWEtZjVjMi00NGQ3LWJmYWYtNmRmZDQ3NjExZTU0XkEyXkFqcGdeQXVyMjE5MTcxMA@@._SY600_SX400.jpg', 'actor', NULL, NULL),
(73, 'Guy Ritchie', '/images/stars/MV5BMTM2NDkxMTcxMl5BMl5BanBnXkFtZTcwNTMyNjI5MQ@@._SY600_SX400.jpg', 'director', NULL, NULL),
(74, 'sydney sweeney', '/images/stars/sydney.jpg', 'actor', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

CREATE TABLE `tags` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `type` enum('0','1') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tags`
--

INSERT INTO `tags` (`id`, `title`, `type`, `created_at`, `updated_at`) VALUES
(1, '250 فیلم برتر تاریخ', '0', NULL, NULL),
(2, '250 سریال برتر تاریخ', '1', NULL, NULL),
(3, 'فیلم های دوبله فارسی', '0', NULL, NULL),
(4, 'سریال های دوبله فارسی', '1', NULL, NULL),
(5, 'فیلم های زیرنویس چسبیده', '0', NULL, NULL),
(6, 'سریال های زیرنویس چسبیده', '1', NULL, NULL),
(7, 'فیلم های 4K', '0', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `profile` varchar(255) NOT NULL DEFAULT '/images/users/default.png',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `phone`, `password`, `profile`, `created_at`, `updated_at`) VALUES
(3, 'Mehran2023', '09144831183', '$2y$12$s2hIhnKkK1hnXluknhhP9.lcVOZ89Gzn5X.lLY8Ydloi7oYyW1/am', '/images/users/default.png', '2024-06-20 18:08:56', '2024-06-20 18:08:56');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `answers`
--
ALTER TABLE `answers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `answers_user_id_foreign` (`user_id`),
  ADD KEY `answers_comment_id_foreign` (`comment_id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comments_user_id_foreign` (`user_id`),
  ADD KEY `comments_movie_id_foreign` (`movie_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `genres`
--
ALTER TABLE `genres`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `genre_movie`
--
ALTER TABLE `genre_movie`
  ADD PRIMARY KEY (`id`),
  ADD KEY `genre_movie_movie_id_foreign` (`movie_id`),
  ADD KEY `genre_movie_genre_id_foreign` (`genre_id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `likes`
--
ALTER TABLE `likes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `likes_user_id_foreign` (`user_id`),
  ADD KEY `likes_movie_id_foreign` (`movie_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `movies`
--
ALTER TABLE `movies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `movie_links`
--
ALTER TABLE `movie_links`
  ADD PRIMARY KEY (`id`),
  ADD KEY `movie_links_movie_id_foreign` (`movie_id`);

--
-- Indexes for table `movie_star`
--
ALTER TABLE `movie_star`
  ADD PRIMARY KEY (`id`),
  ADD KEY `movie_star_movie_id_foreign` (`movie_id`),
  ADD KEY `movie_star_star_id_foreign` (`star_id`);

--
-- Indexes for table `movie_tag`
--
ALTER TABLE `movie_tag`
  ADD PRIMARY KEY (`id`),
  ADD KEY `movie_tag_movie_id_foreign` (`movie_id`),
  ADD KEY `movie_tag_tag_id_foreign` (`tag_id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `seasons`
--
ALTER TABLE `seasons`
  ADD PRIMARY KEY (`id`),
  ADD KEY `seasons_movie_id_foreign` (`movie_id`);

--
-- Indexes for table `sections`
--
ALTER TABLE `sections`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sections_season_id_foreign` (`season_id`);

--
-- Indexes for table `series_links`
--
ALTER TABLE `series_links`
  ADD PRIMARY KEY (`id`),
  ADD KEY `series_links_section_id_foreign` (`section_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `stars`
--
ALTER TABLE `stars`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_username_unique` (`username`),
  ADD UNIQUE KEY `users_phone_unique` (`phone`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `answers`
--
ALTER TABLE `answers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `genres`
--
ALTER TABLE `genres`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `genre_movie`
--
ALTER TABLE `genre_movie`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `likes`
--
ALTER TABLE `likes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `movies`
--
ALTER TABLE `movies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `movie_links`
--
ALTER TABLE `movie_links`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=94;

--
-- AUTO_INCREMENT for table `movie_star`
--
ALTER TABLE `movie_star`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

--
-- AUTO_INCREMENT for table `movie_tag`
--
ALTER TABLE `movie_tag`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `seasons`
--
ALTER TABLE `seasons`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `sections`
--
ALTER TABLE `sections`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `series_links`
--
ALTER TABLE `series_links`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT for table `stars`
--
ALTER TABLE `stars`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT for table `tags`
--
ALTER TABLE `tags`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `answers`
--
ALTER TABLE `answers`
  ADD CONSTRAINT `answers_comment_id_foreign` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `answers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_movie_id_foreign` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `genre_movie`
--
ALTER TABLE `genre_movie`
  ADD CONSTRAINT `genre_movie_genre_id_foreign` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `genre_movie_movie_id_foreign` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `likes`
--
ALTER TABLE `likes`
  ADD CONSTRAINT `likes_movie_id_foreign` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `likes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `movie_links`
--
ALTER TABLE `movie_links`
  ADD CONSTRAINT `movie_links_movie_id_foreign` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `movie_star`
--
ALTER TABLE `movie_star`
  ADD CONSTRAINT `movie_star_movie_id_foreign` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `movie_star_star_id_foreign` FOREIGN KEY (`star_id`) REFERENCES `stars` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `movie_tag`
--
ALTER TABLE `movie_tag`
  ADD CONSTRAINT `movie_tag_movie_id_foreign` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `movie_tag_tag_id_foreign` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `seasons`
--
ALTER TABLE `seasons`
  ADD CONSTRAINT `seasons_movie_id_foreign` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sections`
--
ALTER TABLE `sections`
  ADD CONSTRAINT `sections_season_id_foreign` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `series_links`
--
ALTER TABLE `series_links`
  ADD CONSTRAINT `series_links_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sections` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
