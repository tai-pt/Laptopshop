package org.spring.repository;

import org.spring.domain.Products;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductRepository extends JpaRepository<Products, Long> {

	Page<Products> findAll(Pageable page);

	Page<Products> findAll(Specification<Products> spec, Pageable pageable);

}
