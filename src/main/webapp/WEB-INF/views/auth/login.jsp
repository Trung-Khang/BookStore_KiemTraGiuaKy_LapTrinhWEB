<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<title>Đăng nhập | BookStore</title>
<div class="container py-5" style="max-width:620px"><div class="card shadow-sm"><div class="card-body p-4">
    <h1 class="h3 mb-4">Đăng nhập</h1>
    <c:if test="${not empty success}"><div class="alert alert-success"><c:out value="${success}"/></div></c:if>
    <c:if test="${not empty error}"><div class="alert alert-danger"><c:out value="${error}"/></div></c:if>
    <form method="post" action="<c:url value='/login'/>">
        <div class="mb-3"><label class="form-label" for="email">Email</label><input class="form-control" id="email" name="email" type="email" required value="<c:out value='${email}'/>"/></div>
        <div class="mb-4"><label class="form-label" for="password">Mật khẩu</label><input class="form-control" id="password" name="password" type="password" required/></div>
        <button class="btn btn-primary w-100" type="submit">Đăng nhập</button>
    </form><p class="mt-3 mb-0">Chưa có tài khoản? <a href="<c:url value='/register'/>">Đăng ký</a></p>
</div></div></div>
