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
            input[type=submit] {
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
    <%@page import="ramly.model.Admin"%>
    <% Admin admin = (Admin) session.getAttribute("login");
        if(admin == null){
            response.sendRedirect("LoginAdmin.jsp");
        }
    %>
    <body onload="resetFilter()">
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
                            <center>
                                <form name="form1" onsubmit="setFilter()" method="post" id="ff" action="AssignRiderController">
                                    <select id="filter" name="filter">
                                        <option>All</option>
                                        <option>Available</option>
                                        <option>Unavailable</option>
                                        <option>Delivering</option>
                                    </select>
                                    <input type="submit" value="Filter">
                                </form>
                                <br> 
                                <table class="timetable_pay">
                                    <tr>
                                        <th>ID</th>
                                        <th>Name</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                    <c:forEach items="${riders}" var="rider">
                                        <tr>
                                            <td><c:out value="${rider.riderID}"/></td>
                                            <td><c:out value="${rider.riderName}"/></td>
                                            <td><c:out value="${rider.riderStatus}"/></td>
                                            <c:choose>
                                                <c:when test="${rider.riderStatus.equalsIgnoreCase('Available')}">
                                                    <td>
                                                        <a href="AssignRiderController?action=listOrder&riderID=${rider.riderID}"><button class="btn btn-success">Assign</button></a>
                                                    </td>
                                                </c:when>
                                                <c:otherwise>
                                                    <td>
                                                        <button class="btn btn-danger" disabled>Assign</button>
                                                    </td>
                                                </c:otherwise>
                                            </c:choose>
                                        </tr>
                                    </c:forEach>
                                </table>
                            </center> 
                            <br> 
                            <c:set var="message" value="${requestScope.successAssignRider}"/> 
                            <c:if test="${message != null}">   
                                <script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
                                <script>
                                    Swal.fire({
                                        position: 'top-center',
                                        icon: 'success',
                                        title: 'Rider Has Been Assigned',
                                        showConfirmButton: false,
                                        timer: 3000
                                    });
                                </script>
                            </c:if>
                            <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
                            <script>
                                function setFilter(){
                                    var value = document.getElementById('filter').value;
                                    localStorage.setItem("select", value); 
                                }
                                
                                function getFilter(){
                                    if (localStorage.getItem("select") != null) {// Check if there is selected date. 
                                          return localStorage.getItem("select");
                                    }
                                    else {
                                        return "All";
                                    }
                                }
                                
                                document.getElementById('filter').value = getFilter();
                                 
                                function resetFilter() {
                                   localStorage.removeItem("select");
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