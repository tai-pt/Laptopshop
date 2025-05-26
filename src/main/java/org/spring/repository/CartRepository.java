package org.spring.repository;

import org.spring.domain.Cart;
import org.spring.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CartRepository extends JpaRepository<org.spring.domain.Cart, Long> {
	public Cart findByUser(User user);

}
