package com.chaehwi.shookream.vo;

import java.sql.Date;
import java.sql.Timestamp;

public class OrderVo {
private int order_idx;
private Timestamp order_date;
private String order_category;
private String order_progress;
private int member_idx;
private int order_product_idx;
private String order_main_image;
private String order_member_id;
private int order_product_price;
private int order_product_sell_count;
private int order_product_amount;
private String order_product_size;
private String order_product_color;
private int order_coupon_idx;
private int order_isUse;
private String order_product_name;
private int order_count;
private String  order_size;
private String order_color;
private int order_member_idx;
// join 을 위한 변수
private String product_name;
private String product_size; // 상품 사이즈
private String image_main_file; // 메인 사진
private String product_color; // 상품 색상 카테고리
private int order_price;
private int product_idx;
private String member_id;
private int product_price;
private int product_discount_price;



public int getOrder_member_idx() {
	return order_member_idx;
}

public void setOrder_member_idx(int order_member_idx) {
	this.order_member_idx = order_member_idx;
}

public int getOrder_idx() {
	return order_idx;
}

public void setOrder_idx(int order_idx) {
	this.order_idx = order_idx;
}

public Timestamp getOrder_date() {
	return order_date;
}

public void setOrder_date(Timestamp order_date) {
	this.order_date = order_date;
}

public String getOrder_category() {
	return order_category;
}

public void setOrder_category(String order_category) {
	this.order_category = order_category;
}

public String getOrder_progress() {
	return order_progress;
}

public void setOrder_progress(String order_progress) {
	this.order_progress = order_progress;
}

public int getMember_idx() {
	return member_idx;
}

public void setMember_idx(int member_idx) {
	this.member_idx = member_idx;
}

public int getOrder_product_idx() {
	return order_product_idx;
}

public void setOrder_product_idx(int order_product_idx) {
	this.order_product_idx = order_product_idx;
}

public String getOrder_main_image() {
	return order_main_image;
}

public void setOrder_main_image(String order_main_image) {
	this.order_main_image = order_main_image;
}

public String getOrder_member_id() {
	return order_member_id;
}

public void setOrder_member_id(String order_member_id) {
	this.order_member_id = order_member_id;
}

public int getOrder_product_price() {
	return order_product_price;
}

public void setOrder_product_price(int order_product_price) {
	this.order_product_price = order_product_price;
}

public int getOrder_product_sell_count() {
	return order_product_sell_count;
}

public void setOrder_product_sell_count(int order_product_sell_count) {
	this.order_product_sell_count = order_product_sell_count;
}

public int getOrder_product_amount() {
	return order_product_amount;
}

public void setOrder_product_amount(int order_product_amount) {
	this.order_product_amount = order_product_amount;
}

public String getOrder_product_size() {
	return order_product_size;
}

public void setOrder_product_size(String order_product_size) {
	this.order_product_size = order_product_size;
}

public String getOrder_product_color() {
	return order_product_color;
}

public void setOrder_product_color(String order_product_color) {
	this.order_product_color = order_product_color;
}

public int getOrder_coupon_idx() {
	return order_coupon_idx;
}

public void setOrder_coupon_idx(int order_coupon_idx) {
	this.order_coupon_idx = order_coupon_idx;
}

public int getOrder_isUse() {
	return order_isUse;
}

public void setOrder_isUse(int order_isUse) {
	this.order_isUse = order_isUse;
}

public String getOrder_product_name() {
	return order_product_name;
}

public void setOrder_product_name(String order_product_name) {
	this.order_product_name = order_product_name;
}

public int getOrder_count() {
	return order_count;
}

public void setOrder_count(int order_count) {
	this.order_count = order_count;
}

public String getOrder_size() {
	return order_size;
}

public void setOrder_size(String order_size) {
	this.order_size = order_size;
}

public String getOrder_color() {
	return order_color;
}

public void setOrder_color(String order_color) {
	this.order_color = order_color;
}

public String getProduct_name() {
	return product_name;
}

public void setProduct_name(String product_name) {
	this.product_name = product_name;
}

public String getProduct_size() {
	return product_size;
}

public void setProduct_size(String product_size) {
	this.product_size = product_size;
}

public String getImage_main_file() {
	return image_main_file;
}

public void setImage_main_file(String image_main_file) {
	this.image_main_file = image_main_file;
}

public String getProduct_color() {
	return product_color;
}

public void setProduct_color(String product_color) {
	this.product_color = product_color;
}

public int getOrder_price() {
	return order_price;
}

public void setOrder_price(int order_price) {
	this.order_price = order_price;
}

public int getProduct_idx() {
	return product_idx;
}

public void setProduct_idx(int product_idx) {
	this.product_idx = product_idx;
}

public String getMember_id() {
	return member_id;
}

public void setMember_id(String member_id) {
	this.member_id = member_id;
}

public int getProduct_price() {
	return product_price;
}

public void setProduct_price(int product_price) {
	this.product_price = product_price;
}

public int getProduct_discount_price() {
	return product_discount_price;
}

public void setProduct_discount_price(int product_discount_price) {
	this.product_discount_price = product_discount_price;
}

@Override
public String toString() {
	return "OrderVo [order_idx=" + order_idx + ", order_date=" + order_date + ", order_category=" + order_category
			+ ", order_progress=" + order_progress + ", member_idx=" + member_idx + ", order_product_idx="
			+ order_product_idx + ", order_main_image=" + order_main_image + ", order_member_id=" + order_member_id
			+ ", order_product_price=" + order_product_price + ", order_product_sell_count=" + order_product_sell_count
			+ ", order_product_amount=" + order_product_amount + ", order_product_size=" + order_product_size
			+ ", order_product_color=" + order_product_color + ", order_coupon_idx=" + order_coupon_idx
			+ ", order_isUse=" + order_isUse + ", order_product_name=" + order_product_name + ", order_count="
			+ order_count + ", order_size=" + order_size + ", order_color=" + order_color + ", order_member_idx="
			+ order_member_idx + ", product_name=" + product_name + ", product_size=" + product_size
			+ ", image_main_file=" + image_main_file + ", product_color=" + product_color + ", order_price="
			+ order_price + ", product_idx=" + product_idx + ", member_id=" + member_id + ", product_price="
			+ product_price + ", product_discount_price=" + product_discount_price + "]";
}


}
