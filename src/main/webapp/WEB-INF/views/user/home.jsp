<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<title>Trang chủ | BookStore</title>
<section class="hero-section py-4"><div class="container"><span class="text-primary fw-semibold">ĐỀ GIỮA KỲ - MÃ ĐỀ 01</span><h1 class="display-6 fw-bold mt-2">BookStore</h1><p class="lead mb-0">Khám phá kho sách và những nội dung được yêu thích.</p></div></section>
<section class="container py-5">
    <div class="d-flex justify-content-between align-items-center mb-4"><h2 class="h3 mb-0">Danh sách sách</h2><span class="text-muted">Trang <c:out value="${currentPage}"/> / <c:out value="${totalPages}"/></span></div>
    <div class="row g-4">
        <c:choose>
            <c:when test="${not empty books}">
                <c:forEach items="${books}" var="book">
                    <div class="col-sm-6 col-lg-4"><article class="card h-100 shadow-sm">
                        <c:choose><c:when test="${not empty book.coverImage}"><img class="card-img-top book-cover" src="<c:url value='/assets/images/'/><c:out value='${book.coverImage}'/>" alt="Bìa sách" onerror="this.onerror=null;this.src='<c:url value='/assets/images/book-default.svg'/>'"/></c:when><c:otherwise><img class="card-img-top book-cover" src="<c:url value='/assets/images/book-default.svg'/>" alt="Bìa sách mặc định"/></c:otherwise></c:choose>
                        <div class="card-body d-flex flex-column"><h3 class="h5"><a class="text-decoration-none" href="<c:url value='/book/detail'><c:param name='id' value='${book.id}'/></c:url>"><c:out value="${book.title}" default="Chưa có tiêu đề"/></a></h3>
                            <dl class="small text-muted mb-0"><dt>ISBN</dt><dd><c:out value="${book.isbn}" default="Chưa cập nhật"/></dd><dt>Tác giả</dt><dd><c:choose><c:when test="${not empty book.authors}"><c:forEach items="${book.authors}" var="author" varStatus="status"><c:if test="${status.index > 0}">, </c:if><c:out value="${author.name}"/></c:forEach></c:when><c:otherwise>Chưa cập nhật</c:otherwise></c:choose></dd><dt>Nhà xuất bản</dt><dd><c:out value="${book.publisher}" default="Chưa cập nhật"/></dd><dt>Ngày xuất bản</dt><dd><c:out value="${book.publishDate}" default="Chưa cập nhật"/></dd><dt>Số lượng</dt><dd><c:out value="${book.quantity}" default="0"/></dd><dt>Review</dt><dd><c:out value="${book.reviewCount}"/></dd></dl>
                        </div>
                    </article></div>
                </c:forEach>
            </c:when><c:otherwise><div class="col-12"><div class="alert alert-info">Chưa có dữ liệu sách.</div></div></c:otherwise>
        </c:choose>
    </div>
    <nav class="mt-5" aria-label="Phân trang"><ul class="pagination justify-content-center">
        <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}"><a class="page-link" href="<c:url value='/home'><c:param name='page' value='${currentPage - 1}'/></c:url>">Previous</a></li>
        <c:forEach begin="1" end="${totalPages}" var="pageNumber"><li class="page-item ${pageNumber == currentPage ? 'active' : ''}"><a class="page-link" href="<c:url value='/home'><c:param name='page' value='${pageNumber}'/></c:url>"><c:out value="${pageNumber}"/></a></li></c:forEach>
        <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}"><a class="page-link" href="<c:url value='/home'><c:param name='page' value='${currentPage + 1}'/></c:url>">Next</a></li>
    </ul></nav>
</section>
