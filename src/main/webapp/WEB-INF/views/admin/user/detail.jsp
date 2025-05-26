<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <title>Chi Tiết Người Dùng</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
                <a href="${pageContext.request.contextPath}/admin/orders"><i class="fas fa-shopping-cart"></i>
                    Orders</a>
                <a href="${pageContext.request.contextPath}/admin/user"><i class="fas fa-users"></i> Users</a>
            </div>

            <!-- Content -->
            <div class="content">
                <h2 class="text-center">Chi Tiết Người Dùng</h2>
                <div class="card shadow-lg p-4">
                    <table class="table table-bordered">
                        <tr>
                            <th>ID</th>
                            <td>${user.id}</td>
                        </tr>
                        <tr>
                            <th>Họ và Tên</th>
                            <td>${user.fullName}</td>
                        </tr>
                        <tr>
                            <th>Email</th>
                            <td>${user.email}</td>
                        </tr>
                        <tr>
                            <th>Số điện thoại</th>
                            <td>${user.phone}</td>
                        </tr>
                        <tr>
                            <th>Avatar</th>
                            <td><img src="${pageContext.request.contextPath}/images/avatar/${user.avatar}" alt="Avatar"
                                    class="img-thumbnail" width="100"></td>
                        </tr>
                        <tr>
                            <th>Vai trò</th>
                            <td><span class="badge bg-info">${user.role.name}</span></td>
                        </tr>
                    </table>
                    <div class="text-center">
                        <a href="${pageContext.request.contextPath}/admin/user" class="btn btn-secondary">Quay lại danh
                            sách</a>
                    </div>
                </div>
            </div>
        </body>

        </html>