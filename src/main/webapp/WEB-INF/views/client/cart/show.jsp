<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8">
                    <title> Giỏ hàng - Laptopshop</title>
                    <meta content="width=device-width, initial-scale=1.0" name="viewport">
                    <meta content="" name="keywords">
                    <meta content="" name="description">

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
                        class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
                        <div class="spinner-grow text-primary" role="status"></div>
                    </div>
                    <!-- Spinner End -->

                    <jsp:include page="../layout/header.jsp" />

                    <!-- Cart Page Start -->
                    <div class="container-fluid py-5">
                        <div class="container py-5">
                            <div class="mb-3">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="/">Home</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Chi Tiết Giỏ Hàng</li>
                                    </ol>
                                </nav>
                            </div>
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col">Sản phẩm</th>
                                            <th scope="col">Tên</th>
                                            <th scope="col">Giá cả</th>
                                            <th scope="col">Số lượng</th>
                                            <th scope="col">Thành tiền</th>
                                            <th scope="col">Xử lý</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${ empty cartDetails}">
                                            <tr>
                                                <td colspan="6">
                                                    Không có sản phẩm trong giỏ hàng
                                                </td>
                                            </tr>
                                        </c:if>
                                        <c:forEach var="cartDetail" items="${cartDetails}" varStatus="status">

                                            <tr>
                                                <th scope="row">
                                                    <div class="d-flex align-items-center">
                                                        <img src="/laptopshop/images/product/${cartDetail.product.image}"
                                                            class="img-fluid me-5 rounded-circle"
                                                            style="width: 80px; height: 80px;" alt="">
                                                    </div>
                                                </th>
                                                <td>
                                                    <p class="mb-0 mt-4">
                                                        <a href="/laptopshop/product/${cartDetail.product.id}"
                                                            target="_blank">
                                                            ${cartDetail.product.name}
                                                        </a>
                                                    </p>
                                                </td>
                                                <td>
                                                    <p class="mb-0 mt-4">
                                                        <fmt:formatNumber type="number" value="${cartDetail.price}" /> đ
                                                    </p>
                                                </td>
                                                <td>
                                                    <div class="input-group quantity mt-4" style="width: 100px;">
                                                        <div class="input-group-btn">
                                                            <button
                                                                class="btn btn-sm btn-minus rounded-circle bg-light border">
                                                                <i class="fa fa-minus"></i>
                                                            </button>
                                                        </div>
                                                        <input type="text"
                                                            class="form-control form-control-sm text-center border-0"
                                                            value="${cartDetail.quantity}"
                                                            data-cart-detail-id="${cartDetail.id}"
                                                            data-cart-detail-price="${cartDetail.price}"
                                                            data-cart-detail-index="${status.index}">
                                                        <div class="input-group-btn">
                                                            <button
                                                                class="btn btn-sm btn-plus rounded-circle bg-light border">
                                                                <i class="fa fa-plus"></i>
                                                            </button>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <p class="mb-0 mt-4" data-cart-detail-id="${cartDetail.id}">
                                                        <fmt:formatNumber type="number"
                                                            value="${cartDetail.price * cartDetail.quantity}" /> đ
                                                    </p>
                                                </td>
                                                <td>
                                                    <form method="post"
                                                        action="/laptopshop/delete-cart/${cartDetail.id}">
                                                        <input type="hidden" name="${_csrf.parameterName}"
                                                            value="${_csrf.token}" />
                                                        <button class="btn btn-md rounded-circle bg-light border mt-4">
                                                            <i class="fa fa-times text-danger"></i>
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>

                                    </tbody>
                                </table>
                            </div>
                            <c:if test="${not empty cartDetails}">
                                <div class="mt-5 row g-4 justify-content-start">
                                    <div class="col-12 col-md-8">
                                        <div class="bg-light rounded">
                                            <div class="p-4">
                                                <h1 class="display-6 mb-4">Thông Tin <span class="fw-normal">Đơn
                                                        Hàng</span>
                                                </h1>
                                                <div class="d-flex justify-content-between mb-4">
                                                    <h5 class="mb-0 me-4">Tạm tính:</h5>
                                                    <p class="mb-0" data-cart-total-price="${totalPrice}">
                                                        <fmt:formatNumber type="number" value="${totalPrice}" /> đ
                                                    </p>
                                                </div>
                                                <div class="d-flex justify-content-between">
                                                    <h5 class="mb-0 me-4">Phí vận chuyển</h5>
                                                    <div class="">
                                                        <p class="mb-0">0 đ</p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div
                                                class="py-4 mb-4 border-top border-bottom d-flex justify-content-between">
                                                <h5 class="mb-0 ps-4 me-4">Tổng số tiền</h5>
                                                <p class="mb-0 pe-4" data-cart-total-price="${totalPrice}">
                                                    <fmt:formatNumber type="number" value="${totalPrice}" /> đ
                                                </p>
                                            </div>
                                            <form:form action="/laptopshop/cart/check-out" method="post"
                                                modelAttribute="cart">
                                                <input type="hidden" name="${_csrf.parameterName}"
                                                    value="${_csrf.token}" />
                                                <div style="display: none;">
                                                    <c:forEach var="cartDetail" items="${cart.cartDetails}"
                                                        varStatus="status">
                                                        <div class="mb-3">
                                                            <div class="form-group">
                                                                <label>Id:</label>
                                                                <form:input class="form-control" type="text"
                                                                    value="${cartDetail.id}"
                                                                    path="cartDetails[${status.index}].id" />
                                                            </div>
                                                            <div class="form-group">
                                                                <label>Quantity:</label>
                                                                <form:input class="form-control" type="text"
                                                                    value="${cartDetail.quantity}"
                                                                    path="cartDetails[${status.index}].quantity" />
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                                <button
                                                    class="btn border-secondary rounded-pill px-4 py-3 text-primary text-uppercase mb-4 ms-4">Xác
                                                    nhận thanh toán
                                                </button>
                                            </form:form>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </div>
                    <!-- Cart Page End -->


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
                    <script>
                        (function ($) {
                            "use strict";

                            // Spinner
                            var spinner = function () {
                                setTimeout(function () {
                                    if ($('#spinner').length > 0) {
                                        $('#spinner').removeClass('show');
                                    }
                                }, 1);
                            };
                            spinner(0);


                            // Fixed Navbar
                            $(window).scroll(function () {
                                if ($(window).width() < 992) {
                                    if ($(this).scrollTop() > 55) {
                                        $('.fixed-top').addClass('shadow');
                                    } else {
                                        $('.fixed-top').removeClass('shadow');
                                    }
                                } else {
                                    if ($(this).scrollTop() > 55) {
                                        $('.fixed-top').addClass('shadow').css('top', -55);
                                    } else {
                                        $('.fixed-top').removeClass('shadow').css('top', 0);
                                    }
                                }
                            });


                            // Back to top button
                            $(window).scroll(function () {
                                if ($(this).scrollTop() > 300) {
                                    $('.back-to-top').fadeIn('slow');
                                } else {
                                    $('.back-to-top').fadeOut('slow');
                                }
                            });
                            $('.back-to-top').click(function () {
                                $('html, body').animate({ scrollTop: 0 }, 1500, 'easeInOutExpo');
                                return false;
                            });


                            // Testimonial carousel
                            $(".testimonial-carousel").owlCarousel({
                                autoplay: true,
                                smartSpeed: 2000,
                                center: false,
                                dots: true,
                                loop: true,
                                margin: 25,
                                nav: true,
                                navText: [
                                    '<i class="bi bi-arrow-left"></i>',
                                    '<i class="bi bi-arrow-right"></i>'
                                ],
                                responsiveClass: true,
                                responsive: {
                                    0: {
                                        items: 1
                                    },
                                    576: {
                                        items: 1
                                    },
                                    768: {
                                        items: 1
                                    },
                                    992: {
                                        items: 2
                                    },
                                    1200: {
                                        items: 2
                                    }
                                }
                            });


                            // vegetable carousel
                            $(".vegetable-carousel").owlCarousel({
                                autoplay: true,
                                smartSpeed: 1500,
                                center: false,
                                dots: true,
                                loop: true,
                                margin: 25,
                                nav: true,
                                navText: [
                                    '<i class="bi bi-arrow-left"></i>',
                                    '<i class="bi bi-arrow-right"></i>'
                                ],
                                responsiveClass: true,
                                responsive: {
                                    0: {
                                        items: 1
                                    },
                                    576: {
                                        items: 1
                                    },
                                    768: {
                                        items: 2
                                    },
                                    992: {
                                        items: 3
                                    },
                                    1200: {
                                        items: 4
                                    }
                                }
                            });


                            // Modal Video
                            $(document).ready(function () {
                                var $videoSrc;
                                $('.btn-play').click(function () {
                                    $videoSrc = $(this).data("src");
                                });
                                console.log($videoSrc);

                                $('#videoModal').on('shown.bs.modal', function (e) {
                                    $("#video").attr('src', $videoSrc + "?autoplay=1&amp;modestbranding=1&amp;showinfo=0");
                                })

                                $('#videoModal').on('hide.bs.modal', function (e) {
                                    $("#video").attr('src', $videoSrc);
                                })
                            });



                            // Product Quantity
                            // Product Quantity (Improved)
                            $('.quantity button').on('click', function () {
                                var button = $(this);
                                var input = button.closest('.quantity').find('input');
                                var oldValue = parseInt(input.val());
                                var newVal = oldValue;

                                if (button.hasClass('btn-plus')) {
                                    newVal = oldValue + 1;
                                } else {
                                    newVal = (oldValue > 1) ? oldValue - 1 : 1; // Giới hạn tối thiểu là 1
                                }

                                input.val(newVal);

                                // Cập nhật tổng giá nếu có
                                var parentRow = button.closest('.product-row'); // đảm bảo mỗi sản phẩm bọc trong .product-row
                                var unitPrice = parseFloat(parentRow.find('.item-price').text()) || 0;
                                parentRow.find('.item-total').text((unitPrice * newVal).toFixed(2));
                            });

                        })(jQuery);


                    </script>
                </body>

                </html>