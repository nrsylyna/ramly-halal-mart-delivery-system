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
            table {
                border-collapse: collapse;
                width: 100%;
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
        <c:set var="order" value="${requestScope.orders}"/> 
        <c:if test="${order.isEmpty()}">      
            <script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
            <script>
                Swal.fire({
                    position: 'top-center',
                    icon: 'warning',
                    title: 'No orders to track',
                    showConfirmButton: false,
                    timer: 5000
                });
            </script>
        </c:if>
	<!-- header-bot-->
	<%@ include file="CustNav.jsp" %>
	<!-- //header lists -->
	<!-- top Products -->
	<div class="ads-grid">
            <div class="container">
                <!-- tittle heading -->
                <h3 class="tittle-w3l">Track Order
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
                            <table class="timetable_pay">
                                <tr>
                                    <th>Order ID</th>
                                    <th>Order Status</th>
                                    <th>Order Total Price</th>
                                    <th>Order Date</th>
                                    <th>Order Time</th>
                                    <th colspan="2">Action</th>
                                </tr>
                                <c:forEach items="${orders}" var="order">
                                    <tr>
                                        <td><c:out value="${order.orderID}" /></td>                                   
                                        <td><c:out value="${order.orderStatus}" /></td>
                                        <td><c:out value="${order.orderTotalPrice}" /></td>
                                        <td><c:out value="${order.orderDeliveryDate}" /></td>
                                        <td><c:out value="${order.orderDeliveryTime}" /></td> 
                                        <td>
                                            <a href="PaymentController?action=viewReceipt&id=${order.payID}"><button class="btn btn-info" style="font-size:16px;">View Receipt</button></a>
                                            <c:choose>
                                                <c:when test="${order.orderStatus.equalsIgnoreCase('Delivering')}"> 
                                                    <a href="AssignRiderController?action=viewRider&orderID=${order.orderID}&riderID=${order.riderID}"><button class="btn btn-warning" style="font-size:16px;">View Rider</button></a>
                                                </c:when>
                                                <c:otherwise>
                                                    <button class="btn btn-warning" style="font-size:16px;" disabled>View Rider</button>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>	  
                            </table>
                            <c:set var="message" value="${requestScope.successPayOrder}"/> 
                            <c:if test="${message != null}">      
                                <script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
                                <script>
                                    Swal.fire({
                                        position: 'top-center',
                                        icon: 'success',
                                        title: 'Order Has Been Placed',
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