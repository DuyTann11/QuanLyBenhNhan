"""
URL configuration for core project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from benhnhan import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', views.trangchu),
    path('benhnhan/', views.benhnhan),
    path('lichuongthuoc/', views.lichuongthuoc, name='lichuongthuoc'),
    path('bacsi/', views.bacsi),
    path('huyetap/', views.huyetap),
    path('dangnhap/', views.dangnhap),
    path('quenmatkhau/', views.quenmatkhau),
    path('dangki/', views.dangki),
    path('thongke/', views.thongke),
    path('thembenhnhan/', views.thembenhnhan),
    path('thembacsi/', views.thembacsi),
    path('dsuongthuoc/', views.dsuongthuoc),
    path('taikhoan/', views.taikhoan),
    path('themtaikhoan/', views.themtaikhoan),
    path('suadanhsach/<int:id>/', views.suadanhsach, name='suadanhsach'),
    path('suabenhnhan/<int:id>/', views.suabenhnhan, name='suabenhnhan'),
    path('suabacsi/<int:id>/', views.suabacsi, name='suabacsi'),
    path('suataikhoan/<int:id>/', views.suataikhoan, name='suataikhoan'),
    path('doimatkhau/', views.doimatkhau),
    path('dangxuat/', views.dangxuat, name='dangxuat'),
    path('khu/', views.khu),
    path('themnha/', views.themnha),
    path('suanha/<int:nha_id>/', views.suanha, name='suanha'),

]
