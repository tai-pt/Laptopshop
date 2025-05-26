<%@ page contentType="text/html; charset=UTF-8" %>
    <%@ page pageEncoding="UTF-8" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8" />
                <title>Order Details</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
                <link rel="stylesheet"
                    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
                <style>
                    body {
                        display: flex;
                        margin: 0;
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
                <div class="sidebar">
                    <h4 class="text-center text-white">Admin Panel</h4>
                    <a href="${pageContext.request.contextPath}/admin"><i class="fas fa-home"></i> Dashboard</a>
                    <a href="${pageContext.request.contextPath}/admin/order"><i class="fas fa-shopping-cart"></i>
                        Orders</a>
                </div>
                <div class="content">
                    <div class="container mt-4">
                        <div class="card shadow-lg p-4">
                            <h3 class="mb-4 text-center"><i class="fas fa-receipt"></i> Order Details</h3>
                            <p><strong><i class="fas fa-user"></i> Customer Name:</strong> ${order.name}</p>
                            <p><strong><i class="fas fa-map-marker-alt"></i> Address:</strong> ${order.address}</p>
                            <p><strong><i class="fas fa-dollar-sign"></i> Total Price:</strong>
                                <fmt:formatNumber value="${order.total_price}" type="currency" currencySymbol="₫" />
                            </p>
                            <p><strong><i class="fas fa-clock"></i> Status:</strong> ${order.status}</p>

                            <div class="mt-4 text-center">

                                <a href="${pageContext.request.contextPath}/admin/order" class="btn btn-primary"><i
                                        class="fas fa-arrow-left"></i> Back to Orders</a>
                                <a href="${pageContext.request.contextPath}/admin/order/update/${order.id}"
                                    class="btn btn-warning"><i class="fas fa-edit"></i> Edit</a>


                                <form method="post"
                                    action="${pageContext.request.contextPath}/admin/order/delete/${order.id}"
                                    style="display:inline-block;"
                                    onsubmit="return confirm('Bạn có chắc muốn xóa đơn hàng này không?');">
                                    <sec:csrfInput />
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                                    <button type="submit" class="btn btn-danger">
                                        <i class="fa fa-times"></i> Delete
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>