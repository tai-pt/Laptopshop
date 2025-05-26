<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm Người Dùng</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body {
            display: flex;
        }

        .sidebar {
            width: 250px;
            background: #343a40;
            color: white;
            height: 100vh;
            padding: 15px;
        }

        .sidebar a {
            color: white;
            text-decoration: none;
            display: block;
            padding: 10px;
            margin-bottom: 10px;
        }

        .sidebar a:hover {
            background: #495057;
        }

        .content {
            flex: 1;
            padding: 20px;
        }
    </style>
</head>

<body>
<!-- Sidebar -->
<div class="sidebar">
    <h4 class="text-center text-white">Admin Panel</h4>
    <a href="${pageContext.request.contextPath}/admin"><i class="fas fa-home"></i> Dashboard</a>
    <a href="${pageContext.request.contextPath}/admin/product"><i class="fas fa-box"></i> Products</a>
    <a href="${pageContext.request.contextPath}/admin/orders"><i class="fas fa-shopping-cart"></i> Orders</a>
    <a href="${pageContext.request.contextPath}/admin/user"><i class="fas fa-users"></i> Users</a>
</div>

<!-- Content -->
<div class="content">
    <h2 class="text-center mb-4"><i class="fa-solid fa-user-plus"></i> Thêm Người Dùng</h2>

    <div class="card shadow-lg p-4 mx-auto" style="max-width: 600px;">
        <form:form action="${pageContext.request.contextPath}/admin/user/save"
                   modelAttribute="user" method="post" enctype="multipart/form-data">

            <form:hidden path="id"/>
             <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

            <div class="mb-3">
                <label class="form-label">Họ và Tên</label>
                <form:input path="fullName" class="form-control ${status.errorFields['fullName'] ? 'is-invalid' : ''}"/>
                <form:errors path="fullName" class="text-danger"/>
            </div>

            <div class="mb-3">
                <label class="form-label">Email</label>
                <form:input path="email" class="form-control ${status.errorFields['email'] ? 'is-invalid' : ''}"/>
                <form:errors path="email" cssClass="invalid-feedback" />
            </div>

            <div class="mb-3">
                <label class="form-label">Số điện thoại</label>
                <form:input path="phone" class="form-control ${status.errorFields['phone'] ? 'is-invalid' : ''}"/>
                <form:errors path="phone" class="text-danger"/>
            </div>

            <div class="mb-3">
                <label class="form-label">Địa chỉ</label>
                <form:input path="address" class="form-control ${status.errorFields['address'] ? 'is-invalid' : ''}"/>
                <form:errors path="address" class="text-danger"/>
            </div>

            <div class="mb-3">
                <label class="form-label">Mật khẩu</label>
                <form:password path="password" class="form-control ${status.errorFields['password'] ? 'is-invalid' : ''}"/>
                <form:errors path="password" class="text-danger"/>
            </div>

            <div class="mb-3">
                <label for="avatarPath" class="form-label">Avatar</label>
                <input class="form-control" type="file" id="avatarPath" name="avatarPath"
                       accept=".png,.jpg,.jpeg"/>
            </div>

            <div class="mb-3">
                <label class="form-label">Vai trò</label>
                <form:select path="role.name" class="form-select ${status.errorFields['role.name'] ? 'is-invalid' : ''}">
                    <form:option value="ADMIN">ADMIN</form:option>
                    <form:option value="USER">USER</form:option>
                </form:select>
                <form:errors path="role.name" class="text-danger"/>
            </div>
<c:if test="${not empty errorMessage}">
    <div class="alert alert-danger">${errorMessage}</div>
</c:if>
            <button type="submit" class="btn btn-primary w-100">Lưu Người Dùng</button>
        </form:form>
    </div>

    <div class="mt-3 text-center">
        <a href="${pageContext.request.contextPath}/admin/user" class="btn btn-secondary">Quay lại danh sách</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
