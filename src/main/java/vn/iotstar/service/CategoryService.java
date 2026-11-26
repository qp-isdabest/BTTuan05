package vn.iotstar.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import vn.iotstar.entity.Category;

import java.util.List;
import java.util.Optional;

public interface CategoryService {

    Page<Category> findByNameContaining(String keyword, Pageable page);

    Page<Category> findAll(Pageable pageable);

    List<Category> findAll();

    Optional<Category> findById(Long id);

    <S extends Category> S save(S entity);

    void deleteById(Long id);

    long count();
}
