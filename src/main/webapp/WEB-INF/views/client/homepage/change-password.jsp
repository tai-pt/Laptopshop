<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đổi mật khẩu - LaptopShop</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet">

    <!-- Icon & Bootstrap -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/client/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/client/css/style.css" rel="stylesheet">
</head>

<body>
<div class="container mt-5 mb-5">
    <h2 class="mb-4">Đổi mật khẩu</h2>

    <form:form action="${pageContext.request.contextPath}/change-password" method="post" modelAttribute="password">
        <!-- CSRF Token -->
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

  <!-- Mật khẩu hiện tại -->
<div class="mb-3">
    <label for="oldPassword" class="form-label">Mật khẩu hiện tại</label>
    <form:password path="oldPassword" id="oldPassword" cssClass="form-control"/>
    <form:errors path="oldPassword" cssClass="text-danger mt-1"/>
</div>

        <!-- Mật khẩu mới -->
        <div class="mb-3">
            <label for="newPassword" class="form-label">Mật khẩu mới</label>
            <form:password path="password" cssClass="form-control" id="newPassword"/>
            <form:errors path="password" cssClass="text-danger"/>
        </div>

        <!-- Xác nhận mật khẩu mới -->
        <div class="mb-3">
            <label for="confirmPassword" class="form-label">Xác nhận mật khẩu mới</label>
            <form:password path="confirmPassword" cssClass="form-control" id="confirmPassword"/>
            <form:errors path="confirmPassword" cssClass="text-danger"/>
        </div>

        <!-- Nút hành động -->
        <div class="d-flex justify-content-between">
            <a href="${pageContext.request.contextPath}/profile" class="btn btn-secondary">
                <i class="fas fa-arrow-left me-1"></i> Quay lại
            </a>
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-key me-1"></i> Đổi mật khẩu
            </button>
        </div>
    </form:form>
</div>

<!-- Include layout -->
<jsp:include page="../layout/feature.jsp" />
<jsp:include page="../layout/footer.jsp" />

<!-- Back to Top -->
<a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top">
    <i class="fa fa-arrow-up"></i>
</a>

<!-- JavaScript Libraries -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/client/lib/easing/easing.min.js"></script>
<script src="${pageContext.request.contextPath}/client/lib/waypoints/waypoints.min.js"></script>
<script src="${pageContext.request.contextPath}/client/lib/lightbox/js/lightbox.min.js"></script>
<script src="${pageContext.request.contextPath}/client/lib/owlcarousel/owl.carousel.min.js"></script>
<script src="${pageContext.request.contextPath}/client/js/main.js"></script>

</body>
</html>
