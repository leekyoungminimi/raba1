<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="/resources/css/pay/pay.css">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
     <script type="text/javascript">
     $(document).ready(function() {
         
         //검색하고 나서 결과를 보여줄때 검색 조건을 그대로 노출
         //if("${serviceType}" == "sports"){ //serviceType 이 sport 일 경우 셋팅
             if("card" == "card"){
         
             //라디오 버튼 값으로 선택
             $('input:radio[name="payselect"][value="card"]').prop('checked', true);
             //셀렉트 박스 값으로 선택
             //공연/전시 카테고리 hide
             $( "#moneyc" ).hide();
             //스포츠 카테고리 show
             $( "#cardc" ).show();
             //스포츠 일때 담당MD 비활성화
             /*$( "#mdName" ).prop( "disabled", true );*/
                      $( "#check_module" ).show();
                     $( "#paystart2" ).hide();
                     $( "#cardp" ).show();
                     $( "#moneyp" ).hide();
             //담당MD 입력값 초기화;
             /*$( "#mdName" ).val("");*/
         }
         //라디오 버튼 변경시 이벤트
         $("input[name='payselect']:radio").change(function () {
                 //라디오 버튼 값을 가져온다.
                 var payselect = this.value;
                                 
                 if(payselect == "card"){//스포츠인 경우
                     //스포츠 일때 공연/전시 카테고리 hide
                     $( "#moneyc" ).hide();
                     //스포츠 일때 스포츠 카테고리 show
                     $( "#cardc" ).show();
                     //스포츠 일때 담당MD 비활성화
                     $( "#check_module" ).show();
                     $( "#paystart2" ).hide();
                     $( "#cardp" ).show();
                     $( "#moneyp" ).hide();
                 }else if(payselect == "money"){//공연/전시인 경우
                     //공연/전시 일때 공연/전시 카테고리 show
                     $( "#moneyc" ).show();
                     //공연/전시 일때 스포츠 카테고리 show
                     $( "#cardc" ).hide();
                     //공연/전시 일때 담당 MD 활성화
                     $( "#check_module" ).hide();
                      $( "#paystart2" ).show();
                     $( "#cardp" ).hide();
                     $( "#moneyp" ).show();
                 }
                                 
             });
     });
     </script>
</head>
<body>
    <div class="contents">
        <!-- 여기 작성!!!! class =contents 는 수정하지마시고 이 안에서부터 div새로 만들어서 작업 ㄱㄱ -->
		  <div class="paycart">
            <div class="paycartname">
                <div class="paycartimg"><span>이미지</span></div>
                <div class="paygoods"><span>상품정보</span></div>
                <div class="paypri"><span>판매가</span></div>
                <div class="payamount"><span>수량</span></div>
                <div class="paydelivery"><span>배송비</span></div>
                <div class="paypritotal"><span>합계</span></div>
            </div>
            <div class="paycartlist">
                <div class="paycartimg"><span>이미지</span></div>
                <div class="paygoods"><span>상품정보</span></div>
                <div class="paypri"><span>150,000</span></div>
                <div class="payamount"><span>1</span></div>
                <div class="paydelivery"><span>2,500</span></div>
                <div class="paypritotal"><span>152,500 원</span></div>
            </div>
            <div class="paysal">
                <div class="salprice">
                    <span>상품구매금액 150,000 + 배송비 2,500 = 합계 : 152,500원</span>
                </div>
            </div>
        </div>
        <div class="orderArea">
                   <h2>배송 정보</h2>
        <br>
            <div class="order"><div class="orderArea1"><span>배송지 선택</span></div> <div class="orderArea1_1"> <input type="radio" checked> <label>회원 정보와 동일</label></div></div>
<div class="order3"> <div class="orderArea1"><span>받으시는분</span></div> <div class="orderArea1_1"><input type="text"></div> </div>
            <div class="order4"><div class="orderArea4"><span>주소</span></div> <div class="orderArea4_1"><p><input type="text" name="addr1" id="addr1"  size="5"> <button type="button" onclick="execPostCode();" class="postalcode">우편번호</button></p><p><input type="text" name="addr2" id="addr2"  size="100"></p><p><input type="text" name="addr3"  id="addr3" size="100"></p></div></div>
            <div class="order3"> <div class="orderArea1"><span>휴대전화</span></div> <div class="orderArea1_1"><input type="text" size="12"></div></div>
             <div class="order3"><div class="orderArea1"><span>이메일</span> </div> <div class="orderArea1_1"><input type="text"  size="30"></div></div>
            <div class="order2"><div class="orderArea6">배송메세지</div><div class="orderArea6_1"><textarea class="odertext"></textarea> </div></div>
        </div>

       <!--결제 수단-->
        <div class="orderArea">
         <h2>결제 수단</h2>
        <br>
            <div class="pay">
                <div class="paybtn"><span id="cardp">카드 결제 최종금액</span> <span id="moneyp">무통장 입금 최종금액</span><br><span class="price">150,000원</span><br><br><br><a class="paystart" id="check_module">결제하기(카드)</a><a href="" class="paystart" id="paystart2">결제하기(무통)</a></div>
                <div class="pay1"><input type="radio" value="card" id="payselect" name="payselect" checked> <label>카드결제 </label><input type="radio" value="money" id="payselect" name="payselect"> <label>무통장 입금</label></div>
                                <div class="pay2"><span id="cardc">소액 결제의 경우 PG사 정책에 따라 결제 금액 제한이 있을 수 있습니다.</span>
                                <span id="moneyc">입금계좌 국민은행 05100204153630 예금주 이태관</span></div>
            </div>
        </div>
        
        <!--무이자 할부 이용안내-->
        <div class="paycomment">
            <p class="comment1"> 할부 이용안내</p>
            <br>
            <p class="comment2">무이자할부가 적용되지 않은 상품과 무이자할부가 가능한 상품을 동시에 구매할 경우 전체 주문 상품 금액에 대해 무이자할부가 적용되지 않습니다.</p>
            <p class="comment2">무이자할부를 원하시는 경우 장바구니에서 무이자할부 상품만 선택하여 주문하여 주시기 바랍니다.</p>
        </div>
        
        <!--이용안내-->
        <div class="paycomment2">
            <p class="comment1">아래의 쇼핑몰일 경우에는 모든 브라우저 사용이 가능합니다.</p>
            <br>
            <p class="comment2">KG이니시스, KCP, LG U+를 사용하는 쇼핑몰일 경우</p>
            <p class="comment2">결제가능브라우저 : 크롬,파이어폭스,사파리,오페라 브라우저에서 결제 가능</p>
            <p class="comment2">(단, window os 사용자에 한하며 리눅스/mac os 사용자는 사용불가)</p>
            <p class="comment2">최초 결제 시도시에는 플러그인을 추가 설치 후 반드시 브라우저 종료 후 재시작해야만 결제가 가능합니다.</p>
            <p class="comment2">(무통장 포함)</p>
            <br>
            <p class="comment1">세금계산서 발행 안내</p>
            <br>
            <p class="comment2">부가가치세법 제 54조에 의거하여 세금계산서는 배송완료일로부터 다음달 10일까지만 요청하실 수 있습니다.</p>
             <p class="comment2">세금계산서는 사업자만 신청하실 수 있습니다.</p>
              <p class="comment2">배송이 완료된 주문에 한하여 세금계산서 발행신청이 가능합니다.</p>
               <p class="comment2">[세금계산서 신청]버튼을 눌러 세금계산서 신청양식을 작성한 후 팩스로 사업자등록증사본을 보내셔야 세금계산서 발생이 가능합니다.</p>
                <p class="comment2">[세금계산서 인쇄]버튼을 누르면 발행된 세금계산서를 인쇄하실 수 있습니다.</p>
            <br>
            <p class="comment1">부가가치세법 변경에 따른 신용카드매출전표 및 세금계산서 변경안내</p>
            <br>
            <p class="comment2">변경된 부가가치세법에 의거, 2004.7.1 이후 신용카드로 결제하신 주문에 대해서는 세금계산서 발행이 불가하며</p>
            <p class="comment2">신용카드매출전표로 부가가치세 신고를 하셔야 합니다.(부가가치세법 시행령 57조)</p>
            <p class="comment2">상기 부가가치세법 변경내용에 따라 신용카드 이외의 결제건에 대해서만 세금계산서 발행이 가능함을 양지하여 주시기 바랍니다.</p>
            <br>
            <p class="comment1">현금영수증 이용안내</p>
            <br>
            <p class="comment2">현금영수증은 1원 이상의 현금성거래(무통장입금, 실시간계좌이체, 에스크로, 예치금)에 대해 발행이 됩니다.</p>
            <p class="comment2">현금영수증 발행 금액에는 배송비는 포함되고, 적립금사용액은 포함되지 않습니다.</p>
            <p class="comment2">발행신청 기간제한 현금영수증은 입금확인일로 부터 48시간안에 발행을 해야 합니다.</p>
            <p class="comment2">현금영수증 발행 취소의 경우는 시간 제한이 없습니다. (국세청의 정책에 따라 변경 될 수 있습니다.)</p>
            <p class="comment2">현금영수증이나 세금계산서 중 하나만 발행 가능 합니다.</p>
        </div>
    </div>
        <script>
$("#check_module").click(function () {
var IMP = window.IMP; // 생략가능
IMP.init('imp05668421');
// 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
// i'mport 관리자 페이지 -> 내정보 -> 가맹점식별코드
IMP.request_pay({
pg: 'inicis', // version 1.1.0부터 지원.
/*
'kakao':카카오페이,
html5_inicis':이니시스(웹표준결제)
'nice':나이스페이
'jtnet':제이티넷
'uplus':LG유플러스
'danal':다날
'payco':페이코
'syrup':시럽페이
'paypal':페이팔
*/
pay_method: 'card',
/*
'samsung':삼성페이,
'card':신용카드,
'trans':실시간계좌이체,
'vbank':가상계좌,
'phone':휴대폰소액결제
*/
merchant_uid: 'merchant_' + new Date().getTime(),
/*
merchant_uid에 경우
https://docs.iamport.kr/implementation/payment
위에 url에 따라가시면 넣을 수 있는 방법이 있습니다.
참고하세요.
나중에 포스팅 해볼게요.
*/
name: '주문명:결제테스트',
//결제창에서 보여질 이름
amount: 1000,
//가격
buyer_email: 'iamport@siot.do',
buyer_name: '구매자이름',
buyer_tel: '010-1234-5678',
buyer_addr: '서울특별시 강남구 삼성동',
buyer_postcode: '123-456',
m_redirect_url: 'https://www.yourdomain.com/payments/complete'
/*
모바일 결제시,
결제가 끝나고 랜딩되는 URL을 지정
(카카오페이, 페이코, 다날의 경우는 필요없음. PC와 마찬가지로 callback함수로 결과가 떨어짐)
*/
}, function (rsp) {
console.log(rsp);
if (rsp.success) {
var msg = '결제가 완료되었습니다.';
msg += '고유ID : ' + rsp.imp_uid;
msg += '상점 거래ID : ' + rsp.merchant_uid;
msg += '결제 금액 : ' + rsp.paid_amount;
msg += '카드 승인번호 : ' + rsp.apply_num;
} else {
var msg = '결제에 실패하였습니다.';
msg += '에러내용 : ' + rsp.error_msg;
}
alert(msg);
});
});
function execPostCode() {
    new daum.Postcode({
        oncomplete: function(data) {
           // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

           // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
           // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
           var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
           var extraRoadAddr = ''; // 도로명 조합형 주소 변수

           // 법정동명이 있을 경우 추가한다. (법정리는 제외)
           // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
           if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
               extraRoadAddr += data.bname;
           }
           // 건물명이 있고, 공동주택일 경우 추가한다.
           if(data.buildingName !== '' && data.apartment === 'Y'){
              extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
           }
           // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
           if(extraRoadAddr !== ''){
               extraRoadAddr = ' (' + extraRoadAddr + ')';
           }
           // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
           if(fullRoadAddr !== ''){
               fullRoadAddr += extraRoadAddr;
           }

           // 우편번호와 주소 정보를 해당 필드에 넣는다.
           console.log(data.zonecode);
           console.log(fullRoadAddr);
           
           
           $("[name=addr1]").val(data.zonecode);
           $("[name=addr2]").val(fullRoadAddr);
           
           /* document.getElementById('signUpUserPostNo').value = data.zonecode; //5자리 새우편번호 사용
           document.getElementById('signUpUserCompanyAddress').value = fullRoadAddr;
           document.getElementById('signUpUserCompanyAddressDetail').value = data.jibunAddress; */
       }
    }).open();
}
</script>
</body>
</html>