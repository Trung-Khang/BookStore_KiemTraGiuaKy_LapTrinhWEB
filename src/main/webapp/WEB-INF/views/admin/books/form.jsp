<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<title>${empty book ? 'Thêm sách mới' : 'Chỉnh sửa sách'} | BookStore Admin</title>

<div class="container" style="max-width: 860px;">
    <div class="page-header-wood">
        <div class="d-flex align-items-center gap-3">
            <i class="fa-solid fa-book-medical text-warning fs-3"></i>
            <div>
                <h1 class="h2 mb-0">${empty book ? 'Thêm Sách Mới' : 'Chỉnh Sửa Thông Tin Sách'}</h1>
                <p class="text-muted mb-0 small">Điền các thông tin xuất bản và tác giả tương ứng</p>
            </div>
        </div>
        <a class="btn btn-sm btn-leather-outline" href="<c:url value='/admin/books'/>">
            <i class="fa-solid fa-arrow-left me-1"></i> Quay lại danh sách
        </a>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-custom mb-4">
            <i class="fa-solid fa-triangle-exclamation fs-5"></i>
            <div><c:out value="${error}"/></div>
        </div>
    </c:if>

    <div class="parchment-card-box">
        <form method="post" action="<c:url value='${empty book ? "/admin/books/create" : "/admin/books/edit"}'/>">
            <c:if test="${not empty book}">
                <input type="hidden" name="id" value="${book.id}"/>
            </c:if>

            <div class="row g-3">
                <div class="col-md-6">
                    <label class="form-label fw-semibold" for="isbn">Mã ISBN</label>
                    <input class="form-control" id="isbn" name="isbn" type="number" required value="${book.isbn}" placeholder="Ví dụ: 10000001"/>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-semibold" for="title">Tiêu đề sách</label>
                    <input class="form-control" id="title" name="title" required maxlength="200" value="<c:out value='${book.title}'/>" placeholder="Tên tác phẩm"/>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-semibold" for="publisher">Nhà xuất bản</label>
                    <input class="form-control" id="publisher" name="publisher" value="<c:out value='${book.publisher}'/>" placeholder="Ví dụ: Nhà xuất bản Trẻ"/>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-semibold" for="price">Giá bán (VNĐ)</label>
                    <input class="form-control" id="price" name="price" type="number" step="0.01" min="0" required value="${book.price}" placeholder="Ví dụ: 85000"/>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-semibold" for="publishDate">Ngày xuất bản</label>
                    <input class="form-control" id="publishDate" name="publishDate" type="date" required value="${book.publishDate}"/>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-semibold" for="quantity">Số lượng tồn kho</label>
                    <input class="form-control" id="quantity" name="quantity" type="number" min="0" required value="${book.quantity}" placeholder="Số lượng quyển"/>
                </div>
                <div class="col-12">
                    <label class="form-label fw-semibold" for="coverImage">Tên file ảnh bìa (trong thư mục assets/images/)</label>
                    <input class="form-control" id="coverImage" name="coverImage" value="<c:out value='${book.coverImage}'/>" placeholder="Ví dụ: mat-biec.jpg hoặc để trống dùng bìa mặc định"/>
                </div>
                <div class="col-12">
                    <label class="form-label fw-semibold" for="description">Mô tả tóm tắt nội dung</label>
                    <textarea class="form-control" id="description" name="description" rows="4" placeholder="Giới thiệu nội dung sơ lược của sách..."><c:out value="${book.description}"/></textarea>
                </div>
                <div class="col-12">
                    <label class="form-label fw-semibold d-block">Tác giả biên soạn</label>
                    <div class="p-3" style="background: var(--parchment); border: 1px solid var(--parchment-border); border-radius: var(--radius-sm); max-height: 200px; overflow-y: auto;">
                        <c:choose>
                            <c:when test="${not empty authors}">
                                <div class="row g-2">
                                    <c:forEach items="${authors}" var="a">
                                        <c:set var="checked" value="false"/>
                                        <c:forEach items="${selectedAuthorIds}" var="selectedId">
                                            <c:if test="${selectedId == a.id}"><c:set var="checked" value="true"/></c:if>
                                        </c:forEach>
                                        <div class="col-sm-6 col-md-4">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" id="author_${a.id}" name="authorIds" value="${a.id}" <c:if test="${checked}"> checked="checked"</c:if>/>
                                                <label class="form-check-label" for="author_${a.id}">
                                                    <c:out value="${a.name}"/>
                                                </label>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <span class="text-muted small">Chưa có tác giả nào trong hệ thống. Hãy thêm tác giả trước.</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <div class="d-flex gap-3 align-items-center mt-4 pt-3 border-top">
                <button class="btn btn-leather-primary px-4" type="submit">
                    <i class="fa-solid fa-floppy-disk me-1"></i> Lưu thông tin sách
                </button>
                <a class="btn btn-outline-secondary" href="<c:url value='/admin/books'/>">Hủy bỏ</a>
            </div>
        </form>
    </div>
</div>
