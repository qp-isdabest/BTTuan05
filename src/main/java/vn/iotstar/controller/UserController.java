package vn.iotstar.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.iotstar.entity.User;
import vn.iotstar.service.UserService;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@Controller
@RequestMapping("/admin/users")
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping(value = {"", "/", "/searchpaginated"}, method = {RequestMethod.GET, RequestMethod.POST})
    public String search(ModelMap model,
                         @RequestParam(name = "keyword", required = false) String keyword,
                         @RequestParam("page") Optional<Integer> page,
                         @RequestParam("size") Optional<Integer> size) {

        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);

        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by(Sort.Direction.DESC, "id"));
        Page<User> resultPage;

        if (StringUtils.hasText(keyword)) {
            resultPage = userService.searchUsers(keyword.trim(), pageable);
            model.addAttribute("keyword", keyword.trim());
        } else {
            resultPage = userService.findAll(pageable);
        }

        int totalPages = resultPage.getTotalPages();
        if (totalPages > 0) {
            int start = Math.max(1, currentPage - 2);
            int end = Math.min(currentPage + 2, totalPages);
            List<Integer> pageNumbers = IntStream.rangeClosed(start, end)
                    .boxed()
                    .collect(Collectors.toList());
            model.addAttribute("pageNumbers", pageNumbers);
        }

        model.addAttribute("userPage", resultPage);
        return "admin/user/list";
    }

    @GetMapping("/add")
    public String add(ModelMap model) {
        User user = new User();
        user.setStatus(1);
        user.setRole("USER");
        model.addAttribute("user", user);
        return "admin/user/addOrEdit";
    }

    @GetMapping("/edit/{id}")
    public String edit(@PathVariable("id") Long id, ModelMap model, RedirectAttributes redirectAttributes) {
        Optional<User> optUser = userService.findById(id);
        if (optUser.isPresent()) {
            model.addAttribute("user", optUser.get());
            return "admin/user/addOrEdit";
        }
        redirectAttributes.addFlashAttribute("errorMessage", "Người dùng không tồn tại!");
        return "redirect:/admin/users/searchpaginated";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute("user") User userForm,
                       @RequestParam(name = "newPassword", required = false) String newPassword,
                       ModelMap model,
                       RedirectAttributes redirectAttributes) {

        // If creating new user
        if (userForm.getId() == null) {
            if (!StringUtils.hasText(userForm.getUsername())) {
                model.addAttribute("errorMessage", "Tên đăng nhập không được để trống!");
                model.addAttribute("user", userForm);
                return "admin/user/addOrEdit";
            }

            if (!StringUtils.hasText(userForm.getPassword())) {
                model.addAttribute("errorMessage", "Mật khẩu không được để trống khi tạo mới!");
                model.addAttribute("user", userForm);
                return "admin/user/addOrEdit";
            }

            if (userService.existsByUsername(userForm.getUsername().trim())) {
                model.addAttribute("errorMessage", "Tên đăng nhập đã tồn tại! Vui lòng chọn tên khác.");
                model.addAttribute("user", userForm);
                return "admin/user/addOrEdit";
            }

            if (StringUtils.hasText(userForm.getEmail()) && userService.existsByEmail(userForm.getEmail().trim())) {
                model.addAttribute("errorMessage", "Email đã tồn tại trong hệ thống!");
                model.addAttribute("user", userForm);
                return "admin/user/addOrEdit";
            }

            userService.createUser(userForm);
            redirectAttributes.addFlashAttribute("message", "Thêm người dùng mới thành công!");
        } else {
            // Updating existing user
            Optional<User> existingOpt = userService.findById(userForm.getId());
            if (existingOpt.isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Người dùng không tồn tại!");
                return "redirect:/admin/users/searchpaginated";
            }

            User existingUser = existingOpt.get();
            // Check email uniqueness if email changed
            if (StringUtils.hasText(userForm.getEmail()) && !userForm.getEmail().equalsIgnoreCase(existingUser.getEmail())) {
                if (userService.existsByEmail(userForm.getEmail().trim())) {
                    model.addAttribute("errorMessage", "Email này đã được sử dụng bởi người dùng khác!");
                    model.addAttribute("user", userForm);
                    return "admin/user/addOrEdit";
                }
            }

            userService.updateUser(userForm.getId(), userForm, newPassword);
            redirectAttributes.addFlashAttribute("message", "Cập nhật thông tin người dùng thành công!");
        }

        return "redirect:/admin/users/searchpaginated";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable("id") Long id,
                         HttpSession session,
                         RedirectAttributes redirectAttributes) {

        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser != null && currentUser.getId() != null && currentUser.getId().equals(id)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không thể xóa chính tài khoản đang đăng nhập!");
            return "redirect:/admin/users/searchpaginated";
        }

        userService.deleteById(id);
        redirectAttributes.addFlashAttribute("message", "Xóa người dùng thành công!");
        return "redirect:/admin/users/searchpaginated";
    }

    @GetMapping("/toggle-status/{id}")
    public String toggleStatus(@PathVariable("id") Long id,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {

        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser != null && currentUser.getId() != null && currentUser.getId().equals(id)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không thể tự khóa tài khoản của chính mình!");
            return "redirect:/admin/users/searchpaginated";
        }

        Optional<User> opt = userService.findById(id);
        if (opt.isPresent()) {
            User u = opt.get();
            u.setStatus(u.getStatus() == 1 ? 0 : 1);
            userService.save(u);
            redirectAttributes.addFlashAttribute("message", "Đã " + (u.getStatus() == 1 ? "mở khóa" : "khóa") + " tài khoản " + u.getUsername() + " thành công!");
        }

        return "redirect:/admin/users/searchpaginated";
    }
}
