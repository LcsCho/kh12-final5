<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
        * {
	box-sizing: border-box;
	}
    


   #contents {
    clear: both;
    padding-bottom: 50px;
    position: relative;
    width: 980px;
    margin: 0 auto;
}  

.tit-heading-wrap {
    position: relative;
    height: 51px;
    margin-top: 30px;
    border-bottom: 3px solid #241d1e;
}

.tit-heading-wrap > .submenu {
    position: absolute;
    top: 18px;
    right: 0;
}

.tit-heading-wrap > .submenu > ul {
    overflow: hidden;
}

ol, ul {
    list-style: none;
}

.tit-heading-wrap > .submenu > ul:after {
    content: '';
    clear: both;
    display: block;
}

.tit-heading-wrap > .submenu > ul > li:first-child {
    margin-left: 0;
}

.tit-heading-wrap > .submenu > ul > li {
    float: left;
    margin-left: 15px;
}
 
li {
    display: flex;
    text-align: -webkit-match-parent;
}

 .tit-heading-wrap > .submenu > ul > li.on > a, .tit-heading-wrap > .submenu > ul > li > a:hover, .tit-heading-wrap > .submenu > ul > li > a:focus { 

 color: #e40000; 
 } 

.tit-heading-wrap > .submenu > ul > li > a {
    display: inline-block;
    padding-left: 13px;
    font-weight: 500;
    font-size: 14px;
}

a {
    color: inherit;
    text-decoration: none;
}

a:-webkit-any-link { 

    cursor: pointer; 

 } 

[class|="wrap-movie"][class*="chart"] .sect-movie-chart {
    margin-top: 30px;
}

[class|="sect"][class*="chart"] {
    position: relative;
    overflow: hidden;
}

div[class^="sect-"] {
    clear: both;
    zoom: 1;
}

div[class^="sect-"]:after {
    content: '';
    clear: both;
    display: block;
}

[class|="sect"][class*="chart"] > h3:first-child + ol, [class|="sect"][class*="chart"] >h4:first-child +  ol {
    padding-top: 0;
}

[class|="sect"][class*="chart"] > ol {
    padding-top: 30px;
    margin-left: -64px;
    border-bottom: 3px solid #241d1e;
    zoom: 1;
}

ol {
    display: block;
    list-style-type: decimal;
    margin-block-start: 1em;
    margin-block-end: 1em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    padding-inline-start: 40px;
}

[class|="sect"][class*="chart"] > ol:after {
    content: '';
    clear: both;
    display: block;
}

dl:after, ul:after, ol:after {
    content: '';
    clear: both;
    display: block;
}

[class|="sect"][class*="chart"] > ol > li {
    float: left;
    width: 197px;
    margin-left: 50px;
    padding-bottom: 30px;
}

[class|="sect"][class*="chart"] .box-image {
    position: relative;
    width: 197px;
    min-height: 272px;
    margin-bottom: 10px;
}

[class|="sect"][class*="chart"] > h3:first-child + ol .rank, [class|="sect"][class*="chart"] > h4:first-child + ol .rank, [class|="sect"][class*="chart"] > .spec + ol .rank {
    background: #e71a0f;
}

[class|="sect"][class*="chart"] .rank {
    display: block;
    height: 28px;
    margin-bottom: 4px;
    border: 6px solid #000000;
    background: #333333;
    color: #ffffff;
    font-size: 19px;
    text-align: center;
    line-height: 28px;
}

strong {
    font-weight: 500;
}

.box-image a {
    display: block;
}

[class|="sect"][class*="chart"] .thumb-image {
    border: 6px solid #000000;
}

.thumb-image {
    display: block;
    position: relative;
}

[class|="sect"][class*="chart"] .thumb-image > img {
    height: 260px;
}

.box-image img {
    width: 100%;
}

input, select, img {
    vertical-align: middle;
}

.wrap-movie-chart .box-contents {

    display: contents;
    height: 93px;
}

.box-contents > a {
    display: block;
}

[class|="sect"][class*="chart"] > ol > li:first-child .title, [class|="sect"][class*="chart"] > h3 + ol > li:first-child .title {
    width: 90%;
}

[class|="sect"][class*="chart"] .title {
    font-size: 15px;
}

.title {
    display: block;
    color: #333333;
    white-space: nowrap;
    text-overflow: ellipsis;
    overflow: hidden;
}

[class|="sect"][class*="chart"] .score {
    margin-top: 7px;
}


.score {
    font-size: 11px;
}

[class|="sect"][class*="chart"] .score .egg-gage, [class|="sect"][class*="chart"] .score .percent {
    vertical-align: middle;
}

[class|="sect"][class*="chart"] .score .percent span {
    vertical-align: initial;
}

[class|="sect"][class*="chart"] .score .percent span {
    display: inline-block;
    margin-left: 10px;
    vertical-align: top;
}

.score .percent span {
    color: #333333;
    font-size: 12px;
    font-weight: normal;
    font-family: Verdana, Geneva, sans-serif;
    vertical-align: -1px;
}
[class|="sect"][class*="chart"] .txt-info {
    margin-top: 3px;
    height: 13px;
    color: #666666;
    font-weight: 500;
    white-space: nowrap;
}

.txt-info {
    display: block;
    color: #999999;
    font-size: 12px;
}

.txt-info > strong {
    font-size: 11px;
}

[class|="sect"][class*="chart"] .txt-info {
    margin-top: 3px;
    height: 13px;
    color: #666666;
    font-weight: 500;
    white-space: nowrap;
}

.txt-info {
    display: block;
    color: #999999;
    font-size: 12px;
}

[class|="sect"][class*="chart"] .like {
    display: block;
    margin-top: 10px;
    text-align: center;
}

.like {
    display: inline-block;
    margin-right: 3px;
}

[class|="sect"][class*="chart"] > h4 {
    margin-top: 30px;
    color: #222222;
    font-size: 21px;
    font-weight: 500;
}

.hidden {
    font: 0/0 a;
    height: 0;
    overflow: hidden;
    position: absolute;
    visibility: hidden;
    width: 0;
    zoom: 1;
}
        </style>

<div class="container-fluid">
    <!-- 전체 페이지 폭 관리 -->
            <hr>
    <div class="row">
        <div class="col-md-8 offset-md-2 d-flex flex-wrap" >
<!--             제목 -->
<!--              <div class="row mt-5"> -->
<!--                 <div class="col"> -->
<!--                     <h3>이미지 갤러리</h3> -->
<!--                 </div> -->
<!--             </div>  -->

            
  <c:forEach var="movieDto" items="${movieList}">
            <ol class="me-1" >

                <li>
                
                    <div class="box-image">
                        <a href="#">
                            <span class="thumb-image">
                                <img src="./images/chunsik.jpeg" class="img-thumbnail img-fluid"  style="width: 185px; height: 260px">
                            </span>
                        </a>

                        <div class="box-contents">
                            <a href="#"><strong class="title" style="width: 185px;">${movieDto.movieName}</strong></a>
                            <span class="txt-info">
                            	<strong style="width: 185px;">
                            		<fmt:formatDate value="${movieDto.movieReleaseDate}" pattern="yyyy" /> / ${movieDto.movieNation}
                            	</strong>
                            </span>
                            <div class="score" style="width: 185px;">
                                <strong class="percent">평균 <i class="fa-solid fa-star"></i> 3.3점 </strong>
                            </div>

                        </div>
                    </div>
                </li>
            </ol>
            </c:forEach>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
