<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<title>${empty author ? 'Thêm tác giả' : 'Sửa tác giả'} | BookStore Admin</title>

<div class="container" style="max-width: 680px;">
    <div class="page-header-wood">
        <div class="d-flex align-items-center gap-3">
            <i class="fa-solid fa-feather text-warning fs-3"></i>
            <div>
                <h1 class="h2 mb-0">${empty author ? 'Thêm Tác Giả Mới' : 'Chỉnh Sửa Tác Giả'}</h1>
                <p class="text-muted mb-0 small">Điền thông tin định danh và tiểu sử tác giả</p>
            </div>
        </div>
        <a class="btn btn-sm btn-leather-outline" href="<c:url value='/admin/authors'/>">
            <i class="fa-solid fa-arrow-left me-1"></i> Quay lại
        </a>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-custom mb-4">
            <i class="fa-solid fa-triangle-exclamation fs-5"></i>
            <div><c:out value="${error}"/></div>
        </div>
    </c:if>

    <div class="parchment-card-box">
        <form method="post" action="<c:url value='${empty author ? "/admin/authors/create" : "/admin/authors/edit"}'/>">
            <c:if test="${not empty author}">
                <input type="hidden" name="id" value="${author.id}"/>
            </c:if>

            <div class="mb-3">
                <label class="form-label fw-semibold" for="name">Họ và tên tác giả</label>
                <input class="form-control" id="name" name="name" required maxlength="100" placeholder="Ví dụ: Nguyễn Nhật Ánh" value="<c:out value='${author.name}'/>"/>
            </div>

            <div class="mb-4">
                <label class="form-label fw-semibold" for="dateOfBirth">Ngày sinh</label>
                <input class="form-control" id="dateOfBirth" type="date" name="dateOfBirth" required value="${author.dateOfBirth}"/>
            </div>

            <div class="d-flex gap-3 align-items-center pt-2 border-top">
                <button class="btn btn-leather-primary px-4" type="submit">
                    <i class="fa-solid fa-floppy-disk me-1"></i> Lưu thông tin tác giả
                </button>
                <a class="btn btn-outline-secondary" href="<c:url value='/admin/authors'/>">Hủy bỏ</a>
            </div>
        </form>
    </div>
</div>
