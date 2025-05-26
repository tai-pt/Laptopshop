package org.spring.service;

import java.util.List;
import java.util.Optional;

import org.spring.domain.Order;
import org.spring.domain.OrderDetails;
import org.spring.domain.User;
import org.spring.repository.OrderDetailsRepository;
import org.spring.repository.OrderRepository;
import org.spring.repository.ProductRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
public class OrderService {
	private final org.spring.repository.ProductRepository productRepository;
	private final OrderRepository orderRepository;
	private final OrderDetailsRepository orderDetailsRepository;

	public OrderService(ProductRepository productRepository, OrderRepository orderRepository,
			OrderDetailsRepository orderDetailsRepository) {
		this.productRepository = productRepository;
		this.orderRepository = orderRepository;
		this.orderDetailsRepository = orderDetailsRepository;
	}

	// get list
	public List<Order> getListOrder() {
		return orderRepository.findAll();

	}

	// delete Order

	public void deleteOrder(long orderDetailId) {
		Optional<OrderDetails> orderDetailOptional = orderDetailsRepository.findById(orderDetailId);
		if (orderDetailOptional.isPresent()) {
			OrderDetails orderDetails = orderDetailOptional.get();
			Order currentOrder = orderDetails.getOrder();
			orderDetailsRepository.deleteById(orderDetailId);
			List<OrderDetails> details = orderDetailsRepository.findByOrder(currentOrder);
			if (details.size() == 0) {
				orderRepository.delete(currentOrder);
			}
		}

	}

	// get Order
	public Order getOrderById(long id) {
		return orderRepository.getById(id);
	}

	// update Order
	public Order updateOrder(Order order) {
		return orderRepository.save(order);
	}

	// Page
	public Page<Order> findAll(Pageable page) {
		return orderRepository.findAll(page);
	}

	// Order-History
	public List<Order> fetchOrderByUser(User user) {
		return orderRepository.findByUser(user);
	}

	public List<OrderDetails> fetchOrderDetial(Order order) {
		return orderDetailsRepository.findByOrder(order);
	}

}
