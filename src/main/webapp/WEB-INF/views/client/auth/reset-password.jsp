<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Yêu cầu đặt lại mật khẩu</title>
</head>
<body>
    <h2>Yêu cầu đặt lại mật khẩu</h2>
    <form action="/laptopshop/resetPassword" method="post">
       <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
    
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required />
        <button type="submit">Gửi link đặt lại mật khẩu</button>
    </form>
</body>
</html>
