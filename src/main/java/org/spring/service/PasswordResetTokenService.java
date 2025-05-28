package org.spring.service;

import java.util.Locale;

import org.spring.domain.PasswordResetToken;
import org.spring.domain.User;
import org.spring.repository.PasswordResetTokenRepository;
import org.spring.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpServletRequest;

@Service
public class PasswordResetTokenService {

	private final PasswordResetTokenRepository passwordResetTokenRepository;

	@Autowired
	private org.springframework.core.env.Environment environment;

	@Autowired
	private MessageSource messages;
	@Autowired
	private PasswordEncoder passwordEncoder;
	@Autowired
	private UserRepository userRepository;

	public PasswordResetTokenService(PasswordResetTokenRepository passwordResetTokenRepository) {
		this.passwordResetTokenRepository = passwordResetTokenRepository;
	}

	public void createPasswordResetTokenForUser(User user, String token) {
		PasswordResetToken passwordResetToken = new PasswordResetToken(token, user);
		passwordResetTokenRepository.save(passwordResetToken);
	}

	public SimpleMailMessage constructResetTokenEmail(String appUrl, Locale locale, String token, User user) {
		String resetUrl = appUrl + "/changePassword?token=" + token + "&id=" + user.getId();
		String message = messages.getMessage("message.resetPassword", null, locale);
		return constructEmail("Reset Password", message + " \r\n" + appUrl, user);
	}

	private SimpleMailMessage constructEmail(String subject, String body, User user) {
		SimpleMailMessage email = new SimpleMailMessage();
		email.setSubject(subject);
		email.setText(body);
		email.setTo(user.getEmail());
		email.setFrom(environment.getProperty("support.email"));
		return email;
	}

	public String getAppUrl(HttpServletRequest request) {
		String scheme = request.getScheme();
		String serverName = request.getServerName();
		int serverPort = request.getServerPort();

		boolean isDefaultPort = (scheme.equals("http") && serverPort == 80)
				|| (scheme.equals("https") && serverPort == 443);

		return scheme + "://" + serverName + (isDefaultPort ? "" : ":" + serverPort);
	}

	public void changeUserPassword(User user, String pass) {
		user.setPassword(passwordEncoder.encode(pass));
		userRepository.save(user);

	}

	public PasswordResetToken findByToken(String token) {
		return passwordResetTokenRepository.findByToken(token);
	}

}
