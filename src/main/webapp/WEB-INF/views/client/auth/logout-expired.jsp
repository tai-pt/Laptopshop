<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Phiên đăng nhập hết hạn</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #f8f9fa;
    }
    .expired-box {
      max-width: 450px;
      margin: 100px auto;
      background: #ffffff;
      border-radius: 10px;
      box-shadow: 0 0 15px rgba(0,0,0,0.1);
      padding: 30px;
      text-align: center;
    }
    .expired-box img {
      width: 80px;
    }
  </style>
</head>
<body>

  <div class="expired-box">
    <img src="https://cdn-icons-png.flaticon.com/512/463/463612.png" alt="Session expired">
    <h3 class="mt-3">Phiên đăng nhập đã hết hạn</h3>
    <p>Vui lòng đăng nhập lại để tiếp tục sử dụng hệ thống.</p>
    <a href="/laptopshop/login" class="btn btn-primary mt-3">Đăng nhập lại</a>
  </div>

</body>
</html>
