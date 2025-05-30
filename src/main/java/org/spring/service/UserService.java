package org.spring.service;

import java.io.UnsupportedEncodingException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.spring.domain.Role;
import org.spring.domain.User;
import org.spring.domain.dto.RegisterDTO;
import org.spring.domain.dto.UserDTO;
import org.spring.repository.OrderRepository;
import org.spring.repository.ProductRepository;
import org.spring.repository.RoleRepository;
import org.spring.repository.UserRepository;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.http.HttpServletRequest;

@Service
public class UserService {

	private final UserRepository userRepository;
	private final RoleRepository roleRepository;
	private final OrderRepository orderRepository;
	private final ProductRepository productRepository;
	private final PasswordEncoder passwordEncoder;
	private final UploadService uploadService;
	private final JavaMailSender javaMailSender;

	public UserService(UserRepository userRepository, RoleRepository roleRepository, OrderRepository orderRepository,
			ProductRepository productRepository, PasswordEncoder passwordEncoder, UploadService uploadService,
			JavaMailSender javaMailSender) {
		super();
		this.userRepository = userRepository;
		this.roleRepository = roleRepository;
		this.orderRepository = orderRepository;
		this.productRepository = productRepository;
		this.passwordEncoder = passwordEncoder;
		this.uploadService = uploadService;
		this.javaMailSender = javaMailSender;
	}

	// list
	public List<User> getAllUser() {
		return this.userRepository.findAll();

	}

	// getById
	public Optional<User> getById(long id) {
		return this.userRepository.findById(id);
	}

	// deleteByID
	public void deleteById(long id) {
		this.userRepository.deleteById(id);
	}

	// Save
	public void saveUser(User user) {
		this.userRepository.save(user);

	}

	// Role
	public Role getRoleByName(String name) {
		return this.roleRepository.findByName(name);
	}

	// getUserById
	public User getUserById(long id) {
		return userRepository.getById(id);

	}

	// Register
	public User registerDTOtoUser(RegisterDTO registerDTO) {
		User user = new User();
		user.setFullName(registerDTO.getFirstName() + " " + registerDTO.getLastName());
		user.setEmail(registerDTO.getEmail());
		user.setPassword(registerDTO.getPassword());
		return user;

	}

	// Edit-Account
	public User editAccountUser(UserDTO userDTO, MultipartFile multipartFile, String email) {
		User user = userRepository.findByEmail(email);

		user.setFullName(userDTO.getFullName());
		user.setPhone(userDTO.getPhone());
		user.setAddress(userDTO.getAddress());

		if (!multipartFile.isEmpty()) {
			String avatar = uploadService.handleSaveUploadFile(multipartFile, "avatar");
			user.setAvatar(avatar);
		}

		return userRepository.save(user);
	}

	// checkEmail
	public boolean checkEmailExits(String email) {
		return userRepository.existsByEmail(email);
	}

	// findByEmail
	public User findByEmail(String email) {
		return userRepository.findByEmail(email);
	}

	// Count
	public long CountOrder() {
		return orderRepository.count();
	}

	public long CountProduct() {
		return productRepository.count();
	}

	public long CountUser() {
		return userRepository.count();
	}

	// profile
	public Optional<User> Profile(long id) {
		return userRepository.findById(id);

	}

	// check Name
	public boolean checkUserName(String fullName) {
		return userRepository.existsByFullName(fullName);
	}

	// Forgot Password
	public void updateResetPasswordToken(String token, String email) {
		User user = userRepository.findByEmail(email);
		if (user != null) {
			user.setResetPasswordToken(token);
			user.setResetTokenCreatedAt(LocalDateTime.now());
			userRepository.save(user);
		} else {

		}
	}

	public User getByResetPasswordToken(String token) {
		return userRepository.findByResetPasswordToken(token);
	}

	public void sendEmail(String recipientEmail, String link) throws MessagingException, UnsupportedEncodingException {
		MimeMessage message = javaMailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message);

		helper.setFrom("phamtantai251105@gmail.com", "Reset Password !");
		helper.setTo(recipientEmail);

		String subject = "Here's the link to reset your password";

		String content = "<p>Hello,</p>" + "<p>You have requested to reset your password.</p>"
				+ "<p>Click the link below to change your password:</p>" + "<p><a href=\"" + link
				+ "\">Change my password</a></p>" + "<br>" + "<p>Ignore this email if you do remember your password, "
				+ "or you have not made the request.</p>";

		helper.setSubject(subject);

		helper.setText(content, true);

		javaMailSender.send(message);

	}

	public String getSiteURL(HttpServletRequest request) {
		String siteURL = request.getRequestURL().toString();
		return siteURL.replace(request.getServletPath(), "");
	}

	public User updatePassWord(String newPass, User user) {
		String passWordUpdate = passwordEncoder.encode(newPass);
		user.setPassword(passWordUpdate);
		user.setResetPasswordToken(null);
		return userRepository.save(user);

	}

	public boolean isResetTokenExpired(User user) {
		LocalDateTime createdAt = user.getResetTokenCreatedAt();
		return createdAt.isBefore(LocalDateTime.now().minusHours(2));
	}

}
