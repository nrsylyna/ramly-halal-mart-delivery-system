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
    <%@page import="ramly.model.Rider"%>
    <% Rider rider = (Rider) session.getAttribute("login");
        if(rider == null){
            response.sendRedirect("LoginRider.jsp");
        }
    %>
    <body>
        <!-- header-bot-->
        <%@ include file="RiderNav.jsp" %>
	<!-- //header-bot -->
	<!-- top Products -->
	<div class="ads-grid">
            <div class="container">
                <!-- tittle heading -->
                <h3 class="tittle-w3l">Customer Order
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
                                <thead>
                                    <tr>
                                        <th>Order Number</th>
                                        <th>Status</th>
                                        <th>Amount</th>
                                        <th>Date</th>
                                        <th>Time</th>
                                        <th colspan="2">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="order" items="${orders}">
                                        <c:choose>
                                            <c:when test="${order.orderStatus.equalsIgnoreCase('Delivering')}">
                                                <tr>
                                                    <td><c:out value="${order.orderID}" /></td>                                   
                                                    <td><c:out value="${order.orderStatus}" /></td>
                                                    <td>RM<c:out value="${order.orderTotalPrice}" /></td>
                                                    <td><c:out value="${order.orderDeliveryDate}" /></td> 
                                                    <td><c:out value="${order.orderDeliveryTime}" /></td>
                                                    <td>
                                                        <a href="OrderController?action=viewOrderRider&id=${order.orderID}"><button class="btn btn-info">View</button></a> 
                                                        <a href="OrderController?action=updateOrderRider&id=${order.orderID}"><button class="btn btn-warning">Update</button></a>
                                                    </td>
                                                </tr>
                                            </c:when>
                                            <c:otherwise>
                                                <tr>
                                                    <td><c:out value="${order.orderID}" /></td>                                   
                                                    <td><c:out value="${order.orderStatus}" /></td>
                                                    <td>RM<c:out value="${order.orderTotalPrice}" /></td>
                                                    <td><c:out value="${order.orderDeliveryDate}" /></td> 
                                                    <td><c:out value="${order.orderDeliveryTime}" /></td>
                                                    <td>
                                                        <a href="OrderController?action=viewOrderRider&id=${order.orderID}"><button class="btn btn-info">View</button></a> 
                                                        <a href="OrderController?action=updateOrderRider&id=${order.orderID}"><button class="btn btn-warning" disabled>Update</button></a>
                                                    </td>
                                                </tr>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <c:set var="message" value="${requestScope.orders}"/>
                            <c:if test="${message.isEmpty()}">  
                                <script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
                                <script>
                                    Swal.fire({
                                        position: 'top-center',
                                        icon: 'warning',
                                        title: 'No Orders To Display',
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