<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 카카오 지도 api -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=530dd95ca9b426f51d6a8307877fcb3f&libraries=services"></script>
<!-- 다음 도로명주소 api -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<!-- popper CDN -->
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
	integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
	crossorigin="anonymous"></script>
	
<!-- 부트스트랩 자바스크립트 -->
<script src="/resource/js/bootstrap.min.js"></script>
<link rel="icon" href="resource/img/favi.png" type="image/x-icon">

<!-- 부트스트랩 CSS/favicon -->
<link rel="stylesheet" href="/resource/css/bootstrap.min.css">
<link rel="stylesheet" href="/resource/css/modal.css">
<link rel="stylesheet" href="/resource/css/common.css">
</head>
<style>
.listTable {
    overflow: auto;
    width: 800px;
    height: 150px; /* 디자인에 맞게 더 큰 값을 설정하세요 */
}

table, th, td{
border: 1px solid gray;
text
}
.productList{
position: absolute;
    left: 800px;
    top: 170px;
    width: 500px;
}
.ticketList{
position: absolute;
    left: 800px;
    top: 400px;
}
.branchName{
}
#modalSearch{
	width: 300px;
}

</style>
<body>
<jsp:include page="../side.jsp"></jsp:include>
<div class="commonContainer">	
	<div class="commonTitle"><h2>스토어관리</h2></div>
	<div class="commonContent">
<div class="branchLocation">지점 위치
<button id="modalBtn" class="btn btn-primary" class="btn" data-toggle="modal" data-target="#firstBranchModal" >등록</button>
</div>
<div id="map" style="width:500px;height:400px;"></div>
<!-- <button type="button" class="button" id="branchRegisterConfirm">등록</button> -->
<!-- <button id="modalBtn" class="btn btn-primary" class="btn" data-toggle="modal" data-target="#modal">등록</button> -->

<!-- 지점등록 모달 -->	
<!-- 버튼 클릭 시 열리는 모달창 -->
    <div class="modal fade" id="firstBranchModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <!-- 모달창 제목 -->
            <h5 class="modal-title">지점등록</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <form action=""> <!-- 입력폼 -->
              <div class="form-group">
                <label>지점명</label>
                <input type="text" id="branchName" class="form-control" required>
              </div>
              <div class="form-group">
                <label>도로명주소</label>
                	 <input type="button" onclick="roadAddr()" value="찾기"><br/>
                 <input type="text" id="branchLocation" class="form-control" readonly required  ></input>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                <button type="submit" class="btn btn-primary" onclick="branchRegisterConfirm()">등록</button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
    
<div class="productList">
	<p>상품 리스트</p>
	<input type="text" class="searchProduct" placeholder="검색어 입력">
	<button id="search" class="btn btn-primary">검색</button>
	<button id="modalProductRegister" class="btn btn-primary" class="btn" data-toggle="modal" data-target="#firstProductModal" style="display: none;">등록</button>
	<button id="productInfoRegister" class="btn btn-primary" class="button" onclick="location.href='productInfoRegister.go'" style="display: inline;">본사상품 등록</button>
	<div class="listTable">
	<table>
	</table>
	</div>
	<!-- <button type="button" class="button" onclick="location.href='storeProductRegister.do'">등록</button> -->
</div>


<!-- 첫번째 모달창 -->
<div class="modal fade" id="firstProductModal" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">상품등록</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="modal-body">
            <form action="" method="get">
              <div class="form-group">
                <label>지점명</label> 
                <input type="text" name="currentBranchName" readonly class="form-control" id="currentBranchName">
              </div>
              <div class="form-group">
                <label>카테고리</label>
                <input type="text" readonly class="form-control" id="currentProductCategory">
              </div>
              <div class="form-group">
                <label>상품명</label>
                <!-- <button id="firstProductModalBtn" class="btn btn-primary" class="btn" data-toggle="modal" data-target="#secondProductModal">검색</button> -->
                 <!-- 두번째 모달 창 열기 버튼 -->
        		 <button type="button" id="firstProductSearchModal" class="btn btn-primary" data-toggle="modal" data-target="#secondProductModal">검색</button>
                	 <input type="text" name="currentProductName" readonly required class="form-control" id="currentProductName">
                	 
              </div>
              <div class="form-group">
                <label>가격</label>
                 <input type="text"  class="form-control" class="price" id="currentProductPrice" readonly></input>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                <button type="submit" class="btn btn-primary" id="branchProductRegister">등록</button>
              </div>
            </form>
          </div>
      </div>
      <!-- <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div> -->
    </div>
  </div>
</div>

<!-- 두번째 모달 창 -->
<div class="modal fade" id="secondProductModal" tabindex="-1" role="dialog" style="margin-left: 400px;">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">상품검색</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div>
	        <input type="text" id="secondProductModalSearch" class="form-control">
	        <button class="secondProductModalSearch" class="btn btn-primary">검색</button>
	        </div>
	        <div class="searchedModalProduct" >
	               <table class="table">
	                   <thead>
	                       <tr>
	                           <th>상품번호</th>
	                           <th>상품명</th>
	                           <th>가격</th>
	                       </tr>
	                   </thead>
	                   <tbody></tbody>
	               </table>
	           </div>
	      </div>
      </div>
      <!-- <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                <button type="submit" class="btn btn-primary" onclick="branchRegisterConfirm()">등록</button>
              </div> -->
      <!-- <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div> -->
    </div>
  </div>
</div>





<!-- 지점명(현재선택된 지점명 readonly 로) 카테고리 상품으로 보여주기, 상품명은 검색을 통해, 가격은 상품명에 따른 가격 -->
<!-- 첫번째 상품등록 모달 -->	
   <!--  <div class="modal fade" id="fsdirstProductModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            모달창 제목
            <h5 class="modal-title">상품등록</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <form action=""> 입력폼
              <div class="form-group">
                <label>지점명</label> 
                <input type="text" readonly class="form-control" id="currentBranchName">
              </div>
              <div class="form-group">
                <label>카테고리</label>
                <input type="text" readonly class="form-control" id="currentProductCategory">
              </div>
              <div class="form-group">
                <label>상품명</label>
                <button id="firstProductModalBtn" class="btn btn-primary" class="btn" data-toggle="modal" data-target="#secondProductModal">검색</button>
                	 <input type="text" readonly class="form-control" id="currentProductName">
              </div>
              <div class="form-group">
                <label>가격</label>
                 <input type="text"  class="form-control" class="price" id="currentProductPrice" readonly></input>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                <button type="submit" class="btn btn-primary" onclick="branchRegisterConfirm()">등록</button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
    
    두번째 상품등록 모달	
				    <div class="modal fade" id="secondProductModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true" style="margin-left: auto; margin-right: -1070px;">
				      <div class="modal-dialog" >
				        <div class="modal-content">
				          <div class="modal-header">
				            모달창 제목
				            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				              <span aria-hidden="true">&times;</span>
				            </button>
				          </div>
				          <div class="modal-body">
				            <form action=""> 입력폼
				              <div class="form-group">
				                <label></label>
				                <div>
				                <input type="text" id="modalSearch" class="form-control">
				                <button  class="modalSearch" class="btn btn-primary">검색</button>
				                </div>
				                <div class="searchedModalProduct" >
			                        <table class="table">
			                            <thead>
			                                <tr>
			                                    <th>상품번호</th>
			                                    <th>상품명</th>
			                                    <th>가격</th>
			                                </tr>
			                            </thead>
			                            <tbody></tbody>
			                        </table>
			                    </div>
				              </div>
				              <div class="form-group">
				                <label>내용</label>
				                <textarea type="text" class="form-control" required oninvalid="this.setCustomValidity('관리 내용을 작성해 주세요.')" oninput="this.setCustomValidity('')" maxlength="500" placeholder="500자까지 작성 가능" style="height: 180px;"></textarea>
				              </div>
				              <div class="form-row">
				                <label>작성 날짜</label>
				                <input class="form-control" id="currentDate" readonly type="text" value="date">
				              </div>
				              <div class="modal-footer">
				                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
				                <button type="submit" class="btn btn-primary">저장</button>
				              </div>
				            </form>
				          </div>
				        </div>
				      </div>
				    </div> -->
 <!-- <div class="ticketList">티켓 리스트
	<input type="text" class="searchProduct" placeholder="검색어 입력">
	<button id="search" class="button">검색</button>
	<div class="listTable">
	<table>
	</table>
	</div>
	<button id="modalBtn" class="btn btn-primary" class="btn" data-toggle="modal" data-target="#ticketModal">등록</button>
	<button type="button" class="button" id="ticketRegisterConfirm">등록</button>
	<div id="myTicketModal" class="modal">
	<div class="modal-content">
    <span class="close">&times;</span>
	<p>티켓 등록<p/>
    		 티켓명 <input type="text" id="productName"  name = productName placeholder="티켓명을 입력해주세요" style="width: 50%;"><br/>
			 가격 <input type="text" id="price" name = price placeholder="가격을 입력해주세요"><br/>
			 <button type="button" class="button" onclick="ticketRegisterConfirm()">등록</button>
  </div>
  </div>
</div>
티켓등록 모달	
버튼 클릭 시 열리는 모달창
    <div class="modal fade" id="ticketModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            모달창 제목
            <h5 class="modal-title">티켓등록</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <form action=""> 입력폼
              <div class="form-group">
                <label>지점명</label>
                <input type="text" id="branchName" class="form-control" required >
              </div>
              <div class="form-group">
                <label>도로명주소</label>
                	 <input type="button" onclick="roadAddr()" value="찾기"><br/>
                 <input type="text" id="branchLocation" class="form-control" readonly required  ></input>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                <button type="submit" class="btn btn-primary" onclick="branchRegisterConfirm()">등록</button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>	-->
    
	</div>
</div>
</body>
<script>
resizeWidth();
window.addEventListener('resize',resizeWidth);
function resizeWidth(){
	var winWidth = window.innerWidth;
	//console.log(winWidth);
	var sideWidth = $('nav').outerWidth();
	//console.log(sideWidth);
	var contentWidth = winWidth-sideWidth;
	$('.commonContainer').css({'width':contentWidth, 'margin-left':sideWidth});
}

var matchedProductList;
var productListTable = $('.productList table');
productListTable.html('<tr><th>상품번호</th><th>상품명</th><th>가격</th></tr>');
var ticketListTable = $('.ticketList table');
ticketListTable.html('<tr><th>티켓번호</th><th>티켓명</th><th>가격</th></tr>');
/* var searchedModalProduct = $('.searchedModalProduct table');
searchedModalProduct.html('<tr><th>상품번호</th><th>상품명</th><th>가격</th></tr>'); */
// 현재 보여지고 있는 지점명
var currentBranchName;
var currentProductCategory;
var currentTicketCategory;
var currentProductName;
var currentProductPrice;


// 지점 리스트 지도에 표시
new Promise((resolve, reject) => {
    // 첫 번째 Ajax 호출
    // 카카오 지도 api 를 사용해서 지도 그리기
    $.ajax({
        type: 'get',
        url: 'storeMap.do',
        dataType: 'json',
        success: function (data) {
        	console.log("첫번째 ajax 호출 성공");
            console.log(data);
            console.log("x : " + data.documents[0].x);
            console.log("y : " + data.documents[0].y);
            console.log("------------------");
            
            /* initializeMap(data); */
            resolve(data); // 첫 번째 Ajax 호출 성공 시 resolve 호출
        },
        error: function (e) {
            console.log(e);
            console.log("첫 번째 Ajax 호출 실패");
            reject("첫 번째 Ajax 호출 실패"); // 첫 번째 Ajax 호출 실패 시 reject 호출
        }
    });
}).then((apiResult) => {
    // 두 번째 Ajax 호출
    // 데이터로 받아온 지점의 위도,경도를 가지고 그 지점에 해당하는 상품, 티켓 리스트 뿌려주기
    return new Promise((resolve, reject) => {
        $.ajax({
            type: 'get',
            url: 'storeList.do',
            dataType: 'json',
            success: function (data) {
                	console.log("두번째 ajax 호출 성공");
                	console.log(data);
                	initializeMap(data);
                 	// 첫 번째 Ajax 결과의 x, y 값과 일치하는 branch 찾기
                    var productListTable = $('.productList table');
                    var matchedBranch = null;
                    for (var i = 0; i < data.branchProductList.length; i++) {
                        var branch = data.branchProductList[i];
                        console.log(branch);
                        currentBranchName = branch.branchName;
                        currentProductCategory = "상품";
                        currentTickettCategory = "티켓";
                        $('#currentBranchName').val(currentBranchName);
                        $('#currentProductCategory').val(currentProductCategory);
                        $('#currentTickettCategory').val(currentTickettCategory);
                        console.log("api x 값 / "+ apiResult.documents[0].x);
                        console.log("api y 값 / "+ apiResult.documents[0].y);
                        console.log("지점 x 값 / "+branch.branchLongitude);
                        console.log("지점 y 값 / "+branch.branchLatitude);
                        if (branch.branchLongitude === apiResult.documents[0].x && branch.branchLatitude === apiResult.documents[0].y) {
                            matchedBranch = branch;
                            branchName = matchedBranch;
                            console.log(matchedBranch);
                            break;
                        }
                    }
    				// 지점 탭 추가
	    			console.log("------------------");
    				for (var i = 0; i < data.branchList.length; i++) {
    				    console.log(data.branchList[i].branchName);
    				    var branchButton = $('<button class="branchButton" >' + data.branchList[i].branchName + '</button>');
    				    branchButton.data('branchName', data.branchList[i].branchName);
    				    $('.branchLocation').append(branchButton);
    				}
    				// 상품 리스트 추가
    				console.log("------------------");
    				for (var i = 0; i < data.branchProductList.length; i++) {
						if(data.branchProductList[i].branchName == matchedBranch.branchName &&
								data.branchProductList[i].category === "상품" && data.branchProductList[i].status === "판매중"){
							var product = data.branchProductList[i];
							var productInfo = '<tr>' +
	                         '<td>' + product.productID + '</td>' +
	                         '<td>' + product.productName + '</td>' +
	                         '<td>' + product.price + '</td>' +
	                         '</tr>';
	                     productListTable.append(productInfo);
						}
					}
    				// 티켓 리스트 추가
    				console.log("------------------");
    				for (var i = 0; i < data.branchProductList.length; i++) {
						if(data.branchProductList[i].branchName == matchedBranch.branchName &&
								data.branchProductList[i].category === "티켓" && data.branchProductList[i].status === "판매중"){
							var ticket = data.branchProductList[i];
							var ticketInfo = '<tr>' +
	                         '<td>' + ticket.productID + '</td>' +
	                         '<td>' + ticket.productName + '</td>' +
	                         '<td>' + ticket.price + '</td>' +
	                         '</tr>';
                         ticketListTable.append(ticketInfo);
						}
					}
    				
    				// 지점 탭 클릭
    				$('.branchButton').click(function () {
					    console.log("------------------");
					    console.log("지점 버튼 클릭");
					    branchName = $(this).data('branchName');
					    console.log(branchName);
					    currentBranchName = branchName;
		                currentProductCategory = "상품";
		                currentTickettCategory = "티켓";
		                $('#currentBranchName').val(currentBranchName);
		                $('#currentProductCategory').val(currentProductCategory);
		                $('#currentTickettCategory').val(currentTickettCategory);
		                  // 현재 지점명이 "가산점"이면 productInfoRegister 버튼을 보이게 하고, 그렇지 않으면 modalBtn 버튼을 보이게 함
		                   if (currentBranchName === "가산점") {
		                      document.getElementById("modalProductRegister").style.display = "none";
		                      document.getElementById("productInfoRegister").style.display = "inline";
		                  } else {
		                  	document.getElementById("modalProductRegister").style.display = "inline";
	                      document.getElementById("productInfoRegister").style.display = "none";
		                  } 
					    // 선택된 branchName에 해당하는 지점 찾기
					    var matchedBranch = data.branchProductList.find(function (branch) {
					        return branch.branchName === branchName;
					    });
					    var matchedProducts = data.branchProductList.filter(function (product) {
					        return product.branchName === matchedBranch.branchName && product.category === "상품" 
					        	&& product.status === "판매중";
					    });
					    var matchedTickets = data.branchProductList.filter(function (product) {
					        return product.branchName === matchedBranch.branchName && product.category === "티켓" 
					        && product.status === "판매중";
					    });
					    
					    if (matchedBranch) {
					        console.log("클릭된 지점명과 일치하는 지점명");
					        console.log("탭 지점명 : " + branchName);
					        var branchName = $(this).data('branchName');
					        console.log("클릭된 지점명 값 : " + matchedBranch.branchName);
					        console.log(matchedBranch.branchLongitude);
					        console.log(matchedBranch.branchLatitude);
					        initializeMap({
					            branchList: [{
					            	branchLocation: matchedBranch.branchLocation,
					                branchLongitude: matchedBranch.branchLongitude,
					                branchLatitude: matchedBranch.branchLatitude
					            }]
					        });
							// 모달창에 현재 클릭된 지점명 넣기
					        $('.branchName').val(branchName);
					        
					        // 상품리스트로 테이블 업데이트
					        var productListTable = $('.productList table');
					        productListTable.html('<tr><th>상품번호</th><th>상품명</th><th>가격</th></tr>');
							// 티켓리스트로 테이블 업데이트
							var ticketListTable = $('.ticketList table');
							ticketListTable.html('<tr><th>티켓번호</th><th>티켓명</th><th>가격</th></tr>');
							
					        // 상품 데이터를 테이블에 추가
					        if (matchedProducts.length > 0) {
							    for (var j = 0; j < matchedProducts.length; j++) {
							        var product = matchedProducts[j];
							        var productInfo = '<tr>' +
							            '<td>' + product.productID + '</td>' +
							            '<td>' + product.productName + '</td>' +
							            '<td>' + product.price + '</td>' +
							            '</tr>';
							        productListTable.append(productInfo);
							    }
							} else {
							    // 클릭된 지점명과 일치하는 상품이 하나도 없는 경우 메시지를 추가합니다.
							    var productInfo = '<tr>' +
							        '<td colspan="3">' + "아직 상품이 등록되지 않았습니다" + '</td>' +
							        '</tr>';
							    productListTable.append(productInfo);
							}
					        // 티켓 데이터를 테이블에 추가
					        if (matchedTickets.length > 0) {
							    for (var j = 0; j < matchedTickets.length; j++) {
							        var ticket = matchedTickets[j];
							        var ticketInfo = '<tr>' +
							            '<td>' + ticket.productID + '</td>' +
							            '<td>' + ticket.productName + '</td>' +
							            '<td>' + ticket.price + '</td>' +
							            '</tr>';
							        ticketListTable.append(ticketInfo);
							    }
							} else {
							    // 클릭된 지점명과 일치하는 상품이 하나도 없는 경우 메시지를 추가합니다.
							    var productInfo = '<tr>' +
							        '<td colspan="3">' + "아직 상품이 등록되지 않았습니다" + '</td>' +
							        '</tr>';
							    productListTable.append(productInfo);
							}
					     	
					    }
					        else {
					        console.log("지점에 등록된 상품이 없습니다");
					    }
					});
                resolve(); // 두 번째 Ajax 호출 성공 시 resolve 호출
            },
            error: function (e) {
                console.log(e);
                console.log("두 번째 ajax 호출 실패");
                reject(); // 두 번째 Ajax 호출 실패 시 reject 호출
            }
        });
    });
}).catch((error) => {
    console.log("에러 발생: " + error);
});

// 검색 버튼 클릭
$('#search').click(function () {
searchKeyword = $('.searchProduct').val();
console.log(searchKeyword);
searchProduct(searchKeyword, currentBranchName);
});

// 모달검색 버튼 클릭
 $('.secondProductModalSearch').click(function () {
	 console.log("모달검색버튼 클릭");
   searchKeyword = $('#secondProductModalSearch').val();
   currentBranchName = "본사상품"
   searchProduct(searchKeyword,currentBranchName);
});

//상품 검색 ajax
 function searchProduct(searchKeyword, currentBranchName) {
	 console.log("------------------");
 	 console.log("keyword/Name : "+searchKeyword+"/"+currentBranchName);
     $.ajax({
         type: 'get',	
         url: 'searchProduct.do',
         data: {
             'searchKeyword': searchKeyword,
             'branchName': currentBranchName
         },
         dataType: 'json',
         success: function (data) {
             console.log(data);
             console.log("성공");
             drawProduct(data);
         },
         error: function (e) {
        	 console.log("실패");
             console.log(e);
         }
     });
 }
	// 지도 그리기
    function initializeMap(data) {
        var mapContainer = document.getElementById('map');
        var options = {
            center: new kakao.maps.LatLng(data.branchList[0].branchLatitude,data.branchList[0].branchLongitude),
            level: 3
        };
		// 마커 표시
        var map = new kakao.maps.Map(mapContainer, options);

            var markerPosition = new kakao.maps.LatLng(data.branchList[0].branchLatitude, data.branchList[0].branchLongitude);
            var marker = new kakao.maps.Marker({
                position: markerPosition,
                title: data.branchList[0].branchLocation
            });

            marker.setMap(map);

            // 지점명을 인포윈도우로 표시
            var infowindow = new kakao.maps.InfoWindow({
            		content: '<div style="padding:5px; font-size: 14px; text-align: center; width: 250px;">' + data.branchList[0].branchLocation + '</div>'
            });

            // 초기에 InfoWindow를 열어둠
            infowindow.open(map, marker);
    }
	// 모달 검색 버튼 클릭시
    $(document).ready(function () {
    $('#firstProductSearchModal').click(function () {
        // Ajax를 사용하여 서버에 검색 요청
        $.ajax({
            type: 'get',
            url: 'modalProductList.do',
            data: {
              'currentBranchName': currentBranchName,
          	},
            dataType: 'json',
            success: function (data) {
                // 검색 결과를 받아와서 동적으로 테이블에 추가
                var tableBody = $('.searchedModalProduct table tbody');
                tableBody.empty(); // 기존 내용 비우기
                console.log("상품모달 리스트 성공");
                console.log(data);
                for (var i = 0; i < data.modalSearchedList.length; i++) {
                    var product = data.modalSearchedList[i];
                    var row = '<tr>' +
                        '<td>' + product.productID + '</td>' +
                        '<td class="productNameCell">' + product.productName + '</td>' +
                        '<td>' + product.price + '</td>' +
                        '</tr>';
                    tableBody.append(row);
                }

            },
            error: function (e) {
                console.log("상품모달 리스트 실패");
                console.log(e);
            }
        });
    });
});

 // productName을 클릭하는 이벤트 처리
    $(document).on('click', '.productNameCell', function() {
      // 클릭한 행의 productName과 price 값을 가져와 변수에 저장
      var clickedRow = $(this).closest('tr');
      currentProductName = clickedRow.find('td:eq(1)').text();
      currentProductPrice = clickedRow.find('td:eq(2)').text();
    $('#currentProductName').val(currentProductName);
    $('#currentProductPrice').val(currentProductPrice);
      // 여기에서 필요한 작업 수행
      console.log("선택한 상품명: " + currentProductName);
      console.log("선택한 가격: " + currentProductPrice);

      // 모달을 닫기 (가정: 모달의 id가 'productSearch'인 경우)
      $('#secondProductModal').modal('hide');
  });
	
	// 검색된 상품 그리기
    function drawProduct(data) {
		console.log("drawProduct 함수");
		console.log(data);
		console.log(data.searchedList[0].productName);
		if(data.searchedList[0].status == "본사상품"){
			console.log("모달 검색 성공");
			
		    var searchedModalProduct = $('.searchedModalProduct table tbody');
		    searchedModalProduct.html('<tr><th>상품번호</th><th>상품명</th><th>가격</th></tr>');
		    searchedModalProduct.empty(); // 기존 내용 비우기
		    for (var i = 0; i < data.searchedList.length; i++) {
	        var product = data.searchedList[i];
	        console.log(product.productID);
	        console.log(product.productName);
	        console.log(product.price);
	        console.log(data.searchedList[i].productName);
	        
	        var productInfo = '<tr>' +
	            '<td>' + product.productID + '</td>' +
	            '<td class="productNameCell">' + product.productName + '</td>' +
	            '<td>' + product.price + '</td>' +
	            '</tr>';
	            searchedModalProduct.append(productInfo);
	    	}
		   /*  var productListTable = $('.productList table');
        	productListTable.html('<tr><th>상품번호</th><th>상품명</th><th>가격</th></tr>');
		    var productInfo = '<tr>' +
		        '<td>' + product.productID + '</td>' +
		        '<td class="productNameCell">' + product.productName + '</td>' +
		        '<td>' + product.price + '</td>' +
		        '</tr>';
		        productListTable.append(productInfo); */
		    
		}else{
			
    // 데이터를 테이블에 추가
        var product = data.searchedList[0];
    	console.log("데이터터");
        console.log(product.productID);
        console.log(product.productName);
        console.log(product.price);
        
        var productListTable = $('.productList table');
    	productListTable.empty(); // 기존 내용 비우기
        productListTable.html('<tr><th>상품번호</th><th>상품명</th><th>가격</th></tr>');
        var productInfo = '<tr>' +
            '<td>' + product.productID + '</td>' +
            '<td>' + product.productName + '</td>' +
            '<td>' + product.price + '</td>' +
            '</tr>';
            productListTable.append(productInfo);
		}
    }
    
 	// 카카오 우편번호 api
    function roadAddr() {
        new daum.Postcode({
            oncomplete: function(data) {
                var roadAddr = data.roadAddress; // 도로명 주소 변수

                document.getElementById("branchLocation").value = roadAddr;
                
                var guideTextBox = document.getElementById("guide");
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';
                }
            }
        }).open();
    }

    function branchRegisterConfirm() {
       // 필요한 데이터를 추출
       var branchName = document.getElementById('branchName').value;
       var branchLocation = document.getElementById('branchLocation').value;

       // 값이 비어 있는지 확인
       if (!branchName || !branchLocation) {
           alert("내용을 입력해주세요.");
           return; // 값이 비어 있다면 함수를 실행하지 않음
       }

       // 카카오 맵 지오코더 생성자
       var geocoder = new kakao.maps.services.Geocoder();

       // 주소 검색 결과를 처리할 콜백 함수를 정의합니다.
       var callback = function(result, status) {
           // 검색 상태가 OK인 경우에만 처리합니다.
           if (status === kakao.maps.services.Status.OK) {
               // 검색 결과에서 위도(latitude)와 경도(longitude)를 추출합니다.
               var result = result[0];
               var branchLatitude = result.y; // 위도
               var branchLongitude = result.x; // 경도

               branchReigster(branchName, branchLocation, branchLatitude, branchLongitude);
           } else {
               // 검색 상태가 OK가 아닌 경우에는 에러 메시지를 출력합니다.
               console.error("주소 검색 실패: " + status);
           }
       };

       // 주소 검색 요청을 수행합니다.
       geocoder.addressSearch(branchLocation, callback);
       alert("등록되었습니다!");
       closeModal();
   }

    

    // 지점등록 데이터를 서버로 보내는 함수
    function branchReigster(branchName, branchLocation, branchLatitude, branchLongitude) {
        $.ajax({
            type: 'get',
            url: 'branchRegister.do',
            data: {
                branchName: branchName,
                branchLocation: branchLocation,
                branchLatitude: branchLatitude,
                branchLongitude: branchLongitude
            },
            success: function(data) {
                console.log(data);
                console.log("성공");
            },
            error: function(error) {
                console.error(error);
            }
        });
    }
    document.getElementById('branchProductRegister').addEventListener('click', function() {
      currentBranchName = $()
      var currentBranchName = document.getElementById('currentBranchName').value;
  	  var currentProductName = document.getElementById('currentProductName').value;
      branchProductRegister(currentBranchName, currentProductName);
  });
   	// 모달 상품등록 데이터를 서버로 보내는 함수
    function branchProductRegister(currentBranchName, currentProductName){
   		console.log("모달 상품드록 버튼");
    	$.ajax({
        type: 'post',
        url: 'branchProductRegister.do',
        data: {
        	currentBranchName: currentBranchName,
        	currentProductName: currentProductName
        },
        success: function(data) {
            console.log(data);
            console.log("성공");
        },
        error: function(error) {
            console.error(error);
        }
    	});
    }
    function ticketRegisterConfirm(){
    	if (confirm("등록하시겠습니까?")) {
    		var branchName = document.getElementById('branchName').value;
    		var productName = document.getElementById('productName').value;
            var price = document.getElementById('price').value;
			var category = "티켓";
			
			ticketRegister(productName, price, category);
			
    		alert("등록되었습니다!");
    		}
    }
    
 	// 티켓등록 데이터를 서버로 보내는 함수
    function ticketRegister(branchName, productName, price, category) {
        $.ajax({
            type: 'get',
            url: 'ticketRegister.do',
            data: {
            		branchName: branchName,
            		productName: productName,
            		price: price,
            		category: category
            },
            success: function(data) {
                console.log(data);
                console.log("성공");
            },
            error: function(error) {
                console.error(error);
            }
        });
    }
  	function validationConfirm(){
      		alert("모든 내용을 입력해주세요!");
  	}

</script>
</html>