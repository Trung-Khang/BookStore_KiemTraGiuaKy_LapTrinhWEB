<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<title><c:out value="${book.title}" default="Chi tiết sách"/> | BookStore</title>

<section class="container py-5">
    <div class="mb-3">
        <a href="<c:url value='/home'/>" class="btn btn-sm btn-leather-outline">
            <i class="fa-solid fa-arrow-left me-1"></i> Quay lại kệ sách
        </a>
    </div>

    <c:if test="${param.review == 'success'}">
        <div class="alert alert-success alert-custom mb-4">
            <i class="fa-solid fa-circle-check fs-5"></i>
            <span>Đánh giá của bạn đã được ghi nhận thành công.</span>
        </div>
    </c:if>
    <c:if test="${param.review == 'error'}">
        <div class="alert alert-danger alert-custom mb-4">
            <i class="fa-solid fa-triangle-exclamation fs-5"></i>
            <span>Dữ liệu đánh giá không hợp lệ. Vui lòng thử lại.</span>
        </div>
    </c:if>

    <!-- Main Book Detail Parchment Card -->
    <div class="parchment-card-box mb-4">
        <div class="row g-4">
            <div class="col-md-4 col-lg-3 text-center">
                <div class="book-cover-wrapper" style="height: 340px; border-radius: 4px; box-shadow: -5px 10px 20px rgba(25,12,6,0.35);">
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
            </div>

            <div class="col-md-8 col-lg-9">
                <h1 class="h2 mb-3" style="color: var(--wood-dark);">
                    <c:out value="${book.title}"/>
                </h1>

                <div class="table-responsive mb-4">
                    <table class="table table-sm align-middle" style="background: transparent;">
                        <tbody>
                            <tr>
                                <th style="width: 140px; color: #553e31;"><i class="fa-solid fa-barcode text-muted me-1"></i> Mã ISBN</th>
                                <td><c:out value="${book.isbn}" default="Chưa cập nhật"/></td>
                            </tr>
                            <tr>
                                <th style="color: #553e31;"><i class="fa-solid fa-feather-pointed text-muted me-1"></i> Tác giả</th>
                                <td>
                                    <strong>
                                        <c:choose>
                                            <c:when test="${not empty book.authors}">
                                                <c:forEach items="${book.authors}" var="author" varStatus="status">
                                                    <c:if test="${status.index > 0}">, </c:if><c:out value="${author.name}"/>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>Chưa cập nhật</c:otherwise>
                                        </c:choose>
                                    </strong>
                                </td>
                            </tr>
                            <tr>
                                <th style="color: #553e31;"><i class="fa-solid fa-building text-muted me-1"></i> Nhà xuất bản</th>
                                <td><c:out value="${book.publisher}" default="Chưa cập nhật"/></td>
                            </tr>
                            <tr>
                                <th style="color: #553e31;"><i class="fa-solid fa-calendar-days text-muted me-1"></i> Ngày xuất bản</th>
                                <td><c:out value="${book.publishDate}" default="Chưa cập nhật"/></td>
                            </tr>
                            <tr>
                                <th style="color: #553e31;"><i class="fa-solid fa-boxes-stacked text-muted me-1"></i> Tồn kho</th>
                                <td><span class="badge bg-secondary"><c:out value="${book.quantity}" default="0"/> quyển</span></td>
                            </tr>
                            <tr>
                                <th style="color: #553e31;"><i class="fa-solid fa-comments text-muted me-1"></i> Tổng số review</th>
                                <td><span class="badge text-bg-warning"><c:out value="${fn:length(reviews)}"/> đánh giá</span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <c:if test="${not empty sessionScope.currentUser and not sessionScope.currentUser.admin}">
                    <form method="post" action="<c:url value='/cart/add'/>" class="d-inline-flex gap-2 align-items-center">
                        <input type="hidden" name="bookId" value="${book.id}"/>
                        <input type="hidden" name="quantity" value="1"/>
                        <button class="btn btn-leather-primary btn-lg" type="submit" ${book.quantity == null or book.quantity < 1 ? 'disabled' : ''}>
                            <i class="fa-solid fa-cart-plus me-1"></i>
                            ${book.quantity == null or book.quantity < 1 ? 'Hết hàng' : 'Thêm vào giỏ hàng'}
                        </button>
                    </form>
                </c:if>
            </div>
        </div>
    </div>

    <!-- Reviews Section -->
    <div class="row g-4">
        <div class="col-lg-7">
            <div class="parchment-card-box">
                <div class="d-flex align-items-center gap-2 mb-3 pb-2 border-bottom">
                    <i class="fa-solid fa-star text-warning fs-5"></i>
                    <h2 class="h4 mb-0" style="color: var(--wood-dark);">Độc Giả Đánh Giá (<c:out value="${fn:length(reviews)}"/>)</h2>
                </div>

                <c:choose>
                    <c:when test="${not empty reviews}">
                        <div class="d-flex flex-column gap-3">
                            <c:forEach items="${reviews}" var="review">
                                <article class="p-3" style="background: var(--parchment); border: 1px solid var(--parchment-border); border-radius: var(--radius-sm);">
                                    <div class="d-flex justify-content-between align-items-center mb-1">
                                        <div class="d-flex align-items-center gap-2">
                                            <i class="fa-solid fa-circle-user text-muted"></i>
                                            <strong><c:out value="${review.user.fullname}" default="${review.user.email}"/></strong>
                                        </div>
                                        <div class="text-warning fw-bold">
                                            <c:forEach begin="1" end="${review.score}"><i class="fa-solid fa-star"></i></c:forEach>
                                            <c:forEach begin="${review.score + 1}" end="5"><i class="fa-regular fa-star text-muted"></i></c:forEach>
                                            <span class="ms-1 text-dark small">(<c:out value="${review.score}"/>/5)</span>
                                        </div>
                                    </div>
                                    <p class="mb-0 text-muted" style="color: var(--text-main) !important; font-size: 0.95rem;">
                                        <c:out value="${review.reviewText}"/>
                                    </p>
                                </article>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-4 text-muted">
                            <i class="fa-regular fa-comment-dots fs-3 mb-2 d-block"></i>
                            Chưa có nhận xét nào cho cuốn sách này. Hãy là người đầu tiên chia sẻ cảm nghĩ!
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Add Review Form -->
        <div class="col-lg-5">
            <div class="parchment-card-box">
                <div class="d-flex align-items-center gap-2 mb-3 pb-2 border-bottom">
                    <i class="fa-solid fa-pen-nib text-warning fs-5"></i>
                    <h2 class="h4 mb-0" style="color: var(--wood-dark);">Viết Đánh Giá</h2>
                </div>

                <c:choose>
                    <c:when test="${not empty sessionScope.currentUser}">
                        <form method="post" action="<c:url value='/book/review'/>">
                            <input type="hidden" name="bookId" value="<c:out value='${book.id}'/>"/>

                            <div class="mb-3">
                                <label class="form-label fw-semibold" for="rating">Điểm đánh giá (Sao)</label>
                                <select class="form-select" id="rating" name="rating" required>
                                    <option value="">Chọn điểm số</option>
                                    <c:forEach begin="1" end="5" var="score">
                                        <option value="${score}"><c:out value="${score}"/> sao / 5</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-semibold" for="reviewText">Nội dung nhận xét</label>
                                <textarea class="form-control" id="reviewText" name="reviewText" rows="4" placeholder="Chia sẻ cảm nhận của bạn về cuốn sách này..." required></textarea>
                            </div>

                            <button class="btn btn-leather-primary w-100" type="submit">
                                <i class="fa-solid fa-paper-plane me-1"></i> Gửi nhận xé
                            </button>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <div class="p-3 text-center" style="background: var(--parchment); border: 1px dashed var(--parchment-border); border-radius: var(--radius-sm);">
                            <p class="mb-2 text-muted">Vui lòng đăng nhập để gửi đánh giá và cảm nghĩ của bạn.</p>
                            <a class="btn btn-sm btn-leather-outline" href="<c:url value='/login'/>">
                                <i class="fa-solid fa-right-to-bracket me-1"></i> Đăng nhập ngay
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</section>
