<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
        crossorigin="anonymous">
    <title><c:if test="${product.id != 0}">Sửa</c:if><c:if test="${product.id == 0}">Thêm Mới</c:if> Sản Phẩm</title>
</head>
<body>
    <div class="container mt-5">
        <h2 class="mb-4"><c:if test="${product.id != 0}">Chỉnh Sửa</c:if><c:if test="${product.id == 0}">Thêm Mới</c:if> Sản Phẩm</h2>
        <a href="products" class="btn btn-secondary mb-3">Quay lại Danh Sách</a>

        <form action="products" method="post">

            <%-- Hidden Fields cho Action và ID --%>
            <c:if test="${product.id != 0}"><input type="hidden" name="action" value="update" /><input type="hidden" name="id" value="<c:out value='${product.id}' />" /></c:if>
            <c:if test="${product.id == 0}"><input type="hidden" name="action" value="insert" /></c:if>

            <%-- Trường Tên Sản Phẩm (Hiển thị lỗi) --%>
            <div class="mb-3">
                <label for="name" class="form-label">Tên Sản Phẩm:</label>
                <input type="text" id="name" name="name" class="form-control <c:if test="${errors.name != null}">is-invalid</c:if>" value="<c:out value='${product.name}' />" required />
                <c:if test="${errors.name != null}"><div class="invalid-feedback"><c:out value="${errors.name}" /></div></c:if>
            </div>

            <%-- Trường Giá Sản Phẩm (Hiển thị lỗi) --%>
            <div class="mb-3">
                <label for="price" class="form-label">Giá Sản Phẩm (VNĐ):</label>
                <input type="number" step="0.01" id="price" name="price" class="form-control <c:if test="${errors.price != null}">is-invalid</c:if>" value="<c:out value='${product.price}' />" required />
                <c:if test="${errors.price != null}"><div class="invalid-feedback"><c:out value="${errors.price}" /></div></c:if>
            </div>

            <%-- Trường Mô Tả --%>
            <div class="mb-3">
                <label for="description" class="form-label">Mô Tả:</label>
                <textarea id="description" name="description" class="form-control"><c:out value='${product.description}' /></textarea>
            </div>

            <%-- Trường Nhà Sản Xuất (Hiển thị lỗi) --%>
            <div class="mb-3">
                <label for="manufacturer" class="form-label">Nhà Sản Xuất:</label>
                <input type="text" id="manufacturer" name="manufacturer" class="form-control <c:if test="${errors.manufacturer != null}">is-invalid</c:if>" value="<c:out value='${product.manufacturer}' />" required />
                <c:if test="${errors.manufacturer != null}"><div class="invalid-feedback"><c:out value="${errors.manufacturer}" /></div></c:if>
            </div>

            <button type="submit" class="btn btn-primary">Lưu Sản Phẩm</button>
        </form>
    </div>
    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous">
    </script>
</body>
</html>