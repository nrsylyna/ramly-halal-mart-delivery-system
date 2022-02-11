<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zxx">
    <head>
	<title>RAMLY HALAL MART </title>
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
                height: 450px;
                border: 2px solid orange;
                border-radius: 10px;
            }
            .item-status{
                margin-top: 8px;
                font-family: 'Balsamiq Sans', cursive;
                border-radius: 4px;
                padding-top: 8px;
                border: 1px transparent;
                width: 100px;
                height: 35px;
            }
            .sold-out{
                font-size: 15px;
                color: white;
                background-color: #de4f35;
            }
            ::placeholder {
                color: black;
            }
            input[type="search"]:active, input[type="search"]:focus {
                color: black;
            }
        </style>
    </head>
    <%@page import="ramly.model.Customer"%>
    <% Customer cust = (Customer) session.getAttribute("login");
        if(cust == null){
            response.sendRedirect("LoginCustomer.jsp");
        }
    %>
    <body>
        <c:set var="message" value="${requestScope.alertMsg}"/> 
        <c:if test="${message != null}">      
            <body onload="showAlert()"></body>
        </c:if>
	<!-- header-bot-->
        <%@ include file="CustNav.jsp" %>
	<!-- top Products -->
	<div class="ads-grid">
            <div class="container">
                <!-- tittle heading -->
                <h3 class="tittle-w3l">Search result
                    <span class="heading-style">
                        <i></i>
                        <i></i>
                        <i></i>
                    </span>
                </h3>
                <center>
                    <a href="ItemController?action=CustCatalogue"><button class="btn btn-secondary"><span class="fa fa-backward" aria-hidden="true"></span> View All Products</button></a>
                </center>
                <br>
                <!-- //tittle heading -->
                <!-- form -->
                <div class="agileinfo-ads-display col-md-13 w3l-rightpro">
                    <div class="wrapper">
                        <!-- first section -->
                        <center>
                            <div class="product-sec2">                                               
                                <div class="side-bar col-md-75">
                                    <div class="search-hotel">                     
                                        <table class="search-sec">
                                            <tr>
                                                <form method="post" action="ItemController?action=searchItem">
                                                    <td colspan="2">
                                                        <input type="search" placeholder="Enter product name here..." name="search">
                                                    </td>
                                                    <td>   
                                                        <span class="icon-input-btn" style="margin-left:5px; display: inline-table;">
                                                            <input type="submit" class="btn btn-default" value="Search">
                                                        </span>
                                                    </td>      
                                                </form>
                                                <td>
                                                    <span style="margin-left:15px; display: inline-table;">
                                                        <a href="CartController?action=viewCart"><button class="btn btn-primary"><span class="fa fa-cart-arrow-down" aria-hidden="true"></span> View Cart</button></a>
                                                    </span>
                                                </td>                       
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <c:forEach items="${itemAll}" var="item">
                                    <div class="col-6 col-sm-4">
                                        <div class="card bg-secondary text-white">
                                            <div class="card-border">
                                                <div class="item-img"> <img class="card-img-top" src="data:image/jpg;base64,${item.base64Image}" alt="Card image" width="240" height="500">
                                                </div>
                                                <div class="card-body"  style="height:50%;">
                                                    <!--<c:out value="${item.itemID}" /><br>-->
                                                    <b><div class="item-caption"><c:out value="${item.itemName}" /></div></b>
                                                    <div class="item-price">RM<c:out value="${item.itemPrice}" /></div>
                                                    <br>
                                                    <div class="item-caption-2">Type: <i><c:out value="${item.itemType}" /></i>
                                                    <br>  
                                                        <c:out value="${item.itemDescription}" />
                                                    <br><br>
                                                        <c:out value="${item.itemQty}" /> more left
                                                    </div>
                                                    <br><br><br>
                                                    <c:if test="${item.itemQty >= 1}">
                                                        <br>
                                                        <a href="CartController?action=addToCart&id=${item.getitemID()}"><button class="btn btn-info">  Add To Cart</button></a>
                                                        <br>
                                                    </c:if>
                                                    <c:if test="${item.itemQty < 1}">
                                                        <center><div class="item-status sold-out">SOLD OUT</div></center>
                                                   </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                                
                            </div>    
                        </center>   
                        <!-- //first section -->
                        <script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
                        <script>
                            function showAlert() {
                                Swal.fire({
                                    position: 'top-center',
                                    icon: 'warning',
                                    title: 'Invalid keyword. Please try another keyword',
                                    showConfirmButton: false,
                                    timer: 5000
                                });
                            }
                        </script>
                    </div>
                </div>
            </div>
            <!-- //form -->
        </div>
	<!-- //top products -->
	<!-- footer -->
        <%@ include file="custFooter.html" %>
	<!-- //footer -->
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