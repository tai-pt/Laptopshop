package org.spring.config;

import jakarta.servlet.DispatcherType;
import jakarta.servlet.SessionCookieConfig;
import org.spring.service.CustomUserDetailsService;
import org.spring.service.UserService;
import org.springframework.boot.web.servlet.ServletContextInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.session.HttpSessionEventPublisher;
import org.springframework.security.web.session.SessionInformationExpiredStrategy;
import org.springframework.security.web.session.SimpleRedirectSessionInformationExpiredStrategy;

@Configuration
public class SecurityConfig {

	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

	@Bean
	public UserDetailsService userDetailsService(UserService userService) {
		return new CustomUserDetailsService(userService);
	}

	@Bean
	public SessionRegistry sessionRegistry() {
		return new SessionRegistryImpl();
	}

	@Bean
	public DaoAuthenticationProvider authProvider(PasswordEncoder passwordEncoder,
												  UserDetailsService userDetailsService) {
		DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
		authProvider.setUserDetailsService(userDetailsService);
		authProvider.setPasswordEncoder(passwordEncoder);
		return authProvider;
	}

	@Bean(name = "customSuccessHandlerV2")
	public CustomSuccessHandler customSuccessHandler() {
		return new CustomSuccessHandler();
	}

	@Bean
	public CustomLogoutHandler customLogoutHandler(SessionRegistry sessionRegistry) {
		return new CustomLogoutHandler(sessionRegistry);
	}

	@Bean
	public HttpSessionEventPublisher httpSessionEventPublisher() {
		return new HttpSessionEventPublisher();
	}

	@Bean
	public SessionInformationExpiredStrategy sessionInformationExpiredStrategy() {
		return new SimpleRedirectSessionInformationExpiredStrategy("/login?expired=true");
	}

	@Bean
	public ServletContextInitializer servletContextInitializer() {
		return servletContext -> {
			SessionCookieConfig sessionCookieConfig = servletContext.getSessionCookieConfig();
			sessionCookieConfig.setMaxAge(-1);
			sessionCookieConfig.setHttpOnly(true);
			sessionCookieConfig.setSecure(true);
		};
	}

	@Bean
	SecurityFilterChain filterChain(HttpSecurity http,
									CustomLogoutHandler customLogoutHandler,
									SessionRegistry sessionRegistry) throws Exception {
		http
				.authorizeHttpRequests(authorize -> authorize
						.dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.INCLUDE).permitAll()
						.requestMatchers("/", "/login", "/register", "/product/**", "/client/**", "/css/**", "/js/**",
								"/images/**", "/forgot_password", "/reset_password", "/message", "/collections")
						.permitAll()
						.requestMatchers("/admin/**").hasRole("ADMIN")
						.anyRequest().authenticated()
				)
				.sessionManagement(session -> session
						.sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED)
						.invalidSessionUrl("/login?expired=true")
						.maximumSessions(1)
						.maxSessionsPreventsLogin(true)
						.expiredSessionStrategy(sessionInformationExpiredStrategy())
						.sessionRegistry(sessionRegistry)
				)
				.logout(logout -> logout
						.logoutUrl("/logout")
						.addLogoutHandler(customLogoutHandler)
						.deleteCookies("JSESSIONID")
						.permitAll()
				)
				.formLogin(formLogin -> formLogin
						.loginPage("/login")
						.failureUrl("/login?error=true")
						.successHandler(customSuccessHandler())
						.permitAll()
				)
				.exceptionHandling(ex -> ex.accessDeniedPage("/access-denied"))
				.rememberMe(remember -> remember.disable());

		return http.build();
	}
}
