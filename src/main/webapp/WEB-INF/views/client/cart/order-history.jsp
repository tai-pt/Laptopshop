<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8">
    <title>Lịch sử đơn hàng - Laptopshop</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Fonts & Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- CSS Libraries -->
    <link href="/laptopshop/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
    <link href="/laptopshop/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

    <!-- Bootstrap & Main CSS -->
    <link href="/laptopshop/client/css/bootstrap.min.css" rel="stylesheet">
    <link href="/laptopshop/client/css/style.css" rel="stylesheet">
</head>

<body>
    <jsp:include page="../layout/header.jsp" />

    <div class="container my-5">
        <h3 class="mb-4">Lịch sử đơn hàng của bạn</h3>

        <c:choose>
            <c:when test="${empty orders}">
                <div class="alert alert-info">Bạn chưa có đơn hàng nào.</div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-bordered table-hover text-center">
                        <thead class="table-dark">
                            <tr>
                                <th>Mã đơn hàng</th>
                                <th>Trạng thái</th>
                                <th>Chi tiết</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${orders}">
                                <tr>
                                    <td>${order.id}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${order.status == 'PENDING'}">Đang xử lý</c:when>
                                            <c:when test="${order.status == 'SHIPPED'}">Đã giao</c:when>
                                            <c:when test="${order.status == 'CANCELLED'}">Đã hủy</c:when>
                                            <c:otherwise>${order.status}</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/order/detail/${order.id}" class="btn btn-sm btn-primary">
                                            <i class="fas fa-eye"></i> Xem
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <jsp:include page="../layout/footer.jsp" />

    <!-- JS Libraries -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/laptopshop/client/lib/easing/easing.min.js"></script>
    <script src="/laptopshop/client/lib/waypoints/waypoints.min.js"></script>
    <script src="/laptopshop/client/lib/lightbox/js/lightbox.min.js"></script>
    <script src="/laptopshop/client/lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="/laptopshop/client/js/main.js"></script>
</body>

</html>
