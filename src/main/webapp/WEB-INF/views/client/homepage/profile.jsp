<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thông tin cá nhân - LaptopShop</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet">

    <!-- Icon & Bootstrap -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="/laptopshop/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
    <link href="/laptopshop/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="/laptopshop/client/css/bootstrap.min.css" rel="stylesheet">
    <link href="/laptopshop/client/css/style.css" rel="stylesheet">
</head>

<body>
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            <div class="card shadow rounded-4 border-0">
                <div class="card-body text-center">
                    <h3 class="mb-4 text-primary">Thông tin cá nhân</h3>

                    <c:if test="${not empty user.avatar}">
                        <img src="/laptopshop/images/avatar/${user.avatar}" alt="Avatar"
                             class="rounded-circle mb-3" style="width: 120px; height: 120px; object-fit: cover;">
                    </c:if>

                    <ul class="list-group list-group-flush text-start">
                        <li class="list-group-item"><strong>Họ tên:</strong> ${user.fullName}</li>
                        <li class="list-group-item"><strong>Email:</strong> ${user.email}</li>
                        <li class="list-group-item"><strong>Số điện thoại:</strong> ${user.phone}</li>
                        <li class="list-group-item"><strong>Địa chỉ:</strong> ${user.address}</li>
                    </ul>

                    <div class="mt-4 d-flex justify-content-between">
                        <a href="/laptopshop" class="btn btn-outline-primary px-4">Trang chủ</a>
                        <a href="/laptopshop/edit-account" class="btn btn-primary px-4">Chỉnh sửa</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../layout/feature.jsp" />
<jsp:include page="../layout/footer.jsp" />

<!-- Back to Top -->
<a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top">
    <i class="fa fa-arrow-up"></i>
</a>

<!-- JavaScript -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/client/lib/easing/easing.min.js"></script>
<script src="${pageContext.request.contextPath}/client/lib/waypoints/waypoints.min.js"></script>
<script src="${pageContext.request.contextPath}/client/lib/lightbox/js/lightbox.min.js"></script>
<script src="${pageContext.request.contextPath}/client/lib/owlcarousel/owl.carousel.min.js"></script>
<script src="${pageContext.request.contextPath}/client/js/main.js"></script>
</body>
</html>
