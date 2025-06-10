-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th6 10, 2025 lúc 06:25 AM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `quanlybenhnhan`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add benh nhan', 7, 'add_benhnhan'),
(26, 'Can change benh nhan', 7, 'change_benhnhan'),
(27, 'Can delete benh nhan', 7, 'delete_benhnhan'),
(28, 'Can view benh nhan', 7, 'view_benhnhan'),
(29, 'Can add danh sach kham', 8, 'add_danhsachkham'),
(30, 'Can change danh sach kham', 8, 'change_danhsachkham'),
(31, 'Can delete danh sach kham', 8, 'delete_danhsachkham'),
(32, 'Can view danh sach kham', 8, 'view_danhsachkham'),
(33, 'Can add nhan vien', 9, 'add_nhanvien'),
(34, 'Can change nhan vien', 9, 'change_nhanvien'),
(35, 'Can delete nhan vien', 9, 'delete_nhanvien'),
(36, 'Can view nhan vien', 9, 'view_nhanvien'),
(37, 'Can add tai khoan', 10, 'add_taikhoan'),
(38, 'Can change tai khoan', 10, 'change_taikhoan'),
(39, 'Can delete tai khoan', 10, 'delete_taikhoan'),
(40, 'Can view tai khoan', 10, 'view_taikhoan');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `benhnhan_benhnhan`
--

CREATE TABLE `benhnhan_benhnhan` (
  `BenhNhanID` int(11) NOT NULL,
  `HoVaTen` varchar(200) NOT NULL,
  `NamSinh` int(11) NOT NULL,
  `GioiTinh` char(1) NOT NULL,
  `Khu` varchar(100) DEFAULT NULL,
  `NgayTaoHoSo` datetime NOT NULL DEFAULT current_timestamp(),
  `TrangThai` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `benhnhan_benhnhan`
--

INSERT INTO `benhnhan_benhnhan` (`BenhNhanID`, `HoVaTen`, `NamSinh`, `GioiTinh`, `Khu`, `NgayTaoHoSo`, `TrangThai`) VALUES
(4, 'Nguyễn Văn A', 1977, 'M', 'Khu 1', '2025-06-04 09:23:59', 'Hoạt động'),
(5, 'Nguyễn Thị B', 1968, 'F', 'Khu 2', '2025-06-04 09:25:18', 'Hoạt động'),
(6, 'Nông Văn C', 1972, 'M', 'Khu 3', '2025-06-04 09:26:15', 'Hoạt động'),
(7, 'Lê Thị D', 1988, 'F', 'Khu 1', '2025-06-04 09:26:53', 'Hoạt động'),
(8, 'Nguyễn Thị D', 1976, 'F', 'Khu 2', '2025-06-04 14:01:51', 'Hoạt động'),
(9, 'Lò A Phỏm', 1972, 'M', 'Khu 2', '2025-06-05 02:32:33', 'Hoạt động');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `benhnhan_danhsachkham`
--

CREATE TABLE `benhnhan_danhsachkham` (
  `id` bigint(20) NOT NULL,
  `Thuoc` varchar(200) DEFAULT NULL,
  `NgayKham` date DEFAULT NULL,
  `NgayTaiKham` date DEFAULT NULL,
  `BenhNhan_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `benhnhan_danhsachkham`
--

INSERT INTO `benhnhan_danhsachkham` (`id`, `Thuoc`, `NgayKham`, `NgayTaiKham`, `BenhNhan_id`) VALUES
(13, 'Vitamin A', '2025-06-09', '2025-06-09', 4),
(14, 'Vitamin C', '2025-06-03', '2025-06-06', 5),
(15, '', NULL, NULL, 9);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `benhnhan_nhanvien`
--

CREATE TABLE `benhnhan_nhanvien` (
  `id` bigint(20) NOT NULL,
  `HoTen` varchar(100) NOT NULL,
  `NamSinh` int(11) NOT NULL,
  `GioiTinh` varchar(3) NOT NULL,
  `SDT` varchar(15) NOT NULL,
  `ChucVu` varchar(100) NOT NULL,
  `DiaChi` text NOT NULL,
  `TrangThai` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `benhnhan_nhanvien`
--

INSERT INTO `benhnhan_nhanvien` (`id`, `HoTen`, `NamSinh`, `GioiTinh`, `SDT`, `ChucVu`, `DiaChi`, `TrangThai`) VALUES
(1, 'Nguyễn Thị Lựu', 1989, 'Nữ', '0987654321', 'Nhân Viên Y Tế', 'Bình Phước, Việt Nam', 'Đang làm'),
(2, 'Hứa Văn Đạt', 1965, 'Nam', '0987987987', 'Nhân Viên Quản Lý', 'Hồ Chí Minh, Việt Nam', 'Đang làm');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `benhnhan_taikhoan`
--

CREATE TABLE `benhnhan_taikhoan` (
  `id` bigint(20) NOT NULL,
  `TenDangNhap` varchar(100) NOT NULL,
  `MatKhau` varchar(128) NOT NULL,
  `SoDienThoai` varchar(15) NOT NULL,
  `Gmail` varchar(254) NOT NULL,
  `Quyen` varchar(20) NOT NULL,
  `NgayTao` datetime NOT NULL DEFAULT current_timestamp(),
  `TrangThai` varchar(20) NOT NULL,
  `LanDangNhapCuoi` datetime DEFAULT NULL,
  `MaXacNhan` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `benhnhan_taikhoan`
--

INSERT INTO `benhnhan_taikhoan` (`id`, `TenDangNhap`, `MatKhau`, `SoDienThoai`, `Gmail`, `Quyen`, `NgayTao`, `TrangThai`, `LanDangNhapCuoi`, `MaXacNhan`) VALUES
(1, 'DuyTan122', 'pbkdf2_sha256$720000$joo7Dw2zbOUPzfngCn2lB3$hlKrDrro6YJSshVucA/pcZtcghzie6oyB4G/TwWJtCs=', '0383228141', 'hoangduytan09@gmail.com', 'nhanvien', '2025-06-06 12:51:39', 'hoatdong', '2025-06-06 13:00:27', NULL),
(2, 'DuyTan1234', 'pbkdf2_sha256$720000$lmc0b1l8gZf6G5qBE5yHZ5$uQScVjz+lDievl3jxmaGIk7X71oXLpJX8H1mOcmo7Qk=', '0383228142', 'admin@gmail.com', 'admin', '2025-06-07 03:13:29', 'hoatdong', '2025-06-10 04:18:21', NULL),
(3, 'DuyTan123', 'pbkdf2_sha256$720000$wouDnSQrsTr9X0jBDKZ1cB$WLwsCYa91YqBzYQQARwKK4DQWVCvKHqYvAkcsJIDS80=', '0383228143', 'admin1@gmail.com', 'nhanvien', '2025-06-09 09:20:32', 'hoatdong', '2025-06-09 12:17:21', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime NOT NULL,
  `object_id` text DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(6) NOT NULL,
  `change_message` text NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Bẫy `django_admin_log`
--
DELIMITER $$
CREATE TRIGGER `django_admin_log_action_flag_check` BEFORE INSERT ON `django_admin_log` FOR EACH ROW BEGIN
    IF NEW.action_flag < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'action_flag must be >= 0';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(7, 'benhnhan', 'benhnhan'),
(8, 'benhnhan', 'danhsachkham'),
(9, 'benhnhan', 'nhanvien'),
(10, 'benhnhan', 'taikhoan'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2025-06-04 02:09:25'),
(2, 'auth', '0001_initial', '2025-06-04 02:09:25'),
(3, 'admin', '0001_initial', '2025-06-04 02:09:25'),
(4, 'admin', '0002_logentry_remove_auto_add', '2025-06-04 02:09:25'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2025-06-04 02:09:25'),
(6, 'contenttypes', '0002_remove_content_type_name', '2025-06-04 02:09:26'),
(7, 'auth', '0002_alter_permission_name_max_length', '2025-06-04 02:09:26'),
(8, 'auth', '0003_alter_user_email_max_length', '2025-06-04 02:09:26'),
(9, 'auth', '0004_alter_user_username_opts', '2025-06-04 02:09:26'),
(10, 'auth', '0005_alter_user_last_login_null', '2025-06-04 02:09:26'),
(11, 'auth', '0006_require_contenttypes_0002', '2025-06-04 02:09:26'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2025-06-04 02:09:26'),
(13, 'auth', '0008_alter_user_username_max_length', '2025-06-04 02:09:27'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2025-06-04 02:09:27'),
(15, 'auth', '0010_alter_group_name_max_length', '2025-06-04 02:09:30'),
(16, 'auth', '0011_update_proxy_permissions', '2025-06-04 02:09:30'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2025-06-04 02:09:30'),
(18, 'sessions', '0001_initial', '2025-06-04 02:09:30'),
(19, 'benhnhan', '0001_initial', '2025-06-04 02:17:36'),
(20, 'benhnhan', '0002_danhsachkham', '2025-06-04 08:16:25'),
(21, 'benhnhan', '0003_nhanvien_alter_danhsachkham_ngaykham_and_more', '2025-06-06 02:28:48'),
(22, 'benhnhan', '0004_taikhoan', '2025-06-06 12:32:09');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` text NOT NULL,
  `expire_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('qmbtjl08j9y8z97wjqucyqq23uabb5bv', 'eyJ0ZW5fZGFuZ19uaGFwIjoiRHV5VGFuMTIzNCIsInF1eWVuIjoiYWRtaW4ifQ:1uOdUs:2sjn1Rer29UzJ_qAqiNGxKsKYd14lDiR7m9FPLmpZ0g', '2025-06-23 14:29:10'),
('uk71rp5dfmmjsehd70owwxiltahirsvj', 'eyJ0ZW5fZGFuZ19uaGFwIjoiRHV5VGFuMTIzNCIsInF1eWVuIjoiYWRtaW4ifQ:1uOqRJ:Y99yTO4SKKzTQHZKDKnWPwIsBPdyDBso7I3xxy-Kflk', '2025-06-24 04:18:21');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Chỉ mục cho bảng `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissions_group_id_b120cbf9` (`group_id`),
  ADD KEY `auth_group_permissions_permission_id_84c5c92e` (`permission_id`);

--
-- Chỉ mục cho bảng `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  ADD KEY `auth_permission_content_type_id_2f476e4b` (`content_type_id`);

--
-- Chỉ mục cho bảng `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Chỉ mục cho bảng `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544` (`group_id`),
  ADD KEY `auth_user_groups_user_id_6a12ed8b` (`user_id`);

--
-- Chỉ mục cho bảng `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permissions_permission_id_1fbb5f2c` (`permission_id`),
  ADD KEY `auth_user_user_permissions_user_id_a95ead1b` (`user_id`);

--
-- Chỉ mục cho bảng `benhnhan_benhnhan`
--
ALTER TABLE `benhnhan_benhnhan`
  ADD PRIMARY KEY (`BenhNhanID`);

--
-- Chỉ mục cho bảng `benhnhan_danhsachkham`
--
ALTER TABLE `benhnhan_danhsachkham`
  ADD PRIMARY KEY (`id`),
  ADD KEY `benhnhan_danhsachkham_BenhNhan_id_256bbe4f` (`BenhNhan_id`);

--
-- Chỉ mục cho bảng `benhnhan_nhanvien`
--
ALTER TABLE `benhnhan_nhanvien`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `benhnhan_taikhoan`
--
ALTER TABLE `benhnhan_taikhoan`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `TenDangNhap` (`TenDangNhap`),
  ADD UNIQUE KEY `Gmail` (`Gmail`);

--
-- Chỉ mục cho bảng `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6` (`user_id`);

--
-- Chỉ mục cho bảng `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `app_label` (`app_label`,`model`);

--
-- Chỉ mục cho bảng `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT cho bảng `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `benhnhan_benhnhan`
--
ALTER TABLE `benhnhan_benhnhan`
  MODIFY `BenhNhanID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT cho bảng `benhnhan_danhsachkham`
--
ALTER TABLE `benhnhan_danhsachkham`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT cho bảng `benhnhan_nhanvien`
--
ALTER TABLE `benhnhan_nhanvien`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `benhnhan_taikhoan`
--
ALTER TABLE `benhnhan_taikhoan`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT cho bảng `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissions_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `auth_group_permissions_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_ibfk_1` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `auth_user_groups_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permissions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `auth_user_user_permissions_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `benhnhan_danhsachkham`
--
ALTER TABLE `benhnhan_danhsachkham`
  ADD CONSTRAINT `benhnhan_danhsachkham_ibfk_1` FOREIGN KEY (`BenhNhan_id`) REFERENCES `benhnhan_benhnhan` (`BenhNhanID`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_ibfk_1` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `django_admin_log_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
