<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap & FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            overflow-x: hidden;
        }

        .navbar {
            z-index: 1000;
        }

        .sidebar {
            width: 250px;
            background: #343a40;
            color: white;
            flex-shrink: 0;
            min-height: 100vh;
        }

        .sidebar a {
            display: block;
            color: white;
            padding: 12px 20px;
            text-decoration: none;
        }

        .sidebar a:hover {
            background: #495057;
        }

        .main-wrapper {
            display: flex;
            flex-grow: 1;
        }

        .content {
            flex-grow: 1;
            padding: 30px;
            background-color: #f8f9fa;
        }

        .card {
            border-radius: 12px;
        }

        .chart-container {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                height: auto;
            }

            .main-wrapper {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>

<!-- Header -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark w-100 px-4 py-2">
    <div class="container-fluid justify-content-between">
        <span class="navbar-brand mb-0 h4">Admin</span>
        <div class="d-flex align-items-center">
            <span class="me-3 text-white">Hello, <strong>${sessionScope.fullName}</strong></span>
            <div class="dropdown">
                <a href="#" class="d-flex align-items-center text-white text-decoration-none dropdown-toggle" id="adminDropdown" data-bs-toggle="dropdown">
                    <img src="${pageContext.request.contextPath}/images/avatar/${sessionScope.avatar}" alt="avatar" width="40" height="40" class="rounded-circle me-2">
                </a>
                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="adminDropdown">
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile">Thông tin cá nhân</a></li>
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/change-password">Đổi mật khẩu</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li>
                        <form method="post" action="${pageContext.request.contextPath}/logout" class="m-0">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <button class="dropdown-item" type="submit">Đăng xuất</button>
                        </form>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</nav>

<!-- Sidebar + Main Content Wrapper -->
<div class="main-wrapper">
    <!-- Sidebar -->
    <div class="sidebar">
        <h4 class="text-center py-3">Admin Panel</h4>
        <a href="${pageContext.request.contextPath}/admin"><i class="fas fa-home me-2"></i> Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/product"><i class="fas fa-box me-2"></i> Products</a>
        <a href="${pageContext.request.contextPath}/admin/order"><i class="fas fa-shopping-cart me-2"></i> Orders</a>
        <a href="${pageContext.request.contextPath}/admin/user"><i class="fas fa-users me-2"></i> Users</a>
    </div>

    <!-- Main Content -->
    <div class="content">
        <h2 class="mb-4">Tổng quan quản trị</h2>

        <!-- Summary Cards -->
        <div class="row g-4 mb-5">
            <div class="col-md-4">
                <div class="card text-white bg-primary h-100 shadow-sm">
                    <div class="card-body d-flex align-items-center">
                        <i class="fas fa-users fa-3x me-3"></i>
                        <div>
                            <h6 class="card-title mb-1">Người dùng</h6>
                            <h3>${countUser}</h3>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card text-white bg-success h-100 shadow-sm">
                    <div class="card-body d-flex align-items-center">
                        <i class="fas fa-laptop fa-3x me-3"></i>
                        <div>
                            <h6 class="card-title mb-1">Sản phẩm</h6>
                            <h3>${countProduct}</h3>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card text-white bg-warning h-100 shadow-sm">
                    <div class="card-body d-flex align-items-center">
                        <i class="fas fa-shopping-cart fa-3x me-3"></i>
                        <div>
                            <h6 class="card-title mb-1">Đơn hàng</h6>
                            <h3>${countOrder}</h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Revenue Chart -->
        <div class="chart-container">
            <h5 class="mb-4">Biểu đồ doanh thu 6 tháng gần nhất</h5>
            <canvas id="salesChart" height="100"></canvas>
        </div>
    </div>
</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    $(document).ready(function () {
        const ctx = document.getElementById('salesChart').getContext('2d');
        new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6'],
                datasets: [{
                    label: 'Doanh thu (VNĐ)',
                    data: [12000000, 15000000, 10000000, 18000000, 22000000, 25000000],
                    borderColor: '#007bff',
                    backgroundColor: 'rgba(0, 123, 255, 0.2)',
                    tension: 0.3,
                    fill: true
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top'
                    }
                },
                scales: {
                    y: {
                        ticks: {
                            callback: function (value) {
                                return value.toLocaleString('vi-VN') + ' đ';
                            }
                        }
                    }
                }
            }
        });
    });
</script>
</body>
</html>
