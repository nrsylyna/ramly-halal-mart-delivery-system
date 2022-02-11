<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	</style>
    </head>
    <%@page import="ramly.model.Admin"%>
    <% Admin admin = (Admin) session.getAttribute("login");
        if(admin == null){
            response.sendRedirect("LoginAdmin.jsp");
        }
    %>
    <body>
	<!-- header-bot-->
        <%@ include file="AdminNav.jsp" %>
	<!-- //header-bot -->
	<!-- top Products -->
	<div class="ads-grid">
            <div class="container">
                <!-- tittle heading -->
                <h3 class="tittle-w3l">Order Details
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
                            <div style="  margin: auto; width: 70%; padding-left: 10%; padding-right: 10%;">
                                <table class="table table-borderless">
                                    <tbody>
                                        <tr>
                                            <th style="color: black" ><b>Order Number</b></th>
                                            <td>:</td>
                                            <td  style="color: black"><c:out value="${order.orderID}" /></td>
                                        </tr>
                                        <tr>
                                            <th style="color: black" scope="row">Status</th>
                                            <td>:</td>
                                            <td  style="color: black"><c:out value="${order.orderStatus}" /></td>
                                        </tr>
                                        <tr>
                                            <th style="color: black" scope="row">Amount</th>
                                            <td>:</td>
                                            <td  style="color: black">RM<c:out value="${order.orderTotalPrice}" /></td>
                                        </tr>
                                        <tr>
                                            <th style="color: black" scope="row">Date</th>
                                            <td>:</td>
                                            <td  style="color: black"><c:out value="${order.orderDeliveryDate}" /></td>
                                        </tr>
                                        <tr>
                                            <th style="color: black" scope="row">Time</th>
                                            <td>:</td>
                                            <td style="color: black"><c:out value="${order.orderDeliveryTime}" /></td>
                                        </tr>
                                        <tr>
                                            <th style="color: black" scope="row">Customer Name</th>
                                            <td>:</td>
                                            <td  style="color: black"><c:out value="${customer.custName}" /></td>
                                        </tr>
                                        <tr>
                                            <th style="color: black" scope="row">Customer Phone Number</th>
                                            <td>:</td>
                                            <td  style="color: black"><c:out value="${customer.custPhone}" /></td>
                                        </tr>
                                        <tr>
                                            <th style="color: black" scope="row">Customer Address</th>
                                            <td>:</td>
                                            <td  style="color: black"><c:out value="${customer.custAddress}" /></td>
                                        </tr>
                                        <tr>
                                            <th style="color: black" scope="row">Items</th>
                                            <td>:</td>
                                            <td  style="color: black"></td>
                                        </tr>
                                    </tbody>
                                </table>
                                <table class="timetable_pay">
                                    <thead>
                                        <tr>
                                            <th>Item ID</th>
                                            <th>Item Name</th>
                                            <th>Quantity</th>
                                            <th>Total</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${carts}" var="cart">
                                            <tr>
                                                <td><c:out value="${cart.itemID}" /></td>     
                                                <td><c:out value="${cart.itemName}" /></td>    
                                                <td><c:out value="${cart.cartQty}" /></td>
                                                <td>RM<c:out value="${cart.cartTotal}" /></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <br>
                            <center>
                                <a href="OrderController?action=listOrderAdmin"><button class="btn btn-warning"><i class="fa fa-arrow-left" aria-hidden="true"></i> Back</button></a>
                            </center>
                            <c:set var="message" value="${requestScope.successUpdateOrder}"/> 
                            <c:if test="${message != null}">        
                                <script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
                                <script>
                                    Swal.fire({
                                        position: 'top-center',
                                        icon: 'success',
                                        title: 'Successfully Update Order',
                                        showConfirmButton: false,
                                        timer: 3000
                                    });
                                </script>
                            </c:if>
                        </div>
                        <!-- //first section -->
                    </div>
                </div>
                <!-- //form -->
            </div>
	</div>
	<!-- //top products -->
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