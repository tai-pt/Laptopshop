package org.spring.service.validation;

import org.springframework.stereotype.Service;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

@Service
public class StrongPassValidition implements ConstraintValidator<StrongPassword, String> {

	@Override
	public boolean isValid(String value, ConstraintValidatorContext context) {
		if (value == null) {
			return false; // hoặc true, tùy bạn muốn xử lý password null là hợp lệ hay không
		}
		return value.matches("^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=!*()]).{8,}$");
	}

}
