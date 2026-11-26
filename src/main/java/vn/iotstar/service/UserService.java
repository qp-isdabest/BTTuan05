package vn.iotstar.service;

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

    Optional<User> findById(Long id);

    List<User> findAll();

    long count();
}
