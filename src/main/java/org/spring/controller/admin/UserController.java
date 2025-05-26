package org.spring.controller.admin;

import java.util.List;

import org.spring.domain.User;
import org.spring.service.UploadService;
import org.spring.service.UserService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.Valid;

@Controller
@RequestMapping("/admin")
public class UserController {
	private final UserService userService;
	private final UploadService uploadService;
	private final PasswordEncoder passwordEncoder;

	public UserController(UserService userService, UploadService uploadService, PasswordEncoder passwordEncoder) {
		this.userService = userService;
		this.uploadService = uploadService;
		this.passwordEncoder = passwordEncoder;
	}

	// List
	@GetMapping("/user")
	public String getAll(Model model) {
		List<User> user = userService.getAllUser();
		model.addAttribute("user", user);
		return "admin/user/list";
	}

	// delete
	@GetMapping("/user/delete/{id}")
	public String deleteUser(Model model, @PathVariable long id) {
		model.addAttribute("user", new User());
		model.addAttribute("id", id);
		return "admin/user/delete";
	}

	@PostMapping("/user/delete/{id}")
	public String deleteUser(@PathVariable long id, @ModelAttribute("user") User user) {
		userService.deleteById(user.getId());
		return "redirect:/admin/user";
	}

	// GetUser
	@GetMapping("/user/find/{id}")
	public String getUserById(@PathVariable long id, Model model) {
		User user = userService.getUserById(id);
		model.addAttribute("user", user);
		return "admin/user/detail";
	}

	// Save
	@GetMapping("/user/save")
	public String saveUser(Model model) {
		model.addAttribute("user", new User());
		return "admin/user/save";
	}

	@PostMapping("/user/save")
	public String saveUser(@ModelAttribute("user") @Valid User user, BindingResult result,
			@RequestParam("avatarPath") MultipartFile multipartFile, Model model) {
		if (result.hasErrors()) {
			return "admin/user/save";
		}
		if (userService.checkEmailExits(user.getEmail())) {
			model.addAttribute("errorMessage", "Email đã tồn tại trong hệ thống.");
			return "admin/user/save";
		}
		// setAvatar
		String avatar = uploadService.handleSaveUploadFile(multipartFile, "avatar");
		user.setAvatar(avatar);
		// set Password
		String hassPass = passwordEncoder.encode(user.getPassword());
		user.setPassword(hassPass);
		// setRole
		user.setRole(userService.getRoleByName(user.getRole().getName()));

		userService.saveUser(user);

		return "redirect:/admin/user";
	}

	// Update
	@GetMapping("user/update/{id}")
	public String updateUser(@PathVariable long id, Model model) {
		User newUser = userService.getUserById(id);
		model.addAttribute("newUser", newUser);
		return "admin/user/update";
	}

	@PostMapping("user/update")
	public String updateUser(@ModelAttribute("newUser") @Valid User user, BindingResult bindingResult,
			@RequestParam("avatarPath") MultipartFile multipartFile) {
		User currentUser = userService.getUserById(user.getId());
		if (currentUser == null) {
			return "admin/user/update";
		} else {
			currentUser.setFullName(user.getFullName());
			currentUser.setEmail(user.getEmail());
			currentUser.setPhone(user.getPhone());
			// updateAvatar
			String avatar = uploadService.handleSaveUploadFile(multipartFile, "avatar");
			currentUser.setAvatar(avatar);
			userService.saveUser(currentUser);
			return "redirect:/admin/user";
		}

	}

}
