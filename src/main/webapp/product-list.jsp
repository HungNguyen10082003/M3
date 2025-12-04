<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
        crossorigin="anonymous">
    <title>Quản Lý Sản Phẩm</title>
</head>
<body>
    <div class="container mt-4">
        <h2 class="text-primary mb-4">Danh Sách Sản Phẩm</h2>
        <div class="d-flex justify-content-between mb-3">
            <a href="products?action=new" class="btn btn-success">Thêm Sản Phẩm Mới</a>
            <form class="d-flex" action="products" method="get">
                <input type="hidden" name="action" value="search" />
                <input class="form-control me-2" type="search" name="searchName" placeholder="Tìm kiếm theo tên..."
                       value="${param.searchName != null ? param.searchName : ''}" aria-label="Search">
                <button class="btn btn-outline-primary" type="submit">Tìm Kiếm</button>
            </form>
        </div>
        <table class="table table-striped table-hover">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Tên Sản Phẩm</th>
                    <th>Giá</th>
                    <th>Nhà Sản Xuất</th>
                    <th>Hành Động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="product" items="${listProduct}">
                    <tr>
                        <td><c:out value="${product.id}" /></td>
                        <td><c:out value="${product.name}" /></td>
                        <td><c:out value="${product.price}" /> VNĐ</td>
                        <td><c:out value="${product.manufacturer}" /></td>
                        <td>
                            <a href="products?action=view&id=<c:out value='${product.id}' />" class="btn btn-info btn-sm">Xem</a>
                            <a href="products?action=edit&id=<c:out value='${product.id}' />" class="btn btn-warning btn-sm">Sửa</a>
                            <a href="products?action=delete&id=<c:out value='${product.id}' />"
                                class="btn btn-danger btn-sm"
                                onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm ${product.name}?');">
                                Xóa
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty listProduct}">
                    <tr>
                        <td colspan="5" class="text-center text-muted">Không tìm thấy sản phẩm nào.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous">
    </script>
</body>
</html>