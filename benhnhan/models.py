from django.utils import timezone
from django.db import models

# Create your models here.
# bảng bệnh nhân
class BenhNhan(models.Model):
    BenhNhanID = models.AutoField(primary_key=True)
    HoVaTen = models.CharField(max_length=200)
    NamSinh = models.IntegerField()
    
    GIOI_TINH_CHOICES = [
        ('M', 'Nam'),
        ('F', 'Nữ'),
    ]
    GioiTinh = models.CharField(max_length=1, choices=GIOI_TINH_CHOICES)
    
    Khu = models.CharField(max_length=100, blank=True, null=True)  
    
    NgayTaoHoSo = models.DateTimeField(auto_now_add=True)
    
    TrangThai = models.CharField(max_length=50, blank=True, null=True)

    def __str__(self):
        return self.HoVaTen
    
# bảng danh sách khám
class DanhSachKham(models.Model):
    BenhNhan = models.ForeignKey(BenhNhan, on_delete=models.CASCADE)    
    Thuoc = models.CharField(max_length=200, blank=True, null=True)
    NgayKham = models.DateField(blank=True, null=True)
    NgayTaiKham = models.DateField(blank=True, null=True)

    def __str__(self):
        return f"{self.BenhNhan.HoVaTen} - {self.NgayKham}"
    
# bảng nhân viên
class NhanVien(models.Model):
    GIOI_TINH_CHOICES = [
        ('Nam', 'Nam'),
        ('Nữ', 'Nữ'),
    ]
    
    TRANG_THAI_CHOICES = [
        ('Đang làm', 'Đang làm'),
        ('Tạm nghỉ', 'Tạm nghỉ'),
    ]

    HoTen = models.CharField(max_length=100)
    NamSinh = models.IntegerField()
    GioiTinh = models.CharField(max_length=3, choices=GIOI_TINH_CHOICES)
    SDT = models.CharField(max_length=15)
    ChucVu = models.CharField(max_length=100)
    DiaChi = models.TextField()
    TrangThai = models.CharField(
        max_length=20,
        choices=TRANG_THAI_CHOICES,
        default='Đang làm'
    )

    def __str__(self):
        return self.HoTen
    
#bảng tài khoản
class TaiKhoan(models.Model):
    QUYEN_CHOICES = [
        ('admin', 'Quản trị viên'),
        ('nhanvien', 'Nhân viên'),
    ]

    TRANGTHAI_CHOICES = [
        ('hoatdong', 'Hoạt động'),
        ('ngung', 'Ngưng hoạt động'),
    ]

    TenDangNhap = models.CharField(max_length=100, unique=True)
    MatKhau = models.CharField(max_length=128)  # Nên hash
    SoDienThoai = models.CharField(max_length=15)
    Gmail = models.EmailField(unique=True)
    Quyen = models.CharField(max_length=20, choices=QUYEN_CHOICES, default='nhanvien')
    NgayTao = models.DateTimeField(default=timezone.now)
    TrangThai = models.CharField(max_length=20, choices=TRANGTHAI_CHOICES, default='hoatdong')
    LanDangNhapCuoi = models.DateTimeField(blank=True, null=True)
    MaXacNhan = models.CharField(max_length=6, blank=True, null=True)  

    def __str__(self):
        return self.TenDangNhap