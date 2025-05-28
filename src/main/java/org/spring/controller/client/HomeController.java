package org.spring.controller.client;

import java.security.Principal;
import java.util.List;
import java.util.Locale;
import java.util.Optional;
import java.util.UUID;

import org.spring.domain.PasswordResetToken;
import org.spring.domain.Products;
import org.spring.domain.User;
import org.spring.domain.dto.RegisterDTO;
import org.spring.domain.dto.UserDTO;
import org.spring.service.PasswordResetTokenService;
import org.spring.service.ProductService;
import org.spring.service.SercurityService;
import org.spring.service.UploadService;
import org.spring.service.UserService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class HomeController {
	private final UserService userService;
	private final PasswordEncoder passwordEncoder;
	private final ProductService productService;
	private final UploadService uploadService;
	private final JavaMailSender javaMailSender;
	private final PasswordResetTokenService passwordResetTokenService;
	private final SercurityService sercurityService;

	public HomeController(UserService userService, PasswordEncoder passwordEncoder, ProductService productService,
			UploadService uploadService, JavaMailSender javaMailSender,
			PasswordResetTokenService passwordResetTokenService, SercurityService sercurityService) {
		super();
		this.userService = userService;
		this.passwordEncoder = passwordEncoder;
		this.productService = productService;
		this.uploadService = uploadService;
		this.javaMailSender = javaMailSender;
		this.passwordResetTokenService = passwordResetTokenService;
		this.sercurityService = sercurityService;
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
	@GetMapping("/resetPassword")
	public String getMethodName() {
		return "client/auth/reset-password";
	}

	@PostMapping("/resetPassword")
	public String resetPassword(@RequestParam("email") String email, HttpServletRequest request) {
		User user = userService.findByEmail(email);
		if (user != null) {
	System.out.println("User email: " + user.getEmail());
    System.out.println("User ID: " + user.getId());
			
			String token = UUID.randomUUID().toString();
			passwordResetTokenService.createPasswordResetTokenForUser(user, token);
			try {
				String appUrl = passwordResetTokenService.getAppUrl(request);
				SimpleMailMessage emailMessage = passwordResetTokenService.constructResetTokenEmail(appUrl,
						request.getLocale(), token, user);
				javaMailSender.send(emailMessage);

			} catch (Exception e) {
			}
		}
		return "redirect:/changePassword";
	}

	@GetMapping("/changePassword")
	public String showChangePasswordPage(Locale locale, Model model, @RequestParam("token") String token, long id) {
		String result = sercurityService.validatePasswordResetToken(id, token);
		if (result != null) {
			return "redirect:/login" + locale.getLanguage() + "&message=";
		} else {
			model.addAttribute("token", token);
			return "redirect:/updatePassword" + locale.getLanguage();
		}
	}

	@GetMapping("/savePassword")
	public String savePass() {
		return "client/auth/update-password";
	}

	@PostMapping("/savePassword")
	public String savePassword(@RequestParam("token") String token, @RequestParam("password") String password,
			Model model) {
		PasswordResetToken resetToken = passwordResetTokenService.findByToken(token);

		if (resetToken == null || resetToken.isExpired()) {
			model.addAttribute("message", "Token không hợp lệ hoặc đã hết hạn.");
			return "error";
		}

		User user = resetToken.getUser();
		passwordResetTokenService.changeUserPassword(user, password);

		model.addAttribute("message", "Mật khẩu đã được thay đổi thành công.");
		return "redirect:/login";
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
