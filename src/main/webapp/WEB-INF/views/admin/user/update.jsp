<%@ page contentType="text/html; charset=UTF-8" %>
    <%@ page pageEncoding="UTF-8" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
            <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="UTF-8">
                    <title>Update User</title>

                    <!-- Bootstrap 5 -->
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                    <!-- FontAwesome -->
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

                    <style>
                        body {
                            display: flex;
                            background-color: #f8f9fa;
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
                            transition: 0.3s;
                        }

                        .sidebar a:hover {
                            background: #495057;
                        }

                        .content {
                            margin-left: 250px;
                            padding: 20px;
                            width: 100%;
                        }

                        .preview img {
                            width: 150px;
                            display: block;
                            margin: 10px auto;
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
                        <a href="${pageContext.request.contextPath}/admin/product"><i class="fas fa-box"></i>
                            Products</a>
                        <a href="${pageContext.request.contextPath}/admin/orders"><i class="fas fa-shopping-cart"></i>
                            Orders</a>
                        <a href="${pageContext.request.contextPath}/admin/users"><i class="fas fa-users"></i> Users</a>
                    </div>

                    <!-- Main Content -->
                    <div class="content">
                        <div class="container mt-4">
                            <div class="card shadow-lg p-4">
                                <h3 class="mb-4 text-center"><i class="fas fa-user-edit"></i> Update User</h3>
                                <form:form action="/laptopshop/admin/user/update" method="post"
                                    modelAttribute="newUser" enctype="multipart/form-data">
                                    <input type="hidden" name="id" value="${newUser.id}">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

                                    <div class="row">
                                        <div class="col-md-7">
                                            <div class="mb-3">
                                                <label class="form-label"><i class="fas fa-user"></i> Username</label>
                                                <form:input path="fullName" class="form-control" required="true" />
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Số điện thoại</label>
                                                <form:input path="phone" class="form-control"
                                                    placeholder="Nhập số điện thoại" />
                                                <form:errors path="phone" class="text-danger" />
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label"><i class="fas fa-envelope"></i> Email</label>
                                                <form:input path="email" class="form-control" required="true" />
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label"><i class="fas fa-map-marker-alt"></i>
                                                    Address</label>
                                                <form:input path="address" class="form-control" />
                                            </div>
                                        </div>
                                        <div class="col-md-5 text-center">
                                            <div class="mb-3">
                                                <label class="form-label"><i class="fas fa-image"></i> Avatar</label>
                                                <input type="file" class="form-control" id="avatarUpload"
                                                    name="avatarPath" accept="image/*" required>
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Vai trò</label>
                                                <form:select class="form-select" path="role.name">
                                                    <form:option value="ADMIN">ADMIN</form:option>
                                                    <form:option value="USER">USER</form:option>
                                                </form:select>
                                            </div>
                                            <div class="preview">
                                                <img id="avatarPreview" src="#" alt="Avatar Preview"
                                                    style="display: none;">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="mt-4 text-center">
                                        <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Save
                                            Changes</button>
                                        <a href="${pageContext.request.contextPath}/admin/user"
                                            class="btn btn-secondary"><i class="fas fa-ban"></i> Cancel</a>
                                    </div>
                                </form:form>
                            </div>
                        </div>
                    </div>

                    <script>
                        document.getElementById('avatarUpload').addEventListener('change', function (event) {
                            const reader = new FileReader();
                            reader.onload = function () {
                                document.getElementById('avatarPreview').src = reader.result;
                                document.getElementById('avatarPreview').style.display = 'block';
                            }
                            reader.readAsDataURL(event.target.files[0]);
                        });
                    </script>
                </body>

                </html>