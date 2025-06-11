
import random
import re
from django.utils import timezone
from datetime import date, timedelta
from django.contrib import messages
from django.core.mail import send_mail
from django.utils.dateparse import parse_date
from django.shortcuts import render, get_object_or_404, redirect
from django.contrib.auth.hashers import make_password
from django.contrib.auth.hashers import check_password
from benhnhan.models import BenhNhan, DanhSachKham, KhuNha, Nha, NhanVien, TaiKhoan
from core import settings

# Create your views here.
def trangchu(request):
    if 'ten_dang_nhap' not in request.session:
        return redirect('/dangnhap/')
    
    soNhanVienDangLam = NhanVien.objects.filter(TrangThai="Đang làm").count()
    soBenhNhan = BenhNhan.objects.filter(TrangThai="Hoạt động").count()
    soTaiKhoan = TaiKhoan.objects.filter(TrangThai="hoatdong").count()
    
    ngayHomNay = timezone.now().date()
    ngayMai = ngayHomNay + timedelta(days=1)

    # 🔁 Cập nhật logic so sánh với ngày mai
    soNguoiCanTaiKham = DanhSachKham.objects.filter(NgayTaiKham=ngayMai) \
        .values('BenhNhan').distinct().count()

    danhsach = DanhSachKham.objects.select_related('BenhNhan') \
        .filter(BenhNhan__TrangThai='Hoạt động') \
        .exclude(NgayTaiKham=ngayMai)

    soNguoiCanUongThuoc = DanhSachKham.objects.filter(
    BenhNhan__TrangThai='Hoạt động',
    NgayTaiKham__lte=ngayMai  
        ).values('BenhNhan').distinct().count()

    nhanviens = NhanVien.objects.all()

    return render(request, 'benhnhan/trangchu.html', {
        'soNhanVienDangLam': soNhanVienDangLam,
        'soBenhNhan': soBenhNhan,
        'soNguoiCanTaiKham': soNguoiCanTaiKham,
        'ngayTaiKham': ngayMai,  # 👉 Truyền ngày mai thay vì hôm nay
        'danhsach': danhsach,
        'soNguoiCanUongThuoc': soNguoiCanUongThuoc,
        'nhanviens': nhanviens,
        'soTaiKhoan': soTaiKhoan
    })
#trang bệnh nhân
def benhnhan(request):
    trang_thai = request.GET.get('trang_thai', 'Hoạt động')
    
    if trang_thai in ['Hoạt động', 'Ngưng hoạt động']:
        ds_benhnhan = BenhNhan.objects.filter(TrangThai=trang_thai)
    else:
        ds_benhnhan = BenhNhan.objects.all()
        
    return render(request, 'benhnhan/benhnhan.html', {
        'ds_benhnhan': ds_benhnhan,
        'trang_thai': trang_thai,
    })
#trang lịch uống thuốc 
def lichuongthuoc(request):
    today = timezone.now().date()
    tomorrow = today + timedelta(days=1)

    filter_option = request.GET.get('filter', '')

    if filter_option == 'homnay':
        danhsach = DanhSachKham.objects.select_related('BenhNhan') \
            .filter(
                BenhNhan__TrangThai='Hoạt động',
                NgayTaiKham=today
            )
    elif filter_option == 'ngaymai':
        danhsach = DanhSachKham.objects.select_related('BenhNhan') \
            .filter(
                BenhNhan__TrangThai='Hoạt động',
                NgayTaiKham=tomorrow
            )
    else:
        danhsach = DanhSachKham.objects.select_related('BenhNhan') \
            .filter(BenhNhan__TrangThai='Hoạt động') \
            .exclude(NgayTaiKham=tomorrow)  # lọc tất cả trừ ngày mai

    return render(request, 'benhnhan/lichuongthuoc.html', {
        'danhsach': danhsach,
        'locTheoNgayMai': filter_option == 'ngaymai',
        'locTheoHomNay': filter_option == 'homnay'
    })
#trang bác sĩ
def bacsi(request):
    nhanviens = NhanVien.objects.all()
    return render(request, 'benhnhan/bacsi.html', {'nhanviens': nhanviens})
#trang huyết áp 
def huyetap(request):
    return render(request, 'benhnhan/huyetap.html')
#trang đăng nhập 
def dangnhap(request):
    context = {}

    if request.method == "POST":
        tendangnhap = request.POST.get('tendangnhap')
        matkhau = request.POST.get('matkhau')

        context['tendangnhap'] = tendangnhap  
        

        try:
            user = TaiKhoan.objects.get(TenDangNhap=tendangnhap)
            if check_password(matkhau, user.MatKhau):
                user.LanDangNhapCuoi = timezone.now()  
                user.save(update_fields=['LanDangNhapCuoi'])
                request.session['ten_dang_nhap'] = user.TenDangNhap
                request.session['quyen'] = user.Quyen
                return redirect('/')
            else:
                context['err_matkhau'] = "Mật khẩu không đúng!"
        except TaiKhoan.DoesNotExist:
            context['err_tendangnhap'] = "Tài khoản không tồn tại!"

    return render(request, 'taikhoan/dangnhap.html', context)

#trang đăng xuất
def dangxuat(request):
    request.session.flush()  # Xóa toàn bộ session
    return redirect('/dangnhap/')
#trang quenmatkhau
def generate_otp():
    return str(random.randint(100000, 999999))

def quenmatkhau(request):
    context = {'sent': False}
    
    if request.method == 'POST':
        gmail = request.POST.get('gmail')
        otp = request.POST.get('otp')
        new_password = request.POST.get('new_password')

        try:
            user = TaiKhoan.objects.get(Gmail=gmail)
        except TaiKhoan.DoesNotExist:
            context['error'] = "Gmail không tồn tại."
            return render(request, 'taikhoan/quenmatkhau.html', context)

        # Nếu đã gửi mã và đang xác nhận mã OTP
        if otp and new_password:
            if user.MaXacNhan == otp:
                user.MatKhau = make_password(new_password)
                user.MaXacNhan = None
                user.save()
                context['success'] = "Đổi mật khẩu thành công! Hãy đăng nhập lại."
            else:
                context['sent'] = True
                context['error'] = "Mã xác nhận không đúng!"
        else:
            # Gửi mã xác nhận
            ma_xac_nhan = generate_otp()
            user.MaXacNhan = ma_xac_nhan
            user.save()

            send_mail(
                subject="Mã xác nhận lấy lại mật khẩu",
                message=f"Mã xác nhận của bạn là: {ma_xac_nhan}",
                from_email=settings.EMAIL_HOST_USER,
                recipient_list=[gmail],
                fail_silently=False,
            )

            context['sent'] = True
            context['info'] = "Đã gửi mã xác nhận đến Gmail của bạn!"

    return render(request, 'taikhoan/quenmatkhau.html', context)
#trang đăng kí 
def dangki(request):
    context = {}

    if request.method == 'POST':
        ten = request.POST.get('tendangnhap')
        matkhau = request.POST.get('matkhau')
        nhaplai = request.POST.get('nhaplaimatkhau')
        sdt = request.POST.get('sdt')
        gmail = request.POST.get('gmail')

        has_error = False
        context['tendangnhap'] = ten
        context['sdt'] = sdt
        context['gmail'] = gmail

        if matkhau != nhaplai:
            context['err_nhaplai'] = "Mật khẩu không khớp."
            has_error = True

        if TaiKhoan.objects.filter(TenDangNhap=ten).exists():
            context['err_tendangnhap'] = "Tên đăng nhập đã tồn tại."
            has_error = True

        if TaiKhoan.objects.filter(Gmail=gmail).exists():
            context['err_gmail'] = "Email đã được sử dụng."
            has_error = True

        if not re.match(r'^[a-zA-Z0-9._%+-]+@gmail\.com$', gmail):
            context['err_gmail'] = "Vui lòng nhập đúng định dạng email @gmail.com!"
            has_error = True
        if TaiKhoan.objects.filter(SoDienThoai=sdt).exists():
            context['err_sdt'] = "Số điện thoại đã được sử dụng."
            has_error = True
        if not has_error:
            tai_khoan = TaiKhoan(
                TenDangNhap=ten,
                MatKhau=make_password(matkhau), 
                SoDienThoai=sdt,
                Gmail=gmail,
                Quyen='nhanvien',
                TrangThai='hoatdong',
                NgayTao=timezone.now()
            )
            tai_khoan.save()
            messages.success(request, "Đăng ký thành công.")

    return render(request, 'taikhoan/dangki.html', context)
#trang thống kê
def thongke(request):
    return render(request, 'benhnhan/thongke.html')
#trang thêm bệnh nhân
def thembenhnhan(request):
    if request.method == 'POST':
        ho_va_ten = request.POST.get('HoVaTen')
        nam_sinh = request.POST.get('NamSinh')
        gioi_tinh = request.POST.get('GioiTinh')
        khu_id = request.POST.get('Khu')  # lấy id nhà

        nha = Nha.objects.get(id=khu_id) if khu_id else None

        benhnhan = BenhNhan.objects.create(
            HoVaTen=ho_va_ten,
            NamSinh=nam_sinh,
            GioiTinh=gioi_tinh,
            Khu=nha,
            TrangThai='Hoạt động'
        )

        DanhSachKham.objects.create(
            BenhNhan=benhnhan,
            Thuoc='',           
            NgayKham=None,      
            NgayTaiKham=None    
        )

        messages.success(request, 'Thêm bệnh nhân thành công!')
        return redirect('/thembenhnhan/') 

    ds_nha = Nha.objects.select_related('Khu').all()  # Lấy danh sách các nhà
    return render(request, 'themdulieu/thembenhnhan.html', {'ds_nha': ds_nha})
#trang thêm bác sĩ
def thembacsi(request):
    if request.method == 'POST':
        ho_ten = request.POST.get('hoten')
        nam_sinh = request.POST.get('namsinh')
        gioi_tinh = request.POST.get('gioitinh')
        sdt = request.POST.get('sdt')
        chuc_vu = request.POST.get('chucvu')
        dia_chi = request.POST.get('diachi')

        NhanVien.objects.create(
            HoTen=ho_ten,
            NamSinh=nam_sinh,
            GioiTinh=gioi_tinh,
            SDT=sdt,
            ChucVu=chuc_vu,
            DiaChi=dia_chi,
            TrangThai='Đang làm'  # mặc định
        )
        messages.success(request, 'Thêm nhân viên thành công!')
    return render(request, 'themdulieu/thembacsi.html')
#trang làm danh sách uống thuốc
def dsuongthuoc(request):
    return render(request, 'themdulieu/dsuongthuoc.html')
#trang tài khoản
def taikhoan(request):
    trang_thai = request.GET.get('trang_thai')

    if trang_thai == 'Hoạt động':
        ds_taikhoan = TaiKhoan.objects.filter(TrangThai='hoatdong')
    elif trang_thai == 'Ngưng hoạt động':
        ds_taikhoan = TaiKhoan.objects.filter(TrangThai='ngung')
    else:
        ds_taikhoan = TaiKhoan.objects.all()

    return render(request, 'benhnhan/taikhoan.html', {
        'ds_taikhoan': ds_taikhoan,
        'trang_thai': trang_thai
    })
#trang sửa danh sách khám bệnh
def suadanhsach(request, id):
    benhnhan = get_object_or_404(BenhNhan, pk=id)
    danhsach = DanhSachKham.objects.filter(BenhNhan=benhnhan).first()

    if not danhsach:
        return render(request, 'dskhambenh/suadanhsach.html', {
            'benhnhan': benhnhan,
            'danhsach': None,
            'thongbao': 'Không có thông tin khám cho bệnh nhân này.'
        })

    if request.method == 'POST':
        thuoc = request.POST.get('thuoc')
        ngay_kham = request.POST.get('ngayKham')
        ngay_tai_kham = request.POST.get('ngayTaiKham')

        try:
            danhsach.Thuoc = thuoc
            danhsach.NgayKham = parse_date(ngay_kham) if ngay_kham else None
            danhsach.NgayTaiKham = parse_date(ngay_tai_kham) if ngay_tai_kham else None
            danhsach.save()
            messages.success(request, 'Lưu thành công!')
        except Exception as e:
            messages.error(request, 'Lưu chưa được: ' + str(e))

        return redirect('suadanhsach', id=id)

    return render(request, 'dskhambenh/suadanhsach.html', {
        'benhnhan': benhnhan,
        'danhsach': danhsach
    })
#trang sửa bệnh nhân
def suabenhnhan(request, id):
    benhnhan = get_object_or_404(BenhNhan, pk=id)

    if request.method == 'POST':
        benhnhan.HoVaTen = request.POST.get('HoVaTen')
        benhnhan.NamSinh = request.POST.get('NamSinh')
        benhnhan.GioiTinh = request.POST.get('GioiTinh')
        khu_id = request.POST.get('Khu')
        benhnhan.Khu = Nha.objects.get(id=khu_id) if khu_id else None
        benhnhan.TrangThai = request.POST.get('TrangThai')  
        benhnhan.save()

        messages.success(request, 'Cập nhật bệnh nhân thành công!')

    ds_nha = Nha.objects.select_related('Khu').all()
    return render(request, 'themdulieu/suabenhnhan.html', {
        'benhnhan': benhnhan,
        'ds_nha': ds_nha
    })
#trang sửa bác sĩ 
def suabacsi(request, id):
    nhanvien = get_object_or_404(NhanVien, pk=id)

    if request.method == 'POST':
        nhanvien.HoTen = request.POST['hoten']
        nhanvien.NamSinh = request.POST['namsinh']
        nhanvien.GioiTinh = request.POST['gioitinh']
        nhanvien.SDT = request.POST['sdt']
        nhanvien.ChucVu = request.POST['chucvu']
        nhanvien.DiaChi = request.POST['diachi']
        nhanvien.TrangThai = request.POST['trangthai']
        nhanvien.save()
        messages.success(request, 'Cập nhật nhân viên thành công!')

    return render(request, 'themdulieu/suabacsi.html', {'nhanvien': nhanvien})

#trang thêm tài khoản
def themtaikhoan(request):
    context = {}
    if request.method == "POST":
        ten_dang_nhap = request.POST.get("TenDangNhap")
        mat_khau = request.POST.get("MatKhau")
        so_dien_thoai = request.POST.get("SoDienThoai")
        gmail = request.POST.get("Gmail")
        quyen = request.POST.get("Quyen").lower()
        trang_thai = request.POST.get("TrangThai")
        trang_thai = "hoatdong" if trang_thai == "hoatdong" else "ngung"

        has_error = False

        if TaiKhoan.objects.filter(TenDangNhap=ten_dang_nhap).exists():
            context["err_tendangnhap"] = "Tên đăng nhập đã tồn tại."
            has_error = True

        if TaiKhoan.objects.filter(Gmail=gmail).exists():
            context["err_gmail"] = "Email đã được sử dụng."
            has_error = True

        if not re.match(r'^[a-zA-Z0-9._%+-]+@gmail\.com$', gmail):
            context["err_gmail"] = "Vui lòng nhập đúng định dạng email @gmail.com!"
            has_error = True

        if TaiKhoan.objects.filter(SoDienThoai=so_dien_thoai).exists():
            context["err_sdt"] = "Số điện thoại đã được sử dụng."
            has_error = True

        if not has_error:
            TaiKhoan.objects.create(
                TenDangNhap=ten_dang_nhap,
                MatKhau=make_password(mat_khau),
                SoDienThoai=so_dien_thoai,
                Gmail=gmail,
                Quyen=quyen,
                TrangThai=trang_thai,
                NgayTao=timezone.now()
            )
            messages.success(request, "Thêm tài khoản thành công!")
            

    return render(request, 'themdulieu/themtaikhoan.html', context)

#trang sửa tài khoản
def suataikhoan(request, id):
    taikhoan = get_object_or_404(TaiKhoan, id=id)
    context = {'taikhoan': taikhoan}

    if request.method == 'POST':
        ten = request.POST.get('TenDangNhap')
        sdt = request.POST.get('SoDienThoai')
        gmail = request.POST.get('Gmail')
        quyen = request.POST.get('Quyen')
        trangthai = request.POST.get('TrangThai')
        matkhau_moi = request.POST.get('MatKhau')

        # Khởi tạo lỗi
        loi = {}

        # Kiểm tra tên đăng nhập trùng (trừ chính nó)
        if TaiKhoan.objects.exclude(id=taikhoan.id).filter(TenDangNhap=ten).exists():
            loi['err_tendangnhap'] = "Tên đăng nhập đã tồn tại."

        # Kiểm tra gmail trùng (trừ chính nó)
        if TaiKhoan.objects.exclude(id=taikhoan.id).filter(Gmail=gmail).exists():
            loi['err_gmail'] = "Email đã được sử dụng."

        # Kiểm tra định dạng gmail
        if not re.match(r'^[a-zA-Z0-9._%+-]+@gmail\.com$', gmail):
            loi['err_gmail'] = "Vui lòng nhập email đúng định dạng @gmail.com!"

        # Kiểm tra số điện thoại
        if TaiKhoan.objects.exclude(id=taikhoan.id).filter(SoDienThoai=sdt).exists():
           loi['err_sdt'] = "Số điện thoại đã được sử dụng."

        if loi:
            context.update(loi)
        else:
            # Lưu dữ liệu nếu không có lỗi
            taikhoan.TenDangNhap = ten
            taikhoan.SoDienThoai = sdt
            taikhoan.Gmail = gmail
            taikhoan.Quyen = quyen
            taikhoan.TrangThai = trangthai

            if matkhau_moi:
                taikhoan.MatKhau = make_password(matkhau_moi)

            taikhoan.save()
            messages.success(request, "Cập nhật tài khoản thành công.")

    return render(request, 'themdulieu/suataikhoan.html', context)

#trang quên mật khẩu 
def doimatkhau(request):
    context = {}

    # Lấy tên đăng nhập từ session
    ten_dang_nhap = request.session.get('ten_dang_nhap')
    if not ten_dang_nhap:
        return redirect('/dangnhap/')  # Nếu chưa đăng nhập thì chuyển hướng

    try:
        user = TaiKhoan.objects.get(TenDangNhap=ten_dang_nhap)
    except TaiKhoan.DoesNotExist:
        return redirect('/dangnhap/')

    if request.method == "POST":
        matkhau_ht = request.POST.get("matkhau_hientai")
        matkhau_moi = request.POST.get("matkhau_moi")
        xacnhan_mk = request.POST.get("xacnhan_matkhau_moi")

        if not check_password(matkhau_ht, user.MatKhau):
            context['err_matkhau_hientai'] = "Mật khẩu hiện tại không đúng."
        elif matkhau_moi != xacnhan_mk:
            context['err_xacnhan'] = "Mật khẩu xác nhận không khớp."
        elif matkhau_ht == matkhau_moi:
            context['err_matkhau_moi'] = "Mật khẩu mới không được trùng với mật khẩu hiện tại."
        else:
            user.MatKhau = make_password(matkhau_moi)
            user.save()
            context['success'] = "Đổi mật khẩu thành công!"

    return render(request, 'taikhoan/doimatkhau.html', context)

#trang khu nhà ở 
def khu(request):
    trang_thai = request.GET.get('trang_thai', 'Hoạt động')  # Mặc định là 'Hoạt động'
    
    # Lọc danh sách nhà theo trạng thái
    if trang_thai == 'Tất cả':
        ds_nha = Nha.objects.select_related('Khu').all()
    else:
        ds_nha = Nha.objects.select_related('Khu').filter(TrangThai=trang_thai)
    
    return render(request, 'benhnhan/khu.html', {
        'ds_nha': ds_nha,
        'trang_thai': trang_thai
    })

#trang thêm nhà ở
def themnha(request):
    err_ten_khu = ''
    err_ten_nha = ''
    err_khu = ''
    is_khu_checked = False 

    if request.method == 'POST':
        is_khu = 'is_khu' in request.POST
        is_khu_checked = is_khu  

        if is_khu:
            ten_khu = request.POST.get('TenKhu')
            trang_thai = request.POST.get('TrangThaiKhu')
            if ten_khu:
                try:
                    if KhuNha.objects.filter(TenKhu=ten_khu).exists():
                        err_ten_khu = 'Tên khu đã tồn tại.'
                    else:
                        KhuNha.objects.create(TenKhu=ten_khu, TrangThai=trang_thai)
                        messages.success(request, 'Thêm khu thành công!')
                        is_khu_checked = False 
                except Exception as e:
                    messages.error(request, f'Lỗi khi thêm khu: {str(e)}')
            else:
                err_ten_khu = 'Vui lòng nhập tên khu.'
        else:
            ten_nha = request.POST.get('TenNha')
            khu_id = request.POST.get('Khu')
            trang_thai = request.POST.get('TrangThaiNha')
            if ten_nha and khu_id:
                try:
                    khu = KhuNha.objects.get(id=khu_id)
                    if Nha.objects.filter(TenNha=ten_nha, Khu=khu).exists():
                        err_ten_nha = 'Tên nhà đã tồn tại trong khu này.'
                    else:
                        Nha.objects.create(TenNha=ten_nha, Khu=khu, TrangThai=trang_thai)
                        messages.success(request, 'Thêm nhà thành công!')
                        is_khu_checked = False  
                except Exception as e:
                    messages.error(request, f'Lỗi khi thêm nhà: {str(e)}')
            else:
                if not ten_nha:
                    err_ten_nha = 'Vui lòng nhập tên nhà.'
                if not khu_id:
                    err_khu = 'Vui lòng chọn khu.'

    ds_khu = KhuNha.objects.all()
    return render(request, 'themdulieu/themnha.html', {
        'ds_khu': ds_khu,
        'err_ten_khu': err_ten_khu,
        'err_ten_nha': err_ten_nha,
        'err_khu': err_khu,
        'is_khu_checked': is_khu_checked 
    })

#trang sửa nhà 
def suanha(request, nha_id):
    nha = get_object_or_404(Nha, id=nha_id)
    ds_khu = KhuNha.objects.all()
    err_ten_khu = ''
    err_ten_nha = ''
    err_khu = ''
    is_khu_checked = False

    if request.method == 'POST':
        is_khu = 'is_khu' in request.POST
        is_khu_checked = is_khu

        if is_khu:
            # Sửa khu
            ten_khu = request.POST.get('TenKhu')
            trang_thai = request.POST.get('TrangThaiKhu')
            if ten_khu:
                try:
                    # Kiểm tra trùng tên khu, ngoại trừ khu hiện tại
                    existing_khu = KhuNha.objects.filter(TenKhu=ten_khu).exclude(id=nha.Khu.id).first()
                    if existing_khu:
                        err_ten_khu = f'Tên khu "{ten_khu}" đã tồn tại (ID: {existing_khu.id}). Vui lòng chọn tên khác.'
                    else:
                        # Cập nhật thông tin khu
                        nha.Khu.TenKhu = ten_khu
                        nha.Khu.TrangThai = trang_thai
                        nha.Khu.save()
                        # Đồng bộ trạng thái của tất cả nhà trong khu
                        Nha.objects.filter(Khu=nha.Khu).update(TrangThai=trang_thai)
                        messages.success(request, f'Cập nhật khu "{ten_khu}" thành công!')
                        return redirect('themnha')
                except Exception as e:
                    messages.error(request, f'Lỗi khi cập nhật khu: {str(e)}')
            else:
                err_ten_khu = 'Vui lòng nhập tên khu.'
        else:
            # Sửa nhà
            ten_nha = request.POST.get('TenNha')
            khu_id = request.POST.get('Khu')
            trang_thai = request.POST.get('TrangThaiNha')
            if ten_nha and khu_id:
                try:
                    khu = KhuNha.objects.get(id=khu_id)
                    if Nha.objects.filter(TenNha=ten_nha, Khu=khu).exclude(id=nha_id).exists():
                        err_ten_nha = f'Tên nhà "{ten_nha}" đã tồn tại trong khu "{khu.TenKhu}".'
                    else:
                        nha.TenNha = ten_nha
                        nha.Khu = khu
                        nha.TrangThai = trang_thai
                        nha.save()
                        messages.success(request, f'Cập nhật nhà "{ten_nha}" thành công!')
                        return redirect('themnha')
                except Exception as e:
                    messages.error(request, f'Lỗi khi cập nhật nhà: {str(e)}')
            else:
                if not ten_nha:
                    err_ten_nha = 'Vui lòng nhập tên nhà.'
                if not khu_id:
                    err_khu = 'Vui lòng chọn khu.'

    return render(request, 'themdulieu/suanha.html', {
        'nha': nha,
        'ds_khu': ds_khu,
        'err_ten_khu': err_ten_khu,
        'err_ten_nha': err_ten_nha,
        'err_khu': err_khu,
        'is_khu_checked': is_khu_checked
    })