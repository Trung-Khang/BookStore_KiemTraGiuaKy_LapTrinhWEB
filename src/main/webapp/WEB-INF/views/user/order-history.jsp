<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<title>Lịch sử đặt hàng | BookStore</title>

<section class="container py-5">
    <div class="page-header-wood">
        <div class="d-flex align-items-center gap-3">
            <i class="fa-solid fa-boxes-stacked text-warning fs-3"></i>
            <div>
                <h1 class="h2 mb-0">Lịch Sử Đơn Hàng</h1>
                <p class="text-muted mb-0 small">Theo dõi tiến trình xử lý và trạng thái các đơn hàng đã đặt</p>
            </div>
        </div>
        <a class="btn btn-sm btn-leather-outline" href="<c:url value='/home'/>">
            <i class="fa-solid fa-book-open me-1"></i> Mua sắm thêm
        </a>
    </div>

    <c:if test="${not empty filterError}">
        <div class="alert alert-warning alert-custom mb-4">
            <i class="fa-solid fa-triangle-exclamation fs-5"></i>
            <div><c:out value="${filterError}"/></div>
        </div>
    </c:if>

    <!-- Filter Form -->
    <div class="parchment-card-box mb-4 py-3">
        <form class="row g-3 align-items-end" method="get" action="<c:url value='/orders'/>">
            <div class="col-sm-6 col-md-4">
                <label class="form-label fw-semibold" for="status">
                    <i class="fa-solid fa-filter text-muted me-1"></i>Lọc theo trạng thái
                </label>
                <select class="form-select" id="status" name="status">
                    <option value="ALL" ${selectedStatus == 'ALL' ? 'selected' : ''}>Tất cả đơn hàng</option>
                    <c:forEach items="${statuses}" var="status">
                        <option value="${status.name()}" ${selectedStatus == status.name() ? 'selected' : ''}>
                            <c:out value="${status.label}"/>
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-auto">
                <button class="btn btn-leather-primary" type="submit">
                    <i class="fa-solid fa-magnifying-glass me-1"></i> Lọc đơn
                </button>
            </div>
        </form>
    </div>

    <!-- Orders Table -->
    <c:choose>
        <c:when test="${not empty orders}">
            <div class="parchment-card-box p-0 overflow-hidden">
                <div class="table-responsive">
                    <table class="table table-parchment align-middle mb-0">
                        <thead>
                            <tr>
                                <th style="width: 110px;">Mã đơn</th>
                                <th>Thời gian đặt</th>
                                <th>Trạng thái</th>
                                <th>Hình thức</th>
                                <th>Tổng tiền</th>
                                <th style="width: 120px;" class="text-center">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${orders}" var="order">
                                <tr>
                                    <td>
                                        <strong style="color: var(--wood-dark);">#<c:out value="${order.id}"/></strong>
                                    </td>
                                    <td>
                                        <div class="small"><i class="fa-regular fa-clock text-muted me-1"></i><c:out value="${order.createdAt}"/></div>
                                    </td>
                                    <td>
                                        <c:set var="statusKey" value="${order.status.name()}"/>
                                        <span class="badge-order-status
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
                                            <i class="fa-solid fa-circle-dot" style="font-size: 0.6rem;"></i>
                                            <c:out value="${order.status.label}"/>
                                        </span>
                                    </td>
                                    <td>
                                        <span class="badge bg-light text-dark border"><c:out value="${order.paymentMethod}"/></span>
                                    </td>
                                    <td class="fw-bold text-danger">
                                        <fmt:formatNumber value="${order.totalAmount}" type="currency" currencyCode="VND" maxFractionDigits="0"/>
                                    </td>
                                    <td class="text-center">
                                        <a class="btn btn-sm btn-leather-outline" href="<c:url value='/orders/detail'><c:param name='id' value='${order.id}'/></c:url>">
                                            <i class="fa-solid fa-eye me-1"></i> Chi tiế
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="parchment-card-box text-center py-5">
                <i class="fa-solid fa-box-open text-muted fs-1 mb-3"></i>
                <h3 class="h4 text-muted mb-2">Chưa có đơn hàng nào phù hợp</h3>
                <p class="text-muted">Các đơn hàng mới của bạn sẽ hiển thị tại đây khi được đặt.</p>
            </div>
        </c:otherwise>
    </c:choose>
</section>
