package org.spring.controller.admin;

import org.spring.service.OrderService;
import org.spring.service.ProductService;
import org.spring.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DashboardController {
	private final UserService userService;
	private final ProductService productService;
	private final OrderService orderService;
//
	public DashboardController(UserService userService, ProductService productService, OrderService orderService) {
		this.userService = userService;
		this.productService = productService;
		this.orderService = orderService;
	}

	@GetMapping("/admin")
	public String Dashboard(Model model) {
		model.addAttribute("countUser", userService.CountUser());
		model.addAttribute("countProduct", userService.CountProduct());
		model.addAttribute("countOrder", userService.CountOrder());
		return "admin/dashboard/show";
	}

}
