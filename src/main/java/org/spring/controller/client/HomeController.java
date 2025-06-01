package org.spring.controller.client;

import java.io.UnsupportedEncodingException;
import java.security.Principal;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.spring.domain.Products;
import org.spring.domain.User;
import org.spring.domain.dto.PasswordDTO;
import org.spring.domain.dto.RegisterDTO;
import org.spring.domain.dto.UserDTO;
import org.spring.service.ProductService;
import org.spring.service.UploadService;
import org.spring.service.UserService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.query.Param;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class HomeController {
	private final UserService userService;
	private final PasswordEncoder passwordEncoder;
	private final ProductService productService;
	private final UploadService uploadService;

	public HomeController(UserService userService, PasswordEncoder passwordEncoder, ProductService productService,
			UploadService uploadService) {
		this.userService = userService;
		this.passwordEncoder = passwordEncoder;
		this.productService = productService;
		this.uploadService = uploadService;
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

	// ForgotPassword
	@GetMapping("/forgot_password")
	public String ForgotPassWord() {
		return "client/auth/forgot_password";
	}

	@PostMapping("/forgot_password")
	public String ForgotPassWord(@RequestParam("email") String email, HttpServletRequest request,
			RedirectAttributes redirectAttributes) throws UnsupportedEncodingException, MessagingException {

		User user = userService.findByEmail(email);

		if (user != null) {
			String token = UUID.randomUUID().toString();
			userService.updateResetPasswordToken(token, email);
			String resetPasswordLink = userService.getSiteURL(request) + "/reset_password?token=" + token;
			userService.sendEmail(email, resetPasswordLink);
			redirectAttributes.addFlashAttribute("message", "Check Link Reset in Email");
		} else {
			redirectAttributes.addFlashAttribute("error", "Cannot find Email: " + email);
		}

		return "redirect:/forgot_password";
	}

	@GetMapping("/reset_password")
	public String showResetPasswordForm(@Param(value = "token") String token, Model model) {
		User user = userService.getByResetPasswordToken(token);
		model.addAttribute("token", token);
		model.addAttribute("password", new PasswordDTO());

		if (user == null) {
			model.addAttribute("message", "Invalid Token");
			return "message";
		}

		return "client/auth/reset_password_form";
	}

	@PostMapping("/reset_password")
	public String postMethodName(@RequestParam("token") String token,
			@ModelAttribute("password") @Valid PasswordDTO passwordDTO, BindingResult result,
			RedirectAttributes redirectAttributes) {
		if (result.hasErrors()) {
			return "client/auth/reset_password_form";
		}
		User user = userService.getByResetPasswordToken(token);
		redirectAttributes.addFlashAttribute("title", "Reset your password");

		if (user == null) {
			redirectAttributes.addFlashAttribute("message", "Invalid Token");
			return "redirect:/message";
		} else {
			userService.updatePassWrord(passwordDTO, user);
			redirectAttributes.addFlashAttribute("message", "You have successfully changed your password.");

		}
		return "redirect:/message";
	}

	@GetMapping("/message")
	public String Message() {
		return "client/auth/message";
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

	// Profile-User
	@GetMapping("/profile")
	public String ProfileAccount(Model model, Principal principal) {
		String email = principal.getName();
		User user = userService.findByEmail(email);
		model.addAttribute("user", user);
		return "client/homepage/profile";
	}

	// Change-Password
	@GetMapping("/change-password")
	public String ChangePassword(Model model, Principal principal) {
		String email = principal.getName();
		User user = userService.findByEmail(email);
		model.addAttribute("password", new PasswordDTO());
		model.addAttribute("user", user);
		return "client/homepage/change-password";
	}

	@PostMapping("/change-password")
	public String ChangePassword(@ModelAttribute("pass") @Valid PasswordDTO passwordDTO, BindingResult bindingResult,
			Principal principal, RedirectAttributes redirectAttributes) throws Exception {

		if (bindingResult.hasErrors()) {
			bindingResult.rejectValue("confirmPassword", "error.confirmPassword", "Xác nhận mật khẩu không khớp");
			return "client/homepage/change-pass";
		}
		String email = principal.getName();
		User user = userService.findByEmail(email);
		if (user == null) {
			redirectAttributes.addFlashAttribute("message", "Invalid Token");
			return "redirect:/message";
		} else {
			userService.updatePassword(email, passwordDTO);
		}

		return "redirect:/profile";
	}

	// Update-Account
	@GetMapping("/edit-account")
	public String UpdateAccount(Model model, Principal principal) {
		String email = principal.getName();
		User user = userService.findByEmail(email);
		model.addAttribute("user", user);
		return "client/homepage/update-account";
	}

	@PostMapping("/edit-account")
	public String updateAccount(@ModelAttribute("user") UserDTO userDTO,
			@RequestParam("avatarPath") MultipartFile multipartFile, Principal principal,
			HttpServletRequest httpServletRequest) {
		String email = principal.getName();
		User user = userService.editAccountUser(userDTO, multipartFile, email);
		HttpSession httpSession = httpServletRequest.getSession();
		httpSession.setAttribute("fullName", user.getFullName());
		httpSession.setAttribute("avatar", user.getAvatar());
		return "redirect:/profile";
	}

}
