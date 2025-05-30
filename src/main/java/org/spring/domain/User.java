package org.spring.domain;

import java.time.LocalDateTime;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

@Entity
@Table(name = "user")
public class User {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long id;
	@Column(name = "fullName")
	@NotNull
	private String fullName;
	@Column(name = "email")
	@NotNull
	@NotBlank(message = "Email is required")
	@Email(message = "Invalid email format")
	private String email;
	@Column(name = "address")
	private String address;
	@Column(name = "phone")
	private String phone;
	@Column(name = "password")
	@NotBlank(message = "Password is required")
	@Size(min = 6, message = "Password must be at least 6 characters")
	private String password;
	@Column(name = "avatar")
	private String avatar;
	@Column(name = "reset_password_token")
	private String resetPasswordToken;

	@Column(name = "reset_token_created_at")
	private LocalDateTime resetTokenCreatedAt;

	public LocalDateTime getResetTokenCreatedAt() {
		return resetTokenCreatedAt;
	}

	public void setResetTokenCreatedAt(LocalDateTime resetTokenCreatedAt) {
		this.resetTokenCreatedAt = resetTokenCreatedAt;
	}

	public String getResetPasswordToken() {
		return resetPasswordToken;
	}

	public void setResetPasswordToken(String resetPasswordToken) {
		this.resetPasswordToken = resetPasswordToken;
	}

	@OneToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "cart_id", referencedColumnName = "id")
	private Cart cart;

	// Role
	@ManyToOne
	@JoinColumn(name = "role_id")
	private Role role;

	public List<Order> getOrders() {
		return orders;
	}

	public void setOrders(List<Order> orders) {
		this.orders = orders;
	}

	// Order
	@OneToMany(mappedBy = "user")
	private List<Order> orders;

	public User(long id, @NotNull String fullName,
			@NotNull @NotBlank(message = "Email is required") @Email(message = "Invalid email format") String email,
			String address, String phone,
			@NotBlank(message = "Password is required") @Size(min = 6, message = "Password must be at least 6 characters") String password,
			String avatar, Cart cart, Role role) {
		super();
		this.id = id;
		this.fullName = fullName;
		this.email = email;
		this.address = address;
		this.phone = phone;
		this.password = password;
		this.avatar = avatar;
		this.cart = cart;
		this.role = role;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public Cart getCart() {
		return cart;
	}

	public void setCart(Cart cart) {
		this.cart = cart;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public User() {
		super();
	}

}
