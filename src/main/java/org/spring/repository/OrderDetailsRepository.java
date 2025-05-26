package org.spring.repository;

import java.util.List;

import org.spring.domain.Order;
import org.spring.domain.OrderDetails;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderDetailsRepository extends JpaRepository<OrderDetails, Long> {
	public List<OrderDetails> findByOrder(Order order);

}
