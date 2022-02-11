<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
                <h3 class="tittle-w3l">Item List
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
                            <!-- untuk keluarkan semua image-->
                            <a href="AddItem.jsp"><button class="btn btn-success" ><span class="fa fa-plus-circle" aria-hidden="true"></span> Add New Item</button></a>
                            <br><br>
                            <table class="timetable_pay">                     
                                <tr>      
                                    <th>Item ID</th>
                                    <th>Item Image</th>
                                    <th>Item Name</th>
                                    <th>Item Price</th>
                                    <th>Quantity</th>
                                    <th>Type</th>
                                    <th>Description</th>
                                    <th colspan="3">Actions</th>
                                </tr> 
                                <c:forEach items="${itemAll}" var="item">
                                    <tr>
                                        <td><c:out value="${item.itemID}"/></td> 
                                        <td><img src="data:image/jpg;base64,${item.base64Image}" width="90" height="150"/></td>                               
                                        <td><c:out value="${item.itemName}"/></td>
                                        <td><c:out value="${item.itemPrice}"/></td>
                                        <td><c:out value="${item.itemQty}"/></td>
                                        <td><c:out value="${item.itemType}"/></td> 
                                        <td><c:out value="${item.itemDescription}"/></td> 
                                        <td colspan="3">
                                            <a href="ItemController?action=updateItem&id=<c:out value="${item.itemID}"/>"><button class="btn btn-warning">Update</button></a>
                                            <a href="ItemController?action=deleteItem&id=<c:out value="${item.itemID}"/>"><button class="btn btn-danger" onclick="del(event)">Delete</button></a>
                                        </td>
                                    </tr>
                                </c:forEach> 
                            </table>
                            <c:set var="message" value="${requestScope.successAddItem}"/> 
                            <c:if test="${message != null}">      
                                <script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
                                <script>
                                    Swal.fire({
                                        position: 'top-center',
                                        icon: 'success',
                                        title: 'Successfully Add Item',
                                        showConfirmButton: false,
                                        timer: 3000
                                    });
                                </script>
                            </c:if>
                            <c:set var="message" value="${requestScope.successUpdateItem}"/> 
                            <c:if test="${message != null}">      
                                <script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
                                <script>
                                    Swal.fire({
                                        position: 'top-center',
                                        icon: 'success',
                                        title: 'Successfully Update Item',
                                        showConfirmButton: false,
                                        timer: 3000
                                    });
                                </script>
                            </c:if>
                            <c:set var="message" value="${requestScope.successDeleteItem}"/> 
                            <c:if test="${message != null}">      
                                <script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
                                <script>
                                    Swal.fire({
                                        position: 'top-center',
                                        icon: 'success',
                                        title: 'Item Has Been Deleted',
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
                                        text: "Do you really want to delete this item? This process cannot be undone",
                                        icon: 'warning',
                                        showCancelButton: true,
                                        confirmButtonColor: '#3085d6',
                                        cancelButtonColor: '#d33',
                                        confirmButtonText: 'Yes'
                                    }).then((result) => {
                                        if (result.isConfirmed) {
                                            window.location.href = event.target.offsetParent.children[1].href;
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