package org.spring.repository;

import org.springframework.stereotype.Repository;

@Repository
public interface SecurityUserService {

	String validatePasswordResetToken(long id, String token);

}
