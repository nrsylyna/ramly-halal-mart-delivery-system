<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="ISO-8859-1">
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
            ::before, ::after {
            box-sizing: border-box;
            }
            .section {
                min-height: 100vh;
                display:block;
                padding: 0 400px;
            }
            .section .container {
                padding-top: 40px;
                padding-bottom: 70px;
            }
            .padd-15 {
                padding-left:-1px;
                padding-right: 1px;
            }
            .col-25 {
                float: left;
                width:15%;
                margin-top: 15px;
                margin-left: 30px;
            }
            .col-75 {
                float: left;
                width: 70%;
                margin-top: 15px;
                text-align: center;
            }
            /* Clear floats after the columns */
            .row:after {
                content: "";
                display: table;
                clear: both;
            }
            input[type=text]{
                width: 100%;
                padding: 12px;
                border: 1px solid #ccc;
                border-radius: 4px;
                resize: vertical;
            }
            input[readonly] {
                color: graytext;
                background: buttonface;
                outline: none;
            }
            label {
                padding: 12px 12px 12px 0;
                display: inline-block;
            }
            .product-sec2 {
                box-shadow: 0px 10px 15px 0px #D6D6D6;
                padding: 0px;
                margin-bottom: 14px;
            }
            select { 
                outline: 3; 
                background: #ffffff ; 
                background-image: none; 
                width: 100%; 
                height: 200%; 
                color: black; 
                cursor: pointer; 
                border: 1px solid #ccc;
                border-radius: 4px; 
            } 
            .select { 
                position: relative; 
                display: block; 
                height:2.8em; 
                line-height:3; 
                border-radius: .25em; 
                padding-bottom:20px; 
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
                <h3 class="tittle-w3l">Update Status
                    <span class="heading-style">
                        <i></i>
                        <i></i>
                        <i></i>
                    </span>
                </h3>
                <!-- //tittle heading -->
                <br><br>
                <div class="product-sec2"><br>
                    <center>
                        <div class="card">
                            <div class="card-body">           
                                <form name="formsttatus" method="post" id="ff" action="RiderController?action=manageStatus">
                                    <div class="row">
                                        <div class="col-25">
                                            <label for="name">Rider Name:</label>
                                        </div>	
                                        <div class="col-75">
                                            <input type="text" name="riderName" id="riderName" value="<%=rider.getRiderName()%>" readonly><br>
                                            <input type="text" name="riderID" id="riderID" value="<%=rider.getRiderID()%>" hidden><br>	
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-25">
                                            <label for="name">Rider Status:</label>
                                        </div>	
                                        <div class="col-75">
                                            <div class="select"> 
                                                <select name="status" required>
                                                    <option value="">Select status</option>
                                                    <option value="Available">Available</option>
                                                    <option value="Unavailable">Unavailable</option>
                                                </select>
                                            </div>                                    
                                        </div>
                                    </div>
                                    <br> 
                                    <center>
                                        <a style="font-size: 17px;" href="ManageRiderStatus.jsp" class="btn btn-warning"><i class="fa fa-arrow-left" aria-hidden="true"></i> Back</a>
                                        <input style="font-size: 17px;" type="submit" value="Update" class="btn btn-success">
                                    </center>
                                    <br><br>
                                </form>
                            </div>
                        </div>
                    </center>
                </div>
            </div>
        </div>       
	<!-- js-files -->
	<!-- jquery -->
	<script src="js/jquery-2.1.4.min.js"></script>
	<!-- //jquery -->
	<!-- for bootstrap working -->
	<script src="js/bootstrap.js"></script>
	<!-- //for bootstrap working -->
	<!-- //js-files -->
    </body>
</html>`