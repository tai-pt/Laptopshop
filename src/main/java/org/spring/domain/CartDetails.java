package org.spring.domain;

import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "CartDetails")
public class CartDetails {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long id;

	private long quantity;

	private double price;

	// cart_id: long
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "cart_id")
	private Cart cart;

	// product_id: long
	@ManyToOne
	@JoinColumn(name = "product_id")
	private Products product;

	public CartDetails(long id, long quantity, double price, Cart cart, Products product) {
		super();
		this.id = id;
		this.quantity = quantity;
		this.price = price;
		this.cart = cart;
		this.product = product;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getQuantity() {
		return quantity;
	}

	public void setQuantity(long quantity) {
		this.quantity = quantity;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public Cart getCart() {
		return cart;
	}

	public void setCart(Cart cart) {
		this.cart = cart;
	}

	public Products getProduct() {
		return product;
	}

	public void setProduct(Products product) {
		this.product = product;
	}

	public CartDetails() {
		super();
	}

}
