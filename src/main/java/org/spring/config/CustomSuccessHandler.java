package org.spring.config;

import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import org.spring.domain.User;
import org.spring.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Configuration
public class CustomSuccessHandler implements AuthenticationSuccessHandler {
	@Autowired
	private UserService userService;

	protected String determineTargetUrl(final org.springframework.security.core.Authentication authentication) {
		Map<String, String> roleMap = new HashMap<>();
		roleMap.put("ROLE_USER", "/");
		roleMap.put("ROLE_ADMIN", "/admin");

		final Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();

		for (final GrantedAuthority grantedAuthority : authorities) {
			String authorityName = grantedAuthority.getAuthority();
			if (roleMap.containsKey(authorityName)) {
				return roleMap.get(authorityName);
			}
		}

		throw new IllegalStateException("No matching role found!");
	}

	protected void clearAuthenticationAttributes(HttpServletRequest req,
			org.springframework.security.core.Authentication authentication) {
		HttpSession httpSession = req.getSession(false);
		if (httpSession == null) {
			return;
		}
		httpSession.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
		// email
		String email = authentication.getName();
		// User
		User user = userService.findByEmail(email);

		if (user != null) {
			httpSession.getId();
			httpSession.setAttribute("fullName", user.getFullName());
			httpSession.setAttribute("avatar", user.getAvatar());
			httpSession.setAttribute("email", user.getEmail());
			httpSession.setAttribute("id", user.getId());
			int sum = user.getCart() == null ? 0 : user.getCart().getSum();
			httpSession.setAttribute("sum", sum);

		}
	}

	private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			org.springframework.security.core.Authentication authentication) throws IOException, ServletException {
		String targetUrl = determineTargetUrl(authentication);
		if (response.isCommitted()) {
			return;
		}
		redirectStrategy.sendRedirect(request, response, targetUrl);
		clearAuthenticationAttributes(request, authentication);
	}
}
