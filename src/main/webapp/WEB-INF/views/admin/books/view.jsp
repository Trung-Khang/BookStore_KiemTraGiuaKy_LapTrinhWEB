<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<title>Chi tiết sách | BookStore Admin</title>

<div class="container" style="max-width: 860px;">
    <div class="page-header-wood">
        <div class="d-flex align-items-center gap-3">
            <i class="fa-solid fa-book-open text-warning fs-3"></i>
            <div>
                <h1 class="h2 mb-0">Hồ Sơ Sách</h1>
                <p class="text-muted mb-0 small">Thông tin chi tiết được lưu trữ trong hệ thống</p>
            </div>
        </div>
        <div class="d-flex gap-2">
            <a class="btn btn-sm btn-leather-primary" href="<c:url value='/admin/books/edit'><c:param name='id' value='${book.id}'/></c:url>">
                <i class="fa-solid fa-pen-to-square me-1"></i> Chỉnh sửa
            </a>
            <a class="btn btn-sm btn-leather-outline" href="<c:url value='/admin/books'/>">
                <i class="fa-solid fa-arrow-left me-1"></i> Quay lại
            </a>
        </div>
    </div>

    <div class="parchment-card-box">
        <h2 class="h3 mb-3" style="color: var(--wood-dark);"><c:out value="${book.title}"/></h2>

        <div class="table-responsive">
            <table class="table table-bordered align-middle">
                <tbody>
                    <tr>
                        <th style="width: 180px; background: #faf5ec; color: var(--wood-dark);"><i class="fa-solid fa-hashtag me-1"></i> ID Sách</th>
                        <td>${book.id}</td>
                    </tr>
                    <tr>
                        <th style="background: #faf5ec; color: var(--wood-dark);"><i class="fa-solid fa-barcode me-1"></i> Mã ISBN</th>
                        <td><code>${book.isbn}</code></td>
                    </tr>
                    <tr>
                        <th style="background: #faf5ec; color: var(--wood-dark);"><i class="fa-solid fa-building me-1"></i> Nhà xuất bản</th>
                        <td><c:out value="${book.publisher}" default="Chưa cập nhật"/></td>
                    </tr>
                    <tr>
                        <th style="background: #faf5ec; color: var(--wood-dark);"><i class="fa-solid fa-calendar-days me-1"></i> Ngày xuất bản</th>
                        <td><c:out value="${book.publishDate}"/></td>
                    </tr>
                    <tr>
                        <th style="background: #faf5ec; color: var(--wood-dark);"><i class="fa-solid fa-tag me-1"></i> Giá niêm yết</th>
                        <td class="fw-bold text-danger">
                            <fmt:formatNumber value="${book.price}" type="currency" currencyCode="VND" maxFractionDigits="0"/>
                        </td>
                    </tr>
                    <tr>
                        <th style="background: #faf5ec; color: var(--wood-dark);"><i class="fa-solid fa-boxes-stacked me-1"></i> Tồn kho</th>
                        <td><span class="badge bg-secondary">${book.quantity} quyển</span></td>
                    </tr>
                    <tr>
                        <th style="background: #faf5ec; color: var(--wood-dark);"><i class="fa-solid fa-feather-pointed me-1"></i> Tác giả biên soạn</th>
                        <td>
                            <c:choose>
                                <c:when test="${not empty book.authors}">
                                    <c:forEach items="${book.authors}" var="a" varStatus="status">
                                        <c:if test="${status.index > 0}">, </c:if>
                                        <strong class="text-dark"><c:out value="${a.name}"/></strong>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise><span class="text-muted">Chưa có tác giả</span></c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <th style="background: #faf5ec; color: var(--wood-dark);"><i class="fa-regular fa-image me-1"></i> Đường dẫn ảnh bìa</th>
                        <td><c:out value="${book.coverImage}" default="Mặc định (book-default.svg)"/></td>
                    </tr>
                    <tr>
                        <th style="background: #faf5ec; color: var(--wood-dark);"><i class="fa-solid fa-align-left me-1"></i> Mô tả</th>
                        <td><c:out value="${book.description}" default="Chưa có mô tả"/></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
