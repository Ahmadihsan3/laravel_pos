/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `order_items`;
CREATE TABLE `order_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint unsigned NOT NULL,
  `product_id` bigint unsigned NOT NULL,
  `quantity` int NOT NULL,
  `total_price` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_items_order_id_foreign` (`order_id`),
  KEY `order_items_product_id_foreign` (`product_id`),
  CONSTRAINT `order_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `order_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `transaction_time` timestamp NOT NULL,
  `total_price` int NOT NULL,
  `total_item` int NOT NULL,
  `kasir_id` bigint unsigned NOT NULL,
  `payment_method` enum('Tunai','QRIS') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `orders_kasir_id_foreign` (`kasir_id`),
  CONSTRAINT `orders_kasir_id_foreign` FOREIGN KEY (`kasir_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `price` int NOT NULL DEFAULT '0',
  `stock` int NOT NULL DEFAULT '0',
  `category` enum('food','drink','snack') COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_best_seller` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `roles` enum('admin','staff','user') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `two_factor_secret` text COLLATE utf8mb4_unicode_ci,
  `two_factor_recovery_codes` text COLLATE utf8mb4_unicode_ci,
  `two_factor_confirmed_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(3, '2014_10_12_200000_add_two_factor_columns_to_users_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(4, '2019_08_19_000000_create_failed_jobs_table', 1),
(5, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(6, '2024_02_02_144810_add_phone_roles_at_users', 1),
(7, '2024_02_04_112115_create_soals_table', 1),
(8, '2024_02_06_101414_create_products_table', 1),
(9, '2024_02_28_090246_add_favorite_at_product', 1),
(10, '2024_03_03_110854_create_orders_table', 1),
(11, '2024_03_03_110908_create_order_items_table', 1);

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `total_price`, `created_at`, `updated_at`) VALUES
(11, 12, 43, 1, 2500, '2024-03-09 14:34:18', '2024-03-09 14:34:18');
INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `total_price`, `created_at`, `updated_at`) VALUES
(12, 12, 42, 1, 3000, '2024-03-09 14:34:18', '2024-03-09 14:34:18');
INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `total_price`, `created_at`, `updated_at`) VALUES
(13, 12, 41, 1, 10000, '2024-03-09 14:34:18', '2024-03-09 14:34:18');
INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `total_price`, `created_at`, `updated_at`) VALUES
(14, 13, 43, 3, 2500, '2024-03-11 07:15:04', '2024-03-11 07:15:04'),
(15, 13, 42, 1, 3000, '2024-03-11 07:15:04', '2024-03-11 07:15:04'),
(16, 13, 41, 2, 10000, '2024-03-11 07:15:04', '2024-03-11 07:15:04'),
(17, 14, 42, 3, 3000, '2024-03-11 08:00:37', '2024-03-11 08:00:37'),
(18, 14, 43, 1, 2500, '2024-03-11 08:00:37', '2024-03-11 08:00:37'),
(19, 15, 43, 1, 2500, '2024-03-11 11:39:16', '2024-03-11 11:39:16'),
(20, 15, 42, 1, 3000, '2024-03-11 11:39:16', '2024-03-11 11:39:16'),
(21, 15, 41, 1, 10000, '2024-03-11 11:39:16', '2024-03-11 11:39:16'),
(22, 16, 43, 1, 2500, '2024-03-11 17:43:26', '2024-03-11 17:43:26'),
(23, 16, 42, 1, 3000, '2024-03-11 17:43:26', '2024-03-11 17:43:26'),
(24, 16, 41, 1, 10000, '2024-03-11 17:43:26', '2024-03-11 17:43:26'),
(25, 17, 43, 1, 2500, '2024-03-11 17:43:26', '2024-03-11 17:43:26'),
(26, 17, 42, 1, 3000, '2024-03-11 17:43:26', '2024-03-11 17:43:26'),
(27, 18, 43, 1, 2500, '2024-03-11 18:20:03', '2024-03-11 18:20:03'),
(28, 18, 42, 1, 3000, '2024-03-11 18:20:03', '2024-03-11 18:20:03'),
(29, 18, 41, 1, 10000, '2024-03-11 18:20:03', '2024-03-11 18:20:03'),
(30, 19, 42, 2, 3000, '2024-03-12 03:30:38', '2024-03-12 03:30:38'),
(31, 19, 41, 2, 10000, '2024-03-12 03:30:38', '2024-03-12 03:30:38'),
(32, 19, 43, 2, 2500, '2024-03-12 03:30:38', '2024-03-12 03:30:38'),
(33, 20, 43, 3, 2500, '2024-03-12 03:30:38', '2024-03-12 03:30:38'),
(34, 20, 42, 2, 3000, '2024-03-12 03:30:38', '2024-03-12 03:30:38'),
(35, 20, 41, 3, 10000, '2024-03-12 03:30:38', '2024-03-12 03:30:38'),
(36, 21, 43, 3, 2500, '2024-03-12 12:12:51', '2024-03-12 12:12:51'),
(37, 21, 42, 2, 3000, '2024-03-12 12:12:51', '2024-03-12 12:12:51'),
(38, 21, 41, 2, 10000, '2024-03-12 12:12:51', '2024-03-12 12:12:51'),
(39, 22, 42, 2, 3000, '2024-03-12 12:12:51', '2024-03-12 12:12:51'),
(40, 22, 43, 3, 2500, '2024-03-12 12:12:51', '2024-03-12 12:12:51'),
(41, 22, 41, 4, 10000, '2024-03-12 12:12:51', '2024-03-12 12:12:51'),
(42, 23, 43, 2, 2500, '2024-03-12 12:12:51', '2024-03-12 12:12:51'),
(43, 23, 42, 3, 3000, '2024-03-12 12:12:51', '2024-03-12 12:12:51'),
(44, 23, 41, 4, 10000, '2024-03-12 12:12:51', '2024-03-12 12:12:51'),
(45, 24, 43, 2, 2500, '2024-03-12 12:12:52', '2024-03-12 12:12:52'),
(46, 24, 42, 3, 3000, '2024-03-12 12:12:52', '2024-03-12 12:12:52'),
(47, 24, 41, 4, 10000, '2024-03-12 12:12:52', '2024-03-12 12:12:52');

INSERT INTO `orders` (`id`, `transaction_time`, `total_price`, `total_item`, `kasir_id`, `payment_method`, `created_at`, `updated_at`) VALUES
(12, '2024-03-09 21:34:13', 15500, 3, 11, 'Tunai', '2024-03-09 14:34:18', '2024-03-09 14:34:18');
INSERT INTO `orders` (`id`, `transaction_time`, `total_price`, `total_item`, `kasir_id`, `payment_method`, `created_at`, `updated_at`) VALUES
(13, '2024-03-11 14:14:57', 30500, 6, 11, 'Tunai', '2024-03-11 07:15:04', '2024-03-11 07:15:04');
INSERT INTO `orders` (`id`, `transaction_time`, `total_price`, `total_item`, `kasir_id`, `payment_method`, `created_at`, `updated_at`) VALUES
(14, '2024-03-11 15:00:23', 11500, 4, 11, 'Tunai', '2024-03-11 08:00:37', '2024-03-11 08:00:37');
INSERT INTO `orders` (`id`, `transaction_time`, `total_price`, `total_item`, `kasir_id`, `payment_method`, `created_at`, `updated_at`) VALUES
(15, '2024-03-11 18:39:10', 15500, 3, 11, 'Tunai', '2024-03-11 11:39:16', '2024-03-11 11:39:16'),
(16, '2024-03-12 00:41:52', 15500, 3, 11, 'Tunai', '2024-03-11 17:43:26', '2024-03-11 17:43:26'),
(17, '2024-03-12 00:42:59', 5500, 2, 11, 'Tunai', '2024-03-11 17:43:26', '2024-03-11 17:43:26'),
(18, '2024-03-12 01:18:28', 15500, 3, 11, 'Tunai', '2024-03-11 18:20:03', '2024-03-11 18:20:03'),
(19, '2024-03-12 10:28:06', 31000, 6, 11, 'Tunai', '2024-03-12 03:30:38', '2024-03-12 03:30:38'),
(20, '2024-03-12 10:28:38', 43500, 8, 11, 'Tunai', '2024-03-12 03:30:38', '2024-03-12 03:30:38'),
(21, '2024-03-12 19:10:12', 33500, 7, 11, 'Tunai', '2024-03-12 12:12:51', '2024-03-12 12:12:51'),
(22, '2024-03-12 19:10:26', 51000, 8, 11, 'Tunai', '2024-03-12 12:12:51', '2024-03-12 12:12:51'),
(23, '2024-03-12 19:11:03', 54000, 9, 11, 'Tunai', '2024-03-12 12:12:51', '2024-03-12 12:12:51'),
(24, '2024-03-12 19:12:29', 54000, 9, 11, 'Tunai', '2024-03-12 12:12:52', '2024-03-12 12:12:52');



INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 11, 'auth_token', 'd07b20d1b57edfddd1b9e2c268d12d7b1969fa7f229d0857a3b0ec75bbd07dec', '[\"*\"]', '2024-03-07 13:28:23', NULL, '2024-03-07 12:50:54', '2024-03-07 13:28:23');
INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(2, 'App\\Models\\User', 11, 'auth_token', '9586d5c082ad99b863e91c2583a5845b7eaa886ac9722106ccbda354d180f441', '[\"*\"]', '2024-03-08 14:49:35', NULL, '2024-03-08 12:59:02', '2024-03-08 14:49:35');
INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(6, 'App\\Models\\User', 11, 'auth_token', 'b9c841861ba4f3ae37ce5d050c97cdf973aaf9ca20b29b9de13c1eb38155770e', '[\"*\"]', NULL, NULL, '2024-03-11 10:16:21', '2024-03-11 10:16:21');
INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(7, 'App\\Models\\User', 11, 'auth_token', 'cf0f8c7bf33630374fb33386bdc259911dc2e468aa22535f745b36136c53011d', '[\"*\"]', '2024-03-11 11:39:16', NULL, '2024-03-11 11:38:54', '2024-03-11 11:39:16'),
(10, 'App\\Models\\User', 11, 'auth_token', '413512c9954db04fa629b2823b9f2437c477d1c453dcaa9fea98d837c8515174', '[\"*\"]', NULL, NULL, '2024-03-11 15:14:28', '2024-03-11 15:14:28'),
(13, 'App\\Models\\User', 11, 'auth_token', '23a949e3f737780b22678a5160454cb998123933277045401c8d4eba855aabba', '[\"*\"]', '2024-03-11 17:43:26', NULL, '2024-03-11 17:41:04', '2024-03-11 17:43:26'),
(15, 'App\\Models\\User', 11, 'auth_token', 'a044db250606330e7c514edc89c92e34f61d42d3573c17192a425c3b246ab048', '[\"*\"]', '2024-03-11 18:20:04', NULL, '2024-03-11 18:19:59', '2024-03-11 18:20:04'),
(18, 'App\\Models\\User', 11, 'auth_token', '102a3416057030b747546a5efbfdcc983d32198db77c2b358e47848d6d8bec1c', '[\"*\"]', '2024-03-12 03:30:38', NULL, '2024-03-12 03:28:20', '2024-03-12 03:30:38'),
(19, 'App\\Models\\User', 11, 'auth_token', '849d3c7f76f56e8931abc2c6178126e1cd08e61169240a52cd550cc28d7af089', '[\"*\"]', NULL, NULL, '2024-03-12 03:49:17', '2024-03-12 03:49:17'),
(20, 'App\\Models\\User', 11, 'auth_token', '95809765c7c2a2a726397315eabae43dd6ce3ae203eee598dc68337286f7da64', '[\"*\"]', '2024-03-12 04:39:29', NULL, '2024-03-12 04:39:15', '2024-03-12 04:39:29'),
(21, 'App\\Models\\User', 11, 'auth_token', '72269f4088090f3703ad14a7a7cf700e70845aaaef87fe4824bb7df6d5779fe3', '[\"*\"]', '2024-03-12 11:39:48', NULL, '2024-03-12 11:39:43', '2024-03-12 11:39:48'),
(22, 'App\\Models\\User', 11, 'auth_token', '7e8f17b16254510f72f04dbb517ee3512781220367b23de86de06b9b319d98bc', '[\"*\"]', '2024-03-12 11:48:24', NULL, '2024-03-12 11:48:19', '2024-03-12 11:48:24'),
(24, 'App\\Models\\User', 11, 'auth_token', 'f02e7dd0b2f715b71cb2c39b4fc6422ba3d60dee9b0392edaa64c7d3bde073b3', '[\"*\"]', '2024-03-12 12:12:52', NULL, '2024-03-12 12:11:51', '2024-03-12 12:12:52'),
(25, 'App\\Models\\User', 11, 'auth_token', '49fd1e73094828022c83a8041af52688585ff2a52feebd1b15b96aa1e68a0164', '[\"*\"]', '2024-03-12 12:59:51', NULL, '2024-03-12 12:59:39', '2024-03-12 12:59:51'),
(26, 'App\\Models\\User', 11, 'auth_token', '777eda927f6aed2605de46c6ab0de0dacfcfdd236a901ae3b1e3910426ea0892', '[\"*\"]', NULL, NULL, '2024-03-12 13:37:10', '2024-03-12 13:37:10'),
(27, 'App\\Models\\User', 11, 'auth_token', 'cc5b8c26b1834d66d8ac4754acd5e383bb5e33dc8fc80c013e078a693553abee', '[\"*\"]', NULL, NULL, '2024-03-12 14:02:34', '2024-03-12 14:02:34'),
(28, 'App\\Models\\User', 11, 'auth_token', '7f194b3d71d04b6ed74e493998e54f7ea49b55402c2be9b7df53a207cc0fac95', '[\"*\"]', NULL, NULL, '2024-03-12 14:03:06', '2024-03-12 14:03:06'),
(29, 'App\\Models\\User', 11, 'auth_token', '7c7d8adcd3c567e47189d8a84584987b7e52c82bbb024d38d339f7ac4892fbbb', '[\"*\"]', '2024-03-13 13:37:22', NULL, '2024-03-12 14:13:08', '2024-03-13 13:37:22'),
(30, 'App\\Models\\User', 13, 'auth_token', 'fe554b99b86d79a442f407130f9044a85516a019598cc3ebb564c5e3bedf5d5c', '[\"*\"]', NULL, NULL, '2024-03-13 13:42:32', '2024-03-13 13:42:32'),
(31, 'App\\Models\\User', 13, 'auth_token', '50aef19bd5485350042a5e0973b5650467b132c9224ab19d3544a5db2f94f42e', '[\"*\"]', NULL, NULL, '2024-03-13 13:42:32', '2024-03-13 13:42:32'),
(32, 'App\\Models\\User', 13, 'auth_token', '24c5b16545cab0c29d50224a3efeb838ccf03f20b70d9c6139657d34f9eeb091', '[\"*\"]', NULL, NULL, '2024-03-13 13:42:33', '2024-03-13 13:42:33'),
(33, 'App\\Models\\User', 13, 'auth_token', '9888e02826c63cce9d30350703bed17b7ce2fc95e8811a5f544b4591029de73c', '[\"*\"]', NULL, NULL, '2024-03-13 13:42:34', '2024-03-13 13:42:34'),
(34, 'App\\Models\\User', 13, 'auth_token', '2cf486b6ac9b83c2107d551d78758d71becf4569f6b521cf599ab4359b4fbb1d', '[\"*\"]', NULL, NULL, '2024-03-13 13:42:34', '2024-03-13 13:42:34'),
(35, 'App\\Models\\User', 13, 'auth_token', 'd399c90d64c35c8a3a8b0f7ed47b0d2ece956870fab59ffccf2a0096a5356daf', '[\"*\"]', NULL, NULL, '2024-03-13 13:42:56', '2024-03-13 13:42:56'),
(36, 'App\\Models\\User', 13, 'auth_token', '60c55df82705728a1f4d3ddfab6974ea950ef085a382943dcf3eb28ecdcc0ff0', '[\"*\"]', '2024-03-13 14:08:07', NULL, '2024-03-13 13:43:02', '2024-03-13 14:08:07'),
(37, 'App\\Models\\User', 11, 'auth_token', 'fb54325da169cfe2af8f29451ccc054c37d599aa716e00903df88f6509ee4bfa', '[\"*\"]', NULL, NULL, '2024-03-14 03:35:32', '2024-03-14 03:35:32');

INSERT INTO `products` (`id`, `name`, `description`, `price`, `stock`, `category`, `image`, `created_at`, `updated_at`, `is_best_seller`) VALUES
(41, 'Burger', 'Burger Rotiiii', 10000, 100, 'food', '1709815786.jpg', '2024-03-07 12:49:46', '2024-03-07 12:49:46', 0);
INSERT INTO `products` (`id`, `name`, `description`, `price`, `stock`, `category`, `image`, `created_at`, `updated_at`, `is_best_seller`) VALUES
(42, 'Le mineral', 'Le Minerallll', 3000, 100, 'drink', '1709815817.jpg', '2024-03-07 12:50:17', '2024-03-07 12:50:17', 0);
INSERT INTO `products` (`id`, `name`, `description`, `price`, `stock`, `category`, `image`, `created_at`, `updated_at`, `is_best_seller`) VALUES
(43, 'Wafello', 'wafello caramel', 2500, 100, 'snack', '1709815846.jpg', '2024-03-07 12:50:46', '2024-03-07 12:50:46', 0);
INSERT INTO `products` (`id`, `name`, `description`, `price`, `stock`, `category`, `image`, `created_at`, `updated_at`, `is_best_seller`) VALUES
(45, 'TESTTT', 'TESTTTTTTTTT', 25001, 21, 'food', '1710334408.png', '2024-03-13 12:53:28', '2024-03-13 12:53:28', 0),
(46, 'Testing', NULL, 50000, 100, 'food', '1710338879.png', '2024-03-13 14:07:59', '2024-03-13 14:07:59', 0);

INSERT INTO `users` (`id`, `name`, `email`, `phone`, `roles`, `email_verified_at`, `password`, `two_factor_secret`, `two_factor_recovery_codes`, `two_factor_confirmed_at`, `remember_token`, `created_at`, `updated_at`) VALUES
(3, 'Andrew Hand', 'hagenes.arnulfo@example.com', '+1 (571) 602-2507', 'staff', '2024-03-07 12:45:12', '$2y$12$IiLEBD/YzFfz6zXx4p/YA.Vh8Iv7qMSFTOs/5MEKhJ6Bge.J.TWkK', NULL, NULL, NULL, 'GIWGMnTCG0', '2024-03-07 12:45:12', '2024-03-07 12:45:12');
INSERT INTO `users` (`id`, `name`, `email`, `phone`, `roles`, `email_verified_at`, `password`, `two_factor_secret`, `two_factor_recovery_codes`, `two_factor_confirmed_at`, `remember_token`, `created_at`, `updated_at`) VALUES
(4, 'Arely Ortiz', 'jcruickshank@example.com', '+1 (754) 224-9928', 'staff', '2024-03-07 12:45:12', '$2y$12$IiLEBD/YzFfz6zXx4p/YA.Vh8Iv7qMSFTOs/5MEKhJ6Bge.J.TWkK', NULL, NULL, NULL, 'RgGE5vg3pd', '2024-03-07 12:45:12', '2024-03-07 12:45:12');
INSERT INTO `users` (`id`, `name`, `email`, `phone`, `roles`, `email_verified_at`, `password`, `two_factor_secret`, `two_factor_recovery_codes`, `two_factor_confirmed_at`, `remember_token`, `created_at`, `updated_at`) VALUES
(5, 'Aubrey Rau', 'lgerhold@example.org', '409-948-9021', 'staff', '2024-03-07 12:45:12', '$2y$12$IiLEBD/YzFfz6zXx4p/YA.Vh8Iv7qMSFTOs/5MEKhJ6Bge.J.TWkK', NULL, NULL, NULL, '3g59Z3YYMk', '2024-03-07 12:45:12', '2024-03-07 12:45:12');
INSERT INTO `users` (`id`, `name`, `email`, `phone`, `roles`, `email_verified_at`, `password`, `two_factor_secret`, `two_factor_recovery_codes`, `two_factor_confirmed_at`, `remember_token`, `created_at`, `updated_at`) VALUES
(6, 'Mr. Faustino Quitzon', 'archibald84@example.org', '1-678-577-1294', 'staff', '2024-03-07 12:45:12', '$2y$12$IiLEBD/YzFfz6zXx4p/YA.Vh8Iv7qMSFTOs/5MEKhJ6Bge.J.TWkK', NULL, NULL, NULL, 'KUA9yVYHk9', '2024-03-07 12:45:12', '2024-03-07 12:45:12'),
(7, 'Lynn Lueilwitz', 'travis.christiansen@example.org', '+1-331-714-3930', 'staff', '2024-03-07 12:45:12', '$2y$12$IiLEBD/YzFfz6zXx4p/YA.Vh8Iv7qMSFTOs/5MEKhJ6Bge.J.TWkK', NULL, NULL, NULL, 'OWxJpSgTR1', '2024-03-07 12:45:12', '2024-03-07 12:45:12'),
(8, 'Ms. Shanie Beier Sr.', 'eyundt@example.com', '1-360-798-3616', 'staff', '2024-03-07 12:45:12', '$2y$12$IiLEBD/YzFfz6zXx4p/YA.Vh8Iv7qMSFTOs/5MEKhJ6Bge.J.TWkK', NULL, NULL, NULL, 'AtmWOhFDCF', '2024-03-07 12:45:12', '2024-03-07 12:45:12'),
(9, 'Dr. Alexis Stracke DDS', 'ralph.howell@example.com', '1-650-713-1927', 'staff', '2024-03-07 12:45:12', '$2y$12$IiLEBD/YzFfz6zXx4p/YA.Vh8Iv7qMSFTOs/5MEKhJ6Bge.J.TWkK', NULL, NULL, NULL, '0HSX5RIfTv', '2024-03-07 12:45:12', '2024-03-07 12:45:12'),
(10, 'Toby Spinka', 'vschaden@example.org', '602.232.4472', 'staff', '2024-03-07 12:45:12', '$2y$12$IiLEBD/YzFfz6zXx4p/YA.Vh8Iv7qMSFTOs/5MEKhJ6Bge.J.TWkK', NULL, NULL, NULL, 'Hav2wMKVhF', '2024-03-07 12:45:12', '2024-03-07 12:45:12'),
(11, 'Ihsan', 'ihsan@fic11.com', '086617263612', 'admin', NULL, '$2y$12$TRS4eHRulp3xxVOkXr3lEeNu.3KkCKKuQKz33i66d2pFw2is7EBQe', NULL, NULL, NULL, NULL, '2024-03-07 12:45:13', '2024-03-07 12:45:13'),
(12, 'Admin', 'Admin@gmail.com', '123456789', 'admin', NULL, '$2y$12$fisqHPFvybgY1WuZT8ySo.deFOBcvLLLDWhCBXwlR6FjyB9lAIVXa', NULL, NULL, NULL, NULL, '2024-03-13 13:12:13', '2024-03-13 13:12:13'),
(13, 'User Ihsan', 'Ihsan@gmail.com', '0231555', 'user', NULL, '$2y$12$CHxqhYeBWO30UriAZsV48uQu3vFEtAZvkDANaF.x5pJF6ke36jiOO', NULL, NULL, NULL, NULL, '2024-03-13 13:12:40', '2024-03-13 13:12:40');


/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;