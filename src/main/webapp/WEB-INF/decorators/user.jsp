<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property="title"/></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="<c:url value='/assets/css/site.css'/>" rel="stylesheet">
    <sitemesh:write property="head"/>
</head>
<body class="d-flex flex-column min-vh-100">
<header class="border-bottom bg-white shadow-sm">
    <nav class="navbar navbar-expand-lg container py-3">
        <a class="navbar-brand fw-bold text-primary" href="<c:url value='/home'/>">BookStore</a>
        <div class="navbar-nav ms-auto gap-lg-3 align-items-center">
            <a class="nav-link" href="<c:url value='/home'/>">Trang Chủ</a>
            <a class="nav-link" href="<c:url value='/home'/>">Sản phẩm</a>
            <c:choose>
                <c:when test="${not empty sessionScope.currentUser}">
                    <span class="nav-link text-dark">Xin chào, <strong><c:out value="${sessionScope.currentUser.fullname}"/></strong></span>
                    <c:if test="${sessionScope.currentUser.admin}"><a class="nav-link" href="<c:url value='/admin/dashboard'/>">Trang quản trị</a></c:if>
                    <form method="post" action="<c:url value='/logout'/>" class="d-inline"><button class="btn btn-outline-danger btn-sm" type="submit">Đăng xuất</button></form>
                </c:when>
                <c:otherwise>
                    <a class="nav-link" href="<c:url value='/login'/>">Đăng nhập</a>
                    <a class="nav-link" href="<c:url value='/register'/>">Đăng ký</a>
                </c:otherwise>
            </c:choose>
        </div>
    </nav>
</header>
<main class="flex-grow-1"><sitemesh:write property="body"/></main>
<footer class="site-footer mt-auto py-4"><div class="container text-center"><strong>Nguyễn Trung Khang</strong> | MSSV: 24133028 | Mã đề: 01</div></footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
