package vn.iotstar.controller;

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
import vn.iotstar.entity.Category;
import vn.iotstar.service.CategoryService;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@Controller
@RequestMapping("/admin/categories")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    @RequestMapping(value = {"", "/", "/searchpaginated"}, method = {RequestMethod.GET, RequestMethod.POST})
    public String search(ModelMap model,
                         @RequestParam(name = "name", required = false) String name,
                         @RequestParam("page") Optional<Integer> page,
                         @RequestParam("size") Optional<Integer> size) {

        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);

        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by(Sort.Direction.DESC, "id"));
        Page<Category> resultPage;

        if (StringUtils.hasText(name)) {
            resultPage = categoryService.findByNameContaining(name.trim(), pageable);
            model.addAttribute("name", name.trim());
        } else {
            resultPage = categoryService.findAll(pageable);
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
        model.addAttribute("categoryPage", resultPage);
        return "admin/category/list";
    }

    @GetMapping("/add")
    public String add(ModelMap model) {
        Category category = new Category();
        category.setStatus(1);
        model.addAttribute("category", category);
        return "admin/category/addOrEdit";
    }

    @GetMapping("/edit/{id}")
    public String edit(@PathVariable("id") Long id, ModelMap model, RedirectAttributes redirectAttributes) {
        Optional<Category> optCategory = categoryService.findById(id);
        if (optCategory.isPresent()) {
            model.addAttribute("category", optCategory.get());
            return "admin/category/addOrEdit";
        }
        redirectAttributes.addFlashAttribute("errorMessage", "Category không tồn tại!");
        return "redirect:/admin/categories/searchpaginated";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute("category") Category category, RedirectAttributes redirectAttributes) {
        categoryService.save(category);
        redirectAttributes.addFlashAttribute("message", "Lưu Category thành công!");
        return "redirect:/admin/categories/searchpaginated";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        categoryService.deleteById(id);
        redirectAttributes.addFlashAttribute("message", "Xóa Category thành công!");
        return "redirect:/admin/categories/searchpaginated";
    }

    @GetMapping("/toggle-status/{id}")
    public String toggleStatus(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        Optional<Category> opt = categoryService.findById(id);
        if (opt.isPresent()) {
            Category c = opt.get();
            c.setStatus(c.getStatus() == 1 ? 0 : 1);
            categoryService.save(c);
            redirectAttributes.addFlashAttribute("message", "Đã " + (c.getStatus() == 1 ? "mở khóa" : "khóa") + " danh mục thành công!");
        }
        return "redirect:/admin/categories/searchpaginated";
    }
}
