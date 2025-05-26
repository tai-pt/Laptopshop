<%@ page contentType="text/html; charset=UTF-8" %>
    <%@ page pageEncoding="UTF-8" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8" />
                <title>Danh sách đơn hàng</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
                <link rel="stylesheet"
                    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
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
                </style>
            </head>

            <body>
                <div class="sidebar">
                    <h4 class="text-center text-white">Admin Panel</h4>
                    <a href="${pageContext.request.contextPath}/admin"><i class="fas fa-home"></i> Dashboard</a>
                    <a href="${pageContext.request.contextPath}/admin/product"><i class="fas fa-box"></i> Products</a>
                    <a href="${pageContext.request.contextPath}/admin/order"><i class="fas fa-shopping-cart"></i>
                        Orders</a>
                    <a href="${pageContext.request.contextPath}/admin/user"><i class="fas fa-users"></i> Users</a>
                </div>

                <div class="content">
                    <h2 class="mb-4">Danh sách đơn hàng</h2>
                    <table class="table table-bordered table-striped">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Customer Name</th>
                                <th>Total Price</th>
                                <th>Address</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${order}">
                                <tr>
                                    <td>${order.id}</td>
                                    <td>${order.name}</td>
                                    <td>
                                        <fmt:formatNumber value="${order.total_price}" type="currency"
                                            currencySymbol="₫" />
                                    </td>
                                    <td>${order.address}</td>
                                    <td>${order.status}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/order/view/${order.id}"
                                            class="btn btn-info btn-sm">
                                            <i class="fa fa-eye"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/order/update/${order.id}"
                                            class="btn btn-warning btn-sm">
                                            <i class="fa fa-edit"></i>
                                        </a>
                                        <form method="post"
                                            action="${pageContext.request.contextPath}/admin/order/delete/${order.id}"
                                            style="display:inline-block;"
                                            onsubmit="return confirm('Bạn có chắc muốn xóa đơn hàng này không?');">
                                            <sec:csrfInput />
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                                            <button type="submit" class="btn btn-danger btn-sm">
                                                <i class="fa fa-times"></i> Delete
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

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

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>