<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<title>Chi tiết đơn hàng #<c:out value="${order.id}"/> | BookStore</title>

<section class="container py-5">
    <div class="mb-3">
        <a class="btn btn-sm btn-leather-outline" href="<c:url value='/orders'/>">
            <i class="fa-solid fa-arrow-left me-1"></i> Quay lại lịch sử đặt hàng
        </a>
    </div>

    <!-- Main Order Receipt Box -->
    <div class="parchment-card-box mb-4">
        <div class="d-flex flex-column flex-sm-row justify-content-between align-items-sm-center border-bottom pb-3 mb-4 gap-2">
            <div>
                <span class="text-muted small text-uppercase fw-bold letter-spacing-1">Chi Tiết Đơn Hàng</span>
                <h1 class="h2 mb-0" style="color: var(--wood-dark);">Đơn hàng #<c:out value="${order.id}"/></h1>
            </div>
            <div>
                <c:set var="statusKey" value="${order.status.name()}"/>
                <span class="badge-order-status fs-6
                    <c:choose>
                        <c:when test="${statusKey eq 'NEW'}">badge-status-new</c:when>
                        <c:when test="${statusKey eq 'CONFIRMED'}">badge-status-confirmed</c:when>
                        <c:when test="${statusKey eq 'PREPARING'}">badge-status-preparing</c:when>
                        <c:when test="${statusKey eq 'SHIPPING'}">badge-status-shipping</c:when>
                        <c:when test="${statusKey eq 'DELIVERING'}">badge-status-delivering</c:when>
                        <c:when test="${statusKey eq 'DELIVERED'}">badge-status-delivered</c:when>
                        <c:when test="${statusKey eq 'CANCELLED'}">badge-status-cancelled</c:when>
                        <c:otherwise>badge-status-returned</c:otherwise>
                    </c:choose>">
                    <i class="fa-solid fa-circle-dot" style="font-size: 0.65rem;"></i>
                    <c:out value="${order.status.label}"/>
                </span>
            </div>
        </div>

        <!-- Order Metadata Grid -->
        <div class="row g-3 mb-4 p-3" style="background: var(--parchment); border: 1px solid var(--parchment-border); border-radius: var(--radius-sm);">
            <div class="col-sm-6 col-lg-3">
                <div class="text-muted small"><i class="fa-regular fa-calendar-days me-1"></i>Ngày đặt</div>
                <strong class="text-dark"><c:out value="${order.createdAt}"/></strong>
            </div>
            <div class="col-sm-6 col-lg-3">
                <div class="text-muted small"><i class="fa-solid fa-money-bill-wave me-1"></i>Thanh toán</div>
                <strong class="text-dark"><c:out value="${order.paymentMethod}"/></strong>
            </div>
            <div class="col-sm-6 col-lg-3">
                <div class="text-muted small"><i class="fa-solid fa-user me-1"></i>Người nhận</div>
                <strong class="text-dark"><c:out value="${order.recipientName}"/></strong>
            </div>
            <div class="col-sm-6 col-lg-3">
                <div class="text-muted small"><i class="fa-solid fa-phone me-1"></i>Điện thoại</div>
                <strong class="text-dark"><c:out value="${order.recipientPhone}"/></strong>
            </div>
            <div class="col-sm-6 col-lg-6">
                <div class="text-muted small"><i class="fa-solid fa-envelope me-1"></i>Email</div>
                <strong class="text-dark"><c:out value="${order.recipientEmail}"/></strong>
            </div>
            <div class="col-sm-6 col-lg-6">
                <div class="text-muted small"><i class="fa-solid fa-location-dot me-1"></i>Địa chỉ nhận hàng</div>
                <strong class="text-dark"><c:out value="${order.shippingAddress}"/></strong>
            </div>
        </div>

        <!-- Order Items Table -->
        <h2 class="h5 mb-3" style="color: var(--wood-dark);">
            <i class="fa-solid fa-book-bookmark text-warning me-2"></i>Danh Sách Sách Trong Đơn
        </h2>
        <div class="table-responsive">
            <table class="table table-parchment align-middle mb-0">
                <thead>
                    <tr>
                        <th>Tên sách</th>
                        <th style="width: 180px;">Đơn giá tại lúc đặt</th>
                        <th style="width: 120px;" class="text-center">Số lượng</th>
                        <th style="width: 180px;" class="text-end">Thành tiền</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${order.items}" var="item">
                        <tr>
                            <td>
                                <strong><c:out value="${item.bookTitle}"/></strong>
                            </td>
                            <td>
                                <fmt:formatNumber value="${item.unitPrice}" type="currency" currencyCode="VND" maxFractionDigits="0"/>
                            </td>
                            <td class="text-center fw-semibold">
                                <c:out value="${item.quantity}"/>
                            </td>
                            <td class="text-end fw-bold">
                                <fmt:formatNumber value="${item.lineTotal}" type="currency" currencyCode="VND" maxFractionDigits="0"/>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
                <tfoot>
                    <tr style="background: #faf5ec;">
                        <th colspan="3" class="text-end fs-5" style="color: var(--wood-dark); padding-top: 1rem; padding-bottom: 1rem;">Tổng cộng thanh toán:</th>
                        <th class="text-end fs-4 text-danger" style="padding-top: 1rem; padding-bottom: 1rem;">
                            <fmt:formatNumber value="${order.totalAmount}" type="currency" currencyCode="VND" maxFractionDigits="0"/>
                        </th>
                    </tr>
                </tfoot>
            </table>
        </div>
    </div>
</section>
