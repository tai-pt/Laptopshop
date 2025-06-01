<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <title>Reset Password - Laptopshop</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Bootstrap CSS -->
    <link href="${pageContext.request.contextPath}/client/css/bootstrap.min.css" rel="stylesheet" />

    <!-- FontAwesome -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />

    <!-- Custom Styles -->
    <link href="${pageContext.request.contextPath}/client/css/style.css" rel="stylesheet" />

    <script>
        // Check if confirm password matches password
        function checkPasswordMatch(confirmInput) {
            const pwd = document.getElementById("password").value;
            if (confirmInput.value !== pwd) {
                confirmInput.setCustomValidity("Passwords do not match");
            } else {
                confirmInput.setCustomValidity("");
            }
        }
    </script>
</head>

<body>

    <jsp:include page="../layout/header.jsp" />

    <div class="container my-5" style="max-width: 400px;">
        <h2 class="mb-4 text-center">Reset Your Password</h2>

        <form action="${pageContext.request.contextPath}/reset_password" method="post" novalidate>
            <!-- Hidden token field -->
            <input type="hidden" name="token" value="${token}" />
            <!-- CSRF token -->
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

            <div class="mb-3">
                <label for="password" class="form-label">New Password</label>
                <input type="password" class="form-control" id="password" name="password" required minlength="8"
                    placeholder="Enter new password" autofocus />
                <div class="form-text">Password must be at least 8 characters.</div>
                
            </div>

            <div class="mb-3">
                <label for="confirmPassword" class="form-label">Confirm New Password</label>
                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required
                    placeholder="Confirm new password" oninput="checkPasswordMatch(this)" />
                    
            </div>

            <div class="d-grid">
                <button type="submit" class="btn btn-primary">Change Password</button>
            </div>
        </form>
    </div>

    <jsp:include page="../layout/footer.jsp" />

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="${pageContext.request.contextPath}/client/lib/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/client/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/client/js/main.js"></script>

</body>

</html>
