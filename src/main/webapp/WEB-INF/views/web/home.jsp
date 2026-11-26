<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Trang Chủ - Website</title>
</head>
<body>
    <div class="p-5 mb-4 bg-light rounded-3 text-center">
        <div class="container-fluid py-5">
            <h1 class="display-5 fw-bold text-primary">Spring Boot + JSP + SiteMesh 3</h1>
            <p class="col-md-8 fs-4 mx-auto text-secondary">
                Hệ thống Quản lý Danh mục (Categories) tích hợp Tìm kiếm và Phân trang (Pagination & Search) sử dụng Spring Data JPA.
            </p>
            <div class="mt-4">
                <a class="btn btn-primary btn-lg px-4 gap-3 me-2" href="/admin/categories/searchpaginated">
                    <i class="bi bi-gear-fill"></i> Đến trang Quản lý Category
                </a>
                <a class="btn btn-outline-secondary btn-lg px-4" href="/h2-console" target="_blank">
                    <i class="bi bi-database"></i> Xem H2 Console
                </a>
            </div>
        </div>
    </div>
</body>
</html>
