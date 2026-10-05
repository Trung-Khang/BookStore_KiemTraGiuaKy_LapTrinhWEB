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
<body class="d-flex flex-column min-vh-100">
<header class="site-header">
    <nav class="navbar navbar-expand-lg site-navbar container">
        <a class="navbar-brand navbar-brand-bookstore" href="<c:url value='/home'/>">
            <i class="fa-solid fa-book-open-reader brand-icon"></i>
            <span>BookStore</span>
        </a>
        <button class="navbar-toggler border-0 text-white" type="button" data-bs-toggle="collapse" data-bs-target="#userNavbar" aria-controls="userNavbar" aria-expanded="false" aria-label="Toggle navigation">
            <i class="fa-solid fa-bars fs-4 text-warning"></i>
        </button>
        <div class="collapse navbar-collapse" id="userNavbar">
            <div class="navbar-nav ms-auto gap-lg-2 align-items-lg-center">
                <a class="nav-link site-nav-link" href="<c:url value='/home'/>"><i class="fa-solid fa-house"></i> Trang Chủ</a>
                <a class="nav-link site-nav-link" href="<c:url value='/home'/>"><i class="fa-solid fa-book-bookmark"></i> Sản phẩm</a>
                <c:if test="${not empty sessionScope.currentUser and not sessionScope.currentUser.admin}">
                    <a class="nav-link site-nav-link" href="<c:url value='/cart'/>"><i class="fa-solid fa-cart-shopping"></i> Giỏ hàng</a>
                    <a class="nav-link site-nav-link" href="<c:url value='/orders'/>"><i class="fa-solid fa-boxes-stacked"></i> Đơn hàng của tôi</a>
                </c:if>
                <c:choose>
                    <c:when test="${not empty sessionScope.currentUser}">
                        <span class="site-user-badge my-1 my-lg-0">
                            <i class="fa-solid fa-user-circle me-1 text-warning"></i>
                            Xin chào, <strong><c:choose><c:when test="${sessionScope.currentUser.admin}">Quản trị viên</c:when><c:otherwise><c:out value="${sessionScope.currentUser.fullname}"/></c:otherwise></c:choose></strong>
                        </span>
                        <c:if test="${sessionScope.currentUser.admin}">
                            <a class="nav-link site-nav-link text-warning" href="<c:url value='/admin/dashboard'/>"><i class="fa-solid fa-gear"></i> Trang quản trị</a>
                        </c:if>
                        <form method="post" action="<c:url value='/logout'/>" class="d-inline my-1 my-lg-0">
                            <button class="btn btn-sm btn-outline-light ms-lg-1" type="submit" style="border-color: rgba(255,255,255,0.3);"><i class="fa-solid fa-right-from-bracket me-1"></i> Đăng xuất</button>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <a class="nav-link site-nav-link" href="<c:url value='/login'/>"><i class="fa-solid fa-right-to-bracket"></i> Đăng nhập</a>
                        <a class="btn btn-sm btn-leather-primary ms-lg-1" href="<c:url value='/register'/>"><i class="fa-solid fa-user-plus me-1"></i> Đăng ký</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </nav>
</header>
<main class="flex-grow-1"><sitemesh:write property="body"/></main>
<footer class="site-footer mt-auto py-4">
    <div class="container text-center">
        <strong>Nguyễn Trung Khang</strong> | MSSV: 24133028 | Mã đề: 01
    </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
