<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <title>${user.id != null ? 'Cập nhật Người dùng' : 'Thêm mới Người dùng'}</title>
</head>
<body>
<div class="row justify-content-center">
    <div class="col-lg-8 col-md-10">
        <div class="card shadow-sm border-0">
            <div class="card-header bg-danger text-white py-3">
                <h5 class="mb-0 fw-bold">
                    <i class="bi ${user.id != null ? 'bi-pencil-square' : 'bi-person-plus-fill'} me-2"></i>
                    ${user.id != null ? 'CẬP NHẬT THÔNG TIN NGƯỜI DÙNG' : 'THÊM MỚI NGƯỜI DÙNG'}
                </h5>
            </div>

            <div class="card-body p-4">
                <!-- Thông báo lỗi nếu có -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center mb-4" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-2 fs-5 flex-shrink-0"></i>
                        <div>${errorMessage}</div>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <form action="/admin/users/save" method="post">
                    <input type="hidden" name="id" value="${user.id}" />

                    <div class="row">
                        <!-- Tên đăng nhập -->
                        <div class="col-md-6 mb-3">
                            <label for="username" class="form-label fw-semibold">
                                Tên đăng nhập <span class="text-danger">*</span>
                            </label>
                            <div class="input-group">
                                <span class="input-group-text bg-light"><i class="bi bi-person"></i></span>
                                <input type="text" class="form-control" id="username" name="username"
                                       value="${user.username}" placeholder="VD: johndoe" required
                                       ${user.id != null ? 'readonly' : 'autofocus'} />
                            </div>
                            <c:if test="${user.id != null}">
                                <small class="text-muted">Tên đăng nhập không thể thay đổi sau khi tạo.</small>
                            </c:if>
                        </div>

                        <!-- Mật khẩu -->
                        <div class="col-md-6 mb-3">
                            <label for="passwordField" class="form-label fw-semibold">
                                ${user.id != null ? 'Mật khẩu mới' : 'Mật khẩu'}
                                <c:if test="${user.id == null}"><span class="text-danger">*</span></c:if>
                            </label>
                            <div class="input-group">
                                <span class="input-group-text bg-light"><i class="bi bi-key"></i></span>
                                <c:choose>
                                    <c:when test="${user.id != null}">
                                        <input type="password" class="form-control" id="passwordField" name="newPassword"
                                               placeholder="Bỏ trống nếu không muốn đổi mật khẩu" />
                                    </c:when>
                                    <c:otherwise>
                                        <input type="password" class="form-control" id="passwordField" name="password"
                                               placeholder="Tối thiểu 6 ký tự" required minlength="6" />
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <!-- Họ và tên -->
                        <div class="col-md-6 mb-3">
                            <label for="fullname" class="form-label fw-semibold">
                                Họ và tên <span class="text-danger">*</span>
                            </label>
                            <div class="input-group">
                                <span class="input-group-text bg-light"><i class="bi bi-card-text"></i></span>
                                <input type="text" class="form-control" id="fullname" name="fullname"
                                       value="${user.fullname}" placeholder="VD: Nguyễn Văn A" required />
                            </div>
                        </div>

                        <!-- Email -->
                        <div class="col-md-6 mb-3">
                            <label for="email" class="form-label fw-semibold">
                                Email <span class="text-danger">*</span>
                            </label>
                            <div class="input-group">
                                <span class="input-group-text bg-light"><i class="bi bi-envelope"></i></span>
                                <input type="email" class="form-control" id="email" name="email"
                                       value="${user.email}" placeholder="VD: email@example.com" required />
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <!-- Điện thoại -->
                        <div class="col-md-6 mb-3">
                            <label for="phone" class="form-label fw-semibold">Số điện thoại:</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light"><i class="bi bi-telephone"></i></span>
                                <input type="tel" class="form-control" id="phone" name="phone"
                                       value="${user.phone}" placeholder="VD: 0901234567" />
                            </div>
                        </div>

                        <!-- Vai trò -->
                        <div class="col-md-6 mb-3">
                            <label for="role" class="form-label fw-semibold">
                                Vai trò <span class="text-danger">*</span>
                            </label>
                            <div class="input-group">
                                <span class="input-group-text bg-light"><i class="bi bi-shield-lock"></i></span>
                                <select class="form-select" id="role" name="role" required>
                                    <option value="USER" ${user.role == 'USER' ? 'selected' : ''}>USER (Người dùng thông thường)</option>
                                    <option value="ADMIN" ${user.role == 'ADMIN' ? 'selected' : ''}>ADMIN (Quản trị viên toàn quyền)</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <!-- Trạng thái -->
                    <div class="mb-4">
                        <label class="form-label fw-semibold d-block">Trạng thái tài khoản:</label>
                        <div class="d-flex gap-4">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="status" id="statusActive"
                                       value="1" ${user.status == 1 or user.id == null ? 'checked' : ''}>
                                <label class="form-check-label text-success fw-semibold" for="statusActive">
                                    <i class="bi bi-check-circle me-1"></i> Hoạt động
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="status" id="statusLocked"
                                       value="0" ${user.status == 0 and user.id != null ? 'checked' : ''}>
                                <label class="form-check-label text-secondary fw-semibold" for="statusLocked">
                                    <i class="bi bi-lock me-1"></i> Khóa tài khoản
                                </label>
                            </div>
                        </div>
                    </div>

                    <div class="d-flex gap-2 pt-2 border-top">
                        <button type="submit" class="btn btn-danger px-4 fw-semibold shadow-sm">
                            <i class="bi bi-save me-1"></i> Lưu thông tin
                        </button>
                        <a href="/admin/users/searchpaginated" class="btn btn-secondary px-3">
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
