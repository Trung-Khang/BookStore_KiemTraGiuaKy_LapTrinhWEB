<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<title>Chi tiết tác giả | BookStore Admin</title>

<div class="container" style="max-width: 680px;">
    <div class="page-header-wood">
        <div class="d-flex align-items-center gap-3">
            <i class="fa-solid fa-feather-pointed text-warning fs-3"></i>
            <div>
                <h1 class="h2 mb-0">Hồ Sơ Tác Giả</h1>
                <p class="text-muted mb-0 small">Thông tin định danh tác giả trong cơ sở dữ liệu</p>
            </div>
        </div>
        <div class="d-flex gap-2">
            <a class="btn btn-sm btn-leather-primary" href="<c:url value='/admin/authors/edit'><c:param name='id' value='${author.id}'/></c:url>">
                <i class="fa-solid fa-pen-to-square me-1"></i> Chỉnh sửa
            </a>
            <a class="btn btn-sm btn-leather-outline" href="<c:url value='/admin/authors'/>">
                <i class="fa-solid fa-arrow-left me-1"></i> Quay lại
            </a>
        </div>
    </div>

    <div class="parchment-card-box">
        <h2 class="h3 mb-3" style="color: var(--wood-dark);"><c:out value="${author.name}"/></h2>

        <div class="table-responsive">
            <table class="table table-bordered align-middle mb-0">
                <tbody>
                    <tr>
                        <th style="width: 160px; background: #faf5ec; color: var(--wood-dark);"><i class="fa-solid fa-hashtag me-1"></i> ID Tác giả</th>
                        <td>${author.id}</td>
                    </tr>
                    <tr>
                        <th style="background: #faf5ec; color: var(--wood-dark);"><i class="fa-solid fa-user me-1"></i> Họ và tên</th>
                        <td><strong><c:out value="${author.name}"/></strong></td>
                    </tr>
                    <tr>
                        <th style="background: #faf5ec; color: var(--wood-dark);"><i class="fa-regular fa-calendar me-1"></i> Ngày sinh</th>
                        <td>${author.dateOfBirth}</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
