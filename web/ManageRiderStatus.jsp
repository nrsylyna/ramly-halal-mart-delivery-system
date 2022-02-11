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
            th, td {
                padding: 15px;
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
	<!-- header-bot -->
	<%@ include file="RiderNav.jsp" %>
	<!-- //header-bot -->
	<!-- top Products -->
	<div class="ads-grid">
            <div class="container">
                <!-- tittle heading -->
                <h3 class="tittle-w3l">Manage Status
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
                            <table  class="table-responsive">
                                <tr>
                                    <th>Rider Name</th>
                                    <th>:</th>
                                    <td><%=rider.getRiderName()%></td>
                                </tr>                
                                <tr>
                                    <th>Rider Status</th>
                                    <th>:</th>
                                    <td><%=rider.getRiderStatus()%></td>
                                </tr>
                            </table>
                            <center>
                                <c:set var="riderStatus" value="<%=rider.getRiderStatus()%>"/>
                                <c:choose>
                                    <c:when test="${riderStatus.equalsIgnoreCase('Available')}">
                                        <a href="RiderController?action=manageRider&id=<%=rider.getRiderID()%>"><button style="font-size: 17px;" class="btn btn-success">Edit</button></a>
                                    </c:when>
                                    <c:when test="${riderStatus.equalsIgnoreCase('Unavailable')}">
                                        <a href="RiderController?action=manageRider&id=<%=rider.getRiderID()%>"><button style="font-size: 17px;" class="btn btn-success">Edit</button></a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="RiderController?action=manageRider&id=<%=rider.getRiderID()%>"><button style="font-size: 17px;" class="btn btn-success" disabled>Edit</button></a>
                                    </c:otherwise>
                                </c:choose>
                            </center>
                            <c:set var="message" value="${requestScope.successUpdateOrderStatus}"/>
                            <c:if test="${message != null}">  
                                <script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
                                <script>
                                    Swal.fire({
                                        position: 'top-center',
                                        icon: 'success',
                                        title: 'Order Has Been Delivered',
                                        showConfirmButton: false,
                                        timer: 3000
                                    });
                                </script>   
                            </c:if>
                            <c:set var="message" value="${requestScope.successUpdateStatus}"/> 
                            <c:if test="${message != null}">      
                                <script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
                                <script>
                                    Swal.fire({
                                        position: 'top-center',
                                        icon: 'success',
                                        title: 'Successfully Update Status',
                                        showConfirmButton: false,
                                        timer: 3000
                                    });
                                </script>
                           </c:if>
                        </div>
                    </div>
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
</html>
