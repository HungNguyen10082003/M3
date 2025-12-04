<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
        crossorigin="anonymous">
    <title>Chi Tiết Sản Phẩm</title>
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-info mb-4">Chi Tiết Sản Phẩm</h2>
        <a href="products" class="btn btn-secondary mb-3">Quay lại Danh Sách</a>

        <c:if test="${product != null}">
            <div class="card shadow-sm">
                <div class="card-header bg-info text-white">
                    <h5 class="mb-0"><c:out value="${product.name}" /></h5>
                </div>
                <div class="card-body">
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item"><strong>ID:</strong> <c:out value="${product.id}" /></li>
                        <li class="list-group-item"><strong>Tên Sản Phẩm:</strong> <c:out value="${product.name}" /></li>
                        <li class="list-group-item"><strong>Giá Sản Phẩm:</strong> <span class="text-success fw-bold"><c:out value="${product.price}" /> VNĐ</span></li>
                        <li class="list-group-item"><strong>Nhà Sản Xuất:</strong> <c:out value="${product.manufacturer}" /></li>
                    </ul>
                    <h6 class="mt-4 mb-2">Mô Tả:</h6>
                    <p class="card-text border p-3 bg-light rounded"><c:out value="${product.description}" /></p>
                </div>
                <div class="card-footer text-end">
                    <a href="products?action=edit&id=<c:out value='${product.id}' />" class="btn btn-warning me-2">Sửa Sản Phẩm</a>
                    <a href="products?action=delete&id=<c:out value='${product.id}' />"
                        class="btn btn-danger"
                        onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?');">Xóa</a>
                </div>
            </div>
        </c:if>
        <c:if test="${product == null}">
            <div class="alert alert-danger" role="alert">Không tìm thấy sản phẩm.</div>
        </c:if>
    </div>
    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous">
    </script>
</body>
</html>