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
            input[type=text], input[type=password]{
                width: 90%;
                padding: 12px;
                border: 1px solid #ccc;
                border-radius: 4px;
                resize: vertical;
            }             
            select{
                width: 30%;
                padding: 12px;
                border: 1px solid #ccc;
                border-radius: 4px;
                resize: vertical;
            }
            label {
                padding: 12px 12px 12px 60px;
                display: inline-block;
            }
            th, td {
                padding: 15px;
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
                <h3 class="tittle-w3l">Assign Rider
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
                            <div class="table-responsive">
                                <center>
                                    <table class="table-responsive">
                                        <tr>
                                            <th>Rider ID </th>
                                            <td>:</td>
                                            <td><c:out value="${rider.riderID}" /></td>
                                        </tr>
                                        <tr>
                                            <th>Rider Name </th>
                                            <td>:</td>
                                            <td><c:out value="${rider.riderName}"/></td>
                                        </tr>
                                        <tr>
                                            <th>Order Number </th>
                                            <td>:</td>
                                            <td><c:out value="${order.orderID}"/></td>
                                        </tr>
                                        <tr>
                                            <th>Order Date </th>
                                            <td>:</td>
                                            <td><c:out value="${order.orderDeliveryDate}"/></td>
                                        </tr>
                                        <tr>
                                            <th>Order Time </th>
                                            <td>:</td>
                                            <td><c:out value="${order.orderDeliveryTime}"/></td>
                                        </tr>
                                        <tr>
                                            <th>Order Status </th>
                                            <td>:</td>
                                            <td><c:out value="${order.orderStatus}"/></td>
                                        </tr>
                                    </table>
                                    <br>
                                    <a href="AssignRiderController?action=listOrder&riderID=${rider.riderID}"><button class="btn btn-warnning">Cancel</button></a> 
                                    <a href="AssignRiderController?action=orderConfirmation&riderID=${rider.riderID}&orderID=${order.orderID}"><button class="btn btn-success">Confirm</button></a>
                                </center>                                       
                            </div>
                            <!-- //first section -->
                        </div>
                    </div>
                    <!-- //form -->
		</div>
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