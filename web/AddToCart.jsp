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
            table.item-list tr td {
                padding:20px;
            }
            table.search-sec input[type=search] {
                width:400px;
            }
            .item-img img {
                margin: 5px;
                width: 190px;
                height: 200px;
            }
            .item-caption {
                margin: 5px 5px;
                height: 25px;
                font-size: 20px;
            }
            .item-caption-2 {
                margin: 5px 5px;
                height: 5px;
                font-size: 12px;
            }
            .item-price {
                height: 10px;
                padding-top: 0px;
                font-size: 20px;
                color: #3fbf48;
                margin: 10px 5px 0px 5px;
            }
            .card-border {
                margin: 10px;
                padding: 10px;
                width: 310px;
                height: 450px;
                border: 2px solid orange;
                border-radius: 10px;
            }
            .item-status {
                margin-top: 8px;
                font-family: 'Balsamiq Sans', cursive;
                border-radius: 4px;
                padding-top: 8px;
                border: 1px transparent;
                width: 100px;
                height: 35px;
            }
            .sold-out {
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
        <!-- header-bot -->
	<%@ include file="CustNav.jsp" %>
	<!-- header-bot -->
	<!-- top Products -->
	<div class="ads-grid">
            <div class="container">
                <!-- tittle heading -->
                <h3 class="tittle-w3l">Shop
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
                                <div class="row">
                                    <c:forEach var="item" items="${itemAll}">
                                        <div class="col-6 col-sm-4">
                                            <div class="card bg-secondary text-white">
                                                <div class="card-border">
                                                    <div class="item-img">
                                                        <img class="card-img-top" src="data:image/jpg;base64,${item.base64Image}" alt="Card image" width="240" height="500">
                                                    </div>
                                                    <div class="card-body"  style="height:50%;">
                                                        <c:out value="${item.itemID}" /><br>
                                                        <div class="item-caption">                                                           
                                                            <b><c:out value="${item.itemName}"/></b>
                                                        </div>
                                                        <div class="item-price">RM<c:out value="${item.itemPrice}"/></div>
                                                        <br>
                                                        <div class="item-caption-2">Type: <i><c:out value="${item.itemType}"/></i>
                                                        <br>  
                                                            <c:out value="${item.itemDescription}"/><br><br>
                                                            <c:out value="${item.itemQty}"/> more left
                                                        </div>
                                                        <br><br><br>
                                                        <table>
                                                            <tr>
                                                                <c:choose>
                                                                    <c:when test="${item.itemQty >= 1}">
                                                                        <td>
                                                                            <a href="CartController?action=addToCart&id=${item.getitemID()}"><button class="btn btn-info" onclick="add(event)">Add To Cart</button></a>
                                                                        </td>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <td>
                                                                            <button class="item-status sold-out" disabled>SOLD OUT</button>
                                                                        </td>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                <script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
                                <script>
                                function add(event){
                                    event.preventDefault();   
                                    Swal.fire({
                                        title: 'Are You Sure?',
                                        text: "Do you want to add this item to cart",
                                        icon: 'warning',
                                        showCancelButton: true,
                                        confirmButtonColor: '#3085d6',
                                        cancelButtonColor: '#d33',
                                        confirmButtonText: 'Yes'
                                    }).then((result) => {
                                        if (result.isConfirmed) {
                                            window.location.href = event.target.offsetParent.children[0].href;
                                        }
                                    })
                                 }
                                </script>	
                            </div>
                        </center>
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