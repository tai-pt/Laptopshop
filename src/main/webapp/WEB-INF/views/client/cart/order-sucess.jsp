<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8">
                    <title>Đặt hàng thành công - Laptopshop</title>
                    <meta content="width=device-width, initial-scale=1.0" name="viewport">

                    <!-- Google Web Fonts -->
                    <link rel="preconnect" href="https://fonts.googleapis.com">
                    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                    <link
                        href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                        rel="stylesheet">

                    <!-- Icon Font Stylesheet -->
                    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                        rel="stylesheet">

                    <!-- Libraries Stylesheet -->
                    <link href="/laptopshop/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
                    <link href="/laptopshop/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

                    <!-- Customized Bootstrap Stylesheet -->
                    <link href="/laptopshop/client/css/bootstrap.min.css" rel="stylesheet">

                    <!-- Template Stylesheet -->
                    <link href="/laptopshop/client/css/style.css" rel="stylesheet">
                </head>

                <body>

                    <!-- Spinner Start -->
                    <div id="spinner"
                        class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 d-flex align-items-center justify-content-center">
                        <div class="spinner-grow text-primary" role="status"></div>
                    </div>
                    <!-- Spinner End -->

                    <jsp:include page="../layout/header.jsp" />

                    <!-- Order Success Start -->
                    <div class="container my-5">
                        <div class="row justify-content-center">
                            <div class="col-md-8 text-center">
                                <div class="card shadow p-5">
                                    <div class="mb-4">
                                        <i class="bi bi-check-circle-fill text-success" style="font-size: 5rem;"></i>
                                    </div>
                                    <h2 class="mb-3">Đặt hàng thành công!</h2>
                                    <p class="mb-4">Cảm ơn bạn đã mua hàng tại Laptopshop. Chúng tôi sẽ sớm liên hệ để
                                        xác nhận và giao hàng.</p>
                                    <a href="/laptopshop" class="btn btn-primary me-2">Tiếp tục mua sắm</a>
                                    <a href="/laptopshop/order-history" class="btn btn-outline-secondary">Xem đơn
                                        hàng</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Order Success End -->

                    <jsp:include page="../layout/footer.jsp" />

                    <!-- Back to Top -->
                    <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
                            class="fa fa-arrow-up"></i></a>

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