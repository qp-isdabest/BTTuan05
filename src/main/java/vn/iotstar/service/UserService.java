package vn.iotstar.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import vn.iotstar.entity.User;

import java.util.List;
import java.util.Optional;

public interface UserService {

    User register(String username, String password, String fullname, String email, String phone);

    User login(String username, String password);

    Optional<User> findByUsername(String username);

    Optional<User> findByEmail(String email);

    boolean existsByUsername(String username);

    boolean existsByEmail(String email);

    User save(User user);

    User createUser(User user);

    User updateUser(Long id, User userForm, String newPassword);

    Optional<User> findById(Long id);

    List<User> findAll();

    Page<User> findAll(Pageable pageable);

    Page<User> searchUsers(String keyword, Pageable pageable);

    void deleteById(Long id);

    long count();
}
