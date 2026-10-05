<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<title>Đăng ký | BookStore</title>
<div class="container py-5" style="max-width:620px"><div class="card shadow-sm"><div class="card-body p-4">
    <h1 class="h3 mb-4">Tạo tài khoản</h1>
    <c:if test="${not empty error}"><div class="alert alert-danger"><c:out value="${error}"/></div></c:if>
    <form method="post" action="<c:url value='/register'/>">
        <div class="mb-3"><label class="form-label" for="email">Email</label><input class="form-control" id="email" name="email" type="email" maxlength="50" required value="<c:out value='${email}'/>"/></div>
        <div class="mb-3"><label class="form-label" for="fullname">Họ tên</label><input class="form-control" id="fullname" name="fullname" maxlength="50" required value="<c:out value='${fullname}'/>"/></div>
        <div class="mb-3"><label class="form-label" for="phone">Số điện thoại</label><input class="form-control" id="phone" name="phone" pattern="[0-9]{9,10}" maxlength="10" required value="<c:out value='${phone}'/>"/></div>
        <div class="mb-3"><label class="form-label" for="password">Mật khẩu</label><input class="form-control" id="password" name="password" type="password" minlength="8" required/></div>
        <div class="mb-4"><label class="form-label" for="confirmPassword">Nhập lại mật khẩu</label><input class="form-control" id="confirmPassword" name="confirmPassword" type="password" minlength="8" required/></div>
        <button class="btn btn-primary w-100" type="submit">Đăng ký</button>
    </form><p class="mt-3 mb-0">Đã có tài khoản? <a href="<c:url value='/login'/>">Đăng nhập</a></p>
</div></div></div>
