<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<title>Quản lý sách | BookStore Admin</title>

<div class="container-fluid">
    <div class="page-header-wood">
        <div class="d-flex align-items-center gap-3">
            <i class="fa-solid fa-book text-warning fs-3"></i>
            <div>
                <h1 class="h2 mb-0">Quản Lý Sách</h1>
                <p class="text-muted mb-0 small">Danh mục các đầu sách hiện có trong cơ sở dữ liệu</p>
            </div>
        </div>
        <a class="btn btn-leather-primary" href="<c:url value='/admin/books/create'/>">
            <i class="fa-solid fa-plus me-1"></i> Thêm sách mới
        </a>
    </div>

    <c:if test="${not empty param.success}">
        <div class="alert alert-success alert-custom mb-3">
            <i class="fa-solid fa-circle-check fs-5"></i>
            <div>Thao tác với sách thành công.</div>
        </div>
    </c:if>

    <div class="parchment-card-box p-0 overflow-hidden">
        <div class="table-responsive">
            <table class="table table-parchment align-middle mb-0">
                <thead>
                    <tr>
                        <th style="width: 70px;">ID</th>
                        <th style="width: 130px;">ISBN</th>
                        <th>Tiêu đề sách</th>
                        <th>Tác giả</th>
                        <th>Nhà xuất bản</th>
                        <th style="width: 130px;">Giá bán</th>
                        <th style="width: 100px;">Tồn kho</th>
                        <th style="width: 180px;" class="text-center">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${books}" var="b">
                        <tr>
                            <td><strong style="color: var(--wood-dark);">#${b.id}</strong></td>
                            <td><code>${b.isbn}</code></td>
                            <td>
                                <strong><c:out value="${b.title}"/></strong>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty b.authors}">
                                        <c:forEach items="${b.authors}" var="a" varStatus="status">
                                            <c:if test="${status.index > 0}">, </c:if><c:out value="${a.name}"/>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise><span class="text-muted small">Chưa có</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td><c:out value="${b.publisher}"/></td>
                            <td class="fw-bold text-danger">
                                <fmt:formatNumber value="${b.price}" type="currency" currencyCode="VND" maxFractionDigits="0"/>
                            </td>
                            <td>
                                <span class="badge ${b.quantity > 0 ? 'bg-secondary' : 'bg-danger'}">${b.quantity} quyển</span>
                            </td>
                            <td class="text-center text-nowrap">
                                <a class="btn btn-sm btn-leather-outline" href="<c:url value='/admin/books/view'><c:param name='id' value='${b.id}'/></c:url>">
                                    <i class="fa-solid fa-eye me-1"></i> Xem
                                </a>
                                <a class="btn btn-sm btn-outline-warning" href="<c:url value='/admin/books/edit'><c:param name='id' value='${b.id}'/></c:url>">
                                    <i class="fa-solid fa-pen-to-square me-1"></i> Sửa
                                </a>
                                <form class="d-inline" method="post" action="<c:url value='/admin/books/delete'/>">
                                    <input type="hidden" name="id" value="${b.id}"/>
                                    <button class="btn btn-sm btn-outline-danger" onclick="return confirm('Bạn có chắc muốn xóa sách này?')">
                                        <i class="fa-solid fa-trash-can"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty books}">
                        <tr>
                            <td colspan="8" class="text-center text-muted py-4">Chưa có dữ liệu sách nào.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/admin/pager.jsp"/>
</div>
