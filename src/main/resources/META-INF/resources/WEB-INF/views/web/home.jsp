<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Trang Chủ - Website</title>
</head>
<body>
    <div class="p-5 mb-4 bg-light rounded-3 text-center shadow-sm border">
        <div class="container-fluid py-4">
            <h1 class="display-5 fw-bold text-primary mb-3">
                <i class="bi bi-layers-fill"></i> Spring Boot + JSP + SiteMesh 3
            </h1>
            <p class="col-md-8 fs-5 mx-auto text-secondary mb-4">
                Hệ thống Quản lý Danh mục (Categories) tích hợp Tìm kiếm, Phân trang và Xác thực người dùng (Đăng ký, Đăng nhập, Đăng xuất).
            </p>

            <c:if test="${not empty sessionScope.currentUser}">
                <div class="alert alert-success d-inline-block text-start mb-4 px-4 py-3 shadow-sm">
                    <div class="d-flex align-items-center">
                        <i class="bi bi-person-check-fill fs-3 text-success me-3"></i>
                        <div>
                            <div class="fw-bold">Xin chào, ${sessionScope.currentUser.fullname}!</div>
                            <div class="small text-muted">
                                Tên đăng nhập: <strong>${sessionScope.currentUser.username}</strong> |
                                Vai trò: <span class="badge ${sessionScope.currentUser.admin ? 'bg-danger' : 'bg-primary'}">${sessionScope.currentUser.role}</span>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>

            <div class="d-flex justify-content-center flex-wrap gap-2 mt-2">
                <c:choose>
                    <c:when test="${not empty sessionScope.currentUser}">
                        <c:if test="${sessionScope.currentUser.admin}">
                            <a class="btn btn-danger btn-lg px-4" href="/admin/categories/searchpaginated">
                                <i class="bi bi-shield-lock-fill"></i> Quản lý Category (Admin)
                            </a>
                        </c:if>
                        <a class="btn btn-outline-danger btn-lg px-4" href="/logout">
                            <i class="bi bi-box-arrow-right"></i> Đăng xuất
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a class="btn btn-primary btn-lg px-4" href="/login">
                            <i class="bi bi-box-arrow-in-right"></i> Đăng nhập
                        </a>
                        <a class="btn btn-outline-success btn-lg px-4" href="/register">
                            <i class="bi bi-person-plus"></i> Đăng ký tài khoản
                        </a>
                    </c:otherwise>
                </c:choose>

                <a class="btn btn-outline-secondary btn-lg px-4" href="/h2-console" target="_blank">
                    <i class="bi bi-database"></i> H2 Console
                </a>
            </div>
        </div>
    </div>
</body>
</html>
