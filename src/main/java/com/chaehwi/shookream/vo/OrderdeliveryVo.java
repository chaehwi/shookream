package com.chaehwi.shookream.vo;

public class OrderdeliveryVo {
private String order_name;
private String order_phone;
private String order_addr1;
private String order_addr2;
private String order_content;


public String getOrder_content() {
	return order_content;
}
public void setOrder_content(String order_content) {
	this.order_content = order_content;
}
public String getOrder_name() {
	return order_name;
}
public void setOrder_name(String order_name) {
	this.order_name = order_name;
}
public String getOrder_phone() {
	return order_phone;
}
public void setOrder_phone(String order_phone) {
	this.order_phone = order_phone;
}
public String getOrder_addr1() {
	return order_addr1;
}
public void setOrder_addr1(String order_addr1) {
	this.order_addr1 = order_addr1;
}
public String getOrder_addr2() {
	return order_addr2;
}
public void setOrder_addr2(String order_addr2) {
	this.order_addr2 = order_addr2;
}
@Override
public String toString() {
	return "OrderdeliveryVo [order_name=" + order_name + ", order_phone=" + order_phone + ", order_addr1=" + order_addr1
			+ ", order_addr2=" + order_addr2 + ", order_content=" + order_content + "]";
}
}
