package org.spring.service;

import java.util.Calendar;

import org.spring.domain.PasswordResetToken;
import org.spring.domain.User;
import org.spring.repository.PasswordResetTokenRepository;
import org.spring.repository.SecurityUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SercurityService implements SecurityUserService {

	@Autowired
	private PasswordResetTokenRepository passwordResetTokenRepository;

	@Override
	public String validatePasswordResetToken(long id, String token) {
		final PasswordResetToken passToken = passwordResetTokenRepository.findByToken(token);
		if ((passToken == null) || (passToken.getUser().getId() != id)) {
			return "invalidToken";
		}

		final Calendar cal = Calendar.getInstance();
		if ((passToken.getExpiryDate().getTime() - cal.getTime().getTime()) <= 0) {
			return "expired";
		}
		final User user = passToken.getUser();
		return null;

	}

}
