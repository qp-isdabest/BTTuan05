package vn.iotstar.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import vn.iotstar.entity.User;
import vn.iotstar.repository.UserRepository;
import vn.iotstar.service.UserService;
import vn.iotstar.util.PasswordUtil;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;

    @Override
    public User register(String username, String password, String fullname, String email, String phone) {
        User user = new User();
        user.setUsername(username.trim());
        user.setPassword(PasswordUtil.hashPassword(password));
        user.setFullname(fullname != null ? fullname.trim() : "");
        user.setEmail(email != null ? email.trim() : "");
        user.setPhone(phone != null ? phone.trim() : "");
        user.setRole("USER");
        user.setStatus(1);
        user.setCreatedAt(LocalDateTime.now());
        return userRepository.save(user);
    }

    @Override
    public User login(String username, String password) {
        if (username == null || password == null) {
            return null;
        }
        Optional<User> optUser = userRepository.findByUsername(username.trim());
        if (optUser.isPresent()) {
            User user = optUser.get();
            if (PasswordUtil.checkPassword(password, user.getPassword())) {
                return user;
            }
        }
        return null;
    }

    @Override
    public Optional<User> findByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    @Override
    public Optional<User> findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    @Override
    public boolean existsByUsername(String username) {
        return userRepository.existsByUsername(username);
    }

    @Override
    public boolean existsByEmail(String email) {
        return userRepository.existsByEmail(email);
    }

    @Override
    public User save(User user) {
        return userRepository.save(user);
    }

    @Override
    public User createUser(User user) {
        if (StringUtils.hasText(user.getPassword())) {
            user.setPassword(PasswordUtil.hashPassword(user.getPassword()));
        }
        if (user.getCreatedAt() == null) {
            user.setCreatedAt(LocalDateTime.now());
        }
        return userRepository.save(user);
    }

    @Override
    public User updateUser(Long id, User userForm, String newPassword) {
        Optional<User> opt = userRepository.findById(id);
        if (opt.isPresent()) {
            User user = opt.get();
            user.setFullname(userForm.getFullname());
            user.setEmail(userForm.getEmail());
            user.setPhone(userForm.getPhone());
            user.setRole(userForm.getRole());
            user.setStatus(userForm.getStatus());
            if (StringUtils.hasText(newPassword)) {
                user.setPassword(PasswordUtil.hashPassword(newPassword));
            }
            return userRepository.save(user);
        }
        return null;
    }

    @Override
    public Optional<User> findById(Long id) {
        return userRepository.findById(id);
    }

    @Override
    public List<User> findAll() {
        return userRepository.findAll();
    }

    @Override
    public Page<User> findAll(Pageable pageable) {
        return userRepository.findAll(pageable);
    }

    @Override
    public Page<User> searchUsers(String keyword, Pageable pageable) {
        return userRepository.searchUsers(keyword, pageable);
    }

    @Override
    public void deleteById(Long id) {
        userRepository.deleteById(id);
    }

    @Override
    public long count() {
        return userRepository.count();
    }
}
