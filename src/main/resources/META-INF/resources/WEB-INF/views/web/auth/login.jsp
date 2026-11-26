<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập hệ thống</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #0d6efd 0%, #0a58ca 40%, #052c65 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .login-card {
            max-width: 440px;
            width: 100%;
            border: none;
            border-radius: 1rem;
            box-shadow: 0 1rem 3rem rgba(0, 0, 0, 0.25);
            background: #ffffff;
            overflow: hidden;
        }
        .login-header {
            background: #f8f9fa;
            border-bottom: 1px solid #e9ecef;
            padding: 2rem 1.5rem 1.5rem;
            text-align: center;
        }
        .login-header .icon-circle {
            width: 68px;
            height: 68px;
            border-radius: 50%;
            background: #e7f1ff;
            color: #0d6efd;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            margin-bottom: 0.75rem;
        }
        .form-floating:focus-within {
            z-index: 2;
        }
    </style>
</head>
<body>

    <div class="login-card">
        <div class="login-header">
            <div class="icon-circle shadow-sm">
                <i class="bi bi-shield-lock-fill"></i>
            </div>
            <h4 class="fw-bold text-dark mb-1">ĐĂNG NHẬP</h4>
            <p class="text-muted small mb-0">Hệ thống Quản lý BTTuan05</p>
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

            <!-- Thông báo thành công -->
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success alert-dismissible fade show d-flex align-items-center" role="alert">
                    <i class="bi bi-check-circle-fill me-2 fs-5 flex-shrink-0"></i>
                    <div>${successMessage}</div>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- Thông báo thông tin -->
            <c:if test="${not empty infoMessage}">
                <div class="alert alert-info alert-dismissible fade show d-flex align-items-center" role="alert">
                    <i class="bi bi-info-circle-fill me-2 fs-5 flex-shrink-0"></i>
                    <div>${infoMessage}</div>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <form action="/login" method="post">
                <c:if test="${not empty redirect}">
                    <input type="hidden" name="redirect" value="${redirect}">
                </c:if>

                <div class="mb-3">
                    <label for="username" class="form-label fw-semibold">
                        <i class="bi bi-person me-1"></i> Tên đăng nhập
                    </label>
                    <div class="input-group">
                        <span class="input-group-text bg-light"><i class="bi bi-person-fill"></i></span>
                        <input type="text" class="form-control" id="username" name="username"
                               value="${username}" placeholder="Nhập tên đăng nhập" required autofocus>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="password" class="form-label fw-semibold">
                        <i class="bi bi-key me-1"></i> Mật khẩu
                    </label>
                    <div class="input-group">
                        <span class="input-group-text bg-light"><i class="bi bi-lock-fill"></i></span>
                        <input type="password" class="form-control" id="password" name="password"
                               placeholder="Nhập mật khẩu" required>
                        <button class="btn btn-outline-secondary" type="button" id="togglePasswordBtn">
                            <i class="bi bi-eye" id="toggleEyeIcon"></i>
                        </button>
                    </div>
                </div>

                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="rememberMe" name="rememberMe" value="true"
                               <c:if test="${rememberMe}">checked</c:if>>
                        <label class="form-check-label text-muted small" for="rememberMe">
                            Ghi nhớ đăng nhập
                        </label>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary w-100 py-2 fw-bold shadow-sm">
                    <i class="bi bi-box-arrow-in-right me-1"></i> Đăng nhập
                </button>
            </form>

            <div class="text-center mt-4 pt-3 border-top">
                <p class="text-muted small mb-2">Chưa có tài khoản?</p>
                <a href="/register" class="btn btn-outline-success btn-sm px-3 fw-semibold me-2">
                    <i class="bi bi-person-plus-fill me-1"></i> Đăng ký ngay
                </a>
                <a href="/" class="btn btn-outline-secondary btn-sm px-3">
                    <i class="bi bi-house-door me-1"></i> Trang chủ
                </a>
            </div>

            <!-- Tài khoản mẫu demo -->
            <div class="mt-4 p-3 bg-light rounded small border">
                <div class="fw-bold text-dark mb-1"><i class="bi bi-info-circle"></i> Tài khoản mẫu dùng thử:</div>
                <div>• Admin: <code>admin</code> / <code>123456</code> (Quyền Quản trị viên)</div>
                <div>• User: <code>user</code> / <code>123456</code> (Quyền Người dùng)</div>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('togglePasswordBtn').addEventListener('click', function() {
            var pwd = document.getElementById('password');
            var icon = document.getElementById('toggleEyeIcon');
            if (pwd.type === 'password') {
                pwd.type = 'text';
                icon.classList.remove('bi-eye');
                icon.classList.add('bi-eye-slash');
            } else {
                pwd.type = 'password';
                icon.classList.remove('bi-eye-slash');
                icon.classList.add('bi-eye');
            }
        });
    </script>
</body>
</html>
