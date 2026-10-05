<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<title>Dashboard | BookStore Admin</title>

<div class="container-fluid">
    <div class="page-header-wood">
        <div class="d-flex align-items-center gap-3">
            <i class="fa-solid fa-gauge-high text-warning fs-3"></i>
            <div>
                <h1 class="h2 mb-0">Bảng Điều Khiển Quản Trị</h1>
                <p class="text-muted mb-0 small">Hệ thống quản lý dữ liệu sách, tác giả và đơn hàng giao dịch</p>
            </div>
        </div>
        <div>
            <span class="badge text-bg-dark px-3 py-2 border border-secondary">
                <i class="fa-solid fa-shield text-warning me-1"></i> Phân quyền: Administrator
            </span>
        </div>
    </div>

    <!-- Quick Navigation Cards Grid -->
    <div class="row g-4 mb-4">
        <!-- Books Card -->
        <div class="col-md-4">
            <div class="parchment-card-box h-100 d-flex flex-column" style="border-top: 4px solid var(--leather-accent);">
                <div class="d-flex align-items-center justify-content-between mb-3">
                    <h2 class="h4 mb-0" style="color: var(--wood-dark);">Quản Lý Sách</h2>
                    <div style="width: 44px; height: 44px; background: #fef3c7; border-radius: var(--radius-sm); display: flex; align-items: center; justify-content: center;">
                        <i class="fa-solid fa-book text-warning fs-4"></i>
                    </div>
                </div>
                <p class="text-muted flex-grow-1">Xem danh mục tác phẩm, cập nhật thông tin ISBN, giá bán, số lượng tồn kho và ảnh bìa.</p>
                <div class="d-flex gap-2 mt-3">
                    <a class="btn btn-leather-primary flex-grow-1" href="<c:url value='/admin/books'/>">
                        <i class="fa-solid fa-list me-1"></i> Danh sách sách
                    </a>
                    <a class="btn btn-leather-outline" href="<c:url value='/admin/books/create'/>" title="Thêm sách mới">
                        <i class="fa-solid fa-plus"></i>
                    </a>
                </div>
            </div>
        </div>

        <!-- Authors Card -->
        <div class="col-md-4">
            <div class="parchment-card-box h-100 d-flex flex-column" style="border-top: 4px solid var(--wood-medium);">
                <div class="d-flex align-items-center justify-content-between mb-3">
                    <h2 class="h4 mb-0" style="color: var(--wood-dark);">Quản Lý Tác Giả</h2>
                    <div style="width: 44px; height: 44px; background: #e0e7ff; border-radius: var(--radius-sm); display: flex; align-items: center; justify-content: center;">
                        <i class="fa-solid fa-feather-pointed text-primary fs-4"></i>
                    </div>
                </div>
                <p class="text-muted flex-grow-1">Quản lý hồ sơ các tác giả, ngày sinh và liên kết tác quyền với các đầu sách trong kho.</p>
                <div class="d-flex gap-2 mt-3">
                    <a class="btn btn-leather-primary flex-grow-1" href="<c:url value='/admin/authors'/>">
                        <i class="fa-solid fa-list me-1"></i> Danh sách tác giả
                    </a>
                    <a class="btn btn-leather-outline" href="<c:url value='/admin/authors/create'/>" title="Thêm tác giả mới">
                        <i class="fa-solid fa-plus"></i>
                    </a>
                </div>
            </div>
        </div>

        <!-- Orders Card -->
        <div class="col-md-4">
            <div class="parchment-card-box h-100 d-flex flex-column" style="border-top: 4px solid #16a34a;">
                <div class="d-flex align-items-center justify-content-between mb-3">
                    <h2 class="h4 mb-0" style="color: var(--wood-dark);">Quản Lý Đơn Hàng</h2>
                    <div style="width: 44px; height: 44px; background: #dcfce7; border-radius: var(--radius-sm); display: flex; align-items: center; justify-content: center;">
                        <i class="fa-solid fa-clipboard-list text-success fs-4"></i>
                    </div>
                </div>
                <p class="text-muted flex-grow-1">Theo dõi các đơn hàng COD, lọc trạng thái giao hàng, duyệt đơn và xử lý hủy đơn.</p>
                <div class="d-flex gap-2 mt-3">
                    <a class="btn btn-leather-primary flex-grow-1" href="<c:url value='/admin/orders'/>">
                        <i class="fa-solid fa-list-check me-1"></i> Danh sách đơn hàng
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- System Status Box -->
    <div class="alert alert-success alert-custom">
        <i class="fa-solid fa-circle-check fs-4"></i>
        <div>
            <strong>Hệ thống sẵn sàng:</strong> Session Admin, Filter bảo vệ và SiteMesh decorator đang hoạt động ổn định.
        </div>
    </div>
</div>
