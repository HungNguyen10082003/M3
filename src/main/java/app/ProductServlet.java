package app;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {

    // Lưu ý: Cần đổi kiểu dữ liệu về app.ProductService
    private ProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "new": showNewForm(request, response); break;
                case "delete": deleteProduct(request, response); break;
                case "edit": showEditForm(request, response); break;
                case "view": viewProduct(request, response); break;
                case "search": searchProducts(request, response); break;
                default: listProducts(request, response); break;
            }
        } catch (Exception ex) { throw new ServletException(ex); }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "";

        try {
            if ("insert".equals(action)) {
                insertProduct(request, response);
            } else if ("update".equals(action)) {
                updateProduct(request, response);
            } else {
                listProducts(request, response);
            }
        } catch (Exception ex) { throw new ServletException(ex); }
    }

    // Logic Validation và Insert
    private void insertProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String name = request.getParameter("name");
        String priceStr = request.getParameter("price");
        String desc = request.getParameter("description");
        String manuf = request.getParameter("manufacturer");
        double price = 0.0;
        Map<String, String> errors = new HashMap<>();

        if (name == null || name.trim().isEmpty()) errors.put("name", "Tên sản phẩm không được để trống.");
        if (priceStr == null || priceStr.trim().isEmpty()) errors.put("price", "Giá sản phẩm không được để trống.");
        else {
            try {
                price = Double.parseDouble(priceStr);
                if (price <= 0) errors.put("price", "Giá sản phẩm phải là số dương.");
            } catch (NumberFormatException e) { errors.put("price", "Giá sản phẩm phải là định dạng số."); }
        }
        if (manuf == null || manuf.trim().isEmpty()) errors.put("manufacturer", "Nhà sản xuất không được để trống.");

        if (!errors.isEmpty()) {
            Product product = new Product(0, name, price, desc, manuf);
            request.setAttribute("product", product);
            request.setAttribute("errors", errors);
            request.getRequestDispatcher("/product-form.jsp").forward(request, response);
        } else {
            Product newProduct = new Product(0, name, price, desc, manuf);
            productService.addProduct(newProduct);
            response.sendRedirect("products?action=list");
        }
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String priceStr = request.getParameter("price");
        String desc = request.getParameter("description");
        String manuf = request.getParameter("manufacturer");
        double price = 0.0;
        Map<String, String> errors = new HashMap<>();

        if (name == null || name.trim().isEmpty()) errors.put("name", "Tên sản phẩm không được để trống.");
        if (priceStr == null || priceStr.trim().isEmpty()) errors.put("price", "Giá sản phẩm không được để trống.");
        else {
            try {
                price = Double.parseDouble(priceStr);
                if (price <= 0) errors.put("price", "Giá sản phẩm phải là số dương.");
            } catch (NumberFormatException e) { errors.put("price", "Giá sản phẩm phải là định dạng số."); }
        }
        if (manuf == null || manuf.trim().isEmpty()) errors.put("manufacturer", "Nhà sản xuất không được để trống.");

        if (!errors.isEmpty()) {
            Product product = new Product(id, name, price, desc, manuf);
            request.setAttribute("product", product);
            request.setAttribute("errors", errors);
            request.getRequestDispatcher("/product-form.jsp").forward(request, response);
        } else {
            Product product = new Product(id, name, price, desc, manuf);
            productService.updateProduct(product);
            response.sendRedirect("products?action=list");
        }
    }

    // Các phương thức điều hướng khác (chỉ gọi JSP)
    private void listProducts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Product> listProduct = productService.getAllProducts();
        request.setAttribute("listProduct", listProduct);
        request.getRequestDispatcher("/product-list.jsp").forward(request, response);
    }
    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("product", new Product(0, "", 0.0, "", ""));
        request.getRequestDispatcher("/product-form.jsp").forward(request, response);
    }
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Product existingProduct = productService.getProductById(id);
        request.setAttribute("product", existingProduct);
        request.getRequestDispatcher("/product-form.jsp").forward(request, response);
    }
    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        productService.deleteProduct(id);
        response.sendRedirect("products?action=list");
    }
    private void viewProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Product product = productService.getProductById(id);
        request.setAttribute("product", product);
        request.getRequestDispatcher("/product-detail.jsp").forward(request, response);
    }
    private void searchProducts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchName = request.getParameter("searchName");
        List<Product> listProduct = productService.searchProductsByName(searchName);
        request.setAttribute("listProduct", listProduct);
        request.setAttribute("searchName", searchName);
        request.getRequestDispatcher("/product-list.jsp").forward(request, response);
    }
}