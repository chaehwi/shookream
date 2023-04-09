package com.chaehwi.shookream.vo;

import java.sql.Date;

public class CouponVo {
	private int coupon_idx;
	private String coupon_name;
	private String coupon_content;
	private String coupon_start;
	private String coupon_end;
	private Date coupon_date;
	private int coupon_isUse;
	
	private String coupon_benefit;
	private Integer coupon_benefit_price;
	private String coupon_benefit_unit;
	private int coupon_min_price;
	private Integer coupon_max_discount;
	private Integer coupon_amount;
	
	
	
	
	
	
	public String getCoupon_benefit() {
		return coupon_benefit;
	}
	public void setCoupon_benefit(String coupon_benefit) {
		this.coupon_benefit = coupon_benefit;
	}
	public Integer getCoupon_benefit_price() {
		return coupon_benefit_price;
	}
	public void setCoupon_benefit_price(Integer coupon_benefit_price) {
		this.coupon_benefit_price = coupon_benefit_price;
	}
	public String getCoupon_benefit_unit() {
		return coupon_benefit_unit;
	}
	public void setCoupon_benefit_unit(String coupon_benefit_unit) {
		this.coupon_benefit_unit = coupon_benefit_unit;
	}
	public int getCoupon_min_price() {
		return coupon_min_price;
	}
	public void setCoupon_min_price(int coupon_min_price) {
		this.coupon_min_price = coupon_min_price;
	}
	public Integer getCoupon_max_discount() {
		return coupon_max_discount;
	}
	public void setCoupon_max_discount(Integer coupon_max_discount) {
		this.coupon_max_discount = coupon_max_discount;
	}
	public Integer getCoupon_amount() {
		return coupon_amount;
	}
	public void setCoupon_amount(Integer coupon_amount) {
		this.coupon_amount = coupon_amount;
	}
	public int getCoupon_isUse() {
		return coupon_isUse;
	}
	public void setCoupon_isUse(int coupon_isUse) {
		this.coupon_isUse = coupon_isUse;
	}
	public int getCoupon_idx() {
		return coupon_idx;
	}
	public void setCoupon_idx(int coupon_idx) {
		this.coupon_idx = coupon_idx;
	}
	public String getCoupon_name() {
		return coupon_name;
	}
	public void setCoupon_name(String coupon_name) {
		this.coupon_name = coupon_name;
	}
	public String getCoupon_content() {
		return coupon_content;
	}
	public void setCoupon_content(String coupon_content) {
		this.coupon_content = coupon_content;
	}
	public String getCoupon_start() {
		return coupon_start;
	}
	public void setCoupon_start(String coupon_start) {
		this.coupon_start = coupon_start;
	}
	public String getCoupon_end() {
		return coupon_end;
	}
	public void setCoupon_end(String coupon_end) {
		this.coupon_end = coupon_end;
	}
	public Date getCoupon_date() {
		return coupon_date;
	}
	public void setCoupon_date(Date coupon_date) {
		this.coupon_date = coupon_date;
	}
	
	
	@Override
	public String toString() {
		return "CouponVo [coupon_idx=" + coupon_idx + ", coupon_name=" + coupon_name + ", coupon_content="
				+ coupon_content + ", coupon_start=" + coupon_start + ", coupon_end=" + coupon_end + ", coupon_date="
				+ coupon_date + ", coupon_isUse=" + coupon_isUse + ", coupon_benefit=" + coupon_benefit
				+ ", coupon_benefit_price=" + coupon_benefit_price + ", coupon_benefit_unit=" + coupon_benefit_unit
				+ ", coupon_min_price=" + coupon_min_price + ", coupon_max_discount=" + coupon_max_discount
				+ ", coupon_amount=" + coupon_amount + "]";
	}
	
	
	
}
