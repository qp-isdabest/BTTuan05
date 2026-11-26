<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký tài khoản</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #198754 0%, #157347 40%, #0a3622 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .register-card {
            max-width: 520px;
            width: 100%;
            border: none;
            border-radius: 1rem;
            box-shadow: 0 1rem 3rem rgba(0, 0, 0, 0.25);
            background: #ffffff;
            overflow: hidden;
        }
        .register-header {
            background: #f8f9fa;
            border-bottom: 1px solid #e9ecef;
            padding: 2rem 1.5rem 1.5rem;
            text-align: center;
        }
        .register-header .icon-circle {
            width: 68px;
            height: 68px;
            border-radius: 50%;
            background: #e8f5e9;
            color: #198754;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            margin-bottom: 0.75rem;
        }
    </style>
</head>
<body>

    <div class="register-card">
        <div class="register-header">
            <div class="icon-circle shadow-sm">
                <i class="bi bi-person-plus-fill"></i>
            </div>
            <h4 class="fw-bold text-dark mb-1">ĐĂNG KÝ TÀI KHOẢN</h4>
            <p class="text-muted small mb-0">Tạo tài khoản mới trong hệ thống BTTuan05</p>
        </div>

        <div class="card-body p-4">
            <!-- Thông báo lỗi -->
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2 fs-5 flex-shrink-0"></i>
                    <div>${errorMessage}</div>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <form action="/register" method="post" id="registerForm">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="username" class="form-label fw-semibold">
                            Tên đăng nhập <span class="text-danger">*</span>
                        </label>
                        <div class="input-group">
                            <span class="input-group-text bg-light"><i class="bi bi-person"></i></span>
                            <input type="text" class="form-control" id="username" name="username"
                                   value="${username}" placeholder="VD: johndoe" required autofocus minlength="3">
                        </div>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label for="fullname" class="form-label fw-semibold">
                            Họ và tên <span class="text-danger">*</span>
                        </label>
                        <div class="input-group">
                            <span class="input-group-text bg-light"><i class="bi bi-card-text"></i></span>
                            <input type="text" class="form-control" id="fullname" name="fullname"
                                   value="${fullname}" placeholder="VD: Nguyễn Văn A" required>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="email" class="form-label fw-semibold">
                            Email <span class="text-danger">*</span>
                        </label>
                        <div class="input-group">
                            <span class="input-group-text bg-light"><i class="bi bi-envelope"></i></span>
                            <input type="email" class="form-control" id="email" name="email"
                                   value="${email}" placeholder="VD: email@example.com" required>
                        </div>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label for="phone" class="form-label fw-semibold">
                            Số điện thoại
                        </label>
                        <div class="input-group">
                            <span class="input-group-text bg-light"><i class="bi bi-telephone"></i></span>
                            <input type="tel" class="form-control" id="phone" name="phone"
                                   value="${phone}" placeholder="VD: 0901234567">
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="password" class="form-label fw-semibold">
                            Mật khẩu <span class="text-danger">*</span>
                        </label>
                        <div class="input-group">
                            <span class="input-group-text bg-light"><i class="bi bi-lock"></i></span>
                            <input type="password" class="form-control" id="password" name="password"
                                   placeholder="Tối thiểu 6 ký tự" required minlength="6">
                        </div>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label for="repassword" class="form-label fw-semibold">
                            Xác nhận mật khẩu <span class="text-danger">*</span>
                        </label>
                        <div class="input-group">
                            <span class="input-group-text bg-light"><i class="bi bi-shield-check"></i></span>
                            <input type="password" class="form-control" id="repassword" name="repassword"
                                   placeholder="Nhập lại mật khẩu" required minlength="6">
                        </div>
                    </div>
                </div>

                <div class="form-check mb-4">
                    <input class="form-check-input" type="checkbox" id="agreeTerms" required checked>
                    <label class="form-check-label text-muted small" for="agreeTerms">
                        Tôi đồng ý với các điều khoản và chính sách dịch vụ.
                    </label>
                </div>

                <button type="submit" class="btn btn-success w-100 py-2 fw-bold shadow-sm">
                    <i class="bi bi-check2-circle me-1"></i> Đăng ký tài khoản
                </button>
            </form>

            <div class="text-center mt-4 pt-3 border-top">
                <p class="text-muted small mb-2">Đã có tài khoản?</p>
                <a href="/login" class="btn btn-outline-primary btn-sm px-3 fw-semibold me-2">
                    <i class="bi bi-box-arrow-in-right me-1"></i> Đăng nhập ngay
                </a>
                <a href="/" class="btn btn-outline-secondary btn-sm px-3">
                    <i class="bi bi-house-door me-1"></i> Trang chủ
                </a>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
