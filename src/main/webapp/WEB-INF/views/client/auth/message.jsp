<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Thông báo - LaptopShop</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="/laptopshop/client/css/bootstrap.min.css" rel="stylesheet" />
    <link href="/laptopshop/client/css/style.css" rel="stylesheet" />
</head>
<body>

<jsp:include page="../layout/header.jsp" />

<!-- Bọc trong một container và card để căn giữa và rõ ràng hơn -->
<div class="container d-flex align-items-center justify-content-center" style="min-height: 80vh;">
    <div class="col-md-8 col-lg-6">
        <div class="card shadow p-4 border-0 rounded-3">
            <div class="card-body text-center">
                <h4 class="mb-4 text-success">${message}</h4>
                <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">Quay lại đăng nhập</a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp" />

</body>
</html>
