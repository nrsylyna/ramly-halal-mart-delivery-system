<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zxx">

<head>
	<title>RAMLY HALAL MART</title>
	<!--/tags -->
        <%@ include file="meta.html" %>
	<!--//tags -->
	<link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
	<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
	<link href="css/font-awesome.css" rel="stylesheet">
	<!--pop-up-box-->
	<link href="css/popuo-box.css" rel="stylesheet" type="text/css" media="all" />
	<!--//pop-up-box-->
	<!-- price range -->
	<link rel="stylesheet" type="text/css" href="css/jquery-ui1.css">
	<!-- fonts -->
	<link href="//fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800" rel="stylesheet">
	<style>
            .product-sec2 {
                box-shadow: 0px 10px 15px 0px #D6D6D6;
                padding: 30px 20px;
                margin-bottom: 14px;
            }
            * {
              box-sizing: border-box;
            }
            table.item-list tr td {
                padding:20px;
            }
           table.search-sec tr td{
                padding-left:7px;
            }
            table.search-sec input[type=search] {
                width:400px;
            }
              .item-img img{
                    margin: 5px;
                    width: 190px;
                    height: 200px;
            }
              .item-caption{
                    margin: 5px 5px;
                    height: 25px;
                    font-size: 20px;
            }
            .item-caption-2{
                    margin: 5px 5px;
                    height: 5px;
                    font-size: 12px;
            }
            .item-price{
                    height: 10px;
                    padding-top: 0px;
                    font-size: 20px;
                    color: #3fbf48;
                    margin: 10px 5px 0px 5px;
            }
            .card-border{
                margin: 10px;
                padding: 10px;
                width: 310px;
                height: 400px;
                border: 2px solid orange;
                border-radius: 15px;
            }
	</style>
    </head>
    <body>
	<!-- header-bot-->
        <%@ include file="MainNav.jsp" %>
	<!-- //header-bot -->
	<!-- top Products -->
	<div class="ads-grid">
            <div class="container">
                <!-- tittle heading -->
                <h3 class="tittle-w3l">Our Products
                    <span class="heading-style">
                        <i></i>
                        <i></i>
                        <i></i>
                    </span>
                </h3>
                <!-- //tittle heading -->	
                <!-- form -->
                <div class="agileinfo-ads-display col-md-13 w3l-rightpro">
                    <div class="wrapper">
                        <!-- first section -->
                        <div class="product-sec2">
                            <h3 class="agileinfo_sign"></h3>                                             
                            <center>
                                <div class="row">
                                    <c:forEach items="${itemAll}" var="item">
                                        <div class="col-6 col-sm-4">
                                            <div class="card bg-secondary text-white">
                                                <div class="card-border">
                                                    <div class="item-img"> 
                                                        <img class="card-img-top" src="data:image/jpg;base64,${item.base64Image}" alt="Card image" width="240" height="500">
                                                    </div>
                                                    <div class="card-body"  style="height:50%;">
                                                        <!--<c:out value="${item.itemID}" /><br>-->
                                                       <b><div class="item-caption"><c:out value="${item.itemName}" /></div></b>
                                                       <div class="item-price">RM<c:out value="${item.itemPrice}" /></div><br>
                                                       <div class="item-caption-2">Type: <i><c:out value="${item.itemType}" /></i><br>  
                                                       <c:out value="${item.itemDescription}" /><br><br>
                                                       <c:out value="${item.itemQty}" /> more left</div><br><br><br>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </center>       
                        </div>
                        <!-- //first section -->
                    </div>
                </div>
                <!-- //form -->
            </div>
	</div>
	<!-- //top products -->
	<!-- copyright -->
	<div class="copy-right">
            <div class="container">
                <p>© 2021 Ramly Halal Mart. All rights reserved | Design by Zephyr.</p>
            </div>
	</div>
	<!-- //copyright -->
	<!-- js-files -->
	<!-- jquery -->
	<script src="js/jquery-2.1.4.min.js"></script>
	<!-- //jquery -->
	<!-- for bootstrap working -->
	<script src="js/bootstrap.js"></script>
	<!-- //for bootstrap working -->
	<!-- //js-files -->
    </body>
</html>