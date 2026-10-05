<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<title>Sách</title>
<div class="container" style="max-width:800px">
    <h1>${empty book ? 'Thêm sách' : 'Sửa sách'}</h1>
    <c:if test="${not empty error}"><div class="alert alert-danger"><c:out value="${error}"/></div></c:if>
    <form method="post" action="<c:url value='${empty book ? "/admin/books/create" : "/admin/books/edit"}'/>">
        <c:if test="${not empty book}"><input type="hidden" name="id" value="${book.id}"/></c:if>
        <div class="row g-2">
            <div class="col-md-6"><label>ISBN</label><input class="form-control" name="isbn" type="number" required value="${book.isbn}"/></div>
            <div class="col-md-6"><label>Tiêu đề</label><input class="form-control" name="title" required maxlength="200" value="<c:out value='${book.title}'/>"/></div>
            <div class="col-md-6"><label>Nhà xuất bản</label><input class="form-control" name="publisher" value="<c:out value='${book.publisher}'/>"/></div>
            <div class="col-md-6"><label>Giá</label><input class="form-control" name="price" type="number" step="0.01" min="0" required value="${book.price}"/></div>
            <div class="col-md-6"><label>Ngày xuất bản</label><input class="form-control" name="publishDate" type="date" required value="${book.publishDate}"/></div>
            <div class="col-md-6"><label>Số lượng</label><input class="form-control" name="quantity" type="number" min="0" required value="${book.quantity}"/></div>
            <div class="col-12"><label>Đường dẫn ảnh bìa</label><input class="form-control" name="coverImage" value="<c:out value='${book.coverImage}'/>"/></div>
            <div class="col-12"><label>Mô tả</label><textarea class="form-control" name="description"><c:out value="${book.description}"/></textarea></div>
            <div class="col-12"><label>Tác giả</label>
                <c:forEach items="${authors}" var="a">
                    <c:set var="checked" value="false"/>
                    <c:forEach items="${selectedAuthorIds}" var="selectedId">
                        <c:if test="${selectedId == a.id}"><c:set var="checked" value="true"/></c:if>
                    </c:forEach>
                    <label class="me-3"><input type="checkbox" name="authorIds" value="${a.id}"<c:if test="${checked}"> checked="checked"</c:if>/> <c:out value="${a.name}"/></label>
                </c:forEach>
            </div>
        </div>
        <button class="btn btn-primary mt-3">Lưu</button> <a href="<c:url value='/admin/books'/>">Hủy</a>
    </form>
</div>
