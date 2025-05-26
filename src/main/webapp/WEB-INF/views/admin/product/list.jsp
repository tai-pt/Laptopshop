<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Product List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
        .table img {
            width: 50px;
            border-radius: 5px;
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

    <!-- Main Content -->
    <div class="content">
        <h2 class="mb-4">Product List</h2>

        <!-- Thêm sản phẩm -->
        <a href="${pageContext.request.contextPath}/admin/product/create" class="btn btn-primary mb-3">
            <i class="fas fa-plus"></i> Add Product
        </a>

        <!-- Bảng danh sách sản phẩm -->
        <table class="table table-bordered table-striped">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Sold</th>
                    <th>Factory</th>
                    <th>Target</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="product" items="${product}">
                    <tr>
                        <td>${product.id}</td>
                        <td>${product.name}</td>
                        <td>${product.price} $</td>
                        <td>${product.quantity}</td>
                        <td>${product.sold}</td>
                        <td>${product.factory}</td>
                        <td>${product.target}</td>
                        <td>
                            <a href="product/view/${product.id}" class="btn btn-info btn-sm"><i class="fas fa-eye"></i></a>
                            <a href="product/update/${product.id}" class="btn btn-warning btn-sm"><i class="fas fa-edit"></i></a>
                            <a href="product/delete/${product.id}" class="btn btn-danger btn-sm"><i class="fas fa-trash"></i></a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- Biểu đồ số lượng sản phẩm đã bán -->
        <div class="row mt-4">
            <div class="col-md-8">
                <div class="card p-3">
                    <h5>Sales Statistics</h5>
                    <canvas id="salesChart"></canvas>
                </div>
            </div>
        </div>

        <!-- Phân trang -->
        <nav class="mt-4">
            <ul class="pagination justify-content-center">
                <c:forEach begin="1" end="${totalPage}" var="i">
                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                        <a class="page-link" href="?page=${i}">${i}</a>
                    </li>
                </c:forEach>
            </ul>
        </nav>
    </div>

    <!-- Bootstrap & JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Chart.js for Sales Chart -->
    <script>
        $(document).ready(function() {
            let ctx = document.getElementById('salesChart').getContext('2d');
            let productNames = [];
            let soldQuantities = [];

            // Lấy dữ liệu từ danh sách sản phẩm
            <c:forEach var="product" items="${product}">
                productNames.push("${product.name}");
                soldQuantities.push(${product.sold});
            </c:forEach>

            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: productNames,
                    datasets: [{
                        label: 'Sold Quantity',
                        data: soldQuantities,
                        backgroundColor: 'rgba(54, 162, 235, 0.6)',
                        borderColor: 'rgba(54, 162, 235, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            display: true,
                            position: 'top'
                        }
                    }
                }
            });
        });
    </script>

</body>
</html>
