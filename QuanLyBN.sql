USE `QuanLyBenhNhan`;

-- Table: auth_group
CREATE TABLE `auth_group` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(150) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `auth_group_name_a6ea08ec_uniq` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: django_content_type
CREATE TABLE `django_content_type` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `app_label` VARCHAR(100) NOT NULL,
    `model` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`, `model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: auth_permission
CREATE TABLE `auth_permission` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `content_type_id` INT NOT NULL,
    `codename` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`, `codename`),
    KEY `auth_permission_content_type_id_2f476e4b` (`content_type_id`),
    CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: auth_group_permissions
CREATE TABLE `auth_group_permissions` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `group_id` INT NOT NULL,
    `permission_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`, `permission_id`),
    KEY `auth_group_permissions_group_id_b120cbf9` (`group_id`),
    KEY `auth_group_permissions_permission_id_84c5c92e` (`permission_id`),
    CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_grou` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
    CONSTRAINT `auth_group_permissions_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: auth_user
CREATE TABLE `auth_user` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `password` VARCHAR(128) NOT NULL,
    `last_login` DATETIME NULL,
    `is_superuser` TINYINT(1) NOT NULL,
    `username` VARCHAR(150) NOT NULL,
    `first_name` VARCHAR(150) NOT NULL,
    `last_name` VARCHAR(150) NOT NULL,
    `email` VARCHAR(254) NOT NULL,
    `is_staff` TINYINT(1) NOT NULL,
    `is_active` TINYINT(1) NOT NULL,
    `date_joined` DATETIME NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `auth_user_username_6821ab7c_uniq` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: auth_user_groups
CREATE TABLE `auth_user_groups` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `user_id` INT NOT NULL,
    `group_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`, `group_id`),
    KEY `auth_user_groups_user_id_6a12ed8b` (`user_id`),
    KEY `auth_user_groups_group_id_97559544` (`group_id`),
    CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
    CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: auth_user_user_permissions
CREATE TABLE `auth_user_user_permissions` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `user_id` INT NOT NULL,
    `permission_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`, `permission_id`),
    KEY `auth_user_user_permissions_user_id_a95ead1b` (`user_id`),
    KEY `auth_user_user_permissions_permission_id_1fbb5f2c` (`permission_id`),
    CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
    CONSTRAINT `auth_user_user_permissions_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: benhnhan_khunha
CREATE TABLE `benhnhan_khunha` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `TenKhu` VARCHAR(100) NOT NULL,
    `TrangThai` VARCHAR(20) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `UQ__benhnhan__33A304EBF29A089A` (`TenKhu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: benhnhan_nha
CREATE TABLE `benhnhan_nha` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `TenNha` VARCHAR(100) NOT NULL,
    `Khu_id` INT NOT NULL,
    `TrangThai` VARCHAR(20) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `benhnhan_nha_TenNha_Khu_id_90f425d6_uniq` (`TenNha`, `Khu_id`),
    KEY `benhnhan_nha_Khu_id_7a9a0044` (`Khu_id`),
    CONSTRAINT `benhnhan_nha_Khu_id_7a9a0044_fk_benhnhan_khunha_id` FOREIGN KEY (`Khu_id`) REFERENCES `benhnhan_khunha` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: benhnhan_benhnhan
CREATE TABLE `benhnhan_benhnhan` (
    `BenhNhanID` INT NOT NULL AUTO_INCREMENT,
    `HoVaTen` VARCHAR(200) NOT NULL,
    `NamSinh` INT NOT NULL,
    `GioiTinh` CHAR(1) NOT NULL,
    `Khu_id` INT NULL,
    `NgayTaoHoSo` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `TrangThai` VARCHAR(50) NULL,
    PRIMARY KEY (`BenhNhanID`),
    KEY `benhnhan_benhnhan_Khu_id_80307ba3` (`Khu_id`),
    CONSTRAINT `benhnhan_benhnhan_Khu_id_80307ba3_fk_benhnhan_nha_id` FOREIGN KEY (`Khu_id`) REFERENCES `benhnhan_nha` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: benhnhan_danhsachkham
CREATE TABLE `benhnhan_danhsachkham` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `Thuoc` VARCHAR(200) NULL,
    `NgayKham` DATE NULL,
    `NgayTaiKham` DATE NULL,
    `BenhNhan_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    KEY `benhnhan_danhsachkham_BenhNhan_id_256bbe4f` (`BenhNhan_id`),
    CONSTRAINT `benhnhan_danhsachkham_BenhNhan_id_256bbe4f_fk_benhnhan_` FOREIGN KEY (`BenhNhan_id`) REFERENCES `benhnhan_benhnhan` (`BenhNhanID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: benhnhan_nhanvien
CREATE TABLE `benhnhan_nhanvien` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `HoTen` VARCHAR(100) NOT NULL,
    `NamSinh` INT NOT NULL,
    `GioiTinh` VARCHAR(3) NOT NULL,
    `SDT` VARCHAR(15) NOT NULL,
    `ChucVu` VARCHAR(100) NOT NULL,
    `DiaChi` TEXT NOT NULL,
    `TrangThai` VARCHAR(20) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: benhnhan_taikhoan
CREATE TABLE `benhnhan_taikhoan` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `TenDangNhap` VARCHAR(100) NOT NULL,
    `MatKhau` VARCHAR(128) NOT NULL,
    `SoDienThoai` VARCHAR(15) NOT NULL,
    `Gmail` VARCHAR(254) NOT NULL,
    `Quyen` VARCHAR(20) NOT NULL,
    `NgayTao` DATETIME NOT NULL,
    `TrangThai` VARCHAR(20) NOT NULL,
    `LanDangNhapCuoi` DATETIME NULL,
    `MaXacNhan` VARCHAR(6) NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `UQ__benhnhan__55F68FC018C8537F` (`TenDangNhap`),
    UNIQUE KEY `UQ__benhnhan__B488B103F6452B3D` (`Gmail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: django_admin_log
CREATE TABLE `django_admin_log` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `action_time` DATETIME NOT NULL,
    `object_id` TEXT NULL,
    `object_repr` VARCHAR(200) NOT NULL,
    `action_flag` SMALLINT NOT NULL CHECK (`action_flag` >= 0),
    `change_message` TEXT NOT NULL,
    `content_type_id` INT NULL,
    `user_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    KEY `django_admin_log_content_type_id_c4bce8eb` (`content_type_id`),
    KEY `django_admin_log_user_id_c564eba6` (`user_id`),
    CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
    CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: django_migrations
CREATE TABLE `django_migrations` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `app` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `applied` DATETIME NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: django_session
CREATE TABLE `django_session` (
    `session_key` VARCHAR(40) NOT NULL,
    `session_data` TEXT NOT NULL,
    `expire_date` DATETIME NOT NULL,
    PRIMARY KEY (`session_key`),
    KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert Data: django_content_type
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(2, 'auth', 'permission'),
(3, 'auth', 'group'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session'),
(7, 'benhnhan', 'benhnhan'),
(8, 'benhnhan', 'danhsachkham'),
(9, 'benhnhan', 'nhanvien'),
(10, 'benhnhan', 'taikhoan'),
(11, 'benhnhan', 'nha'),
(12, 'benhnhan', 'khunha');

-- Insert Data: auth_permission
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
(40, 'Can view tai khoan', 10, 'view_taikhoan'),
(41, 'Can add nha', 11, 'add_nha'),
(42, 'Can change nha', 11, 'change_nha'),
(43, 'Can delete nha', 11, 'delete_nha'),
(44, 'Can view nha', 11, 'view_nha'),
(45, 'Can add khu nha', 12, 'add_khunha'),
(46, 'Can change khu nha', 12, 'change_khunha'),
(47, 'Can delete khu nha', 12, 'delete_khunha'),
(48, 'Can view khu nha', 12, 'view_khunha');

-- Insert Data: benhnhan_khunha
INSERT INTO `benhnhan_khunha` (`id`, `TenKhu`, `TrangThai`) VALUES
(1, 'Khu 1', 'Hoạt động'),
(2, 'Khu 2', 'Hoạt động'),
(3, 'Khu 3', 'Hoạt động');

-- Insert Data: benhnhan_nha
INSERT INTO `benhnhan_nha` (`id`, `TenNha`, `Khu_id`, `TrangThai`) VALUES
(1, 'Nhà 1', 1, 'Hoạt động'),
(2, 'Nhà 2', 1, 'Hoạt động'),
(3, 'Nhà 3', 1, 'Hoạt động'),
(4, 'Nhà 4', 1, 'Hoạt động');

-- Insert Data: benhnhan_benhnhan
INSERT INTO `benhnhan_benhnhan` (`BenhNhanID`, `HoVaTen`, `NamSinh`, `GioiTinh`, `Khu_id`, `NgayTaoHoSo`, `TrangThai`) VALUES
(4, 'Nguyễn Văn A', 1977, 'M', 1, '2025-06-04 09:23:59', 'Hoạt động'),
(5, 'Nguyễn Thị B', 1968, 'F', 1, '2025-06-04 09:25:18', 'Hoạt động'),
(6, 'Nông Văn C', 1972, 'M', 2, '2025-06-04 09:26:15', 'Hoạt động'),
(7, 'Lê Thị D', 1988, 'F', 2, '2025-06-04 09:26:53', 'Hoạt động'),
(8, 'Nguyễn Thị D', 1976, 'F', 3, '2025-06-04 14:01:51', 'Hoạt động'),
(9, 'Lò A Phỏm', 1972, 'M', 3, '2025-06-05 02:32:33', 'Hoạt động');

-- Insert Data: benhnhan_danhsachkham
INSERT INTO `benhnhan_danhsachkham` (`id`, `Thuoc`, `NgayKham`, `NgayTaiKham`, `BenhNhan_id`) VALUES
(13, 'Vitamin A', '2025-06-12', '2025-06-12', 4),
(14, 'Vitamin C', '2025-06-03', '2025-06-06', 5),
(15, '', NULL, NULL, 9);

-- Insert Data: benhnhan_nhanvien
INSERT INTO `benhnhan_nhanvien` (`id`, `HoTen`, `NamSinh`, `GioiTinh`, `SDT`, `ChucVu`, `DiaChi`, `TrangThai`) VALUES
(1, 'Nguyễn Thị Lựu', 1989, 'Nữ', '0987654321', 'Nhân Viên Y Tế', 'Bình Phước, Việt Nam', 'Đang làm'),
(2, 'Hứa Văn Đạt', 1965, 'Nam', '0987987987', 'Nhân Viên Quản Lý', 'Hồ Chí Minh, Việt Nam', 'Đang làm');

-- Insert Data: benhnhan_taikhoan
INSERT INTO `benhnhan_taikhoan` (`id`, `TenDangNhap`, `MatKhau`, `SoDienThoai`, `Gmail`, `Quyen`, `NgayTao`, `TrangThai`, `LanDangNhapCuoi`, `MaXacNhan`) VALUES
(1, 'DuyTan122', 'pbkdf2_sha256$720000$joo7Dw2zbOUPzfngCn2lB3$hlKrDrro6YJSshVucA/pcZtcghzie6oyB4G/TwWJtCs=', '0383228141', 'hoangduytan09@gmail.com', 'nhanvien', '2025-06-06 12:51:39', 'hoatdong', '2025-06-06 13:00:27', NULL),
(2, 'DuyTan1234', 'pbkdf2_sha256$720000$lmc0b1l8gZf6G5qBE5yHZ5$uQScVjz+lDievl3jxmaGIk7X71oXLpJX8H1mOcmo7Qk=', '0383228142', 'admin@gmail.com', 'admin', '2025-06-07 03:13:29', 'hoatdong', '2025-06-11 02:37:33', NULL),
(3, 'DuyTan123', 'pbkdf2_sha256$720000$wouDnSQrsTr9X0jBDKZ1cB$WLwsCYa91YqBzYQQARwKK4DQWVCvKHqYvAkcsJIDS80=', '0383228143', 'admin1@gmail.com', 'nhanvien', '2025-06-09 09:20:32', 'ngung', '2025-06-11 02:30:52', NULL);

-- Insert Data: django_migrations
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
(22, 'benhnhan', '0004_taikhoan', '2025-06-06 12:32:09'),
(23, 'benhnhan', '0005_khunha_nha_alter_benhnhan_khu', '2025-06-10 08:26:10'),
(24, 'benhnhan', '0006_khunha_trangthai_nha_trangthai', '2025-06-10 09:22:44');

-- Insert Data: django_session
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('j1qq893hrkv081fqv3b525r62tiuzvwe', 'eyJ0ZW5fZGFuZ19uaGFwIjoiRHV5VGFuMTIzNCIsInF1eWVuIjoiYWRtaW4ifQ:1uPBLJ:zLnKqHNw_xVvd3qoPHxvjTV_W4nQH1tp6KZcRNtl6NU', '2025-06-25 02:37:33');