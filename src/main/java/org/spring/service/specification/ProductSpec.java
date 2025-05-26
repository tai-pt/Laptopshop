package org.spring.service.specification;

import org.spring.domain.Products;
import org.springframework.data.jpa.domain.Specification;

public class ProductSpec {
	// Page filter
	public static Specification<Products> nameLike(String name) {
		return (root, query, CriteriaBuilder) -> CriteriaBuilder.like(root.get("name"), "%" + name + "%");

	}

}
