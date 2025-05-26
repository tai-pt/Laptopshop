<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="Register - Laptopshop" />
    <meta name="author" content="Laptopshop Team" />
    <title>Register - Laptopshop</title>

    <!-- CSS -->
    <link href="${pageContext.request.contextPath}/css/styles.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>

<body class="bg-primary">
    <div id="layoutAuthentication">
        <div id="layoutAuthentication_content">
            <main>
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-lg-7">
                            <div class="card shadow-lg border-0 rounded-lg mt-5">
                                <div class="card-header bg-light">
                                    <h3 class="text-center font-weight-light my-4">Create Account</h3>
                                </div>
                                <div class="card-body">
                                    <form:form method="post" action="/laptopshop/register" modelAttribute="registerUser">
                                        <!-- First and Last Name -->
                                        <div class="row mb-3">
                                            <div class="col-md-6">
                                                <div class="form-floating mb-3 mb-md-0">
                                                    <form:input path="firstName"
                                                                cssClass="form-control"
                                                                cssErrorClass="form-control is-invalid"
                                                                placeholder="Enter your first name" />
                                                    <label for="firstName">First name</label>
                                                    <form:errors path="firstName" cssClass="invalid-feedback" />
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-floating">
                                                    <form:input path="lastName"
                                                                cssClass="form-control"
                                                                cssErrorClass="form-control is-invalid"
                                                                placeholder="Enter your last name" />
                                                    <label for="lastName">Last name</label>
                                                    <form:errors path="lastName" cssClass="invalid-feedback" />
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Email -->
                                        <div class="form-floating mb-3">
                                            <form:input path="email"
                                                        type="email"
                                                        cssClass="form-control"
                                                        cssErrorClass="form-control is-invalid"
                                                        placeholder="name@example.com" />
                                            <label for="email">Email address</label>
                                            <form:errors path="email" cssClass="invalid-feedback" />
                                        </div>

                                        <!-- Password and Confirm Password -->
                                        <div class="row mb-3">
                                            <div class="col-md-6">
                                                <div class="form-floating mb-3 mb-md-0">
                                                    <form:password path="password"
                                                                   cssClass="form-control"
                                                                   cssErrorClass="form-control is-invalid"
                                                                   placeholder="Create a password" />
                                                    <label for="password">Password</label>
                                                    <form:errors path="password" cssClass="invalid-feedback" />
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-floating mb-3 mb-md-0">
                                                    <form:password path="confirmPassword"
                                                                   cssClass="form-control"
                                                                   cssErrorClass="form-control is-invalid"
                                                                   placeholder="Confirm password" />
                                                    <label for="confirmPassword">Confirm Password</label>
                                                    <form:errors path="confirmPassword" cssClass="invalid-feedback" />
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Submit Button -->
                                        <div class="mt-4 mb-0">
                                            <div class="d-grid">
                                                <button class="btn btn-primary btn-block" type="submit">
                                                    Create Account
                                                </button>
                                            </div>
                                        </div>
                                    </form:form>
                                </div>

                                <!-- Footer -->
                                <div class="card-footer text-center py-3">
                                    <div class="small">
                                        <a href="/laptopshop/login">Already have an account? Go to login</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
            crossorigin="anonymous"></script>
    <script src="${pageContext.request.contextPath}/js/scripts.js"></script>
</body>

</html>
