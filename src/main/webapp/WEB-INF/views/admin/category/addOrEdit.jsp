<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <title>${category.id != null ? 'Chỉnh sửa Category' : 'Thêm mới Category'}</title>
</head>
<body>
<div class="row justify-content-center">
    <div class="col-md-8">
        <div class="card shadow-sm border-0">
            <div class="card-header bg-primary text-white">
                <h5 class="mb-0">${category.id != null ? 'Cập nhật Category' : 'Thêm mới Category'}</h5>
            </div>
            <div class="card-body">
                <form action="/admin/categories/save" method="post">
                    <input type="hidden" name="id" value="${category.id}" />

                    <div class="mb-3">
                        <label for="name" class="form-label fw-semibold">Tên Category (*):</label>
                        <input type="text" class="form-control" id="name" name="name" value="${category.name}" required placeholder="Nhập tên category" />
                    </div>

                    <div class="mb-3">
                        <label for="images" class="form-label fw-semibold">Tên file hình ảnh:</label>
                        <input type="text" class="form-control" id="images" name="images" value="${category.images}" placeholder="Ví dụ: laptop.jpg" />
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Trạng thái:</label>
                        <div class="d-flex gap-3">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="status" id="status1" value="1" ${category.status == 1 or category.id == null ? 'checked' : ''}>
                                <label class="form-check-label" for="status1">Hoạt động</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="status" id="status0" value="0" ${category.status == 0 and category.id != null ? 'checked' : ''}>
                                <label class="form-check-label" for="status0">Khóa</label>
                            </div>
                        </div>
                    </div>

                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-success px-4">Lưu</button>
                        <a href="/admin/categories/searchpaginated" class="btn btn-secondary">Quay lại</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
