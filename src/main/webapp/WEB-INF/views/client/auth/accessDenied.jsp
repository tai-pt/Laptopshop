<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Truy cập bị từ chối</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>

<body>
    <div class="container text-center mt-5">
        <h1 class="text-danger">🚫 Truy cập bị từ chối</h1>
        <p class="lead">Bạn không có quyền truy cập vào trang này.</p>
        <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Quay lại Trang Chủ</a>
    </div>
</body>

</html>
