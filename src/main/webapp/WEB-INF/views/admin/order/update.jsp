<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Cập nhật trạng thái đơn hàng</title>
    
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    
    <style>
        body {
            display: flex;
        }
        .sidebar {
            width: 250px;
            height: 100vh;
            background: #343a40;
            padding-top: 20px;
            position: fixed;
        }
        .sidebar a {
            display: block;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
        }
        .sidebar a:hover {
            background: #495057;
        }
        .content {
            margin-left: 250px;
            padding: 20px;
            width: 100%;
        }
    </style>
</head>
<body>

    <!-- Sidebar -->
    <div class="sidebar">
        <h4 class="text-center text-white">Admin Panel</h4>
        <a href="${pageContext.request.contextPath}/admin"><i class="fas fa-home"></i> Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/order"><i class="fas fa-shopping-cart"></i> Orders</a>
    </div>

    <!-- Main Content -->
    <div class="content">
        <div class="container mt-4">
            <div class="card shadow-lg p-4">
                <h3 class="mb-4 text-center"><i class="fas fa-edit"></i> Cập nhật trạng thái đơn hàng</h3>
                
                <form:form action="${pageContext.request.contextPath}/admin/order/update/${order.id}" method="post" modelAttribute="order">
                    <input type="hidden" name="id" value="${order.id}">
                    
                    <div class="mb-3">
                        <label class="form-label"><i class="fas fa-hashtag"></i> Mã đơn hàng:</label>
                        <input type="text" class="form-control" value="${order.id}" disabled>
                    </div>

                    <div class="mb-3">
                        <label class="form-label"><i class="fas fa-info-circle"></i> Trạng thái</label>
                        <form:select path="status" class="form-select">
                            <form:option value="Pending">Chờ xử lý</form:option>
                            <form:option value="Shipped">Đang giao hàng</form:option>
                            <form:option value="Delivered">Đã giao</form:option>
                            <form:option value="Cancelled">Đã hủy</form:option>
                        </form:select>
                    </div>
                    
                    <div class="mt-4 text-center">
                        <a href="${pageContext.request.contextPath}/admin/order" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Quay lại</a>
                        <button type="submit" class="btn btn-success"><i class="fas fa-save"></i> Cập nhật</button>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
