<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zxx">
    <head>
	<title>Admin</title>
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
                                <tr>
                                    <th>Order Number</th>
                                    <th>Status</th>
                                    <th>Amount</th>
                                    <th>Date</th>
                                    <th>Time</th>
                                    <th colspan="3">Actions</th>
                                </tr>
                                <c:choose>
                                    <c:when test="${empty orders}">
                                        <td colspan="6">
                                            <p style="font-size: 20px; align-content: center;"><b>No Results Found</b></p>
                                        </td>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="order" items="${orders}">
                                            <tr>
                                                <td><c:out value="${order.orderID}"/></td>                                   
                                                <td><c:out value="${order.orderStatus}"/></td>
                                                <td>RM<c:out value="${order.orderTotalPrice}"/></td>
                                                <td><c:out value="${order.orderDeliveryDate}"/></td> 
                                                <td><c:out value="${order.orderDeliveryTime}"/></td>
                                                <td colspan="3">
                                                    <a href="OrderController?action=viewOrderAdmin&id=${order.orderID}" class="btn btn-info" style="font-size:16px;">View</a>
                                                    <a href="OrderController?action=updateOrderAdmin&id=${order.orderID}" class="btn btn-warning" style="font-size:16px;">Update</a>
                                                    <a href="OrderController?action=deleteOrderAdmin&id=${order.orderID}&pId=${order.getPayID()}" class="btn btn-danger" style="font-size:16px;" onclick="del(event)">Delete</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </table>
                            <c:set var="message" value="${requestScope.successDeleteOrder}"/> 
                            <c:if test="${message != null}">        
                                <script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
                                <script>
                                    Swal.fire({
                                        position: 'top-center',
                                        icon: 'success',
                                        title: 'Order Has Been Deleted',
                                        showConfirmButton: false,
                                        timer: 3000
                                    });
                                </script>
                            </c:if>
                            <script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
                            <script>
                                function del(event){
                                    event.preventDefault();   
                                    Swal.fire({
                                        title: 'Are you sure?',
                                        text: "Do you really want to delete this order? This process cannot be undone",
                                        icon: 'warning',
                                        showCancelButton: true,
                                        confirmButtonColor: '#3085d6',
                                        cancelButtonColor: '#d33',
                                        confirmButtonText: 'Yes'
                                    }).then((result) => {
                                        if (result.isConfirmed) {
                                            window.location.href = event.target.offsetParent.children[2].href;
                                        }
                                    })
                                 }
                            </script>
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