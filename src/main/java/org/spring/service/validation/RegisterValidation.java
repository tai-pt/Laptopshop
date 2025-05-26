package org.spring.service.validation;

import org.spring.domain.dto.RegisterDTO;
import org.spring.service.UserService;
import org.springframework.stereotype.Service;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

@Service
public class RegisterValidation implements ConstraintValidator<RegisterChecked, RegisterDTO> {

	private final UserService userService;

	public RegisterValidation(UserService userService) {
		this.userService = userService;
	}

	@Override
	public boolean isValid(RegisterDTO value, ConstraintValidatorContext context) {
		boolean valid = true;

		// Check if password fields match
		if (!value.getPassword().equals(value.getConfirmPassword())) {
			context.buildConstraintViolationWithTemplate("Passwords nhập không chính xác")
					.addPropertyNode("confirmPassword").addConstraintViolation().disableDefaultConstraintViolation();
			valid = false;
		}
		// checkEmail
		if (this.userService.checkEmailExits(value.getEmail())) {
			context.buildConstraintViolationWithTemplate("Email đã tồn tại").addPropertyNode("email")
					.addConstraintViolation().disableDefaultConstraintViolation();
			valid = false;
		}

		return valid;

	}
}