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
                padding: 2px 2px;
                margin-bottom: 14px;
            }
            * {
                box-sizing: border-box;
            }
	</style>
    </head>
    <body>
        <!-- header-bot-->
        <%@ include file="AdminNav.jsp" %>
        <!-- //header-bot -->
	<!-- top Products -->
	<div class="ads-grid">
            <div class="container">
                <!-- tittle heading -->
                <h3 class="tittle-w3l">Payment Details
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
                        <div class="product-sec2"><br>
                            <h3 class="agileinfo_sign">Online payment</h3>
                            <div style="  margin: auto; width: 85%; padding-left: 20%;"><!-- update 15/5/2021 -->
                                <table class="table table-borderless">
                                    <tbody>
                                        <tr>
                                            <th style="color: black" ><b>Order ID</b></th>
                                            <td>:</td>
                                            <td  style="color: black"><c:out value="${payment.orderID}" /></td>
                                        </tr>
                                        <tr>
                                            <th style="color: black" scope="row">Payment ID</th>
                                            <td>:</td>
                                            <td  style="color: black"><c:out value="${payment.payID}" /></td>
                                        </tr>
                                        <tr>
                                            <th style="color: black" scope="row">Payment Amount</th>
                                            <td>:</td>
                                            <td  style="color: black">RM<c:out value="${payment.payAmount}" /></td>
                                        </tr>
                                        <tr>
                                            <th style="color: black" scope="row">Payment Type</th>
                                            <td>:</td>
                                            <td  style="color: black"><c:out value="${payment.payType}" /></td>
                                        </tr>
                                        <tr>
                                            <th style="color: black" scope="row">Payment Status</th>
                                            <td>:</td>
                                            <td  style="color: black"><c:out value="${payment.payStatus}" /></td>
                                        </tr>
                                        <tr>
                                            <th style="color: black" scope="row">Payment Receipt</th>
                                            <td>:</td>
                                            <td><p style="color: #575757;"><img src="data:image/jpg;base64,${payment.base64Image}" height="650"/></p></td>
                                        </tr>
                                    </tbody>
                                </table> 
                            </div>
                            <center>
                                <a href="PaymentController?action=listPayment"> <button class="btn btn-warning"><i class="fa fa-arrow-left" aria-hidden="true"></i> Back</button></a>
                            </center>
                            <br>
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
