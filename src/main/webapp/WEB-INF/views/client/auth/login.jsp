<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Login - LaptopShop</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Styles -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/styles.css" rel="stylesheet">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>

<body class="bg-light d-flex align-items-center" style="min-height: 100vh;">

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-4">
                <div class="card shadow border-0 rounded-4 p-4">
                    <div class="card-header text-center bg-white border-0">
                        <h3 class="text-primary fw-bold mb-0">LaptopShop</h3>
                        <small class="text-muted">Sign in to your account</small>
                    </div>

                    <div class="card-body">
                        <form method="post" action="${pageContext.request.contextPath}/login">
                            <!-- Thông báo lỗi đăng nhập -->
                            <c:if test="${param.error != null}">
                                <div class="alert alert-danger text-center">
                                    Invalid email or password.
                                </div>
                            </c:if>

                            <div class="mb-3">
                                <label class="form-label">Email address</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                    <input type="email" name="username" class="form-control"
                                           placeholder="name@example.com" required />
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Password</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                    <input type="password" name="password" class="form-control"
                                           placeholder="Password" required />
                                </div>
                                <div class="mt-2 text-end">
                                    <a href="${pageContext.request.contextPath}/forgot_password" class="small">Forgot Password ?</a>
                                </div>
                            </div>

                            <!-- CSRF Token -->
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary">Login</button>
                            </div>
                        </form>
                    </div>

                    <div class="card-footer text-center bg-white border-0">
                        <small>Don't have an account? <a href="${pageContext.request.contextPath}/register">Sign up!</a></small>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
            crossorigin="anonymous"></script>
</body>

</html>
