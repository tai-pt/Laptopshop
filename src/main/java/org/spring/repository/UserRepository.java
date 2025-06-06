package org.spring.repository;

import org.spring.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
	public boolean existsByEmail(String email);

	public User findByEmail(String email);

	public User findByResetPasswordToken(String resetPasswordToken);

	public boolean existsByFullName(String fullName);

	public boolean existsByPassword(String password);
}