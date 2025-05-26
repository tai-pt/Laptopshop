<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Create Product</title>
    
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

    <style>
        body {
            display: flex;
        }
        .sidebar {
            width: 250px;
            height: 100vh;
            background: #343a40;
            padding-top: 20px;
            position: fixed;
        }
        .sidebar a {
            display: block;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
        }
        .sidebar a:hover {
            background: #495057;
        }
        .content {
            margin-left: 250px;
            padding: 20px;
            width: 100%;
        }
    </style>
</head>
<body>

    <!-- Sidebar -->
    <div class="sidebar">
        <h4 class="text-center text-white">Admin Panel</h4>
        <a href="${pageContext.request.contextPath}/admin"><i class="fas fa-home"></i> Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/product"><i class="fas fa-box"></i> Products</a>
        <a href="${pageContext.request.contextPath}/admin/orders"><i class="fas fa-shopping-cart"></i> Orders</a>
        <a href="${pageContext.request.contextPath}/admin/users"><i class="fas fa-users"></i> Users</a>
    </div>

    <!-- Main Content -->
    <div class="content">
        <div class="container mt-4">
            <div class="card shadow-lg p-4">
                <h3 class="mb-4"><i class="fas fa-plus-circle"></i> Create Product</h3>

                <form:form modelAttribute="product" method="post"
                           action="${pageContext.request.contextPath}/admin/product/create"
                           class="needs-validation" enctype="multipart/form-data">
                    
                    <!-- Name -->
                    <div class="mb-3">
                        <label class="form-label"><i class="fas fa-tag"></i> Name:</label>
                        <form:input path="name" class="form-control" />
                        <form:errors path="name" cssClass="text-danger" />
                    </div>

                    <!-- Price -->
                    <div class="mb-3">
                        <label class="form-label"><i class="fas fa-dollar-sign"></i> Price:</label>
                        <form:input path="price" class="form-control" />
                        <form:errors path="price" cssClass="text-danger" />
                    </div>

                    <!-- Image Upload -->
                   <div class="mb-3">
                          <label for="avatarFile" class="form-label">Image:</label>
                                                    <input class="form-control" type="file" id="avatarPath"
                                                        accept=".png, .jpg, .jpeg" name="avatarPath" />
                                                </div>
                    </div>
                    <!-- Detail Description -->
                    <div class="mb-3">
                        <label class="form-label"><i class="fas fa-align-left"></i> Detail Description:</label>
                        <form:textarea path="detailDesc" class="form-control" />
                        <form:errors path="detailDesc" cssClass="text-danger" />
                    </div>

                    <!-- Short Description -->
                    <div class="mb-3">
                        <label class="form-label"><i class="fas fa-align-right"></i> Short Description:</label>
                        <form:textarea path="shortDesc" class="form-control" />
                        <form:errors path="shortDesc" cssClass="text-danger" />
                    </div>

                    <!-- Quantity -->
                    <div class="mb-3">
                        <label class="form-label"><i class="fas fa-boxes"></i> Quantity:</label>
                        <form:input path="quantity" class="form-control" />
                        <form:errors path="quantity" cssClass="text-danger" />
                    </div>

                    <!-- Sold -->
                    <div class="mb-3">
                        <label class="form-label"><i class="fas fa-chart-line"></i> Sold:</label>
                        <form:input path="sold" class="form-control" />
                        <form:errors path="sold" cssClass="text-danger" />
                    </div>

                    <!-- Factory -->
                    <div class="mb-3">
                        <label class="form-label"><i class="fas fa-industry"></i> Factory:</label>
                        <form:input path="factory" class="form-control" />
                        <form:errors path="factory" cssClass="text-danger" />
                    </div>

                    <!-- Target Audience -->
                    <div class="mb-3">
                        <label class="form-label"><i class="fas fa-users"></i> Target Audience:</label>
                        <form:input path="target" class="form-control" />
                        <form:errors path="target" cssClass="text-danger" />
                    </div>

                    <!-- Submit -->
                    <div class="mb-3">
                        <button type="submit" class="btn btn-primary"><i class="fas fa-check"></i> Create Product</button>
                    </div>

                </form:form>
            </div>
        </div>
    </div>

    <!-- Bootstrap & JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Preview Image Before Upload -->
    <script>
        $("#imageUpload").change(function() {
            let reader = new FileReader();
            reader.onload = function(e) {
                $("#previewImage").attr("src", e.target.result).show();
            }
            reader.readAsDataURL(this.files[0]);
        });
    </script>

</body>
</html>
