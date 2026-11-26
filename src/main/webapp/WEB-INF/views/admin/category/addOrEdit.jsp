<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <title>${category.id != null ? 'Cập nhật Category' : 'Thêm mới Category'}</title>
</head>
<body>
<div class="row justify-content-center">
    <div class="col-lg-8 col-md-10">
        <div class="card shadow-sm border-0">
            <div class="card-header bg-danger text-white py-3">
                <h5 class="mb-0 fw-bold">
                    <i class="bi ${category.id != null ? 'bi-pencil-square' : 'bi-plus-circle'} me-2"></i>
                    ${category.id != null ? 'CẬP NHẬT CATEGORY' : 'THÊM MỚI CATEGORY'}
                </h5>
            </div>
            <div class="card-body p-4">
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center mb-4" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-2 fs-5 flex-shrink-0"></i>
                        <div>${errorMessage}</div>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <form action="/admin/categories/save" method="post">
                    <input type="hidden" name="id" value="${category.id}" />

                    <div class="mb-3">
                        <label for="name" class="form-label fw-semibold">
                            Tên danh mục (Category Name) <span class="text-danger">*</span>:
                        </label>
                        <div class="input-group">
                            <span class="input-group-text bg-light"><i class="bi bi-tag-fill"></i></span>
                            <input type="text" class="form-control" id="name" name="name"
                                   value="${category.name}" required placeholder="Nhập tên danh mục..." autofocus />
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="images" class="form-label fw-semibold">Tên file hình ảnh:</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light"><i class="bi bi-image"></i></span>
                            <input type="text" class="form-control" id="images" name="images"
                                   value="${category.images}" placeholder="Ví dụ: laptop.jpg" />
                        </div>
                        <small class="text-muted">Nhập tên file hoặc URL hình ảnh đại diện của danh mục.</small>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-semibold d-block">Trạng thái danh mục:</label>
                        <div class="d-flex gap-4">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="status" id="status1" value="1"
                                       ${category.status == 1 or category.id == null ? 'checked' : ''}>
                                <label class="form-check-label text-success fw-semibold" for="status1">
                                    <i class="bi bi-check-circle me-1"></i> Hoạt động
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="status" id="status0" value="0"
                                       ${category.status == 0 and category.id != null ? 'checked' : ''}>
                                <label class="form-check-label text-secondary fw-semibold" for="status0">
                                    <i class="bi bi-lock me-1"></i> Khóa
                                </label>
                            </div>
                        </div>
                    </div>

                    <div class="d-flex gap-2 pt-2 border-top">
                        <button type="submit" class="btn btn-danger px-4 fw-semibold shadow-sm">
                            <i class="bi bi-save me-1"></i> Lưu thông tin
                        </button>
                        <a href="/admin/categories/searchpaginated" class="btn btn-secondary px-3">
                            <i class="bi bi-arrow-left me-1"></i> Quay lại
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
