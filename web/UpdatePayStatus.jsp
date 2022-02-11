<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zxx">
    <head>
	<title>Admin</title>
	<!--/tags -->
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="keywords" content="Grocery Shoppy Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, 
	Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
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
            label {
              padding: 12px 12px 12px 60px;
              display: inline-block;
            }
            input[type=text], select{
              width: 90%;
              padding: 12px;
              border: 1px solid #ccc;
              border-radius: 4px;
              resize: vertical;
            }
            input:focus {
                outline: none;
            }
            input[readonly] {
                color: graytext;
                background: buttonface;
                outline: none;
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
                <h3 class="tittle-w3l">Update Payment Details
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
                            <form id="ff" name="form1" method="post" action="PaymentController?action=updatePay">
                                <div class="row">
                                    <div class="col-25">
                                        <label>Order ID</label>
                                    </div>
                                    <center>
                                        <div class="col-75">
                                            <input type="text" name="orderID" id="orderID" value="<c:out value="${payment.orderID}"/>" readonly/>
                                        </div>
                                    </center>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-25">
                                        <label>Payment ID</label>
                                    </div>
                                    <center>
                                        <div class="col-75">
                                            <input type="text" name="payID" id="payID" value="<c:out value="${payment.payID}"/>" readonly/>
                                        </div>
                                    </center>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-25">
                                        <label>Payment Amount (RM)</label>
                                    </div>
                                    <center>
                                        <div class="col-75">
                                            <input type="text" name="payAmount" id="payAmount" value="<c:out value="${payment.payAmount}"/>" readonly/>
                                        </div>
                                    </center>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-25">
                                        <label>Payment Type</label>
                                    </div>
                                    <center>
                                        <div class="col-75">
                                            <input type="text" name="payType" id="payType" value="<c:out value="${payment.payType}"/>" readonly/>
                                        </div>
                                    </center>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-25">
                                        <label>Payment Status</label>
                                    </div>
                                    <center>
                                        <div class="col-75">
                                            <select name="payStatus">
                                                <option value="UNPAID">UNPAID</option>
                                                <option value="PAID">PAID</option>
                                            </select>
                                        </div>
                                    </center>
                                </div>
                                <br><br>
                                <input type="hidden" name="adminID" id="adminID" value="<%=admin.getAdminID()%>" />
                                <div class="row">
                                    <br>		   
                                </div>
                                <div class="row" align="center">
                                    <a href="PaymentController?action=listPayment" class="btn btn-warning"><i class="fa fa-arrow-left" aria-hidden="true"></i> Back</a>    
                                    <input type="submit" value="Update" class="btn btn-success">
                                </div>
                            </form>
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