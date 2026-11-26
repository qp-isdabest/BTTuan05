package vn.iotstar;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import vn.iotstar.entity.User;
import vn.iotstar.service.UserService;
import vn.iotstar.util.PasswordUtil;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class UserServiceTest {

    @Autowired
    private UserService userService;

    @Test
    void testInitialUsersCreated() {
        assertTrue(userService.count() >= 2, "Default admin and user should be initialized");
        assertTrue(userService.existsByUsername("admin"));
        assertTrue(userService.existsByUsername("user"));
    }

    @Test
    void testLoginSuccess() {
        User admin = userService.login("admin", "123456");
        assertNotNull(admin);
        assertEquals("admin", admin.getUsername());
        assertTrue(admin.isAdmin());

        User user = userService.login("user", "123456");
        assertNotNull(user);
        assertEquals("user", user.getUsername());
        assertFalse(user.isAdmin());
    }

    @Test
    void testLoginFailedWrongPassword() {
        User user = userService.login("admin", "wrongpass");
        assertNull(user);
    }

    @Test
    void testRegisterNewUser() {
        String testUsername = "newtestuser";
        if (userService.existsByUsername(testUsername)) {
            // Already exists in run
            return;
        }

        User registered = userService.register(testUsername, "password123", "Test Fullname", "testuser@gmail.com", "0987654321");
        assertNotNull(registered);
        assertEquals(testUsername, registered.getUsername());
        assertEquals("USER", registered.getRole());

        // Test login with newly registered user
        User loginUser = userService.login(testUsername, "password123");
        assertNotNull(loginUser);
        assertEquals("Test Fullname", loginUser.getFullname());
    }

    @Test
    void testPasswordHashing() {
        String hashed = PasswordUtil.hashPassword("secret");
        assertNotNull(hashed);
        assertNotEquals("secret", hashed);
        assertTrue(PasswordUtil.checkPassword("secret", hashed));
        assertFalse(PasswordUtil.checkPassword("wrong", hashed));
    }
}
