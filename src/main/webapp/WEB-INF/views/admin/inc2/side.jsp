<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style type="text/css">
	* {
		font-family: "Noto Sans KR", sans-serif;
	}
</style>
 <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <div class="sb-sidenav-menu-heading">바로 이동</div>
                            <a class="nav-link" href="admin.ad">
                                <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                                관리자 페이지
                            </a>
                            <a class="nav-link" href="./">
                                <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                                사용자 페이지
                            </a>
                            
                            <!-- 관리자 메뉴 -->
                            <div class="sb-sidenav-menu-heading">관리자 메뉴</div>
                            <!-- 상품 및 주문관리 -->
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts" aria-expanded="false" aria-controls="collapseLayouts">
                                <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                                상품 및 주문관리
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseLayouts" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link" href="ProductInsertForm.po">상품 등록</a>
                                    <a class="nav-link" href="ProductList.po">상품 관리</a>
                                    <a class="nav-link" href="AdminProductOrderList.ad">주문 관리</a>
                                </nav>
                            </div>
                            
                            <!-- 회원 및 쿠폰관리 -->
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#member_coupon" aria-expanded="false" aria-controls="#member_coupon">
                                <div class="sb-nav-link-icon"><i class="fas fa-book-open"></i></div>
                                회원 및 쿠폰관리
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="member_coupon" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
                                    <a class="nav-link collapsed" href="MemberList.me">
                                        회원 관리
                                    </a>
                                    
                                    <a class="nav-link collapsed" href="CouponList.po">
                                       쿠폰 목록
                                    </a>
                                </nav>
                            </div>
                            
                            
                             <!-- 게시판 관리 -->
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapse_board" aria-expanded="false" aria-controls="#collapse_board">
                                <div class="sb-nav-link-icon"><i class="fas fa-book-open"></i></div>
                                게시판 관리
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapse_board" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
                                    <a class="nav-link collapsed" href="BoardWriteForm.bo">
                                        글쓰기
                                    </a>
                                    <a class="nav-link collapsed" href="AdminBoard.ad" >
                                        공지사항 관리
                                    </a>
                                    <a class="nav-link collapsed" href="AdminFAQ.ad" >
                                        FAQ 관리
                                    </a>
                                    
                                </nav>
                            </div>
                            
                            
                        </div>
                    </div>
                    <div class="sb-sidenav-footer">
                        <div class="small">Logged in as:</div>
                        Start Bootstrap
                    </div>
                </nav>
              </div>