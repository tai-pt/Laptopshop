<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <title>Xác nhận Xóa Người Dùng</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            </head>

            <body>
                <div class="container mt-5">
                    <h2 class="text-center text-danger">Xóa Người Dùng id = ${id}</h2>
                    <div class="card shadow-lg p-4">
                        <p class="text-center">Bạn có chắc chắn muốn xóa người dùng này không?</p>

                        <form:form action="${pageContext.request.contextPath}/admin/user/delete/${id}" method="post">
                            <div class="text-center">
                                <button type="submit" class="btn btn-danger">Xóa</button>
                                <a href="${pageContext.request.contextPath}/admin/user"
                                    class="btn btn-secondary">Hủy</a>
                            </div>
                        </form:form>
                    </div>
                </div>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>