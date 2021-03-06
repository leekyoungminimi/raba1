<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8>
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
<title>Cart-List</title>
<%-- <sec:csrfMetaTags /> --%>
	<link rel="stylesheet" href="/resources/css/cart/cart_list.css">
	<link rel="stylesheet" href="/resources/css/cart/mediaqueries.css">
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script src="/resources/js/cart/cart_list.js"></script>
	<script>
		document.addEventListener("DOMContentLoaded", function(){
		// Handler when the DOM is fully loaded
		
			var img_uuid = document.getElementsByClassName("img_uuid");
			var img_fileName = document.getElementsByClassName("img_fileName");
			var img_uploadPath = document.getElementsByClassName("img_uploadPath");
			var img_fileType = document.getElementsByClassName("img_fileType");
			
			var goods_img = document.getElementsByClassName("cartimg");
			
			
			
			for(var i =0 ; i < goods_img.length; i++){
				
				var str = "";
				
				var uuid = img_uuid[i].value;
				var fileName = img_fileName[i].value;
				var uploadPath = img_uploadPath[i].value;
				var fileType = img_fileType[i].value;
				
				var fileCallPath = encodeURIComponent(uploadPath+"/s_"+uuid+"_"+fileName);
				
				/* console.log("fileCallPath" +fileCallPath); */
				
				str += "<div class='goods_img' data-path='"+uploadPath+"' data-uuid='"+uuid+"' data-filename='"+fileName+"' data-type='"+fileType+"' >";
				str += "<img src='/display?fileName="+fileCallPath+"' alt='"+fileName+"'>";
				str += "</div>";
				
				goods_img[i].innerHTML=str;
				
			}
		
			
			/* 숫자 ,  */
			
            Number.prototype.format = function(){
                if(this==0) return 0;

                var reg = /(^[+-]?\d+)(\d{3})/;
                var n = (this + '');

                while (reg.test(n)) n = n.replace(reg, '$1' + ',' + '$2');

                return n;
            };
            
            String.prototype.format = function(){
                var num = parseFloat(this);
                if( isNaN(num) ) return "0";

                return num.format();
            };
            
            jQuery('.format-money').text(function() {
                jQuery(this).text(
                    jQuery(this).text().format()
                );
            });
			
		}); 
</script>
</head>
<body>
	<div class="contents">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		
		<sec:authorize access="isAuthenticated()">
			<sec:authentication property='principal.username' var="userid" />
			<input type="hidden" id="userid" value="${userid}">
		</sec:authorize>
		
		<!--장바구니 상품 정보-->
		<div class="goodscartbtn1">
			<span>선택상품</span>
			<button type="button" onClick="delete_cno()">삭제</button>
			<button type="button" class="cartalldelete" onClick="delete_ALL()">장바구니 비우기</button>
		</div>
		<div class="cart">

			<!--장바구니 상품 정보 윗부분-->
			<div class="cartname">
				<div class="cartch1">
					<input type="checkbox" id="main_checkbox" onClick="checkAll(), plusPrice()" >
				</div>
				<div class="cartimg2">
					<span>이미지</span>
				</div>
				<div class="cartgoods">
					<span>상품정보</span>
				</div>
				<div class="cartpri">
					<span>판매가</span>
				</div>
				<div class="cartamount">
					<span>수량</span>
				</div>
				<!-- <div class="cartdelivery">
					<span>배송비</span>
				</div> -->
				<div class="cartpritotal">
					<span>합계</span>
				</div>
			</div>

			<!--장바구니 상품 정보 아랫부분-->
			<c:forEach var="listcno" items="${cnolist}">
				<input type="hidden" value="${listcno.cno }" class="cnolist">
			</c:forEach>
			<c:forEach var="Cartlist" items="${list }">
			<!-- cno값을 따로 가져왓는데 한꺼번에 가져오는 방식을 찾아서 수정할 예정  -->
			<div class="cartlist">
				<div class="cartch2">
					<input type="checkbox" class="list_checkbox" onclick="plusPrice()" >
				</div>
				<div class="cartimg">
					
					
				</div>
				<div class="cartgoods">
					<span><c:out value="${Cartlist.p_name }"/></span>
				</div>
				<div class="cartpri">
					<span><span class="format-money">${Cartlist.p_price }</span>원</span>
				</div>
				
				<div class="cartamount">
					<span><c:out value="${Cartlist.p_amount }"/>개</span>
				</div>
				
				<div class="cartpritotal">
					<span><span class="format-money">${Cartlist.p_price * Cartlist.p_amount }</span>원</span>
					<input type="hidden" value="<c:out value="${Cartlist.p_price * Cartlist.p_amount }"/>" class="price">
				</div>
			</div>
			
			</c:forEach>
			

		<!--장바구니 상품 삭제 장바구니 비우기 버튼 -->
		<div class="goodscartbtn2">
			<span>선택상품</span>
			<button type="button" onClick="delete_cno()">삭제</button>
			<button type="button" class="cartalldelete" onClick="delete_ALL()">장바구니 비우기</button>
		</div>

		<!--결제 금액 안내-->
		
		
		<div class="goodstotalprice">
			
			<!--결제 금액 안내 윗부분-->
			<div class="goodscartname1">
				<div class="goodstotalprice_1">
					<span>총 상품금액</span>
				</div>
				<div class="goodstotalprice_1">
					<span>배송비</span>
				</div>
				<div class="goodstotalprice_2">
					<span>결제예정금액</span>
				</div>
			</div>

			<!--결제 금액 안내 아랫부분-->
			
			
			<div class="goodscartname2">
				<div class="goodstotalprice2_1">
					<span id="price_text"></span>
				</div>
				<div class="goodstotalprice2_1">
					<span id="delivery_price_text"></span>
				</div>
				<div class="goodstotalprice2_2">
					<span id="total_price_text">원</span>
				</div>
			</div>
		</div>
		<span id="delivery_notice">※ 50,000원 이상 구매시 택배비 무료</span>
		
		<!-- 숨겨놓은 이미지 값  -->
		 <c:forEach var="Imagelist" items="${img_list }">
				<input type="hidden" class="img_uuid" value="${Imagelist.uuid }">
				<input type="hidden" class="img_uploadPath" value="${Imagelist.uploadPath }">
				<input type="hidden" class="img_fileName" value="${Imagelist.fileName }">
				<input type="hidden" class="img_fileType" value="${Imagelist.fileType }">
		</c:forEach>
		
		<!--상품 결제페이지 이동 버튼-->
		<div class="chartpay" >
			<form action="/pay" method="post" id="paysubmit">
				
				<div id="orderdata"></div>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<input type="hidden" name="totalprice" id="total_price">
				<input type="hidden" name="usercode" value="${userid }">
				<input type="button" value="상품 주문 " class="cartpaybtn" onclick="check_submit()">
				
			</form>
			
		</div>
	</div>
</body>
</html>