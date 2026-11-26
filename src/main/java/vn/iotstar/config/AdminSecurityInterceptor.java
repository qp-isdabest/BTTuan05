package vn.iotstar.config;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import vn.iotstar.entity.User;

@Component
public class AdminSecurityInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            String uri = request.getRequestURI();
            String query = request.getQueryString();
            String redirectUrl = uri + (query != null ? "?" + query : "");
            response.sendRedirect(request.getContextPath() + "/login?redirect=" + java.net.URLEncoder.encode(redirectUrl, "UTF-8"));
            return false;
        }

        if (!currentUser.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/?error=forbidden");
            return false;
        }

        return true;
    }
}
