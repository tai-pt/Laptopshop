<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8" />
    <title>Chi tiết đơn hàng - Laptopshop</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
        href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
        rel="stylesheet" />

    <!-- Icon Font Stylesheet -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet" />

    <!-- Libraries Stylesheet -->
    <link href="/laptopshop/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet" />
    <link href="/laptopshop/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet" />

    <!-- Customized Bootstrap Stylesheet -->
    <link href="/laptopshop/client/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Template Stylesheet -->
    <link href="/laptopshop/client/css/style.css" rel="stylesheet" />
</head>

<body>
    <!-- Spinner Start -->
    <div id="spinner"
        class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 d-flex align-items-center justify-content-center">
        <div class="spinner-grow text-primary" role="status"></div>
    </div>
    <!-- Spinner End -->

    <jsp:include page="../layout/header.jsp" />

    <main class="container my-5">
        <h2 class="mb-4 text-center">Chi tiết đơn hàng</h2>

        <div class="table-responsive shadow-sm rounded">
            <table class="table table-bordered table-striped align-middle mb-0">
                <thead class="table-dark">
                    <tr class="text-center">
                        <th scope="col">STT</th>
                        <th scope="col">Sản phẩm</th>
                        <th scope="col">Số lượng</th>
                        <th scope="col">Giá (VNĐ)</th>
                        <th scope="col">Tổng tiền (VNĐ)</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${orderDetails}" varStatus="status">
                        <tr>
                            <td class="text-center">${status.index + 1}</td>
                            <td>${item.product.name}</td>
                            <td class="text-center">${item.quantity}</td>
                            <td class="text-end">
                                <fmt:formatNumber value="${item.price}" type="currency" currencySymbol="₫"
                                    groupingUsed="true" />
                            </td>
                            <td class="text-end">
                                <fmt:formatNumber value="${item.price * item.quantity}" type="currency"
                                    currencySymbol="₫" groupingUsed="true" />
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="mt-4 d-flex justify-content-center">
            <a href="${pageContext.request.contextPath}" class="btn btn-secondary">
                <i class="fas fa-arrow-left me-2"></i> Back
            </a>
        </div>
    </main>

    <jsp:include page="../layout/footer.jsp" />

    <!-- Back to Top -->
    <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top position-fixed"
        style="bottom: 20px; right: 20px; width: 45px; height: 45px;">
        <i class="fa fa-arrow-up"></i>
    </a>

    <!-- JavaScript Libraries -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/laptopshop/client/lib/easing/easing.min.js"></script>
    <script src="/laptopshop/client/lib/waypoints/waypoints.min.js"></script>
    <script src="/laptopshop/client/lib/lightbox/js/lightbox.min.js"></script>
    <script src="/laptopshop/client/lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="/laptopshop/client/js/main.js"></script>
</body>

</html>
