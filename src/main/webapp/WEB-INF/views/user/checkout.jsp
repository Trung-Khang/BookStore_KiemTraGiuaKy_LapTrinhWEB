<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<title>Thanh toán COD | BookStore</title>

<section class="container py-5">
    <div class="page-header-wood">
        <div class="d-flex align-items-center gap-3">
            <i class="fa-solid fa-credit-card text-warning fs-3"></i>
            <div>
                <h1 class="h2 mb-0">Thanh Toán Đơn Hàng</h1>
                <p class="text-muted mb-0 small">Điền thông tin người nhận và hoàn tất đơn hàng giao tận nơi (COD)</p>
            </div>
        </div>
        <a class="btn btn-sm btn-leather-outline" href="<c:url value='/cart'/>">
            <i class="fa-solid fa-arrow-left me-1"></i> Quay lại giỏ hàng
        </a>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-custom mb-4">
            <i class="fa-solid fa-triangle-exclamation fs-5"></i>
            <div><c:out value="${error}"/></div>
        </div>
    </c:if>

    <div class="row g-4">
        <!-- Recipient Information Form -->
        <div class="col-lg-7">
            <div class="parchment-card-box">
                <h2 class="h4 mb-3 pb-2 border-bottom" style="color: var(--wood-dark);">
                    <i class="fa-solid fa-address-book text-warning me-2"></i>Thông Tin Giao Hàng
                </h2>

                <form method="post" action="<c:url value='/checkout'/>">
                    <div class="mb-3">
                        <label class="form-label fw-semibold" for="recipientName">Họ và tên người nhận</label>
                        <input class="form-control" id="recipientName" name="recipientName" maxlength="100" placeholder="Ví dụ: Nguyễn Văn A" required value="<c:out value='${param.recipientName}'/>"/>
                    </div>

                    <div class="row g-3 mb-3">
                        <div class="col-sm-6">
                            <label class="form-label fw-semibold" for="recipientPhone">Số điện thoại liên hệ</label>
                            <input class="form-control" id="recipientPhone" name="recipientPhone" type="tel" maxlength="20" pattern="[0-9+(). -]{8,20}" placeholder="0912345678" required value="<c:out value='${param.recipientPhone}'/>"/>
                        </div>
                        <div class="col-sm-6">
                            <label class="form-label fw-semibold" for="recipientEmail">Email nhận thông báo</label>
                            <input class="form-control" id="recipientEmail" name="recipientEmail" type="email" maxlength="254" placeholder="email@example.com" required value="<c:out value='${param.recipientEmail}' default='${sessionScope.currentUser.email}'/>"/>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold" for="shippingAddress">Địa chỉ nhận hàng chi tiết</label>
                        <textarea class="form-control" id="shippingAddress" name="shippingAddress" maxlength="500" rows="3" placeholder="Số nhà, tên đường, phường/xã, quận/huyện, tỉnh/thành phố..." required><c:out value="${param.shippingAddress}"/></textarea>
                    </div>

                    <div class="p-3 mb-4" style="background: var(--parchment-warm); border: 1px solid var(--parchment-border); border-radius: var(--radius-sm);">
                        <div class="d-flex align-items-center gap-2">
                            <i class="fa-solid fa-hand-holding-dollar fs-4 text-warning"></i>
                            <div>
                                <strong>Phương thức: Thanh toán khi nhận hàng (COD)</strong>
                                <div class="small text-muted">Bạn chỉ thanh toán tiền mặt trực tiếp cho nhân viên giao hàng khi nhận được sách.</div>
                            </div>
                        </div>
                    </div>

                    <div class="d-flex gap-3 align-items-center">
                        <button class="btn btn-leather-primary btn-lg px-4" type="submit">
                            <i class="fa-solid fa-check me-1"></i> Xác nhận đặt hàng
                        </button>
                        <a class="btn btn-outline-secondary" href="<c:url value='/cart'/>">Hủy bỏ</a>
                    </div>
                </form>
            </div>
        </div>

        <!-- Order Summary Column -->
        <div class="col-lg-5">
            <div class="parchment-card-box">
                <h2 class="h4 mb-3 pb-2 border-bottom" style="color: var(--wood-dark);">
                    <i class="fa-solid fa-receipt text-warning me-2"></i>Tóm Tắt Đơn Hàng
                </h2>

                <ul class="list-group list-group-flush mb-3">
                    <c:forEach items="${cartLines}" var="line">
                        <li class="list-group-item d-flex justify-content-between align-items-center px-0 py-3" style="background: transparent;">
                            <div>
                                <div class="fw-semibold" style="color: var(--wood-dark);"><c:out value="${line.book.title}"/></div>
                                <div class="small text-muted">Số lượng: <strong><c:out value="${line.quantity}"/></strong></div>
                            </div>
                            <span class="fw-bold">
                                <fmt:formatNumber value="${line.subtotal}" type="currency" currencyCode="VND" maxFractionDigits="0"/>
                            </span>
                        </li>
                    </c:forEach>
                    <li class="list-group-item d-flex justify-content-between align-items-center px-0 pt-3 border-top border-2" style="background: transparent;">
                        <span class="fs-5 fw-bold" style="color: var(--wood-dark);">Tổng thanh toán</span>
                        <strong class="fs-4 text-danger">
                            <fmt:formatNumber value="${cartTotal}" type="currency" currencyCode="VND" maxFractionDigits="0"/>
                        </strong>
                    </li>
                </ul>

                <div class="small text-muted mt-3 pt-3 border-top">
                    <i class="fa-solid fa-circle-info me-1"></i>
                    Giá và số lượng sách được kiểm tra và trừ tồn kho tự động trong giao dịch đặt hàng an toàn.
                </div>
            </div>
        </div>
    </div>
</section>
