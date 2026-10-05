<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property="title"/></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="<c:url value='/assets/css/site.css'/>" rel="stylesheet"><sitemesh:write property="head"/>
</head>
<body class="admin-body"><div class="d-flex min-vh-100">
    <aside class="admin-sidebar p-4 text-white">
        <a class="navbar-brand text-white fw-bold fs-4" href="<c:url value='/admin/dashboard'/>">BookStore Admin</a><hr>
        <p class="mb-1">Xin chào</p><strong><c:out value="${sessionScope.currentUser.fullname}" default="Quản trị viên"/></strong>
        <nav class="nav flex-column mt-4 gap-2"><a class="nav-link text-white" href="<c:url value='/admin/dashboard'/>">Tổng quan</a><a class="nav-link text-white" href="#">Quản lý sách</a><a class="nav-link text-white" href="#">Quản lý tác giả</a><a class="nav-link text-white" href="<c:url value='/home'/>">Về trang User</a></nav>
    </aside>
    <div class="flex-grow-1 d-flex flex-column"><header class="bg-white border-bottom px-4 py-3 shadow-sm d-flex justify-content-between align-items-center"><strong>Trang quản trị BookStore</strong><form method="post" action="<c:url value='/logout'/>"><button class="btn btn-outline-danger btn-sm" type="submit">Đăng xuất</button></form></header>
        <main class="flex-grow-1 p-4"><sitemesh:write property="body"/></main><footer class="site-footer py-3 text-center">Nguyễn Trung Khang | MSSV: 24133028 | Mã đề: 01</footer>
    </div>
</div><script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script></body>
</html>
