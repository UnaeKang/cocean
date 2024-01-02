<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<style>

#dpTableHead{
	background-color: #86B0F3;
	text-align: center;
}

#dpTable{
	width: 72%;
	height: 30%;
	top: 255px;
	left: 400px;
	position: absolute;
}

#dpList{
	text-align:center;
}

#hTitle {
	width: 120px;
	height: 50px;
	left: 400px; 
	position: absolute;
	top: 120px;
}

#hTitle a {
	font-size: 22px;
}

#search input {
	z-index: 99999;
}

#search{
	    position: absolute;
	    top:27%;
   		left: 78%;
}

@media screen and (max-width: 1457px) {
	#search {
		top: 23%;
	}
	#search button {
		width: 233px;
	}
	#search input {
		margin-bottom: 5px;
	}
}
</style>
</head>
<body>
<jsp:include page="../side.jsp"></jsp:include>	
	<div id="hTitle">
		<a>부서함</a>
	</div>
	
	<!-- <form action="searchList.do" method="POST">
	<select id="category" name="formCategory">
	  <option value="전체" selected="selected">전체</option>
	  <option value="일반">일반</option>
	  <option value="근태">근태</option>
	  <option value="인사">인사</option>
	</select>

		<input type="search" name="keyword" placeholder="제목"/>
		<button class="btn btn-primary">검색</button>
	</form> -->
	<nav class="navbar navbar" id="search">
            <form class="form-inline">
              <input class="form-control mr-sm-2" type="search" placeholder="문서양식을 입력하세요." aria-label="Search">
              <button class="btn btn-outline-primary my-2 my-sm-0" type="submit">검색</button>
            </form>
    </nav>
		
	<div id=dpTable>
	<table class="table table-hover">
		<thead id="dpTableHead">
		<tr>
			<th scope="col">기안일</th>
			<th scope="col">유형</th>
			<th scope="col">제목</th>
			<th scope="col">기안자</th>
			<th scope="col">상태</th>
		</tr>
		
		<tbody id=dpList>
		<c:forEach items="${list}" var="list">
		<tr>
			<td scope="row">${list.draftDate}</td>
			<td>${list.formCategory}</td>
			<td> 
				<c:choose>
	                <c:when test="${list.title == null}">
	                    <a href="draftDetail.go?idx=${list.idx}&employeeID=${list.employeeID}">${list.formTitle}</a>
	                </c:when>
	                <c:when test="${list.title == ''}">
	                    <a href="draftDetail.go?idx=${list.idx}&employeeID=${list.employeeID}">${list.formTitle}</a>
	                </c:when>
	                <c:otherwise>
	                    <a href="draftDetail.go?idx=${list.idx}&employeeID=${list.employeeID}">${list.title}</a>
	                </c:otherwise>
	            	</c:choose>
            </td>
            <td>${list.name}</td>
			<td>${list.draftStatus}</td>
		</tr>	
		</c:forEach>
		</tbody>
	</table>
	</div>
	
</body>
<script>

    $("#category").change(function () {
        var selectedCategory = $(this).val();
        var keyword = $("input[name='keyword']").val();
        console.log(selectedCategory);
        filterList(selectedCategory, keyword);
    });

    function filterList(category, keyword) {
        if (category === "전체") {
            $("table tr").show();
        } else {
            $("table tr:gt(0)").hide();
            $("table tr").filter(function () {
            	 var categoryMatch = $(this).find("td:first").text() === category;
                 var keywordMatch = $(this).find("td:last").text().includes(keyword);
                 return categoryMatch && keywordMatch;
            }).show();
        }
    }

</script>
</html>