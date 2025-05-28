package org.spring.service;

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
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class UserService {

	private final UserRepository userRepository;
	private final RoleRepository roleRepository;
	private final OrderRepository orderRepository;
	private final ProductRepository productRepository;
	private final PasswordEncoder passwordEncoder;
	private final UploadService uploadService;

	public UserService(UserRepository userRepository, RoleRepository roleRepository, OrderRepository orderRepository,
			ProductRepository productRepository, PasswordEncoder passwordEncoder, UploadService uploadService) {
		super();
		this.userRepository = userRepository;
		this.roleRepository = roleRepository;
		this.orderRepository = orderRepository;
		this.productRepository = productRepository;
		this.passwordEncoder = passwordEncoder;
		this.uploadService = uploadService;
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

		if (userDTO.getPassword() != null && !userDTO.getPassword().isBlank()) {
			String pass = passwordEncoder.encode(userDTO.getPassword());
			user.setPassword(pass);
		}

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

}
