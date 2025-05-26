package org.spring.repository;

import org.spring.domain.Cart;
import org.spring.domain.CartDetails;
import org.spring.domain.Products;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CartDetailsRepository extends JpaRepository<CartDetails, Long> {

	CartDetails findByCartAndProduct(Cart cart, Products prodcut);

}
