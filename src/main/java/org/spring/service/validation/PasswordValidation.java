package org.spring.service.validation;

import org.spring.domain.dto.PasswordDTO;
import org.spring.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

public class PasswordValidation implements ConstraintValidator<PasswordChecked, PasswordDTO> {
	@Autowired
	private UserService userService;

	@Override
	public boolean isValid(PasswordDTO value, ConstraintValidatorContext context) {
		boolean valid = true;

		// Check if password fields match
		if (!value.getPassword().equals(value.getConfirmPassword())) {
			context.buildConstraintViolationWithTemplate("Mật khẩu mới và xác nhận mật khẩu không khớp")
					.addPropertyNode("confirmPassword").addConstraintViolation();
			valid = false;
		}

		return valid;
	}

}
