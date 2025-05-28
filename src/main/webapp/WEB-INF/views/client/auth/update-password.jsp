<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Đặt lại mật khẩu mới</title>
</head>
<body>
    <h2>Đặt lại mật khẩu mới</h2>
    <form action="/laptopshop/savePassword" method="post">
        <input type="hidden" name="token" value="${token}" />
                                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
        
        
        <label for="password">Mật khẩu mới:</label>
        <input type="password" id="password" name="password" required />
        
        <label for="confirmPassword">Xác nhận mật khẩu:</label>
        <input type="password" id="confirmPassword" name="confirmPassword" required />
        
        <button type="submit">Lưu mật khẩu mới</button>
    </form>

    <c:if test="${not empty errorMessage}">
        <p style="color:red;">${errorMessage}</p>
    </c:if>

    <script>
        // Optional: client-side check mật khẩu khớp
        const form = document.querySelector('form');
        form.addEventListener('submit', function(e) {
            const pwd = document.getElementById('password').value;
            const cpwd = document.getElementById('confirmPassword').value;
            if (pwd !== cpwd) {
                alert("Mật khẩu xác nhận không khớp!");
                e.preventDefault();
            }
        });
    </script>
</body>
</html>
