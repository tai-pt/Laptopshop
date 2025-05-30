package org.spring.domain.dto;

public class UserDTO {
	private String fullName;
	private String address;
	private String phone;
	private String avatar;

	public UserDTO(String fullName, String address, String phone, String avatar) {
		super();
		this.fullName = fullName;
		this.address = address;
		this.phone = phone;
		this.avatar = avatar;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
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

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {

		this.avatar = avatar;
	}

	public UserDTO() {
		super();
	}

}
