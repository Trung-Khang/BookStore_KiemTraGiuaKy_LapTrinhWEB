<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<title>Thanh toán COD | BookStore</title>
<section class="container py-5"><h1 class="h2 mb-4">Thanh toán đơn hàng</h1>
    <c:if test="${not empty error}"><div class="alert alert-danger"><c:out value="${error}"/></div></c:if>
    <div class="row g-4"><div class="col-lg-7"><form method="post" action="<c:url value='/checkout'/>">
        <div class="mb-3"><label class="form-label" for="recipientName">Họ và tên người nhận</label><input class="form-control" id="recipientName" name="recipientName" maxlength="100" required value="<c:out value='${param.recipientName}'/>"/></div>
        <div class="mb-3"><label class="form-label" for="recipientPhone">Số điện thoại</label><input class="form-control" id="recipientPhone" name="recipientPhone" type="tel" maxlength="20" pattern="[0-9+(). -]{8,20}" required value="<c:out value='${param.recipientPhone}'/>"/></div>
        <div class="mb-3"><label class="form-label" for="recipientEmail">Email</label><input class="form-control" id="recipientEmail" name="recipientEmail" type="email" maxlength="254" required value="<c:out value='${param.recipientEmail}' default='${sessionScope.currentUser.email}'/>"/></div>
        <div class="mb-3"><label class="form-label" for="shippingAddress">Địa chỉ nhận hàng</label><textarea class="form-control" id="shippingAddress" name="shippingAddress" maxlength="500" rows="3" required><c:out value="${param.shippingAddress}"/></textarea></div>
        <div class="alert alert-info">Phương thức thanh toán: <strong>Thanh toán khi nhận hàng (COD)</strong></div>
        <button class="btn btn-primary btn-lg" type="submit">Đặt hàng</button> <a class="btn btn-outline-secondary btn-lg" href="<c:url value='/cart'/>">Quay lại giỏ hàng</a>
    </form></div><div class="col-lg-5"><h2 class="h5">Tóm tắt đơn hàng</h2><ul class="list-group mb-3"><c:forEach items="${cartLines}" var="line"><li class="list-group-item d-flex justify-content-between"><span><c:out value="${line.book.title}"/> × <c:out value="${line.quantity}"/></span><strong><fmt:formatNumber value="${line.subtotal}" type="currency" currencyCode="VND" maxFractionDigits="0"/></strong></li></c:forEach><li class="list-group-item d-flex justify-content-between"><strong>Tổng cộng</strong><strong><fmt:formatNumber value="${cartTotal}" type="currency" currencyCode="VND" maxFractionDigits="0"/></strong></li></ul></div></div>
</section>
