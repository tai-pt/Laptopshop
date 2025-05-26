package org.spring.laptopshop;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@ComponentScan(basePackages = "org.spring.controller.admin")
@ComponentScan(basePackages = "org.spring.controller.client")
@ComponentScan(basePackages = "org.spring.config")
@ComponentScan(basePackages = "org.spring.service")
@ComponentScan(basePackages = "org.spring.validation")
@ComponentScan(basePackages = "org.spring.domain.dto")
@EntityScan(basePackages = "org.spring.domain")
@EnableJpaRepositories(basePackages = "org.spring.repository")
public class LaptopshopApplication {

	public static void main(String[] args) {
		SpringApplication.run(LaptopshopApplication.class, args);
	}

}
