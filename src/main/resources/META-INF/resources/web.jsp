<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property='title'/></title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <sitemesh:write property='head'/>
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
    <!-- Header / Navbar cho Web thông thường -->
    <header>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
            <div class="container">
                <a class="navbar-brand fw-bold text-primary" href="/"><i class="bi bi-box-seam"></i> Web Portal</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#userNavbar">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="userNavbar">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link active" href="/"><i class="bi bi-house"></i> Trang chủ</a>
                        </li>
                        <c:if test="${not empty sessionScope.currentUser and sessionScope.currentUser.admin}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle text-warning fw-semibold" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="bi bi-shield-lock"></i> Quản trị Admin
                                </a>
                                <ul class="dropdown-menu shadow">
                                    <li>
                                        <a class="dropdown-item" href="/admin/categories/searchpaginated">
                                            <i class="bi bi-folder-fill me-2 text-danger"></i> Quản lý Category
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="/admin/users/searchpaginated">
                                            <i class="bi bi-people-fill me-2 text-danger"></i> Quản lý User
                                        </a>
                                    </li>
                                </ul>
                            </li>
                        </c:if>
                    </ul>
                    <div class="d-flex align-items-center">
                        <c:choose>
                            <c:when test="${not empty sessionScope.currentUser}">
                                <div class="dropdown">
                                    <button class="btn btn-outline-light dropdown-toggle d-flex align-items-center" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                        <i class="bi bi-person-circle me-2 fs-5"></i>
                                        <span>${not empty sessionScope.currentUser.fullname ? sessionScope.currentUser.fullname : sessionScope.currentUser.username}</span>
                                        <c:if test="${sessionScope.currentUser.admin}">
                                            <span class="badge bg-danger ms-2">Admin</span>
                                        </c:if>
                                    </button>
                                    <ul class="dropdown-menu dropdown-menu-end shadow">
                                        <li class="dropdown-header">
                                            Tài khoản: <strong>${sessionScope.currentUser.username}</strong><br>
                                            <small class="text-muted">${sessionScope.currentUser.email}</small>
                                        </li>
                                        <li><hr class="dropdown-divider"></li>
                                        <c:if test="${sessionScope.currentUser.admin}">
                                            <li>
                                                <a class="dropdown-item" href="/admin/categories/searchpaginated">
                                                    <i class="bi bi-folder-fill me-2 text-danger"></i> Quản lý Category
                                                </a>
                                            </li>
                                            <li>
                                                <a class="dropdown-item" href="/admin/users/searchpaginated">
                                                    <i class="bi bi-people-fill me-2 text-danger"></i> Quản lý User
                                                </a>
                                            </li>
                                            <li><hr class="dropdown-divider"></li>
                                        </c:if>
                                        <li>
                                            <a class="dropdown-item text-danger" href="/logout">
                                                <i class="bi bi-box-arrow-right me-2"></i> Đăng xuất
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <a href="/login" class="btn btn-outline-light btn-sm me-2">
                                    <i class="bi bi-box-arrow-in-right me-1"></i> Đăng nhập
                                </a>
                                <a href="/register" class="btn btn-primary btn-sm">
                                    <i class="bi bi-person-plus me-1"></i> Đăng ký
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </nav>
    </header>

    <!-- Main Content Body -->
    <main class="container my-4 flex-grow-1">
        <sitemesh:write property='body'/>
    </main>

    <!-- Footer -->
    <footer class="bg-dark text-white text-center py-3 mt-auto">
        <div class="container">
            <small>&copy; 2026 Spring Boot + JSP + SiteMesh 3 - BTTuan5. Thiết kế bởi Phan Thế Quân.</small>
        </div>
    </footer>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
