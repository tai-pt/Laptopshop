<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Dashboard - Quản lý Người Dùng</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
        <a href="${pageContext.request.contextPath}/admin/order"><i class="fas fa-shopping-cart"></i> Orders</a>
        <a href="${pageContext.request.contextPath}/admin/user"><i class="fas fa-users"></i> Users</a>
    </div>

    <div class="content">
        <h2 class="mb-4"><i class="fa-solid fa-users"></i> Quản Lý Người Dùng</h2>
        <canvas id="userChart" width="400" height="150"></canvas>
        <a href="${pageContext.request.contextPath}/admin/user/save" class="btn btn-primary my-3">
            <i class="fa fa-plus"></i> Thêm Người Dùng
        </a>
        <table class="table table-bordered table-hover shadow-sm">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th><i class="fa fa-user"></i> Username</th>
                    <th><i class="fa fa-envelope"></i> Email</th>
                    <th><i class="fa fa-map-marker-alt"></i> Address</th>
                    <th><i class="fa fa-phone"></i> Phone</th>
                    <th><i class="fa fa-user-shield"></i> Role</th>
                    <th><i class="fa fa-cogs"></i> Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="u" items="${user}">
                    <tr>
                        <td>${u.id}</td>
                        <td>${u.fullName}</td>
                        <td>${u.email}</td>
                        <td>${u.address}</td>
                        <td>${u.phone}</td>                    
                        <td><span class="badge bg-info">${u.role.name}</span></td>
                        <td>
                            <a href="user/find/${u.id}" class="btn btn-success btn-sm">
                                <i class="fa fa-eye"></i> Xem
                            </a>
                            <a href="user/update/${u.id}" class="btn btn-warning btn-sm">
                                <i class="fa fa-edit"></i> Cập Nhật
                            </a>
                            <a href="user/delete/${u.id}" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn xóa người dùng này?')">
                                <i class="fa fa-trash"></i> Xóa
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        
        <!-- Phân trang -->
        <nav>
            <ul class="pagination justify-content-center">
                <c:forEach begin="1" end="${totalPage}" var="i">
                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                        <a class="page-link" href="?page=${i}">${i}</a>
                    </li>
                </c:forEach>
            </ul>
        </nav>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
