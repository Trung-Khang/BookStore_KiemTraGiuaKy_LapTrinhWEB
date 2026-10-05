<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property="title"/></title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,600;0,700;1,600&family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap 5.3 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome 6 Standard Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <!-- Custom Bookstore Wooden Theme -->
    <link href="<c:url value='/assets/css/site.css'/>" rel="stylesheet">
    <sitemesh:write property="head"/>
</head>
<body>
<div class="admin-wrapper">
    <aside class="admin-sidebar">
        <a class="admin-brand" href="<c:url value='/admin/dashboard'/>">
            <i class="fa-solid fa-shield-halved text-warning"></i>
            <span>BookStore Admin</span>
        </a>
        <div class="mb-4 px-2 py-2" style="background: rgba(255,255,255,0.06); border-radius: var(--radius-sm); border: 1px solid rgba(255,255,255,0.1);">
            <div class="small text-muted" style="color: #c4ab94 !important;">Xin chào</div>
            <strong class="text-white"><i class="fa-solid fa-circle-user text-warning me-1"></i> Quản trị viên</strong>
        </div>
        <nav class="nav flex-column">
            <a class="admin-nav-item" href="<c:url value='/admin/dashboard'/>"><i class="fa-solid fa-gauge-high"></i> Tổng quan</a>
            <a class="admin-nav-item" href="<c:url value='/admin/books'/>"><i class="fa-solid fa-book"></i> Quản lý sách</a>
            <a class="admin-nav-item" href="<c:url value='/admin/authors'/>"><i class="fa-solid fa-feather-pointed"></i> Quản lý tác giả</a>
            <a class="admin-nav-item" href="<c:url value='/admin/orders'/>"><i class="fa-solid fa-clipboard-list"></i> Quản lý đơn hàng</a>
            <hr style="border-color: rgba(223, 208, 188, 0.2); margin: 1rem 0;">
            <a class="admin-nav-item" href="<c:url value='/home'/>"><i class="fa-solid fa-arrow-left"></i> Về trang User</a>
        </nav>
    </aside>
    <div class="flex-grow-1 d-flex flex-column min-vh-100">
        <header class="admin-header d-flex justify-content-between align-items-center">
            <div class="d-flex align-items-center gap-2">
                <i class="fa-solid fa-landmark text-muted"></i>
                <strong class="text-dark">Hệ Thống Quản Trị BookStore</strong>
            </div>
            <form method="post" action="<c:url value='/logout'/>">
                <button class="btn btn-sm btn-outline-danger" type="submit">
                    <i class="fa-solid fa-right-from-bracket me-1"></i> Đăng xuấ
                </button>
            </form>
        </header>
        <main class="admin-main flex-grow-1"><sitemesh:write property="body"/></main>
        <footer class="site-footer py-3 text-center">Nguyễn Trung Khang | MSSV: 24133028 | Mã đề: 01</footer>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
