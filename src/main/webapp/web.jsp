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
                        <li class="nav-item">
                            <a class="nav-link" href="/admin/categories/searchpaginated"><i class="bi bi-grid-3x3-gap"></i> Danh mục (Admin)</a>
                        </li>
                    </ul>
                    <span class="navbar-text text-light">
                        <i class="bi bi-person-circle"></i> Khách hàng
                    </span>
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
