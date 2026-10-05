<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:remove var="checkoutOrderId" scope="session"/>
<title>Giỏ hàng | BookStore</title>

<section class="container py-5">
    <div class="page-header-wood">
        <div class="d-flex align-items-center gap-3">
            <i class="fa-solid fa-cart-shopping text-warning fs-3"></i>
            <div>
                <h1 class="h2 mb-0">Giỏ Hàng Của Bạn</h1>
                <p class="text-muted mb-0 small">Kiểm tra danh mục sách đã chọn trước khi tiến hành thanh toán COD</p>
            </div>
        </div>
        <a class="btn btn-sm btn-leather-outline" href="<c:url value='/home'/>">
            <i class="fa-solid fa-arrow-left me-1"></i> Tiếp tục chọn sách
        </a>
    </div>

    <!-- Alert Notifications -->
    <c:choose>
        <c:when test="${param.message == 'order'}">
            <div class="alert alert-success alert-custom mb-4">
                <i class="fa-solid fa-circle-check fs-5"></i>
                <div>Đặt hàng COD thành công! Mã đơn: <strong>#<c:out value="${sessionScope.checkoutOrderId}"/></strong>. Đơn hàng đang được chuẩn bị.</div>
            </div>
        </c:when>
        <c:when test="${param.message == 'invalid'}">
            <div class="alert alert-danger alert-custom mb-4">
                <i class="fa-solid fa-triangle-exclamation fs-5"></i>
                <div>Số lượng yêu cầu không hợp lệ, sách đã hết hàng hoặc vượt quá số lượng tồn kho hiện tại.</div>
            </div>
        </c:when>
        <c:when test="${param.message == 'added'}">
            <div class="alert alert-success alert-custom mb-4">
                <i class="fa-solid fa-circle-check fs-5"></i>
                <div>Đã thêm sách vào giỏ hàng thành công.</div>
            </div>
        </c:when>
        <c:when test="${param.message == 'updated'}">
            <div class="alert alert-success alert-custom mb-4">
                <i class="fa-solid fa-circle-check fs-5"></i>
                <div>Đã cập nhật số lượng sách trong giỏ hàng.</div>
            </div>
        </c:when>
        <c:when test="${param.message == 'removed'}">
            <div class="alert alert-info alert-custom mb-4">
                <i class="fa-solid fa-info fs-5"></i>
                <div>Đã xóa sách khỏi giỏ hàng.</div>
            </div>
        </c:when>
    </c:choose>

    <!-- Cart Content -->
    <c:choose>
        <c:when test="${empty cartLines}">
            <div class="parchment-card-box text-center py-5">
                <i class="fa-solid fa-basket-shopping text-muted fs-1 mb-3"></i>
                <h3 class="h4 text-muted mb-3">Giỏ hàng của bạn đang trống</h3>
                <p class="text-muted mb-4">Hãy dạo quanh các kệ sách để tìm những tác phẩm ưng ý nhất.</p>
                <a class="btn btn-leather-primary" href="<c:url value='/home'/>">
                    <i class="fa-solid fa-book-open me-1"></i> Khám phá kệ sách ngay
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="parchment-card-box p-0 overflow-hidden mb-4">
                <div class="table-responsive">
                    <table class="table table-parchment align-middle mb-0">
                        <thead>
                            <tr>
                                <th>Sách</th>
                                <th style="width: 160px;">Đơn giá</th>
                                <th style="width: 220px;">Số lượng</th>
                                <th style="width: 160px;">Thành tiền</th>
                                <th style="width: 80px;" class="text-center">Xóa</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${cartLines}" var="line">
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center gap-3">
                                            <div style="width: 48px; height: 64px; flex-shrink: 0; background: #3a1e12; border-radius: 2px; overflow: hidden; box-shadow: 0 2px 5px rgba(0,0,0,0.2);">
                                                <c:choose>
                                                    <c:when test="${not empty line.book.coverImage}">
                                                        <img src="<c:url value='/assets/images/'/><c:out value='${line.book.coverImage}'/>"
                                                             alt="" style="width: 100%; height: 100%; object-fit: cover;"
                                                             onerror="this.onerror=null;this.src='<c:url value='/assets/images/book-default.svg'/>'"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="<c:url value='/assets/images/book-default.svg'/>" alt="" style="width: 100%; height: 100%; object-fit: cover;"/>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div>
                                                <a class="fw-bold text-decoration-none" style="color: var(--wood-dark);" href="<c:url value='/book/detail'><c:param name='id' value='${line.book.id}'/></c:url>">
                                                    <c:out value="${line.book.title}"/>
                                                </a>
                                                <div class="small text-muted mt-1">
                                                    <i class="fa-solid fa-boxes-stacked me-1"></i> Tồn kho: <c:out value="${line.book.quantity}"/> quyển
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="fw-semibold">
                                        <fmt:formatNumber value="${line.book.price}" type="currency" currencyCode="VND" maxFractionDigits="0"/>
                                    </td>
                                    <td>
                                        <form class="d-flex gap-2 align-items-center" method="post" action="<c:url value='/cart/update'/>">
                                            <input type="hidden" name="bookId" value="${line.book.id}"/>
                                            <input class="form-control form-control-sm text-center fw-bold" style="max-width: 85px;" type="number" name="quantity" min="1" max="${line.book.quantity}" value="${line.quantity}" required/>
                                            <button class="btn btn-sm btn-outline-secondary" type="submit" title="Cập nhật số lượng">
                                                <i class="fa-solid fa-arrows-rotate"></i>
                                            </button>
                                        </form>
                                    </td>
                                    <td class="fw-bold text-danger">
                                        <fmt:formatNumber value="${line.subtotal}" type="currency" currencyCode="VND" maxFractionDigits="0"/>
                                    </td>
                                    <td class="text-center">
                                        <form method="post" action="<c:url value='/cart/remove'/>">
                                            <input type="hidden" name="bookId" value="${line.book.id}"/>
                                            <button class="btn btn-sm btn-outline-danger" type="submit" title="Xóa sách này">
                                                <i class="fa-solid fa-trash-can"></i>
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Cart Footer Summary -->
            <div class="parchment-card-box d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3">
                <form method="post" action="<c:url value='/cart/clear'/>">
                    <button class="btn btn-outline-danger btn-sm" type="submit" onclick="return confirm('Bạn có chắc chắn muốn dọn sạch giỏ hàng?')">
                        <i class="fa-solid fa-trash me-1"></i> Xóa toàn bộ giỏ hàng
                    </button>
                </form>

                <div class="d-flex flex-column flex-sm-row align-items-sm-center gap-4">
                    <div class="fs-5 text-end">
                        <span class="text-muted">Tổng thanh toán:</span>
                        <strong class="text-danger ms-2 fs-4">
                            <fmt:formatNumber value="${cartTotal}" type="currency" currencyCode="VND" maxFractionDigits="0"/>
                        </strong>
                    </div>
                    <a class="btn btn-leather-primary btn-lg" href="<c:url value='/checkout'/>">
                        <i class="fa-solid fa-truck-ramp-box me-1"></i> Tiến hành thanh toán COD
                    </a>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</section>
