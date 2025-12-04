package app;

import java.util.*;
import java.util.stream.Collectors;

public class ProductServiceImpl implements ProductService {
    private static List<Product> productStore = new ArrayList<>();
    private static int NEXT_ID = 1;

    // Khởi tạo dữ liệu mẫu
    static {
        productStore.add(new Product(NEXT_ID++, "Laptop Gaming X", 25000000.0, "Mô tả Laptop Gaming hiệu năng cao.", "Dell"));
        productStore.add(new Product(NEXT_ID++, "Điện thoại S23", 18500000.0, "Mô tả Điện thoại cao cấp thế hệ mới.", "Samsung"));
    }

    @Override
    public List<Product> getAllProducts() { return productStore; }

    @Override
    public Product getProductById(int id) {
        return productStore.stream().filter(p -> p.getId() == id).findFirst().orElse(null);
    }

    @Override
    public void addProduct(Product product) {
        product.setId(NEXT_ID++);
        productStore.add(product);
    }

    @Override
    public void updateProduct(Product updatedProduct) {
        for (int i = 0; i < productStore.size(); i++) {
            if (productStore.get(i).getId() == updatedProduct.getId()) {
                productStore.set(i, updatedProduct);
                return;
            }
        }
    }

    @Override
    public void deleteProduct(int id) { productStore.removeIf(p -> p.getId() == id); }

    @Override
    public List<Product> searchProductsByName(String name) {
        if (name == null || name.trim().isEmpty()) return productStore;
        String lowerCaseName = name.toLowerCase();
        return productStore.stream()
                .filter(p -> p.getName().toLowerCase().contains(lowerCaseName))
                .collect(Collectors.toList());
    }
}