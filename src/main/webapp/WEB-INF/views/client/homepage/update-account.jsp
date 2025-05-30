<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Cập nhật tài khoản</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h2>Cập nhật tài khoản</h2>

    <form action="/laptopshop/edit-account" method="post" enctype="multipart/form-data">
        <!-- Tên đầy đủ -->
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        
        <div class="mb-3">
            <label for="fullName" class="form-label">Họ và tên</label>
            <input type="text" class="form-control" id="fullName" name="fullName" value="${user.fullName}" required>
        </div>

        <!-- Số điện thoại -->
        <div class="mb-3">
            <label for="phone" class="form-label">Số điện thoại</label>
            <input type="text" class="form-control" id="phone" name="phone" value="${user.phone}">
        </div>

        <!-- Địa chỉ -->
        <div class="mb-3">
            <label for="address" class="form-label">Địa chỉ</label>
            <input type="text" class="form-control" id="address" name="address" value="${user.address}">
        </div>

        <!-- Ảnh đại diện -->
        <div class="mb-3">
            <label for="avatarPath" class="form-label">Ảnh đại diện</label>
            <input type="file" class="form-control" id="avatarPath" name="avatarPath" accept="image/*">
        </div>

        <!-- Nút cập nhật -->
        <button type="submit" class="btn btn-primary">Cập nhật</button>
    </form>
</div>
</body>
</html>
