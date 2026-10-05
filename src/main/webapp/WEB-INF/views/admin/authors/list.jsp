<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<title>Quản lý tác giả | BookStore Admin</title>

<div class="container-fluid">
    <div class="page-header-wood">
        <div class="d-flex align-items-center gap-3">
            <i class="fa-solid fa-feather-pointed text-warning fs-3"></i>
            <div>
                <h1 class="h2 mb-0">Quản Lý Tác Giả</h1>
                <p class="text-muted mb-0 small">Danh mục các tác giả và thông tin tiểu sử</p>
            </div>
        </div>
        <a class="btn btn-leather-primary" href="<c:url value='/admin/authors/create'/>">
            <i class="fa-solid fa-plus me-1"></i> Thêm tác giả mới
        </a>
    </div>

    <c:if test="${not empty param.success}">
        <div class="alert alert-success alert-custom mb-3">
            <i class="fa-solid fa-circle-check fs-5"></i>
            <div>Thao tác với tác giả thành công.</div>
        </div>
    </c:if>
    <c:if test="${not empty param.error}">
        <div class="alert alert-danger alert-custom mb-3">
            <i class="fa-solid fa-triangle-exclamation fs-5"></i>
            <div><c:out value="${param.error}"/></div>
        </div>
    </c:if>

    <div class="parchment-card-box p-0 overflow-hidden">
        <div class="table-responsive">
            <table class="table table-parchment align-middle mb-0">
                <thead>
                    <tr>
                        <th style="width: 80px;">ID</th>
                        <th>Họ và tên tác giả</th>
                        <th style="width: 220px;">Ngày sinh</th>
                        <th style="width: 200px;" class="text-center">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${authors}" var="a">
                        <tr>
                            <td><strong style="color: var(--wood-dark);">#${a.id}</strong></td>
                            <td>
                                <strong><c:out value="${a.name}"/></strong>
                            </td>
                            <td>
                                <span><i class="fa-regular fa-calendar text-muted me-1"></i>${a.dateOfBirth}</span>
                            </td>
                            <td class="text-center text-nowrap">
                                <a class="btn btn-sm btn-leather-outline" href="<c:url value='/admin/authors/view'><c:param name='id' value='${a.id}'/></c:url>">
                                    <i class="fa-solid fa-eye me-1"></i> Xem
                                </a>
                                <a class="btn btn-sm btn-outline-warning" href="<c:url value='/admin/authors/edit'><c:param name='id' value='${a.id}'/></c:url>">
                                    <i class="fa-solid fa-pen-to-square me-1"></i> Sửa
                                </a>
                                <form class="d-inline" method="post" action="<c:url value='/admin/authors/delete'/>">
                                    <input type="hidden" name="id" value="${a.id}"/>
                                    <button class="btn btn-sm btn-outline-danger" onclick="return confirm('Bạn có chắc muốn xóa tác giả này?')">
                                        <i class="fa-solid fa-trash-can"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty authors}">
                        <tr>
                            <td colspan="4" class="text-center text-muted py-4">Chưa có dữ liệu tác giả nào.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/admin/pager.jsp"/>
</div>
