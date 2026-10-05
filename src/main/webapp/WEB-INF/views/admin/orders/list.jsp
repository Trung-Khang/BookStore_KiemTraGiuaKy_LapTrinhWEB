<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<title>Quản lý đơn hàng | BookStore Admin</title>

<div class="container-fluid">
    <div class="page-header-wood">
        <div class="d-flex align-items-center gap-3">
            <i class="fa-solid fa-clipboard-list text-warning fs-3"></i>
            <div>
                <h1 class="h2 mb-0">Quản Lý Đơn Hàng</h1>
                <p class="text-muted mb-0 small">Theo dõi tình trạng vận chuyển, cập nhật trạng thái đơn COD và xử lý hủy đơn</p>
            </div>
        </div>
    </div>

    <!-- Alert Notifications -->
    <c:if test="${param.success eq 'status'}">
        <div class="alert alert-success alert-custom mb-3">
            <i class="fa-solid fa-circle-check fs-5"></i>
            <div>Đã cập nhật trạng thái đơn hàng thành công.</div>
        </div>
    </c:if>
    <c:if test="${param.success eq 'deleted'}">
        <div class="alert alert-success alert-custom mb-3">
            <i class="fa-solid fa-circle-check fs-5"></i>
            <div>Đã xóa vĩnh viễn đơn hàng đã hủy.</div>
        </div>
    </c:if>
    <c:if test="${not empty param.error}">
        <div class="alert alert-danger alert-custom mb-3">
            <i class="fa-solid fa-triangle-exclamation fs-5"></i>
            <div><c:out value="${param.error}"/></div>
        </div>
    </c:if>

    <!-- Filter Form -->
    <div class="parchment-card-box mb-4 py-3">
        <form method="get" action="<c:url value='/admin/orders'/>" class="row g-3 align-items-end">
            <div class="col-sm-6 col-md-4">
                <label class="form-label fw-semibold" for="statusFilter">
                    <i class="fa-solid fa-filter text-muted me-1"></i>Lọc theo trạng thái
                </label>
                <select class="form-select" id="statusFilter" name="status">
                    <option value="ALL" ${selectedStatus eq 'ALL' ? 'selected' : ''}>Tất cả các đơn</option>
                    <c:forEach items="${statuses}" var="status">
                        <option value="${status.name()}" ${selectedStatus eq status.name() ? 'selected' : ''}>
                            <c:out value="${status.label}"/>
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-auto">
                <button class="btn btn-leather-primary" type="submit">
                    <i class="fa-solid fa-magnifying-glass me-1"></i> Lọc danh sách
                </button>
            </div>
        </form>
    </div>

    <!-- Orders Table -->
    <div class="parchment-card-box p-0 overflow-hidden mb-4">
        <div class="table-responsive">
            <table class="table table-parchment align-middle mb-0">
                <thead>
                    <tr>
                        <th style="width: 80px;">Mã đơn</th>
                        <th style="width: 140px;">Ngày đặt</th>
                        <th>Tài khoản</th>
                        <th>Người nhận</th>
                        <th>Điện thoại</th>
                        <th style="width: 130px;">Tổng tiền</th>
                        <th style="width: 140px;">Trạng thái</th>
                        <th style="min-width: 250px;" class="text-center">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${orders}" var="order">
                        <tr>
                            <td><strong style="color: var(--wood-dark);">#${order.id}</strong></td>
                            <td class="small text-muted"><i class="fa-regular fa-calendar me-1"></i>${order.createdAt}</td>
                            <td><c:out value="${order.user.email}"/></td>
                            <td><strong><c:out value="${order.recipientName}"/></strong></td>
                            <td><c:out value="${order.recipientPhone}"/></td>
                            <td class="fw-bold text-danger">
                                <fmt:formatNumber value="${order.totalAmount}" maxFractionDigits="0"/> đ
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
                                    <c:out value="${order.status.label}"/>
                                </span>
                            </td>
                            <td class="text-nowrap text-center">
                                <div class="d-inline-flex gap-2 align-items-center">
                                    <form method="post" action="<c:url value='/admin/orders/status'/>" class="d-inline-flex gap-1">
                                        <input type="hidden" name="orderId" value="${order.id}">
                                        <input type="hidden" name="statusFilter" value="${selectedStatus}">
                                        <select class="form-select form-select-sm" name="status" aria-label="Trạng thái mới" style="width: 140px;">
                                            <c:forEach items="${statuses}" var="status">
                                                <option value="${status.name()}" ${order.status eq status ? 'selected' : ''}>
                                                    <c:out value="${status.label}"/>
                                                </option>
                                            </c:forEach>
                                        </select>
                                        <button class="btn btn-sm btn-leather-primary" type="submit" title="Cập nhật trạng thái">
                                            <i class="fa-solid fa-check"></i>
                                        </button>
                                    </form>
                                    <c:if test="${order.status.name() eq 'CANCELLED'}">
                                        <form method="post" action="<c:url value='/admin/orders/delete'/>" class="d-inline" onsubmit="return confirm('Xóa vĩnh viễn đơn hàng đã hủy này?')">
                                            <input type="hidden" name="orderId" value="${order.id}">
                                            <input type="hidden" name="statusFilter" value="${selectedStatus}">
                                            <button class="btn btn-sm btn-outline-danger" type="submit" title="Xóa đơn hủy">
                                                <i class="fa-solid fa-trash-can"></i>
                                            </button>
                                        </form>
                                    </c:if>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty orders}">
                        <tr>
                            <td colspan="8" class="text-center text-muted py-4">Chưa có đơn hàng nào phù hợp với bộ lọc.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Pagination for Admin Orders -->
    <nav aria-label="Phân trang đơn hàng">
        <ul class="pagination pagination-library">
            <c:forEach begin="1" end="${totalPages}" var="page">
                <li class="page-item ${page eq currentPage ? 'active' : ''}">
                    <c:url var="pageUrl" value="/admin/orders">
                        <c:param name="page" value="${page}"/>
                        <c:param name="status" value="${selectedStatus}"/>
                    </c:url>
                    <a class="page-link" href="${pageUrl}">${page}</a>
                </li>
            </c:forEach>
        </ul>
    </nav>
</div>
