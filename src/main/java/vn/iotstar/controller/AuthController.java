package vn.iotstar.controller;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.iotstar.entity.User;
import vn.iotstar.service.UserService;

@Controller
public class AuthController {

    @Autowired
    private UserService userService;

    @GetMapping("/login")
    public String showLoginForm(HttpServletRequest request,
                                HttpSession session,
                                ModelMap model,
                                @RequestParam(name = "redirect", required = false) String redirect) {
        if (session.getAttribute("currentUser") != null) {
            return "redirect:/";
        }

        // Check remember me cookie
        if (request.getCookies() != null) {
            for (Cookie cookie : request.getCookies()) {
                if ("rememberUsername".equals(cookie.getName())) {
                    model.addAttribute("username", cookie.getValue());
                    model.addAttribute("rememberMe", true);
                    break;
                }
            }
        }

        if (StringUtils.hasText(redirect)) {
            model.addAttribute("redirect", redirect);
        }

        return "web/auth/login";
    }

    @PostMapping("/login")
    public String processLogin(@RequestParam("username") String username,
                               @RequestParam("password") String password,
                               @RequestParam(name = "rememberMe", required = false) String rememberMe,
                               @RequestParam(name = "redirect", required = false) String redirect,
                               HttpServletResponse response,
                               HttpSession session,
                               ModelMap model,
                               RedirectAttributes redirectAttributes) {

        if (!StringUtils.hasText(username) || !StringUtils.hasText(password)) {
            model.addAttribute("errorMessage", "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu!");
            model.addAttribute("username", username);
            model.addAttribute("redirect", redirect);
            return "web/auth/login";
        }

        User user = userService.login(username, password);
        if (user == null) {
            model.addAttribute("errorMessage", "Tên đăng nhập hoặc mật khẩu không chính xác!");
            model.addAttribute("username", username);
            model.addAttribute("redirect", redirect);
            return "web/auth/login";
        }

        if (user.getStatus() == 0) {
            model.addAttribute("errorMessage", "Tài khoản của bạn đang bị khóa. Vui lòng liên hệ quản trị viên!");
            model.addAttribute("username", username);
            return "web/auth/login";
        }

        // Save user to session
        session.setAttribute("currentUser", user);

        // Handle remember me cookie
        if (rememberMe != null) {
            Cookie cookie = new Cookie("rememberUsername", username.trim());
            cookie.setMaxAge(7 * 24 * 60 * 60); // 7 days
            cookie.setPath("/");
            response.addCookie(cookie);
        } else {
            Cookie cookie = new Cookie("rememberUsername", "");
            cookie.setMaxAge(0);
            cookie.setPath("/");
            response.addCookie(cookie);
        }

        redirectAttributes.addFlashAttribute("successMessage", "Đăng nhập thành công! Chào mừng " + (user.getFullname() != null ? user.getFullname() : user.getUsername()));

        if (StringUtils.hasText(redirect) && !redirect.contains("/login") && !redirect.contains("/logout")) {
            return "redirect:" + redirect;
        }

        if (user.isAdmin()) {
            return "redirect:/admin/categories/searchpaginated";
        }

        return "redirect:/";
    }

    @GetMapping("/register")
    public String showRegisterForm(HttpSession session) {
        if (session.getAttribute("currentUser") != null) {
            return "redirect:/";
        }
        return "web/auth/register";
    }

    @PostMapping("/register")
    public String processRegister(@RequestParam("username") String username,
                                  @RequestParam("password") String password,
                                  @RequestParam("repassword") String repassword,
                                  @RequestParam("fullname") String fullname,
                                  @RequestParam("email") String email,
                                  @RequestParam(name = "phone", required = false) String phone,
                                  ModelMap model,
                                  RedirectAttributes redirectAttributes) {

        // Validate basic inputs
        if (!StringUtils.hasText(username) || !StringUtils.hasText(password) || !StringUtils.hasText(repassword)
                || !StringUtils.hasText(fullname) || !StringUtils.hasText(email)) {
            model.addAttribute("errorMessage", "Vui lòng điền đầy đủ các thông tin bắt buộc (*)");
            populateModelAttributes(model, username, fullname, email, phone);
            return "web/auth/register";
        }

        if (username.trim().length() < 3) {
            model.addAttribute("errorMessage", "Tên đăng nhập phải có ít nhất 3 ký tự!");
            populateModelAttributes(model, username, fullname, email, phone);
            return "web/auth/register";
        }

        if (password.length() < 6) {
            model.addAttribute("errorMessage", "Mật khẩu phải có độ dài tối thiểu 6 ký tự!");
            populateModelAttributes(model, username, fullname, email, phone);
            return "web/auth/register";
        }

        if (!password.equals(repassword)) {
            model.addAttribute("errorMessage", "Mật khẩu xác nhận không trùng khớp!");
            populateModelAttributes(model, username, fullname, email, phone);
            return "web/auth/register";
        }

        if (userService.existsByUsername(username.trim())) {
            model.addAttribute("errorMessage", "Tên đăng nhập đã được sử dụng! Vui lòng chọn tên khác.");
            populateModelAttributes(model, username, fullname, email, phone);
            return "web/auth/register";
        }

        if (userService.existsByEmail(email.trim())) {
            model.addAttribute("errorMessage", "Email đã được đăng ký! Vui lòng sử dụng email khác.");
            populateModelAttributes(model, username, fullname, email, phone);
            return "web/auth/register";
        }

        // Register user
        userService.register(username, password, fullname, email, phone);
        redirectAttributes.addFlashAttribute("successMessage", "Đăng ký tài khoản thành công! Vui lòng đăng nhập.");
        return "redirect:/login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session, RedirectAttributes redirectAttributes) {
        session.removeAttribute("currentUser");
        session.invalidate();
        redirectAttributes.addFlashAttribute("infoMessage", "Bạn đã đăng xuất khỏi hệ thống thành công.");
        return "redirect:/login";
    }

    private void populateModelAttributes(ModelMap model, String username, String fullname, String email, String phone) {
        model.addAttribute("username", username);
        model.addAttribute("fullname", fullname);
        model.addAttribute("email", email);
        model.addAttribute("phone", phone);
    }
}
