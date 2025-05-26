package org.spring.controller.client;

import java.util.List;
import java.util.Optional;

import org.spring.domain.Products;
import org.spring.domain.User;
import org.spring.domain.dto.RegisterDTO;
import org.spring.service.ProductService;
import org.spring.service.UserService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;

@Controller
public class HomeController {
	private final UserService userService;
	private final PasswordEncoder passwordEncoder;
	private final ProductService productService;

	public HomeController(UserService userService, PasswordEncoder passwordEncoder, ProductService productService) {
		this.userService = userService;
		this.passwordEncoder = passwordEncoder;
		this.productService = productService;
	}

	// List Product
	@GetMapping("/")
	public String getProduct(Model model, HttpServletRequest request) {
		List<Products> products = productService.findAll();
		model.addAttribute("product", products);
		return "client/homepage/show";
	}

	// Register
	@GetMapping("/register")
	public String getRegisterPage(Model model) {
		model.addAttribute("registerUser", new RegisterDTO());
		return "client/auth/register";

	}

	@PostMapping("/register")
	public String handleRegister(@ModelAttribute("registerUser") @Valid RegisterDTO registerDTO,
			BindingResult bindingResult) {
		if (bindingResult.hasErrors()) {
			return "client/auth/register";
		}
		User user = userService.registerDTOtoUser(registerDTO);
		String password = passwordEncoder.encode(user.getPassword());
		user.setPassword(password);
		user.setRole(userService.getRoleByName("USER"));
		userService.saveUser(user);
		return "redirect:/login";
	}

	// Login
	@GetMapping("/login")
	public String getLoginPage() {
		return "client/auth/login";
	}

	// AccessDenied
	@GetMapping("/access-denied")
	public String AccessDenied() {
		return "client/auth/accessDenied";
	}

	@GetMapping("/logout-expired")
	public String LogoutExpired() {
		return "client/auth/logout-expired";
	}

	// collections
	@GetMapping("/collections")
	public String Collections(Model model, @RequestParam("page") Optional<String> optional,
			@RequestParam("name") Optional<String> nameOptional) {
		int page = 1;
		try {
			if (optional.isPresent()) {
				page = Integer.parseInt(optional.get());
			}
		} catch (NumberFormatException e) {

		}
		String name = nameOptional.isPresent() ? nameOptional.get() : "";
		Pageable pageable = PageRequest.of(page - 1, 5);
		Page<Products> pageList = productService.fetchProducts(pageable, name);
		List<Products> list = pageList.getContent();
		model.addAttribute("products", list);
		// Page
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPage", pageList.getTotalPages());

		return "client/product/list";

	}
}
