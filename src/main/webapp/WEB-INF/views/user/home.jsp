<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<title>Trang chủ | BookStore</title>

<!-- HERO SECTION: BIG 3D OPEN BOOK WITH ANIMATED FLUTTERING FLYING PAGES (HÌNH SỐ 3) -->
<section class="hero-library">
    <div class="container">
        <div class="row align-items-center g-4">
            <div class="col-lg-7">
                <span class="hero-badge">
                    <i class="fa-solid fa-graduation-cap"></i> ĐỀ GIỮA KỲ - MÃ ĐỀ 01
                </span>
                <h1 class="hero-title">
                    Không Gian Sách <br>
                    <span class="highlight-wood">Tri Thức & Chiêm Nghiệm</span>
                </h1>
                <p class="hero-subtitle">
                    Khám phá kho tàng tác phẩm văn học và tri thức kinh điển, nơi mỗi cuốn sách là một hành trình mở ra chân trời mới cho độc giả.
                </p>
                <div class="hero-features">
                    <div class="hero-feature-item">
                        <i class="fa-solid fa-circle-check"></i>
                        <span>Sách thật trên kệ gỗ</span>
                    </div>
                    <div class="hero-feature-item">
                        <i class="fa-solid fa-truck-fast"></i>
                        <span>Giao hàng COD an toàn</span>
                    </div>
                    <div class="hero-feature-item">
                        <i class="fa-solid fa-shield-heart"></i>
                        <span>Đảm bảo chất lượng xuất bản</span>
                    </div>
                </div>
            </div>

            <div class="col-lg-5">
                <!-- 3D Open Book Stage with Continuous Floating Pages -->
                <div class="book-3d-stage" aria-label="Hình minh họa cuốn sách mở với trang sách đang bay">
                    <!-- Base 3D Open Book -->
                    <div class="open-book-base">
                        <div class="book-cover-underlay"></div>
                        <div class="book-pages-spread">
                            <div class="page-left">
                                <div class="page-lines">
                                    <div class="line-placeholder short"></div>
                                    <div class="line-placeholder medium"></div>
                                    <div class="line-placeholder long"></div>
                                    <div class="line-placeholder medium"></div>
                                    <div class="line-placeholder short"></div>
                                </div>
                            </div>
                            <div class="book-spine-crease"></div>
                            <div class="page-right">
                                <div class="page-lines">
                                    <div class="line-placeholder medium"></div>
                                    <div class="line-placeholder long"></div>
                                    <div class="line-placeholder short"></div>
                                    <div class="line-placeholder long"></div>
                                    <div class="line-placeholder medium"></div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Floating Flying Pages Fluttering upward into the air (Chuyển động liên tục thật) -->
                    <div class="flying-page flying-page-1">
                        <div class="fp-lines">
                            <div class="fp-line" style="width: 70%;"></div>
                            <div class="fp-line" style="width: 90%;"></div>
                            <div class="fp-line" style="width: 50%;"></div>
                        </div>
                    </div>

                    <div class="flying-page flying-page-2">
                        <div class="fp-lines">
                            <div class="fp-line" style="width: 85%;"></div>
                            <div class="fp-line" style="width: 60%;"></div>
                            <div class="fp-line" style="width: 75%;"></div>
                        </div>
                    </div>

                    <div class="flying-page flying-page-3">
                        <div class="fp-lines">
                            <div class="fp-line" style="width: 65%;"></div>
                            <div class="fp-line" style="width: 80%;"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- BOOKSHELF SECTION: REAL WOODEN SHELVES WITH BOOKS STANDING UPRIGHT (HÌNH SỐ 4) -->
<section class="container bookshelf-section">
    <!-- Header of Bookshelf -->
    <div class="bookshelf-header">
        <div class="d-flex align-items-center gap-2">
            <i class="fa-solid fa-book text-warning fs-4"></i>
            <h2>Kệ Sách Tuyển Chọn</h2>
        </div>
        <div class="text-muted fw-semibold">
            <i class="fa-solid fa-layer-group me-1"></i>
            Trang <c:out value="${currentPage}"/> / <c:out value="${totalPages}"/> (Tối đa 6 sách/trang)
        </div>
    </div>

    <!-- Shelf 1 (First 3 books) and Shelf 2 (Next 3 books) -->
    <c:choose>
        <c:when test="${not empty books}">
            <!-- Shelf Row 1 -->
            <div class="bookshelf-unit">
                <div class="row g-4 align-items-stretch">
                    <c:forEach items="${books}" var="book" varStatus="loop">
                        <c:if test="${loop.index < 3}">
                            <div class="col-12 col-md-6 col-lg-4 d-flex">
                                <article class="book-standing-card w-100">
                                    <div class="book-cover-wrapper">
                                        <c:choose>
                                            <c:when test="${not empty book.coverImage}">
                                                <img class="book-cover-img"
                                                     src="<c:url value='/assets/images/'/><c:out value='${book.coverImage}'/>"
                                                     alt="Bìa sách <c:out value='${book.title}'/>"
                                                     onerror="this.onerror=null;this.src='<c:url value='/assets/images/book-default.svg'/>'"/>
                                            </c:when>
                                            <c:otherwise>
                                                <img class="book-cover-img"
                                                     src="<c:url value='/assets/images/book-default.svg'/>"
                                                     alt="Bìa sách mặc định"/>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="book-card-body">
                                        <h3 class="h5 mb-2">
                                            <a class="book-title-link" href="<c:url value='/book/detail'><c:param name='id' value='${book.id}'/></c:url>" title="<c:out value='${book.title}'/>">
                                                <c:out value="${book.title}" default="Chưa có tiêu đề"/>
                                            </a>
                                        </h3>
                                        <c:if test="${not empty sessionScope.currentUser and not sessionScope.currentUser.admin}">
                                            <form method="post" action="<c:url value='/cart/add'/>" class="mb-3">
                                                <input type="hidden" name="bookId" value="${book.id}"/>
                                                <input type="hidden" name="quantity" value="1"/>
                                                <button class="btn btn-sm btn-leather-primary w-100" type="submit" ${book.quantity == null or book.quantity < 1 ? 'disabled' : ''}>
                                                    <i class="fa-solid fa-cart-plus"></i>
                                                    ${book.quantity == null or book.quantity < 1 ? 'Hết hàng' : 'Thêm vào giỏ'}
                                                </button>
                                            </form>
                                        </c:if>
                                        <dl class="book-meta-grid mt-auto">
                                            <dt><i class="fa-solid fa-barcode text-muted me-1"></i>ISBN</dt>
                                            <dd><c:out value="${book.isbn}" default="Chưa cập nhật"/></dd>
                                            <dt><i class="fa-solid fa-feather-pointed text-muted me-1"></i>Tác giả</dt>
                                            <dd>
                                                <c:choose>
                                                    <c:when test="${not empty book.authors}">
                                                        <c:forEach items="${book.authors}" var="author" varStatus="status">
                                                            <c:if test="${status.index > 0}">, </c:if><c:out value="${author.name}"/>
                                                        </c:forEach>
                                                    </c:when>
                                                    <c:otherwise>Chưa cập nhật</c:otherwise>
                                                </c:choose>
                                            </dd>
                                            <dt><i class="fa-solid fa-building text-muted me-1"></i>NXB</dt>
                                            <dd><c:out value="${book.publisher}" default="Chưa cập nhật"/></dd>
                                            <dt><i class="fa-solid fa-calendar-days text-muted me-1"></i>Ngày XB</dt>
                                            <dd><c:out value="${book.publishDate}" default="Chưa cập nhật"/></dd>
                                            <dt><i class="fa-solid fa-boxes-stacked text-muted me-1"></i>Tồn kho</dt>
                                            <dd><strong><c:out value="${book.quantity}" default="0"/></strong> quyển</dd>
                                            <dt><i class="fa-solid fa-star text-warning me-1"></i>Review</dt>
                                            <dd><strong><c:out value="${book.reviewCount}"/></strong> đánh giá</dd>
                                        </dl>
                                    </div>
                                </article>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
                <!-- 3D Wooden Shelf Plank Under Row 1 -->
                <div class="wood-shelf-plank">
                    <div class="shelf-top-face"></div>
                    <div class="shelf-front-fascia">
                        <div class="shelf-bracket left"></div>
                        <div class="shelf-bracket right"></div>
                    </div>
                </div>
            </div>

            <!-- Shelf Row 2 (if there are more than 3 books) -->
            <c:if test="${books.size() > 3}">
                <div class="bookshelf-unit">
                    <div class="row g-4 align-items-stretch">
                        <c:forEach items="${books}" var="book" varStatus="loop">
                            <c:if test="${loop.index >= 3}">
                                <div class="col-12 col-md-6 col-lg-4 d-flex">
                                    <article class="book-standing-card w-100">
                                        <div class="book-cover-wrapper">
                                            <c:choose>
                                                <c:when test="${not empty book.coverImage}">
                                                    <img class="book-cover-img"
                                                         src="<c:url value='/assets/images/'/><c:out value='${book.coverImage}'/>"
                                                         alt="Bìa sách <c:out value='${book.title}'/>"
                                                         onerror="this.onerror=null;this.src='<c:url value='/assets/images/book-default.svg'/>'"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <img class="book-cover-img"
                                                         src="<c:url value='/assets/images/book-default.svg'/>"
                                                         alt="Bìa sách mặc định"/>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="book-card-body">
                                            <h3 class="h5 mb-2">
                                                <a class="book-title-link" href="<c:url value='/book/detail'><c:param name='id' value='${book.id}'/></c:url>" title="<c:out value='${book.title}'/>">
                                                    <c:out value="${book.title}" default="Chưa có tiêu đề"/>
                                                </a>
                                            </h3>
                                            <c:if test="${not empty sessionScope.currentUser and not sessionScope.currentUser.admin}">
                                                <form method="post" action="<c:url value='/cart/add'/>" class="mb-3">
                                                    <input type="hidden" name="bookId" value="${book.id}"/>
                                                    <input type="hidden" name="quantity" value="1"/>
                                                    <button class="btn btn-sm btn-leather-primary w-100" type="submit" ${book.quantity == null or book.quantity < 1 ? 'disabled' : ''}>
                                                        <i class="fa-solid fa-cart-plus"></i>
                                                        ${book.quantity == null or book.quantity < 1 ? 'Hết hàng' : 'Thêm vào giỏ'}
                                                    </button>
                                                </form>
                                            </c:if>
                                            <dl class="book-meta-grid mt-auto">
                                                <dt><i class="fa-solid fa-barcode text-muted me-1"></i>ISBN</dt>
                                                <dd><c:out value="${book.isbn}" default="Chưa cập nhật"/></dd>
                                                <dt><i class="fa-solid fa-feather-pointed text-muted me-1"></i>Tác giả</dt>
                                                <dd>
                                                    <c:choose>
                                                        <c:when test="${not empty book.authors}">
                                                            <c:forEach items="${book.authors}" var="author" varStatus="status">
                                                                <c:if test="${status.index > 0}">, </c:if><c:out value="${author.name}"/>
                                                            </c:forEach>
                                                        </c:when>
                                                        <c:otherwise>Chưa cập nhật</c:otherwise>
                                                    </c:choose>
                                                </dd>
                                                <dt><i class="fa-solid fa-building text-muted me-1"></i>NXB</dt>
                                                <dd><c:out value="${book.publisher}" default="Chưa cập nhật"/></dd>
                                                <dt><i class="fa-solid fa-calendar-days text-muted me-1"></i>Ngày XB</dt>
                                                <dd><c:out value="${book.publishDate}" default="Chưa cập nhật"/></dd>
                                                <dt><i class="fa-solid fa-boxes-stacked text-muted me-1"></i>Tồn kho</dt>
                                                <dd><strong><c:out value="${book.quantity}" default="0"/></strong> quyển</dd>
                                                <dt><i class="fa-solid fa-star text-warning me-1"></i>Review</dt>
                                                <dd><strong><c:out value="${book.reviewCount}"/></strong> đánh giá</dd>
                                            </dl>
                                        </div>
                                    </article>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                    <!-- 3D Wooden Shelf Plank Under Row 2 -->
                    <div class="wood-shelf-plank">
                        <div class="shelf-top-face"></div>
                        <div class="shelf-front-fascia">
                            <div class="shelf-bracket left"></div>
                            <div class="shelf-bracket right"></div>
                        </div>
                    </div>
                </div>
            </c:if>
        </c:when>
        <c:otherwise>
            <div class="parchment-card-box text-center py-5">
                <i class="fa-solid fa-book-open text-muted fs-1 mb-3"></i>
                <h4 class="text-muted">Chưa có dữ liệu sách trên kệ.</h4>
            </div>
        </c:otherwise>
    </c:choose>

    <!-- Pagination for User Home (6 books per page rule preserved) -->
    <nav class="mt-5" aria-label="Phân trang sách">
        <ul class="pagination pagination-library justify-content-center">
            <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                <a class="page-link" href="<c:url value='/home'><c:param name='page' value='${currentPage - 1}'/></c:url>">
                    <i class="fa-solid fa-chevron-left me-1"></i> Previous
                </a>
            </li>
            <c:forEach begin="1" end="${totalPages}" var="pageNumber">
                <li class="page-item ${pageNumber == currentPage ? 'active' : ''}">
                    <a class="page-link" href="<c:url value='/home'><c:param name='page' value='${pageNumber}'/></c:url>">
                        <c:out value="${pageNumber}"/>
                    </a>
                </li>
            </c:forEach>
            <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                <a class="page-link" href="<c:url value='/home'><c:param name='page' value='${currentPage + 1}'/></c:url>">
                    Next <i class="fa-solid fa-chevron-right ms-1"></i>
                </a>
            </li>
        </ul>
    </nav>
</section>
