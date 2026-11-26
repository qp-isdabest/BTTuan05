package vn.iotstar.config;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import vn.iotstar.entity.Category;
import vn.iotstar.entity.User;
import vn.iotstar.service.CategoryService;
import vn.iotstar.service.UserService;
import vn.iotstar.util.PasswordUtil;

@Configuration
public class DataInitializer {

    @Bean
    public CommandLineRunner initData(CategoryService categoryService, UserService userService) {
        return args -> {
            if (categoryService.count() == 0) {
                categoryService.save(new Category(null, "Laptop Gaming ASUS ROG", "laptop-gaming.jpg", 1));
                categoryService.save(new Category(null, "Laptop Dell XPS 15", "laptop-dell.jpg", 1));
                categoryService.save(new Category(null, "Laptop MacBook Pro M3", "macbook.jpg", 1));
                categoryService.save(new Category(null, "Laptop Lenovo ThinkPad", "thinkpad.jpg", 1));
                categoryService.save(new Category(null, "Laptop HP Envy 13", "hp-envy.jpg", 1));
                categoryService.save(new Category(null, "Điện thoại iPhone 16 Pro Max", "iphone16.jpg", 1));
                categoryService.save(new Category(null, "Điện thoại Samsung Galaxy S24 Ultra", "galaxy-s24.jpg", 1));
                categoryService.save(new Category(null, "Điện thoại Xiaomi 14 Pro", "xiaomi14.jpg", 1));
                categoryService.save(new Category(null, "Máy tính bảng iPad Pro M4", "ipad-pro.jpg", 1));
                categoryService.save(new Category(null, "Máy tính bảng Samsung Galaxy Tab S9", "galaxy-tab.jpg", 1));
                categoryService.save(new Category(null, "Bàn phím cơ không dây Keychron Q1", "keyboard-q1.jpg", 1));
                categoryService.save(new Category(null, "Chuột gaming Logitech G Pro X Superlight", "mouse-gpro.jpg", 1));
                categoryService.save(new Category(null, "Tai nghe chống ồn Sony WH-1000XM5", "sony-xm5.jpg", 1));
                categoryService.save(new Category(null, "Màn hình Dell UltraSharp 4K", "dell-ultrasharp.jpg", 1));
                categoryService.save(new Category(null, "Đồng hồ thông minh Apple Watch Ultra 2", "apple-watch.jpg", 1));
            }

            if (userService.count() == 0) {
                User admin = new User(null, "admin", PasswordUtil.hashPassword("123456"), "Quản Trị Viên", "admin@iotstar.vn", "0901234567", "ADMIN", 1);
                userService.save(admin);

                User user = new User(null, "user", PasswordUtil.hashPassword("123456"), "Nguyễn Văn Người Dùng", "user@iotstar.vn", "0912345678", "USER", 1);
                userService.save(user);
            }
        };
    }
}
