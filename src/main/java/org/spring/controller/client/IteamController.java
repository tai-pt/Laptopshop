package org.spring.controller.client;

import java.util.ArrayList;
import java.util.List;

import org.spring.domain.Cart;
import org.spring.domain.CartDetails;
import org.spring.domain.Order;
import org.spring.domain.Products;
import org.spring.domain.User;
import org.spring.service.OrderService;
import org.spring.service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class IteamController {
	private final ProductService productService;
	private final OrderService orderService;

	public IteamController(ProductService productService, OrderService orderService) {
		this.productService = productService;
		this.orderService = orderService;
	}

	@GetMapping("/product/{id}")
	public String getProduct(@PathVariable long id, Model model) {
		Products products = productService.getById(id);
		model.addAttribute("product", products);
		model.addAttribute("id", id);
		return "client/product/detail";
	}

	// Cart
	@PostMapping("/add-product-to-cart/{id}")
	public String AddCart(@PathVariable long id, HttpServletRequest request) {
		HttpSession session = request.getSession(true);
		long productId = id;
		String email = (String) session.getAttribute("email");
		productService.handleAddProductToCart(email, productId, session);
		return "redirect:/";
	}

	@GetMapping("/cart")
	public String Cart(Model model, HttpServletRequest httpServletRequest) {
		User currentUser = new User();
		HttpSession httpSession = httpServletRequest.getSession();
		long id = (long) httpSession.getAttribute("id");
		currentUser.setId(id);

		org.spring.domain.Cart cart = productService.findByUser(currentUser);

		List<CartDetails> cartDetails = cart == null ? new ArrayList<CartDetails>() : cart.getCartDetails();

		double totalPrice = 0;

		for (CartDetails cd : cartDetails) {
			totalPrice += cd.getPrice() * cd.getQuantity();

		}
		model.addAttribute("cartDetails", cartDetails);
		model.addAttribute("totalPrice", totalPrice);
		model.addAttribute("cart", cart);
		return "client/cart/show";
	}

	// deleteCart
	@PostMapping("/delete-cart/{id}")
	public String deleteCart(@PathVariable long id, HttpServletRequest httpServletRequest) {
		HttpSession session = httpServletRequest.getSession(true);
		long cartId = id;
		productService.handleRemoveCartDetails(cartId, session);
		return "redirect:/cart";
	}

	// check-out
	@GetMapping("/cart/check-out")
	public String CheckOut(Model model, HttpServletRequest httpServletRequest) {
		User currentUser = new User();
		HttpSession session = httpServletRequest.getSession(false);
		long id = (long) session.getAttribute("id");
		currentUser.setId(id);

		Cart cart = this.productService.findByUser(currentUser);

		List<CartDetails> cartDetails = cart == null ? new ArrayList<CartDetails>() : cart.getCartDetails();
		double totalPrice = 0;
		for (CartDetails cd : cartDetails) {
			totalPrice += cd.getPrice() * cd.getQuantity();
		}

		model.addAttribute("cartDetails", cartDetails);
		model.addAttribute("totalPrice", totalPrice);

		return "client/cart/checkout";
	}

	@PostMapping("/cart/check-out")
	public String ComfirmCheckout(@ModelAttribute("cart") org.spring.domain.Cart cart) {
		List<CartDetails> cartDetails = cart == null ? new ArrayList<CartDetails>() : cart.getCartDetails();
		productService.handleUpdateBeforeCheckOut(cartDetails);
		return "redirect:/cart/check-out";
	}

	@PostMapping("/cart/place-order")
	public String Order(@RequestParam("receiverName") String receiverName,
			@RequestParam("receiverAddress") String receiverAddress,
			@RequestParam("receiverPhone") String receiverPhone, HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		User currentUser = new User();
		long id = (long) session.getAttribute("id");
		currentUser.setId(id);
		productService.handleOrder(currentUser, session, receiverName, receiverAddress, receiverPhone);
		return "redirect:/order-sucess";
	}

	// Order Success
	@GetMapping("/order-sucess")
	public String OrderSuccess() {
		return "client/cart/order-sucess";
	}

	// Order-History
	@GetMapping("/order-history")
	public String OrderHistory(Model model, HttpServletRequest httpServletRequest) {
		User currentUser = new User();
		HttpSession httpSession = httpServletRequest.getSession(false);
		long id = (long) httpSession.getAttribute("id");
		currentUser.setId(id);

		List<Order> orders = orderService.fetchOrderByUser(currentUser);
		model.addAttribute("orders", orders);
		return "client/cart/order-history";
	}

}
