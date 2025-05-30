<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Quên mật khẩu - LaptopShop</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap & Custom CSS -->
    <link href="/laptopshop/client/css/bootstrap.min.css" rel="stylesheet">
    <link href="/laptopshop/client/css/style.css" rel="stylesheet">
</head>
<body>

<jsp:include page="../layout/header.jsp" />

<div class="container d-flex justify-content-center align-items-center py-5" style="min-height: 80vh;">
    <div class="col-md-6 col-lg-5">
        <div class="card shadow-lg border-0 rounded-4 p-4">
            <h3 class="text-center text-primary mb-3">Forgot Password</h3>
            <p class="text-center text-muted mb-4">We will send a reset password link to your email.</p>

            <!-- Thông báo lỗi -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger text-center">${error}</div>
            </c:if>

            <!-- Thông báo thành công -->
            <c:if test="${not empty message}">
                <div class="alert alert-success text-center">${message}</div>
            </c:if>

            <!-- Form -->
            <form action="${pageContext.request.contextPath}/forgot_password" method="post">
                <!-- CSRF token nếu dùng Spring Security -->
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                <div class="mb-3">
                    <label class="form-label">Email address</label>
                    <input type="email" name="email" class="form-control" placeholder="Enter your email" required autofocus />
                </div>

                <div class="d-grid">
                    <button type="submit" class="btn btn-primary">Send Reset Link</button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp" />

<!-- JavaScript -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="/laptopshop/client/js/bootstrap.bundle.min.js"></script>
<script src="/laptopshop/client/js/main.js"></script>

</body>
</html>
