<%@ page contentType="text/html; charset=UTF-8" %>
    <%@ page pageEncoding="UTF-8" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <title>Product Details</title>

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

                    .product-image {
                        width: 300px;
                        transition: transform 0.3s ease;
                    }

                    .product-image:hover {
                        transform: scale(1.1);
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

                <!-- Main Content -->
                <div class="content">
                    <div class="container mt-4">
                        <div class="card shadow-lg p-4">
                            <h3 class="mb-4 text-center"><i class="fas fa-info-circle"></i> Product Details</h3>

                            <div class="row">
                                <!-- Image -->
                                <div class="col-md-5 text-center">
                                    <img src="${pageContext.request.contextPath}/images/product/${product.image}"
                                        alt="Product Image" class="img-fluid product-image">
                                </div>

                                <!-- Product Details -->
                                <div class="col-md-7">
                                    <h4 class="mb-3"><i class="fas fa-tag"></i> ${product.name}</h4>
                                    <p><strong><i class="fas fa-dollar-sign"></i> Price:</strong> ${product.price}</p>
                                    <p><strong><i class="fas fa-boxes"></i> Quantity:</strong> ${product.quantity}</p>
                                    <p><strong><i class="fas fa-chart-line"></i> Sold:</strong> ${product.sold}</p>
                                    <p><strong><i class="fas fa-industry"></i> Factory:</strong> ${product.factory}</p>
                                    <p><strong><i class="fas fa-bullseye"></i> Target Audience:</strong>
                                        ${product.target}</p>
                                    <p><strong><i class="fas fa-align-right"></i> Short Description:</strong>
                                        ${product.shortDesc}</p>
                                    <p><strong><i class="fas fa-align-left"></i> Detail Description:</strong>
                                        ${product.detailDesc}</p>
                                </div>
                            </div>

                            <!-- Buttons -->
                            <div class="mt-4 text-center">
                                <a href="${pageContext.request.contextPath}/admin/product" class="btn btn-primary"><i
                                        class="fas fa-arrow-left"></i> Back to List</a>
                                <a href="${pageContext.request.contextPath}/admin/product/update/${product.id}"
                                    class="btn btn-warning"><i class="fas fa-edit"></i> Edit</a>
                                <a href="${pageContext.request.contextPath}/admin/product/delete/${product.id}"
                                    class="btn btn-danger" onclick="return confirm('Are you sure?')"><i
                                        class="fas fa-trash"></i> Delete</a>
                            </div>

                        </div>
                    </div>
                </div>

                <!-- Bootstrap & JS -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

            </body>

            </html>