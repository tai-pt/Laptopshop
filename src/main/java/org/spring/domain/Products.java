package org.spring.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "products")
public class Products {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long id;
	@Column(name = "name")
	private String name;
	@Column(name = "image")
	private String image;
	@Column(name = "price")
	private double price;
	@Column(name = "detailDesc")
	private String detailDesc;
	@Column(name = "shortDesc")
	private String shortDesc;
	@Column(name = "quantity")
	private long quantity;
	@Column(name = "sold")
	private long sold;
	@Column(name = "factory")
	private String factory;
	@Column(name = "target")
	private String target;

	public Products(long id, String name, String image, double price, String detailDesc, String shortDesc,
			long quantity, long sold, String factory, String target) {
		super();
		this.id = id;
		this.name = name;
		this.image = image;
		this.price = price;
		this.detailDesc = detailDesc;
		this.shortDesc = shortDesc;
		this.quantity = quantity;
		this.sold = sold;
		this.factory = factory;
		this.target = target;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getDetailDesc() {
		return detailDesc;
	}

	public void setDetailDesc(String detailDesc) {
		this.detailDesc = detailDesc;
	}

	public String getShortDesc() {
		return shortDesc;
	}

	public void setShortDesc(String shortDesc) {
		this.shortDesc = shortDesc;
	}

	public long getQuantity() {
		return quantity;
	}

	public void setQuantity(long quantity) {
		this.quantity = quantity;
	}

	public long getSold() {
		return sold;
	}

	public void setSold(long sold) {
		this.sold = sold;
	}

	public String getFactory() {
		return factory;
	}

	public void setFactory(String factory) {
		this.factory = factory;
	}

	public String getTarget() {
		return target;
	}

	public void setTarget(String target) {
		this.target = target;
	}

	public Products() {
		super();
	}

	@Override
	public String toString() {
		return "Products [id=" + id + ", name=" + name + ", image=" + image + ", price=" + price + ", detailDesc="
				+ detailDesc + ", shortDesc=" + shortDesc + ", quantity=" + quantity + ", sold=" + sold + ", factory="
				+ factory + ", target=" + target + "]";
	}

}
