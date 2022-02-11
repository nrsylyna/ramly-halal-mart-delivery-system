<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
	<!-- header-bot-->
	<%@ include file="CustNav.jsp" %>
	<!-- //header lists -->
	<!-- top Products -->
	<div class="ads-grid">
            <div class="container">
                <!-- tittle heading -->
                <h3 class="tittle-w3l">Customer
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
                            <h3 class="agileinfo_sign">View Rider</h3>
                            <div style="  margin: auto; width: 70%; padding-left: 10%; padding-right: 10%;">
                                <table class="table table-borderless">
                                    <tbody>
                                        <tr>
                                            <th style="color: black" ><b>Order ID</b></th>
                                            <td>:</td>
                                            <td  style="color: black"><c:out value="${order.orderID}" /></td>
                                        </tr>
                                        <tr>
                                            <th style="color: black" ><b>Rider Name</b></th>
                                            <td>:</td>
                                            <td  style="color: black"><c:out value="${rider.riderName}" /></td>
                                        </tr>
                                        <tr>
                                            <th style="color: black" scope="row">Rider Phone Number</th>
                                            <td>:</td>
                                            <td  style="color: black"><c:out value="${rider.riderPhone}" /></td>
                                        </tr>
                                        <tr>
                                            <th style="color: black" scope="row">Rider Plate Number</th>
                                            <td>:</td>
                                            <td  style="color: black"><c:out value="${rider.riderPlate}" /></td>
                                        </tr>
                                    </tbody>
                                </table>
                                <center>
                                    <a href="OrderController?action=trackOrder&id=<%=cust.getCustID()%>"><button class="btn btn-warning"><i class="fa fa-arrow-left" aria-hidden="true"></i> Back</button></a>
                                </center>
                            </div>
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