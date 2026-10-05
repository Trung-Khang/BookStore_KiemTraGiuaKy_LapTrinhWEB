<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<title>Dashboard | BookStore Admin</title>
<div class="container-fluid"><h1 class="h2">Dashboard</h1><p class="text-muted">Quản lý dữ liệu sách và tác giả.</p><a class="btn btn-primary me-2" href="<c:url value='/admin/books'/>">Quản lý sách</a><a class="btn btn-secondary" href="<c:url value='/admin/authors'/>">Quản lý tác giả</a><div class="alert alert-success mt-4">Session Admin, Filter và SiteMesh đang hoạt động.</div></div>
