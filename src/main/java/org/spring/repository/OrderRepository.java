package org.spring.repository;

import java.util.List;

import org.spring.domain.Order;
import org.spring.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {
	public List<Order> findByUser(User user);

}
