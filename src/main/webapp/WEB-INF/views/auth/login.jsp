<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<title>Đăng nhập | BookStore</title>

<div class="container py-5" style="max-width: 520px;">
    <div class="parchment-card-box p-4 p-md-5">
        <div class="text-center mb-4">
            <div class="d-inline-flex align-items-center justify-content-center mb-2" style="width: 60px; height: 60px; background: linear-gradient(135deg, #3a1e12 0%, #1f1109 100%); border-radius: 50%; box-shadow: 0 4px 10px rgba(0,0,0,0.3);">
                <i class="fa-solid fa-book-open-reader fs-3 text-warning"></i>
            </div>
            <h1 class="h3 mb-1" style="color: var(--wood-dark);">Đăng Nhập BookStore</h1>
            <p class="text-muted small">Chào mừng bạn quay trở lại với không gian tri thức</p>
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

        <form method="post" action="<c:url value='/login'/>">
            <div class="mb-3">
                <label class="form-label fw-semibold" for="email">
                    <i class="fa-solid fa-envelope text-muted me-1"></i>Địa chỉ Email
                </label>
                <input class="form-control" id="email" name="email" type="email" placeholder="name@example.com" required value="<c:out value='${email}'/>"/>
            </div>

            <div class="mb-4">
                <label class="form-label fw-semibold" for="password">
                    <i class="fa-solid fa-lock text-muted me-1"></i>Mật khẩu
                </label>
                <input class="form-control" id="password" name="password" type="password" placeholder="Nhập mật khẩu" required/>
            </div>

            <button class="btn btn-leather-primary w-100 py-2 fs-6 mb-3" type="submit">
                <i class="fa-solid fa-right-to-bracket me-1"></i> Đăng nhập tài khoản
            </button>
        </form>

        <div class="text-center pt-3 border-top">
            <span class="text-muted">Chưa có tài khoản?</span>
            <a class="fw-bold ms-1" style="color: var(--leather-accent);" href="<c:url value='/register'/>">Đăng ký ngay</a>
        </div>
    </div>
</div>
