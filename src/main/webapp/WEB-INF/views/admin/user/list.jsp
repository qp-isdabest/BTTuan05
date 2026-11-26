<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý Người dùng - BTTuan05</title>
</head>
<body>
<div class="card shadow-sm border-0 mb-4">
    <div class="card-header bg-danger text-white d-flex justify-content-between align-items-center py-3">
        <h5 class="mb-0 fw-bold">
            <i class="bi bi-people-fill me-2"></i> DANH SÁCH NGƯỜI DÙNG
        </h5>
        <a href="/admin/users/add" class="btn btn-light btn-sm fw-semibold shadow-sm">
            <i class="bi bi-person-plus-fill me-1"></i> Thêm người dùng
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
                <form action="/admin/users/searchpaginated" method="get" class="d-flex gap-2">
                    <div class="input-group">
                        <span class="input-group-text bg-white"><i class="bi bi-search text-muted"></i></span>
                        <input type="text" name="keyword" id="keyword" value="${keyword}" class="form-control"
                               placeholder="Tìm theo tên đăng nhập, họ tên, email, sđt..." />
                    </div>
                    <button type="submit" class="btn btn-danger px-4 text-nowrap">
                        <i class="bi bi-search me-1"></i> Tìm kiếm
                    </button>
                    <c:if test="${not empty keyword}">
                        <a href="/admin/users/searchpaginated" class="btn btn-outline-secondary text-nowrap">
                            <i class="bi bi-arrow-counterclockwise"></i> Đặt lại
                        </a>
                    </c:if>
                </form>
            </div>

            <div class="col-md-4 text-md-end">
                <form action="/admin/users/searchpaginated" method="get" class="d-inline-flex align-items-center gap-2">
                    <c:if test="${not empty keyword}">
                        <input type="hidden" name="keyword" value="${keyword}" />
                    </c:if>
                    <label for="size" class="form-label mb-0 fw-semibold text-nowrap small text-muted">Hiển thị:</label>
                    <select name="size" id="size" class="form-select form-select-sm w-auto" onchange="this.form.submit()">
                        <option ${userPage.size == 3 ? 'selected':''} value="3">3 mục / trang</option>
                        <option ${userPage.size == 5 ? 'selected':''} value="5">5 mục / trang</option>
                        <option ${userPage.size == 10 ? 'selected':''} value="10">10 mục / trang</option>
                        <option ${userPage.size == 20 ? 'selected':''} value="20">20 mục / trang</option>
                    </select>
                </form>
            </div>
        </div>

        <!-- Trống danh sách -->
        <c:if test="${!userPage.hasContent()}">
            <div class="alert alert-warning text-center my-4 py-4">
                <i class="bi bi-inbox fs-2 text-warning d-block mb-2"></i>
                Không tìm thấy người dùng nào phù hợp với điều kiện tìm kiếm.
            </div>
        </c:if>

        <!-- Bảng danh sách người dùng -->
        <c:if test="${userPage.hasContent()}">
            <div class="table-responsive">
                <table class="table table-hover table-bordered align-middle">
                    <thead class="table-dark">
                        <tr>
                            <th style="width: 60px;" class="text-center">STT</th>
                            <th>Tên đăng nhập</th>
                            <th>Họ và tên</th>
                            <th>Email</th>
                            <th>Điện thoại</th>
                            <th style="width: 110px;" class="text-center">Vai trò</th>
                            <th style="width: 120px;" class="text-center">Trạng thái</th>
                            <th style="width: 160px;" class="text-center">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${userPage.content}" var="u" varStatus="STT">
                            <tr>
                                <td class="text-center fw-bold text-muted">${STT.index + 1 + (userPage.number * userPage.size)}</td>
                                <td>
                                    <span class="fw-semibold text-primary">
                                        <i class="bi bi-person me-1"></i>${u.username}
                                    </span>
                                </td>
                                <td class="fw-medium">${u.fullname}</td>
                                <td>
                                    <small><i class="bi bi-envelope me-1 text-muted"></i>${u.email}</small>
                                </td>
                                <td>
                                    <small><i class="bi bi-telephone me-1 text-muted"></i>${not empty u.phone ? u.phone : '-'}</small>
                                </td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${u.role == 'ADMIN'}">
                                            <span class="badge bg-danger shadow-sm">ADMIN</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-primary">USER</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <a href="/admin/users/toggle-status/${u.id}" class="text-decoration-none" title="Bấm để đổi trạng thái">
                                        <c:choose>
                                            <c:when test="${u.status == 1}">
                                                <span class="badge bg-success"><i class="bi bi-check-circle me-1"></i>Hoạt động</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary"><i class="bi bi-lock me-1"></i>Bị khóa</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </a>
                                </td>
                                <td class="text-center">
                                    <a href="/admin/users/edit/${u.id}" class="btn btn-sm btn-outline-warning me-1" title="Chỉnh sửa">
                                        <i class="bi bi-pencil-square"></i> Sửa
                                    </a>
                                    <a href="/admin/users/delete/${u.id}" class="btn btn-sm btn-outline-danger" title="Xóa"
                                       onclick="return confirm('Bạn có chắc chắn muốn xóa tài khoản ${u.username}?');">
                                        <i class="bi bi-trash"></i> Xóa
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Phân trang -->
            <c:if test="${userPage.totalPages > 0}">
                <nav aria-label="Page navigation" class="d-flex flex-wrap justify-content-between align-items-center mt-3 pt-2 border-top">
                    <small class="text-muted">
                        Đang xem trang <strong>${userPage.number + 1}</strong> / <strong>${userPage.totalPages}</strong>
                        (Tổng số: <strong>${userPage.totalElements}</strong> tài khoản)
                    </small>

                    <c:if test="${userPage.totalPages > 1}">
                        <ul class="pagination pagination-sm mb-0">
                            <!-- Nút Đầu tiên -->
                            <li class="page-item ${userPage.first ? 'disabled' : ''}">
                                <a class="page-link" href="<c:url value='/admin/users/searchpaginated?keyword=${keyword}&size=${userPage.size}&page=1'/>">
                                    <i class="bi bi-chevron-double-left"></i>
                                </a>
                            </li>

                            <!-- Nút Trước -->
                            <li class="page-item ${userPage.hasPrevious() ? '' : 'disabled'}">
                                <a class="page-link" href="<c:url value='/admin/users/searchpaginated?keyword=${keyword}&size=${userPage.size}&page=${userPage.number}'/>">
                                    <i class="bi bi-chevron-left"></i>
                                </a>
                            </li>

                            <!-- Các số trang -->
                            <c:forEach items="${pageNumbers}" var="pageNumber">
                                <li class="page-item ${pageNumber == userPage.number + 1 ? 'active' : ''}">
                                    <a class="page-link" href="<c:url value='/admin/users/searchpaginated?keyword=${keyword}&size=${userPage.size}&page=${pageNumber}'/>">
                                        ${pageNumber}
                                    </a>
                                </li>
                            </c:forEach>

                            <!-- Nút Kế tiếp -->
                            <li class="page-item ${userPage.hasNext() ? '' : 'disabled'}">
                                <a class="page-link" href="<c:url value='/admin/users/searchpaginated?keyword=${keyword}&size=${userPage.size}&page=${userPage.number + 2}'/>">
                                    <i class="bi bi-chevron-right"></i>
                                </a>
                            </li>

                            <!-- Nút Cuối cùng -->
                            <li class="page-item ${userPage.last ? 'disabled' : ''}">
                                <a class="page-link" href="<c:url value='/admin/users/searchpaginated?keyword=${keyword}&size=${userPage.size}&page=${userPage.totalPages}'/>">
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
