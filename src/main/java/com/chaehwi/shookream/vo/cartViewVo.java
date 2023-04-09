package com.chaehwi.shookream.vo;

import java.sql.Date;

public class cartViewVo {
	
	private int cart_idx; 
	private int member_idx; 
	private int product_idx;
	private Date cart_date;
	private int cart_price;
	private int cart_discount;
	private int cart_order_price;
	private int product_price;
	private int product_release_price;
	private int cart_count; 
	private String cart_size; 
	private String cart_color;
	private String cart_product_name; 
	private String cart_product_image;
	
	public int getCart_idx() {
		return cart_idx;
	}
	public void setCart_idx(int cart_idx) {
		this.cart_idx = cart_idx;
	}
	public int getMember_idx() {
		return member_idx;
	}
	public void setMember_idx(int member_idx) {
		this.member_idx = member_idx;
	}
	public int getProduct_idx() {
		return product_idx;
	}
	public void setProduct_idx(int product_idx) {
		this.product_idx = product_idx;
	}
	public Date getCart_date() {
		return cart_date;
	}
	public void setCart_date(Date cart_date) {
		this.cart_date = cart_date;
	}
	public int getCart_price() {
		return cart_price;
	}
	public void setCart_price(int cart_price) {
		this.cart_price = cart_price;
	}
	public int getCart_discount() {
		return cart_discount;
	}
	public void setCart_discount(int cart_discount) {
		this.cart_discount = cart_discount;
	}
	public int getCart_order_price() {
		return cart_order_price;
	}
	public void setCart_order_price(int cart_order_price) {
		this.cart_order_price = cart_order_price;
	}
	public int getProduct_price() {
		return product_price;
	}
	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}
	public int getProduct_release_price() {
		return product_release_price;
	}
	public void setProduct_release_price(int product_release_price) {
		this.product_release_price = product_release_price;
	}
	public int getCart_count() {
		return cart_count;
	}
	public void setCart_count(int cart_count) {
		this.cart_count = cart_count;
	}
	public String getCart_size() {
		return cart_size;
	}
	public void setCart_size(String cart_size) {
		this.cart_size = cart_size;
	}
	public String getCart_color() {
		return cart_color;
	}
	public void setCart_color(String cart_color) {
		this.cart_color = cart_color;
	}
	public String getCart_product_name() {
		return cart_product_name;
	}
	public void setCart_product_name(String cart_product_name) {
		this.cart_product_name = cart_product_name;
	}
	public String getCart_product_image() {
		return cart_product_image;
	}
	public void setCart_product_image(String cart_product_image) {
		this.cart_product_image = cart_product_image;
	}
	
	@Override
	public String toString() {
		return "cartViewVo [cart_idx=" + cart_idx + ", member_idx=" + member_idx + ", product_idx=" + product_idx
				+ ", cart_date=" + cart_date + ", cart_price=" + cart_price + ", cart_discount=" + cart_discount
				+ ", cart_order_price=" + cart_order_price + ", product_price=" + product_price
				+ ", product_release_price=" + product_release_price + ", cart_count=" + cart_count + ", cart_size="
				+ cart_size + ", cart_color=" + cart_color + ", cart_product_name=" + cart_product_name
				+ ", cart_product_image=" + cart_product_image + "]";
	}
	
	
	

}
