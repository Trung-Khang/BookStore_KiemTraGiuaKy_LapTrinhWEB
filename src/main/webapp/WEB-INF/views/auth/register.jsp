<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<title>Đăng ký | BookStore</title>

<div class="container py-5" style="max-width: 580px;">
    <div class="parchment-card-box p-4 p-md-5">
        <div class="text-center mb-4">
            <div class="d-inline-flex align-items-center justify-content-center mb-2" style="width: 60px; height: 60px; background: linear-gradient(135deg, #3a1e12 0%, #1f1109 100%); border-radius: 50%; box-shadow: 0 4px 10px rgba(0,0,0,0.3);">
                <i class="fa-solid fa-user-plus fs-3 text-warning"></i>
            </div>
            <h1 class="h3 mb-1" style="color: var(--wood-dark);">Tạo Tài Khoản Mới</h1>
            <p class="text-muted small">Gia nhập cộng đồng độc giả yêu sách tại BookStore</p>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-custom mb-3">
                <i class="fa-solid fa-triangle-exclamation fs-5"></i>
                <div><c:out value="${error}"/></div>
            </div>
        </c:if>

        <form method="post" action="<c:url value='/register'/>">
            <div class="mb-3">
                <label class="form-label fw-semibold" for="email">
                    <i class="fa-solid fa-envelope text-muted me-1"></i>Email đăng ký
                </label>
                <input class="form-control" id="email" name="email" type="email" maxlength="50" placeholder="name@example.com" required value="<c:out value='${email}'/>"/>
            </div>

            <div class="row g-3 mb-3">
                <div class="col-sm-6">
                    <label class="form-label fw-semibold" for="fullname">
                        <i class="fa-solid fa-user text-muted me-1"></i>Họ và tên
                    </label>
                    <input class="form-control" id="fullname" name="fullname" maxlength="50" placeholder="Họ tên của bạn" required value="<c:out value='${fullname}'/>"/>
                </div>
                <div class="col-sm-6">
                    <label class="form-label fw-semibold" for="phone">
                        <i class="fa-solid fa-phone text-muted me-1"></i>Số điện thoại
                    </label>
                    <input class="form-control" id="phone" name="phone" pattern="[0-9]{9,10}" maxlength="10" placeholder="0912345678" required value="<c:out value='${phone}'/>"/>
                </div>
            </div>

            <div class="row g-3 mb-4">
                <div class="col-sm-6">
                    <label class="form-label fw-semibold" for="password">
                        <i class="fa-solid fa-lock text-muted me-1"></i>Mật khẩu (tối thiểu 8 ký tự)
                    </label>
                    <input class="form-control" id="password" name="password" type="password" minlength="8" placeholder="••••••••" required/>
                </div>
                <div class="col-sm-6">
                    <label class="form-label fw-semibold" for="confirmPassword">
                        <i class="fa-solid fa-lock-check text-muted me-1"></i>Nhập lại mật khẩu
                    </label>
                    <input class="form-control" id="confirmPassword" name="confirmPassword" type="password" minlength="8" placeholder="••••••••" required/>
                </div>
            </div>

            <button class="btn btn-leather-primary w-100 py-2 fs-6 mb-3" type="submit">
                <i class="fa-solid fa-user-check me-1"></i> Hoàn tất đăng ký tài khoản
            </button>
        </form>

        <div class="text-center pt-3 border-top">
            <span class="text-muted">Đã có tài khoản?</span>
            <a class="fw-bold ms-1" style="color: var(--leather-accent);" href="<c:url value='/login'/>">Đăng nhập tại đây</a>
        </div>
    </div>
</div>
