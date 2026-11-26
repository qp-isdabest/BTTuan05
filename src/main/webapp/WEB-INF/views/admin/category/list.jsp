<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý Danh mục - Phân trang & Tìm kiếm</title>
</head>
<body>
<div class="card shadow-sm border-0 mb-4">
    <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
        <h5 class="mb-0">Danh sách Danh mục</h5>
        <a href="/admin/categories/add" class="btn btn-light btn-sm fw-semibold">
            <i class="bi bi-plus-circle"></i> Add category
        </a>
    </div>
    <div class="card-body">
        <!-- Hiển thông báo -->
        <c:if test="${message != null}">
            <div class="alert alert-info alert-dismissible fade show" role="alert">
                <i>${message}</i>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        <!-- Hêt thông báo -->

        <div class="row mb-3">
            <div class="col-md-8">
                <form action="/admin/categories/searchpaginated" method="get" class="d-flex gap-2">
                    <input type="text" name="name" id="name" value="${name}" class="form-control" placeholder="Nhập từ khóa để tìm" />
                    <button type="submit" class="btn btn-primary px-4">Search</button>
                    <c:if test="${not empty name}">
                        <a href="/admin/categories/searchpaginated" class="btn btn-outline-secondary">Reset</a>
                    </c:if>
                </form>
            </div>
            <div class="col-md-4 text-end">
                <form action="/admin/categories/searchpaginated" method="get" class="d-inline-flex align-items-center gap-2">
                    <c:if test="${not empty name}">
                        <input type="hidden" name="name" value="${name}" />
                    </c:if>
                    <label for="size" class="form-label mb-0 fw-semibold text-nowrap">Page size:</label>
                    <select name="size" id="size" class="form-select form-select-sm w-auto" onchange="this.form.submit()">
                        <option ${categoryPage.size == 3 ? 'selected':''} value="3">3</option>
                        <option ${categoryPage.size == 5 ? 'selected':''} value="5">5</option>
                        <option ${categoryPage.size == 10 ? 'selected':''} value="10">10</option>
                        <option ${categoryPage.size == 15 ? 'selected':''} value="15">15</option>
                        <option ${categoryPage.size == 20 ? 'selected':''} value="20">20</option>
                    </select>
                </form>
            </div>
        </div>

        <c:if test="${!categoryPage.hasContent()}">
            <div class="alert alert-warning text-center my-4">
                No Category
            </div>
        </c:if>

        <c:if test="${categoryPage.hasContent()}">
            <div class="table-responsive">
                <table class="table table-hover table-bordered align-middle">
                    <thead class="table-secondary">
                        <tr>
                            <th style="width: 70px;" class="text-center">STT</th>
                            <th>Images</th>
                            <th>Category name</th>
                            <th style="width: 120px;" class="text-center">Status</th>
                            <th style="width: 150px;" class="text-center">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${categoryPage.content}" var="cate" varStatus="STT">
                            <tr>
                                <td class="text-center">${STT.index + 1}</td>
                                <td>
                                    <span class="badge bg-light text-dark border">${cate.images}</span>
                                </td>
                                <td class="fw-medium">${cate.name}</td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${cate.status == 1}">
                                            <span class="badge bg-success">Hoạt động</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">Khóa</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <a href="/admin/categories/edit/${cate.id}" class="btn btn-sm btn-outline-warning me-1">Sửa</a>
                                    <a href="/admin/categories/delete/${cate.id}" class="btn btn-sm btn-outline-danger" onclick="return confirm('Bạn có chắc chắn muốn xóa category này?');">Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Pagination Nav -->
            <c:if test="${categoryPage.totalPages > 0}">
                <nav aria-label="Page navigation" class="d-flex justify-content-between align-items-center mt-3">
                    <small class="text-muted">
                        Trang <strong>${categoryPage.number + 1}</strong> / <strong>${categoryPage.totalPages}</strong> (Tổng <strong>${categoryPage.totalElements}</strong> mục)
                    </small>
                    <ul class="pagination pagination-sm mb-0">
                        <c:forEach items="${pageNumbers}" var="pageNumber">
                            <c:if test="${categoryPage.totalPages > 1}">
                                <li class="${pageNumber == categoryPage.number + 1 ? 'page-item active' : 'page-item'}">
                                    <a class="page-link" href="<c:url value='/admin/categories/searchpaginated?name=${name}&size=${categoryPage.size}&page=${pageNumber}'/>">${pageNumber}</a>
                                </li>
                            </c:if>
                        </c:forEach>
                    </ul>
                </nav>
            </c:if>
        </c:if>
    </div>
</div>
</body>
</html>
