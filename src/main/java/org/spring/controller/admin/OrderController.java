package org.spring.controller.admin;

import java.util.List;
import java.util.Optional;

import org.spring.domain.Order;
import org.spring.service.OrderService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.validation.Valid;

@Controller
@RequestMapping("/admin")
public class OrderController {
	private final OrderService orderService;

	public OrderController(OrderService orderService) {
		super();
		this.orderService = orderService;
	}

	@GetMapping("/order")
	public String ListOrder(Model model, @RequestParam("page") Optional<String> optional) {
		int page = 1;
		try {
			if (optional.isPresent()) {
				page = Integer.parseInt(optional.get());
			}
		} catch (NumberFormatException e) {

		}
		Pageable pageable = PageRequest.of(page - 1, 5);
		Page<Order> pageList = orderService.findAll(pageable);
		List<Order> list = pageList.getContent();
		model.addAttribute("order", list);
		// Page
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPage", pageList.getTotalPages());

		return "admin/order/list";
	}

	// deleteByid
	@PostMapping("/order/delete/{id}")
	public String deleteOrder(@PathVariable long id, @ModelAttribute Order order) {
		orderService.deleteOrder(order.getId());
		return "redirect:/admin/order";
	}

	// getOrderById
	@GetMapping("/order/view/{id}")
	public String viewOrder(@PathVariable long id, Model model) {
		Order order = orderService.getOrderById(id);
		model.addAttribute("id", id);
		model.addAttribute("order", order);
		return "admin/order/view";
	}

	// updateOrder
	@GetMapping("/order/update/{id}")
	public String showUpdateOrderForm(@PathVariable long id, Model model) {
		Order currentOrder = orderService.getOrderById(id);
		if (currentOrder == null) {
			return "redirect:/admin/order";
		}
		model.addAttribute("order", currentOrder);
		return "admin/order/update";
	}

	@PostMapping("/order/update/{id}")
	public String updateOrderStatus(@PathVariable long id, @ModelAttribute("order") @Valid Order order,
			BindingResult result, Model model) {
		if (result.hasErrors()) {
			return "admin/order/update";
		}

		Order existingOrder = orderService.getOrderById(id);
		if (existingOrder != null) {
			existingOrder.setStatus(order.getStatus());
			orderService.updateOrder(existingOrder);
		}

		return "redirect:/admin/order";
	}

}
