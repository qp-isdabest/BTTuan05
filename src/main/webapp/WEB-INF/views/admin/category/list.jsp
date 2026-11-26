<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý Danh mục - BTTuan05</title>
</head>
<body>
<div class="card shadow-sm border-0 mb-4">
    <div class="card-header bg-danger text-white d-flex justify-content-between align-items-center py-3">
        <h5 class="mb-0 fw-bold">
            <i class="bi bi-folder-fill me-2"></i> DANH SÁCH DANH MỤC (CATEGORIES)
        </h5>
        <a href="/admin/categories/add" class="btn btn-light btn-sm fw-semibold shadow-sm">
            <i class="bi bi-plus-circle me-1"></i> Thêm danh mục
        </a>
    </div>

    <div class="card-body">
        <!-- Thông báo thành công -->
        <c:if test="${not empty message}">
            <div class="alert alert-success alert-dismissible fade show d-flex align-items-center" role="alert">
                <i class="bi bi-check-circle-fill me-2 fs-5"></i>
                <div>${message}</div>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Thông báo lỗi -->
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2 fs-5"></i>
                <div>${errorMessage}</div>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Thanh tìm kiếm & chọn số lượng trên trang -->
        <div class="row mb-3 g-2 align-items-center">
            <div class="col-md-8">
                <form action="/admin/categories/searchpaginated" method="get" class="d-flex gap-2">
                    <div class="input-group">
                        <span class="input-group-text bg-white"><i class="bi bi-search text-muted"></i></span>
                        <input type="text" name="name" id="name" value="${name}" class="form-control"
                               placeholder="Nhập tên danh mục cần tìm..." />
                    </div>
                    <button type="submit" class="btn btn-danger px-4 text-nowrap">
                        <i class="bi bi-search me-1"></i> Tìm kiếm
                    </button>
                    <c:if test="${not empty name}">
                        <a href="/admin/categories/searchpaginated" class="btn btn-outline-secondary text-nowrap">
                            <i class="bi bi-arrow-counterclockwise"></i> Đặt lại
                        </a>
                    </c:if>
                </form>
            </div>

            <div class="col-md-4 text-md-end">
                <form action="/admin/categories/searchpaginated" method="get" class="d-inline-flex align-items-center gap-2">
                    <c:if test="${not empty name}">
                        <input type="hidden" name="name" value="${name}" />
                    </c:if>
                    <label for="size" class="form-label mb-0 fw-semibold text-nowrap small text-muted">Hiển thị:</label>
                    <select name="size" id="size" class="form-select form-select-sm w-auto" onchange="this.form.submit()">
                        <option ${categoryPage.size == 3 ? 'selected':''} value="3">3 mục / trang</option>
                        <option ${categoryPage.size == 5 ? 'selected':''} value="5">5 mục / trang</option>
                        <option ${categoryPage.size == 10 ? 'selected':''} value="10">10 mục / trang</option>
                        <option ${categoryPage.size == 15 ? 'selected':''} value="15">15 mục / trang</option>
                        <option ${categoryPage.size == 20 ? 'selected':''} value="20">20 mục / trang</option>
                    </select>
                </form>
            </div>
        </div>

        <!-- Trống danh sách -->
        <c:if test="${!categoryPage.hasContent()}">
            <div class="alert alert-warning text-center my-4 py-4">
                <i class="bi bi-inbox fs-2 text-warning d-block mb-2"></i>
                Không tìm thấy danh mục nào phù hợp với từ khóa "${name}".
            </div>
        </c:if>

        <!-- Bảng danh sách danh mục -->
        <c:if test="${categoryPage.hasContent()}">
            <div class="table-responsive">
                <table class="table table-hover table-bordered align-middle">
                    <thead class="table-dark">
                        <tr>
                            <th style="width: 60px;" class="text-center">STT</th>
                            <th style="width: 140px;">Hình ảnh</th>
                            <th>Tên danh mục</th>
                            <th style="width: 130px;" class="text-center">Trạng thái</th>
                            <th style="width: 160px;" class="text-center">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${categoryPage.content}" var="cate" varStatus="STT">
                            <tr>
                                <td class="text-center fw-bold text-muted">${STT.index + 1 + (categoryPage.number * categoryPage.size)}</td>
                                <td>
                                    <span class="badge bg-light text-dark border">
                                        <i class="bi bi-image me-1"></i>${cate.images}
                                    </span>
                                </td>
                                <td class="fw-semibold text-dark">${cate.name}</td>
                                <td class="text-center">
                                    <a href="/admin/categories/toggle-status/${cate.id}" class="text-decoration-none" title="Bấm để đổi trạng thái">
                                        <c:choose>
                                            <c:when test="${cate.status == 1}">
                                                <span class="badge bg-success"><i class="bi bi-check-circle me-1"></i>Hoạt động</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary"><i class="bi bi-lock me-1"></i>Khóa</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </a>
                                </td>
                                <td class="text-center">
                                    <a href="/admin/categories/edit/${cate.id}" class="btn btn-sm btn-outline-warning me-1" title="Chỉnh sửa">
                                        <i class="bi bi-pencil-square"></i> Sửa
                                    </a>
                                    <a href="/admin/categories/delete/${cate.id}" class="btn btn-sm btn-outline-danger" title="Xóa"
                                       onclick="return confirm('Bạn có chắc chắn muốn xóa category: ${cate.name}?');">
                                        <i class="bi bi-trash"></i> Xóa
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Phân trang -->
            <c:if test="${categoryPage.totalPages > 0}">
                <nav aria-label="Page navigation" class="d-flex flex-wrap justify-content-between align-items-center mt-3 pt-2 border-top">
                    <small class="text-muted">
                        Đang xem trang <strong>${categoryPage.number + 1}</strong> / <strong>${categoryPage.totalPages}</strong>
                        (Tổng số: <strong>${categoryPage.totalElements}</strong> mục)
                    </small>

                    <c:if test="${categoryPage.totalPages > 1}">
                        <ul class="pagination pagination-sm mb-0">
                            <!-- Nút Đầu tiên -->
                            <li class="page-item ${categoryPage.first ? 'disabled' : ''}">
                                <a class="page-link" href="<c:url value='/admin/categories/searchpaginated?name=${name}&size=${categoryPage.size}&page=1'/>">
                                    <i class="bi bi-chevron-double-left"></i>
                                </a>
                            </li>

                            <!-- Nút Trước -->
                            <li class="page-item ${categoryPage.hasPrevious() ? '' : 'disabled'}">
                                <a class="page-link" href="<c:url value='/admin/categories/searchpaginated?name=${name}&size=${categoryPage.size}&page=${categoryPage.number}'/>">
                                    <i class="bi bi-chevron-left"></i>
                                </a>
                            </li>

                            <!-- Các số trang -->
                            <c:forEach items="${pageNumbers}" var="pageNumber">
                                <li class="page-item ${pageNumber == categoryPage.number + 1 ? 'active' : ''}">
                                    <a class="page-link" href="<c:url value='/admin/categories/searchpaginated?name=${name}&size=${categoryPage.size}&page=${pageNumber}'/>">
                                        ${pageNumber}
                                    </a>
                                </li>
                            </c:forEach>

                            <!-- Nút Kế tiếp -->
                            <li class="page-item ${categoryPage.hasNext() ? '' : 'disabled'}">
                                <a class="page-link" href="<c:url value='/admin/categories/searchpaginated?name=${name}&size=${categoryPage.size}&page=${categoryPage.number + 2}'/>">
                                    <i class="bi bi-chevron-right"></i>
                                </a>
                            </li>

                            <!-- Nút Cuối cùng -->
                            <li class="page-item ${categoryPage.last ? 'disabled' : ''}">
                                <a class="page-link" href="<c:url value='/admin/categories/searchpaginated?name=${name}&size=${categoryPage.size}&page=${categoryPage.totalPages}'/>">
                                    <i class="bi bi-chevron-double-right"></i>
                                </a>
                            </li>
                        </ul>
                    </c:if>
                </nav>
            </c:if>
        </c:if>
    </div>
</div>
</body>
</html>
