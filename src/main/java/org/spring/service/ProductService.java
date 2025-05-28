package org.spring.service;

import java.util.List;
import java.util.Optional;

import org.spring.domain.Cart;
import org.spring.domain.CartDetails;
import org.spring.domain.Order;
import org.spring.domain.OrderDetails;
import org.spring.domain.Products;
import org.spring.domain.User;
import org.spring.repository.CartDetailsRepository;
import org.spring.repository.CartRepository;
import org.spring.repository.OrderDetailsRepository;
import org.spring.repository.OrderRepository;
import org.spring.repository.ProductRepository;
import org.spring.service.specification.ProductSpec;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;

@Service
public class ProductService {
	private final ProductRepository productRepository;
	private final CartDetailsRepository cartDetailsRepository;
	private final CartRepository cartRepository;
	private final UserService userService;
	private final OrderRepository orderRepository;
	private final OrderDetailsRepository orderDetailsRepository;

	public ProductService(ProductRepository productRepository, CartDetailsRepository cartDetailsRepository,
			CartRepository cartRepository, UserService userService, OrderRepository orderRepository,
			OrderDetailsRepository orderDetailsRepository) {
		super();
		this.productRepository = productRepository;
		this.cartDetailsRepository = cartDetailsRepository;
		this.cartRepository = cartRepository;
		this.userService = userService;
		this.orderRepository = orderRepository;
		this.orderDetailsRepository = orderDetailsRepository;
	}

	// list
	public List<Products> findAll() {
		return this.productRepository.findAll();
	}

	// Create
	public void createProduct(Products products) {
		this.productRepository.save(products);
	}

	// findById
	public Optional<Products> findById(long id) {
		return this.productRepository.findById(id);
	}

	// delete
	public void deleteProductById(long id) {
		this.productRepository.deleteById(id);
	}

	// getById
	public Products getById(long id) {
		return productRepository.getById(id);
	}

	// findByUser
	public Cart findByUser(User user) {
		return cartRepository.findByUser(user);
	}

	// Page
	public Page<Products> fetchProductPage(Pageable pageable) {
		return productRepository.findAll(pageable);
	}

// Cart
	public void handleAddProductToCart(String email, long productId, HttpSession session) {
		User user = userService.findByEmail(email);
		if (user != null) {
			Cart cart = cartRepository.findByUser(user);
			if (cart == null) {
				Cart otherCart = new Cart();
				otherCart.setUser(user);
				otherCart.setSum(1);
				cart = cartRepository.save(otherCart);

			}
			// save CartDetails
			Optional<Products> pOptional = productRepository.findById(productId);
			if (pOptional.isPresent()) {
				Products products = pOptional.get();
				CartDetails oldDetails = cartDetailsRepository.findByCartAndProduct(cart, products);
				if (oldDetails == null) {
					CartDetails cartDetails = new CartDetails();
					cartDetails.setCart(cart);
					cartDetails.setProduct(products);
					cartDetails.setPrice(products.getPrice());
					cartDetails.setQuantity(1);
					cartDetailsRepository.save(cartDetails);
					int s = cart.getSum() + 1;
					cart.setSum(s);
					cartRepository.save(cart);
					session.setAttribute("sum", s);
				} else {
					oldDetails.setQuantity(oldDetails.getQuantity() + 1);
					cartDetailsRepository.save(oldDetails);
				}

			}

		}

	}

	// delete Cart
	public void handleRemoveCartDetails(long cartDetailsId, HttpSession httpSession) {
		Optional<CartDetails> cartdetailOptional = cartDetailsRepository.findById(cartDetailsId);
		if (cartdetailOptional.isPresent()) {
			CartDetails cartDetails = cartdetailOptional.get();
			Cart currentCart = cartDetails.getCart();
			// deleteCartDetails
			cartDetailsRepository.deleteById(cartDetailsId);
			// updateCart
			if (currentCart.getSum() > 1) {
				int s = currentCart.getSum() - 1;
				httpSession.setAttribute("sum", s);
				cartRepository.deleteById(cartDetailsId);

			}

		}
	}

	// updateBeforeCheckOut
	public void handleUpdateBeforeCheckOut(List<CartDetails> cartDetails) {
		for (CartDetails cd : cartDetails) {
			Optional<CartDetails> cartdetailsOptional = cartDetailsRepository.findById(cd.getId());
			if (cartdetailsOptional.isPresent()) {
				CartDetails currentCartDetail = cartdetailsOptional.get();
				currentCartDetail.setQuantity(cd.getQuantity());
				cartDetailsRepository.save(currentCartDetail);
			}
		}

	}

	// Order
	public void handleOrder(User user, HttpSession session, String receiverName, String receiverAddress,
			String receiverPhone) {
		// create
		Order order = new Order();
		order.setName(receiverName);
		order.setAddress(receiverAddress);
		order.setPhone(receiverPhone);
		order.setUser(user);
		order.setStatus("PENDING");
		order = orderRepository.save(order);

		Cart cart = cartRepository.findByUser(user);

		if (cart != null) {
			List<CartDetails> cartDetails = cart.getCartDetails();
			if (cartDetails != null) {
				for (CartDetails cd : cartDetails) {
					OrderDetails orderDetails = new OrderDetails();
					orderDetails.setOrder(order);
					orderDetails.setPrice(cd.getPrice());
					orderDetails.setProduct(cd.getProduct());
					orderDetails.setQuantity(cd.getQuantity());

					orderDetailsRepository.save(orderDetails);
				}

				// delete Cart_delete and cart
				for (CartDetails cd : cartDetails) {
					cartDetailsRepository.delete(cd);

				}
				cartRepository.delete(cart);
				// update session
				session.setAttribute("sum", 0);
			}
		}
	}

	public Page<Products> fetchProducts(Pageable page, String name) {
		return productRepository.findAll(ProductSpec.nameLike(name), page);
	}

}