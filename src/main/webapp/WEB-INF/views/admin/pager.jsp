<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:if test="${totalPages > 1}">
    <nav class="mt-4" aria-label="Phân trang quản trị">
        <ul class="pagination pagination-library">
            <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                <a class="page-link" href="?page=${currentPage - 1}">
                    <i class="fa-solid fa-chevron-left me-1"></i> Trước
                </a>
            </li>
            <c:forEach begin="1" end="${totalPages}" var="p">
                <li class="page-item ${p == currentPage ? 'active' : ''}">
                    <a class="page-link" href="?page=${p}">${p}</a>
                </li>
            </c:forEach>
            <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                <a class="page-link" href="?page=${currentPage + 1}">
                    Sau <i class="fa-solid fa-chevron-right ms-1"></i>
                </a>
            </li>
        </ul>
    </nav>
</c:if>
