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
            * {
                box-sizing: border-box;
            }
            label {
                padding: 12px 12px 12px 60px;
                display: inline-block;
            }
            th, td {
                padding: 15px;
            }
            .search-Fill {
                width: 30%;
                padding: 12px;
                border: 1px solid #ccc;
                border-radius: 4px;
                resize: vertical;
            }
            .submit-Search {
                background-color: #644334;
                color: white;
                padding: 12px 18px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                float: center;
                width: 20%;
            }
            .filter-Fill {
                padding: 12px;
                border: 1px solid #ccc;
                border-radius: 4px;
                resize: vertical;
            }
            .submit-Filter {
                background-color: #644334;
                color: white;
                padding: 12px 18px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }
            input[type=submit]:hover {
                background-color: #462f25;
            }
	</style><!-- UPDATE 26/6/2021  -->
    </head>
    <body onload="resetFilter()">
	<!-- header-bot-->
        <%@ include file="AdminNav.jsp" %>
        <!-- //header-bot -->
	<!-- top Products -->
	<div class="ads-grid">
            <div class="container">
                <!-- tittle heading -->
                <h3 class="tittle-w3l">Payment List
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
                                <form method="post" action="PaymentController?action=searchID">
                                    <input type="search" id="searchOrder" name="searchOrder" placeholder= "Enter order ID to search order" class="search-Fill">
                                    <input type="submit" value="Search" class="submit-Search">
                                </form>
                            </center>
                            <br>
                            <form method="post" action="PaymentController?action=filterItem" onsubmit="setFilter()">
                                <select name="filter" id="filter" class="filter-Fill">
                                    <option>All</option>
                                    <option>COD</option>
                                    <option>Online Payment</option>
                                    <option>Paid</option>
                                    <option>Unpaid</option>
                                </select>
                                <input type="submit" value="Filter" class="submit-Filter">
                            </form>
                            <br>
                            <table class="timetable_pay">
                                <tr>
                                    <th>Order ID</th>
                                    <th>Payment Amount(RM)</th>
                                    <th>Payment Type</th>
                                    <th>Payment Status</th>
                                    <th colspan="3">Actions</th>
                                </tr>
                                <c:choose>
                                    <c:when test="${empty payments}">
                                        <td colspan="5">
                                            <p style="font-size: 20px; align-content: center;"><b>No Results Found</b></p>
                                        </td>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="payment" items="${payments}">
                                            <tr>
                                                <td><c:out value="${payment.orderID}"/></td>                                  
                                                <td><c:out value="${payment.payAmount}"/></td>
                                                <td><c:out value="${payment.payType}"/></td>
                                                <td><c:out value="${payment.payStatus}"/></td> 
                                                <td colspan="3">
                                                    <a href="PaymentController?action=viewPayment&id=${payment.payID}" class="btn btn-info" style="font-size:16px;">View</a>
                                                    <a href="PaymentController?action=updatePayment&id=${payment.payID}" class="btn btn-warning" style="font-size:16px;">Update</a>
                                                    <a href="PaymentController?action=deletePayment&id=${payment.payID}" class="btn btn-danger" style="font-size:16px;" onclick="del(event)">Delete</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </table>
                            <c:set var="message" value="${requestScope.successUpdatePayment}"/> 
                            <c:if test="${message != null}">        
                                <script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
                                <script>
                                    Swal.fire({
                                        position: 'top-center',
                                        icon: 'success',
                                        title: 'Successfully Update Payment',
                                        showConfirmButton: false,
                                        timer: 3000
                                    });
                                </script>
                            </c:if>
                            <c:set var="message" value="${requestScope.successDeletePayment}"/> 
                            <c:if test="${message != null}">        
                                <script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
                                <script>
                                    Swal.fire({
                                        position: 'top-center',
                                        icon: 'success',
                                        title: 'Payment Has Been Deleted',
                                        showConfirmButton: false,
                                        timer: 3000
                                    });
                                </script>
                            </c:if>
                            <script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
                            <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
                            <script>
                                function setFilter(){
                                    var value = document.getElementById('filter').value;
                                    localStorage.setItem("select", value); 
                                }                                
                                function getFilter(){
                                    if(localStorage.getItem("select") != null) {
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
                                function del(event){
                                    event.preventDefault();   
                                    Swal.fire({
                                        title: 'Are you sure?',
                                        text: "Do you really want to delete this payment? This process cannot be undone",
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
	<!-- footer -->
	<!-- //footer -->
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