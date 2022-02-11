<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
            input[type=text], input[type=password]{
                width: 90%;
                padding: 12px;
                border: 1px solid #ccc;
                border-radius: 4px;
                resize: vertical;
            }
            label {
                padding: 12px 12px 12px 60px;
                display: inline-block;
            }
            input[type=reset], input[type=submit] {
                background-color: #644334;
                color: white;
                padding: 12px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                float: center;
                width: 20%;
            }
            input[type=reset]:hover, input[type=submit]:hover {
                background-color: #462f25;
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
        <!-- header-bot-->
        <%@ include file="CustNav.jsp" %>
	<div class="ads-grid">
            <div class="container">
                <!-- tittle heading -->
                <h3 class="tittle-w3l">RECEIPT
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
                            <p align="center" style="color: #000000;"> Your order will be ready after our representative validate your payment.</p>
                            <p align="center" style="color: #000000;"> Thank you for Shopping with us!</p>
                            <div class="table-responsive">
                                <p style="color: #575757;"><b>Order ID:</b> <c:out value="${orderdelivery.orderID}"/></p>
                                <p style="color: #575757;"><b>Payment ID:</b> <c:out value="${payment.payID}"/></p>
                                <p style="color: #575757;"><b>Payment Type:</b> <c:out value="${payment.payType}"/></p>
                                <p style="color: #575757;"><b>Payment Status:</b> <c:out value="${payment.payStatus}"/></p><br>
                                <p style="color: #575757;"><b>Name:</b> <%=cust.getCustName()%></p>
                                <p style="color: #575757;"><b>Phone No.:</b> <%=cust.getCustPhone()%></p>
                                <p style="color: #575757;"><b>Address:</b> <%=cust.getCustAddress()%></p><br>
                                <table class="timetable_pay">
                                    <tr>
                                        <th> Item Name </th>
                                        <th> Unit Price </th>
                                        <th> Quantity </th>
                                        <th> Amount(RM)</th>
                                    </tr>
                                    <c:forEach items="${receipts}" var="receipt">
                                        <tr>
                                            <td><c:out value="${receipt.itemName}"/></td>     
                                            <td><c:out value="${receipt.itemPrice}"/></td>    
                                            <td><c:out value="${receipt.cartQty}"/></td>
                                            <td><c:out value="${receipt.cartTotal}"/></td>
                                        </tr>
                                    </c:forEach>
                                    <tr>
                                        <td colspan=3 class="timetable_pay2"> Subtotal </td>
                                        <td><c:out value="${orderdelivery.orderTotalPrice}"/></td>
                                    </tr>
                                    <tr>
                                        <th colspan=3 class="timetable_pay2"> Delivery charge (fix)</th>
                                        <th> RM 5.00 </th>
                                    </tr>
                                    <tr>
                                        <th colspan=3 class="timetable_pay2"><b>TOTAL PRICE</b></th>
                                        <th><b><c:out value="${payment.payAmount}"/></b></th>
                                    </tr>		
                                </table>
                            </div>
                            <p style="color: #000000;"> Date: <c:out value="${orderdelivery.orderDeliveryDate}"/></p>
                            <p style="color: #000000;"> Time: <c:out value="${orderdelivery.orderDeliveryTime}"/></p>
                            <br><br>
                            <center>
                                <a href="OrderController?action=trackOrder&id=<%=cust.getCustID()%>"><button class="btn btn-warning"><i class="fa fa-arrow-left" aria-hidden="true"></i> Back</button></a>
                            </center>    
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
