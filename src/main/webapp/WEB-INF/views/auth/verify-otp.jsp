<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<title>Xác minh email | BookStore</title>
<div class="container py-5" style="max-width:620px"><div class="card shadow-sm"><div class="card-body p-4">
    <h1 class="h3 mb-3">Xác minh email</h1><p>Nhập mã OTP 6 chữ số đã được gửi đến email của bạn.</p>
    <c:if test="${not empty success}"><div class="alert alert-success"><c:out value="${success}"/></div></c:if>
    <c:if test="${not empty error}"><div class="alert alert-danger"><c:out value="${error}"/></div></c:if>
    <form method="post" action="<c:url value='/verify-otp'/>"><label class="form-label" for="otp">Mã OTP</label><input class="form-control form-control-lg mb-3" id="otp" name="otp" inputmode="numeric" pattern="[0-9]{6}" maxlength="6" required/><button class="btn btn-primary w-100" type="submit">Xác minh OTP</button></form>
    <form method="post" action="<c:url value='/verify-otp/resend'/>" class="mt-3"><button class="btn btn-outline-secondary w-100" type="submit">Gửi lại OTP</button></form>
    <p class="mt-3 mb-0"><a href="<c:url value='/login'/>">Quay lại đăng nhập</a></p>
</div></div></div>
