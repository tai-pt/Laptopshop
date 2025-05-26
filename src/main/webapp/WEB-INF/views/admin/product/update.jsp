<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Cập Nhật Sản Phẩm</title>
    
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    
    <style>
        body {
            display: flex;
            background: #f8f9fa;
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
        .product-image {
            width: 100%;
            max-width: 300px;
            display: block;
            margin: auto;
            border-radius: 10px;
            box-shadow: 2px 2px 15px rgba(0, 0, 0, 0.1);
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
                <h3 class="mb-4 text-center"><i class="fas fa-edit"></i> Cập Nhật Sản Phẩm</h3>
<form action="/laptopshop/admin/product/update" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="id" value="${newProduct.id}">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

                    <div class="row">
                        <!-- Left Side: Form Inputs -->
                        <div class="col-md-7">
                            <div class="mb-3">
                                <label class="form-label">Tên sản phẩm</label>
                                <input type="text" class="form-control" name="name" value="${newProduct.name}" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Giá</label>
                                <input type="number" class="form-control" name="price" value="${newProduct.price}" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Số lượng</label>
                                <input type="number" class="form-control" name="quantity" value="${newProduct.quantity}" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Mô tả ngắn</label>
                                <textarea class="form-control" name="shortDesc" rows="2">${newProduct.shortDesc}</textarea>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Mô tả chi tiết</label>
                                <textarea class="form-control" name="detailDesc" rows="4">${newProduct.detailDesc}</textarea>
                            </div>
                        </div>

                        <!-- Right Side: Image Upload -->
                        <div class="mb-3">
                          <label for="avatarFile" class="form-label">Image:</label>
                                                    <input class="form-control" type="file" id="avatarPath"
                                                        accept=".png, .jpg, .jpeg" name="avatarPath" />
                                                </div>
                    </div>

                    <!-- Buttons -->
                    <div class="mt-4 text-center">
                        <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Lưu thay đổi</button>
                        <a href="${pageContext.request.contextPath}/admin/product/" class="btn btn-secondary"><i class="fas fa-ban"></i> Hủy</a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap & JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Image Preview -->
    <script>
        document.getElementById('imageInput').addEventListener('change', function(event) {
            const reader = new FileReader();
            reader.onload = function() {
                document.getElementById('imagePreview').src = reader.result;
            }
            reader.readAsDataURL(event.target.files[0]);
        });
    </script>

</body>
</html>
