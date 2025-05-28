package org.spring.service.validation;

import org.spring.domain.dto.UserDTO;
import org.spring.service.UserService;
import org.springframework.stereotype.Service;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

@Service
public class UserValidation implements ConstraintValidator<UserChecked, UserDTO> {
	private final UserService userService;

	public UserValidation(UserService userService) {
		this.userService = userService;
	}

	@Override
	public boolean isValid(UserDTO user, ConstraintValidatorContext context) {
		boolean valid = true;
		// checkName
		if (this.userService.checkUserName(user.getFullName())) {
			context.buildConstraintViolationWithTemplate("Email đã tồn tại").addPropertyNode("email")
					.addConstraintViolation().disableDefaultConstraintViolation();
			valid = false;
		}

		return false;
	}

}
