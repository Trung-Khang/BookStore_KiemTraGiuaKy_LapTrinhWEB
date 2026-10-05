<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:remove var="checkoutOrderId" scope="session"/>
<title>Giỏ hàng | BookStore</title>
<section class="container py-5">
    <h1 class="h2 mb-4">Giỏ hàng</h1>
    <c:choose>
        <c:when test="${param.message == 'order'}"><div class="alert alert-success">Đặt hàng COD thành công. Mã đơn: <c:out value="${sessionScope.checkoutOrderId}"/>.</div></c:when>
        <c:when test="${param.message == 'invalid'}"><div class="alert alert-danger">Số lượng không hợp lệ, sách hết hàng hoặc vượt tồn kho hiện tại.</div></c:when>
        <c:when test="${param.message == 'added'}"><div class="alert alert-success">Đã thêm sách vào giỏ hàng.</div></c:when>
        <c:when test="${param.message == 'updated'}"><div class="alert alert-success">Đã cập nhật số lượng.</div></c:when>
        <c:when test="${param.message == 'removed'}"><div class="alert alert-info">Đã xóa sách khỏi giỏ hàng.</div></c:when>
    </c:choose>
    <c:choose>
        <c:when test="${empty cartLines}"><div class="alert alert-info">Giỏ hàng đang trống.</div><a class="btn btn-primary" href="<c:url value='/home'/>">Tiếp tục xem sách</a></c:when>
        <c:otherwise>
            <div class="table-responsive"><table class="table align-middle"><thead><tr><th>Sách</th><th>Đơn giá</th><th>Số lượng</th><th>Thành tiền</th><th></th></tr></thead><tbody>
                <c:forEach items="${cartLines}" var="line"><tr>
                    <td><a href="<c:url value='/book/detail'><c:param name='id' value='${line.book.id}'/></c:url>"><c:out value="${line.book.title}"/></a><div class="small text-muted">Tồn kho: <c:out value="${line.book.quantity}"/></div></td>
                    <td><fmt:formatNumber value="${line.book.price}" type="currency" currencyCode="VND" maxFractionDigits="0"/></td>
                    <td><form class="d-flex gap-2" method="post" action="<c:url value='/cart/update'/>"><input type="hidden" name="bookId" value="${line.book.id}"/><input class="form-control" style="max-width:100px" type="number" name="quantity" min="1" max="${line.book.quantity}" value="${line.quantity}" required/><button class="btn btn-outline-primary" type="submit">Cập nhật</button></form></td>
                    <td><fmt:formatNumber value="${line.subtotal}" type="currency" currencyCode="VND" maxFractionDigits="0"/></td>
                    <td><form method="post" action="<c:url value='/cart/remove'/>"><input type="hidden" name="bookId" value="${line.book.id}"/><button class="btn btn-outline-danger" type="submit">Xóa</button></form></td>
                </tr></c:forEach>
            </tbody></table></div>
            <div class="d-flex justify-content-between align-items-center"><form method="post" action="<c:url value='/cart/clear'/>"><button class="btn btn-outline-danger" type="submit">Xóa giỏ hàng</button></form><div class="h4 mb-0">Tổng: <fmt:formatNumber value="${cartTotal}" type="currency" currencyCode="VND" maxFractionDigits="0"/></div><a class="btn btn-primary" href="<c:url value='/checkout'/>">Thanh toán COD</a></div>
        </c:otherwise>
    </c:choose>
</section>
