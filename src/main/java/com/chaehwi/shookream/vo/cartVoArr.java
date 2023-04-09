package com.chaehwi.shookream.vo;

import java.util.Arrays;

public class cartVoArr {
	
	private int[] member_idxArr; 
	private int[] product_idxArr; 
	private int[] cart_idxArr; 
	private int[] cart_priceArr;//hidden
	private int[] cart_discountArr; //hidden
	private int[] cart_order_priceArr; //hidden
	private int[] cart_countArr; //hidden
	private String[] cart_sizeArr; //select
	private String[] cart_colorArr; //select
	private String[] cart_product_nameArr; //hidden
	private String[] cart_product_imageArr; //hidden
	
	
	//-------setter, getter-------
	public int[] getMember_idxArr() {
		return member_idxArr;
	}


	public void setMember_idxArr(int[] member_idxArr) {
		this.member_idxArr = member_idxArr;
	}


	public int[] getProduct_idxArr() {
		return product_idxArr;
	}


	public void setProduct_idxArr(int[] product_idxArr) {
		this.product_idxArr = product_idxArr;
	}


	public int[] getCart_idxArr() {
		return cart_idxArr;
	}


	public void setCart_idxArr(int[] cart_idxArr) {
		this.cart_idxArr = cart_idxArr;
	}


	public int[] getCart_priceArr() {
		return cart_priceArr;
	}


	public void setCart_priceArr(int[] cart_priceArr) {
		this.cart_priceArr = cart_priceArr;
	}


	public int[] getCart_discountArr() {
		return cart_discountArr;
	}


	public void setCart_discountArr(int[] cart_discountArr) {
		this.cart_discountArr = cart_discountArr;
	}


	public int[] getCart_order_priceArr() {
		return cart_order_priceArr;
	}


	public void setCart_order_priceArr(int[] cart_order_priceArr) {
		this.cart_order_priceArr = cart_order_priceArr;
	}


	public int[] getCart_countArr() {
		return cart_countArr;
	}


	public void setCart_countArr(int[] cart_countArr) {
		this.cart_countArr = cart_countArr;
	}


	public String[] getCart_sizeArr() {
		return cart_sizeArr;
	}


	public void setCart_sizeArr(String[] cart_sizeArr) {
		this.cart_sizeArr = cart_sizeArr;
	}


	public String[] getCart_colorArr() {
		return cart_colorArr;
	}


	public void setCart_colorArr(String[] cart_colorArr) {
		this.cart_colorArr = cart_colorArr;
	}


	public String[] getCart_product_nameArr() {
		return cart_product_nameArr;
	}


	public void setCart_product_nameArr(String[] cart_product_nameArr) {
		this.cart_product_nameArr = cart_product_nameArr;
	}


	public String[] getCart_product_imageArr() {
		return cart_product_imageArr;
	}


	public void setCart_product_imageArr(String[] cart_product_imageArr) {
		this.cart_product_imageArr = cart_product_imageArr;
	}
	// -------toString--------------
	@Override
	public String toString() {
		return "cartVoArr [member_idxArr=" + Arrays.toString(member_idxArr) + ", product_idxArr="
				+ Arrays.toString(product_idxArr) + ", cart_idxArr=" + Arrays.toString(cart_idxArr) + ", cart_priceArr="
				+ Arrays.toString(cart_priceArr) + ", cart_discountArr=" + Arrays.toString(cart_discountArr)
				+ ", cart_order_priceArr=" + Arrays.toString(cart_order_priceArr) + ", cart_countArr="
				+ Arrays.toString(cart_countArr) + ", cart_sizeArr=" + Arrays.toString(cart_sizeArr)
				+ ", cart_colorArr=" + Arrays.toString(cart_colorArr) + ", cart_product_nameArr="
				+ Arrays.toString(cart_product_nameArr) + ", cart_product_imageArr="
				+ Arrays.toString(cart_product_imageArr) + "]";
	}
	
	
	
	
}
