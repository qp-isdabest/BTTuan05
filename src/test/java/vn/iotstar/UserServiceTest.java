package vn.iotstar;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
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
        if (!userService.existsByUsername(testUsername)) {
            User registered = userService.register(testUsername, "password123", "Test Fullname", "testuser@gmail.com", "0987654321");
            assertNotNull(registered);
            assertEquals(testUsername, registered.getUsername());
            assertEquals("USER", registered.getRole());
        }

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

    @Test
    void testUserCrudAndPagination() {
        // Test pagination
        Page<User> page = userService.findAll(PageRequest.of(0, 3, Sort.by(Sort.Direction.DESC, "id")));
        assertNotNull(page);
        assertTrue(page.getTotalElements() > 0);
        assertTrue(page.getContent().size() <= 3);

        // Test search
        Page<User> searchResult = userService.searchUsers("admin", PageRequest.of(0, 5));
        assertNotNull(searchResult);
        assertTrue(searchResult.getTotalElements() >= 1);

        // Test create user
        String sampleUser = "cruduser";
        if (!userService.existsByUsername(sampleUser)) {
            User created = userService.createUser(new User(null, sampleUser, "123456", "CRUD Test", "crud@gmail.com", "0999888777", "USER", 1));
            assertNotNull(created.getId());

            // Test update user
            User updated = userService.updateUser(created.getId(), new User(created.getId(), sampleUser, null, "CRUD Updated", "crud_updated@gmail.com", "0999888777", "ADMIN", 0), "newpass654");
            assertNotNull(updated);
            assertEquals("CRUD Updated", updated.getFullname());
            assertEquals("ADMIN", updated.getRole());
            assertEquals(0, updated.getStatus());

            // Test delete user
            userService.deleteById(created.getId());
            assertFalse(userService.findById(created.getId()).isPresent());
        }
    }
}
