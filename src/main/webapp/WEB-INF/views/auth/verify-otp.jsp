<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<title>Xác minh email | BookStore</title>

<div class="container py-5" style="max-width: 520px;">
    <div class="parchment-card-box p-4 p-md-5">
        <div class="text-center mb-4">
            <div class="d-inline-flex align-items-center justify-content-center mb-2" style="width: 60px; height: 60px; background: linear-gradient(135deg, #3a1e12 0%, #1f1109 100%); border-radius: 50%; box-shadow: 0 4px 10px rgba(0,0,0,0.3);">
                <i class="fa-solid fa-envelope-circle-check fs-3 text-warning"></i>
            </div>
            <h1 class="h3 mb-2" style="color: var(--wood-dark);">Xác Minh Email</h1>
            <p class="text-muted small">Vui lòng nhập mã OTP 6 chữ số vừa được gửi đến hòm thư điện tử của bạn</p>
        </div>

        <c:if test="${not empty success}">
            <div class="alert alert-success alert-custom mb-3">
                <i class="fa-solid fa-circle-check fs-5"></i>
                <div><c:out value="${success}"/></div>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-custom mb-3">
                <i class="fa-solid fa-triangle-exclamation fs-5"></i>
                <div><c:out value="${error}"/></div>
            </div>
        </c:if>

        <form method="post" action="<c:url value='/verify-otp'/>">
            <div class="mb-3">
                <label class="form-label fw-semibold text-center d-block" for="otp">Mã xác minh (OTP)</label>
                <input class="form-control form-control-lg text-center fw-bold letter-spacing-2"
                       id="otp" name="otp" inputmode="numeric" pattern="[0-9]{6}" maxlength="6"
                       placeholder="••••••" style="font-size: 1.6rem; letter-spacing: 0.35em;" required/>
            </div>
            <button class="btn btn-leather-primary w-100 py-2 fs-6" type="submit">
                <i class="fa-solid fa-check-double me-1"></i> Xác minh OTP
            </button>
        </form>

        <form method="post" action="<c:url value='/verify-otp/resend'/>" class="mt-3">
            <button class="btn btn-outline-secondary w-100" type="submit">
                <i class="fa-solid fa-rotate-right me-1"></i> Gửi lại mã OTP mới
            </button>
        </form>

        <div class="text-center pt-3 mt-3 border-top">
            <a class="text-decoration-none text-muted" href="<c:url value='/login'/>">
                <i class="fa-solid fa-arrow-left me-1"></i> Quay lại đăng nhập
            </a>
        </div>
    </div>
</div>
