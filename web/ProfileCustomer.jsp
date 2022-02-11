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
            label {
              padding: 12px 12px 12px 60px;
              display: inline-block;
            }
            input[type=text], input[type=password]{
                width: 90%;
                padding: 12px;
                border: 1px solid #ccc;
                border-radius: 4px;
                resize: vertical;
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
            th, td {
                padding: 15px;
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
                <h3 class="tittle-w3l">Profile
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
                            <!-- form -->
                            <table  class="table-responsive">
                                <tr>
                                    <th>User ID</th>
                                    <td>:</td>
                                    <td><%=cust.getCustID()%></td>
                                </tr>
                                <tr>
                                    <th>Name</th>
                                     <td>:</td>
                                    <td><%=cust.getCustName()%></td>
                                </tr>
                                <tr>
                                    <th>No. Phone</th>
                                     <td>:</td>
                                    <td><%=cust.getCustPhone()%></td>
                                </tr>
                                <tr>
                                    <th>Email</th>
                                     <td>:</td>
                                    <td><%=cust.getCustEmail()%></td>
                                </tr>
                                <tr>
                                    <th>Address</th>
                                     <td>:</td>
                                    <td><%=cust.getCustAddress()%></td>
                                </tr>
                                <tr>
                                   <th>Username</th>
                                    <td>:</td>
                                   <td><%=cust.getCustUsername()%></td>
                                </tr>    
                            </table>
                            <center>
                                <a href="CustomerController?action=updateCustomer&id=<%=cust.getCustID()%>"><button class="btn btn-success" style="font-size: 17px;">Edit</button></a>
                            </center>
                            <c:set var="message" value="${requestScope.successUpdateProfile}"/> 
                            <c:if test="${message != null}">      
                                <script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
                                <script>
                                    Swal.fire({
                                        position: 'top-center',
                                        icon: 'success',
                                        title: 'Successfully Update Profile',
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