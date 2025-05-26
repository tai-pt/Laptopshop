<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Collections - My Shop</title>
                <!-- Google Web Fonts -->
                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                <link
                    href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                    rel="stylesheet">

                <!-- Icon Font Stylesheet -->
                <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
                <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                    rel="stylesheet">

                <!-- Libraries Stylesheet -->
                <link href="${pageContext.request.contextPath}/client/lib/lightbox/css/lightbox.min.css"
                    rel="stylesheet">
                <link href="${pageContext.request.contextPath}/client/lib/owlcarousel/assets/owl.carousel.min.css"
                    rel="stylesheet">

                <!-- Customized Bootstrap Stylesheet -->
                <link href="${pageContext.request.contextPath}/client/css/bootstrap.min.css" rel="stylesheet">
                <link href="${pageContext.request.contextPath}/client/css/style.css" rel="stylesheet">
                <style>
                    .pagination .page-item .page-link {
                        border-radius: 10px;
                        color: #333;
                        border: 1px solid #dee2e6;
                        padding: 6px 12px;
                        transition: all 0.2s ease;
                    }

                    .pagination .page-item.active .page-link {
                        background-color: #84cc16;
                        border-color: #84cc16;
                        color: #fff;
                    }

                    .pagination .page-item .page-link:hover {
                        background-color: #f0f0f0;
                    }
                </style>
            </head>

            <body>
                <jsp:include page="../layout/header.jsp" />
                <div class="container py-5 text-center">
                    <h1 class="text-center mb-4">Our Collections</h1>
                    <div class="row justify-content-center">
                        <c:forEach var="product" items="${products}">
                            <div class="col-md-4 mb-4">
                                <div class="card h-100 shadow-lg border-0 rounded-lg overflow-hidden">
                                    <img src="${pageContext.request.contextPath}/images/product/${product.image}"
                                        class="card-img-top" alt="${product.name}">
                                    <div class="card-body text-center">
                                        <h5 class="card-title">${product.name}</h5>
                                        <p class="card-text text-muted">${product.shortDesc}</p>
                                        <h6 class="text-danger fw-bold">
                                            <fmt:formatNumber type="number" value="${product.price}" /> đ
                                        </h6>
                                        <a href="${pageContext.request.contextPath}/product/${product.id}"
                                            class="btn btn-primary">
                                            <i class="fas fa-eye"></i> Views
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    
                    <!-- Pagination -->
                    <c:if test="${totalPage > 1}">
                        <nav class="mt-4">
                            <ul class="pagination d-flex flex-wrap justify-content-center gap-2">
                                <!-- Previous -->
                                <c:if test="${currentPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="?page=${currentPage - 1}" aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>
                                </c:if>

                                <!-- Page range logic -->
                                <c:set var="start" value="${currentPage - 2}" />
                                <c:set var="end" value="${currentPage + 2}" />

                                <c:if test="${start < 1}">
                                    <c:set var="end" value="${end + (1 - start)}" />
                                    <c:set var="start" value="1" />
                                </c:if>
                                <c:if test="${end > totalPage}">
                                    <c:set var="start" value="${start - (end - totalPage)}" />
                                    <c:set var="end" value="${totalPage}" />
                                </c:if>
                                <c:if test="${start < 1}">
                                    <c:set var="start" value="1" />
                                </c:if>

                                <!-- Page numbers -->
                                <c:forEach begin="${start}" end="${end}" var="i">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="?page=${i}">${i}</a>
                                    </li>
                                </c:forEach>

                                <!-- Next -->
                                <c:if test="${currentPage < totalPage}">
                                    <li class="page-item">
                                        <a class="page-link" href="?page=${currentPage + 1}" aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                        </a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </c:if>


                </div>
                <jsp:include page="../layout/footer.jsp" />

                <!-- JavaScript Libraries -->
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                <script src="${pageContext.request.contextPath}/client/lib/easing/easing.min.js"></script>
                <script src="${pageContext.request.contextPath}/client/lib/waypoints/waypoints.min.js"></script>
                <script src="${pageContext.request.contextPath}/client/lib/lightbox/js/lightbox.min.js"></script>
                <script src="${pageContext.request.contextPath}/client/lib/owlcarousel/owl.carousel.min.js"></script>
                <script src="${pageContext.request.contextPath}/client/js/main.js"></script>
            </body>

            </html>