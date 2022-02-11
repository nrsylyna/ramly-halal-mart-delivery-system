<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
            .pay-opt {
                display: inline-flex;    
            }
            .pay-opt button {
                margin-left: 5px;
            }
            .product-sec2 {
                box-shadow: 0px 10px 15px 0px #D6D6D6;
                padding: 30px 20px;
                margin-bottom: 14px;
            }
            * {
                box-sizing: border-box;
            }
            label {
                padding: 12px 12px 12px 24px;
                display: inline-block;
                font-weight: normal;
            }
            small {
                font-size: 80%;
            }
            input[type=text], select {
                width: 100%;
                padding: 12px;
                border: 1px solid #ccc;
                border-radius: 4px;
                resize: vertical;
            }
            input[type=tel] {
                width: 100%;
                padding: 12px;
                border: 1px solid #ccc;
                border-radius: 4px;
                resize: vertical;
            }
            .col-25 {
                float: left;
                width: 15%;
                margin-top: 15px;
                margin-left: 15px;
            }
            .col-75 {
                float: left;
                width: 75%;
                margin-top: 15px;
                text-align: left;
             }
            /* Clear floats after the columns */
            .row:after {
                content: "";
                display: table;
                clear: both;
            }
        </style>
    </head>
    <%@page import="ramly.model.Customer"%>
    <%@page import="ramly.model.Cart"%>
    <% Customer cust = (Customer) session.getAttribute("login");
        if(cust == null){
            response.sendRedirect("LoginCustomer.jsp");
        }
    %>
    <body>
        <!-- header-bot-->
	 <%@ include file="CustNav.jsp" %>
	<!-- top Products -->
	<div class="ads-grid">
            <div class="container">
                <!-- tittle heading -->
                <h3 class="tittle-w3l">Payment
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
                            <br>
                            <div class="table-responsive">
                                <table class="timetable_pay">
                                    <tr>
                                        <th> Item ID </th>
                                        <th> Item Name </th>
                                        <th> Unit Price </th>
                                        <th> Quantity </th>
                                        <th> Amount(RM) </th>
                                    </tr>
                                    <c:if test="${cart.lineItemCount == 0}">
                                        <tr> 
                                            <td colspan="4">- Cart is currently empty -</td>
                                        </tr>
                                    </c:if>
                                    <c:forEach var="item" items="${items}">  
                                        <tr>
                                            <td><c:out value="${item.getitemID()}"/></td>
                                            <td><c:out value="${item.getitemName()}"/></td>
                                            <td><c:out value="${item.getiQty()}"/></td>
                                            <td>RM<c:out value="${item.getitemPrice()}"/></td>
                                            <td>RM<fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" value="${item.getitemPrice() * item.getiQty()}"/></td>
                                        </tr>
                                    </c:forEach>
                                    <tr>
                                        <td colspan=4 class="timetable_pay2"> Subtotal </td>
                                        <td>RM <fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" value="${totalprice}"/></b></td>
                                    </tr>
                                    <tr>
                                        <th colspan=4 class="timetable_pay2"> Delivery charge (fix)</th>
                                        <th> RM 5.00 </th>
                                    </tr>
                                    <tr>
                                        <th colspan=4 class="timetable_pay2"><b> TOTAL </b></th>
                                        <th> 
                                            <c:set var="grandtotal" value="${0}"/>
                                            <c:set var="grandtotal" value="${totalprice + 5.0}"/>
                                            RM<fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" value="${grandtotal}"/>
                                        </th>
                                    </tr>		
                                </table>
                                </div>
                                    <div style="background-color: #f9f9f9">
                                    <br>
                                    <p style=" color: #000; font-weight: 600"><span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span> Delivery Address </p>
                                    <form id="ff" name="form1" method="post" action="CustomerController?action=UpdateCustomerAddress&total=${totalprice}">
                                    <input type="text" name="custID" id="custID" value="<%=cust.getCustID()%>" readonly hidden><br>
                                    <div class="row">
                                        <div class="col-25">
                                            <label for="subject">Phone No. :</label>
                                        </div>
                                        <div class="col-75">
                                            <small>Example: "012-3456789" | Maximum 10 digits</small>
                                            <input type="tel" name="custPhone" id="custPhone" pattern="[0-9]{3}-[0-9]{7}" minlength="11" maxlength="11" value="<%=cust.getCustPhone()%>" required>
                                            <br>	
                                        </div>
                                    </div>
                                   <div class="row">
                                        <div class="col-25">
                                            <label for="subject">Address Line :</label>
                                        </div>
                                        <div class="col-75">
                                            <small>Example: "No.1, Street, Area"</small>
                                            <c:set var = "fullAddress" value="<%=cust.getCustAddress()%>"/>
                                            <c:set var="addressLine" value="${fn:split(fullAddress, ',')}" />
                                            <input type="text" id="custAddress" name="custAddress" pattern="^[\w\d./*]{1,},[^\S][\w\d./* ]{1,},[^\S][\w\d./* ]{1,}$"  minlength="5" value="<c:out value="${addressLine[0]}"/><c:out value="${','}"/><c:out value="${addressLine[1]}"/><c:out value="${','}"/><c:out value="${addressLine[2]}"/>" required>
                                            <br>	
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-25">
                                            <label for="subject">Postcode :</label>
                                        </div>
                                        <div class="col-75">
                                            <c:set var="postcodecity" value="${fn:split(addressLine[3], ' ')}" />
                                            <input type="text" id="custPostcode" name="custPostcode" pattern="^[0-9]{0,}$" minlength="5" maxlength="5" value="<c:out value="${postcodecity[0]}"/>" required>
                                            <br>	
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-25">
                                            <label for="subject">City :</label>
                                        </div>
                                        <div class="col-75">
                                            <input type="text" id="custCity" name="custCity" pattern="^\S\D*$" minlength="4" value="<c:out value="${postcodecity[1]}"/>" required>
                                            <br>	
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-25">
                                            <label for="subject">State :</label>
                                        </div>
                                        <div class="col-75">
                                            <select id="custState" name="custState" required>
                                                <option value="Johor" <c:if test="${addressLine[4].equalsIgnoreCase(' Johor')}">selected</c:if>>Johor</option>
                                                <option value="Kedah" <c:if test="${addressLine[4].equalsIgnoreCase(' Kedah')}">selected</c:if>>Kedah</option>
                                                <option value="Kelantan" <c:if test="${addressLine[4].equalsIgnoreCase(' Kelantan')}">selected</c:if>>Kelantan</option>
                                                <option value="Malacca" <c:if test="${addressLine[4].equalsIgnoreCase(' Malacca')}">selected</c:if>>Malacca</option>
                                                <option value="Negeri Sembilan" <c:if test="${addressLine[4].equalsIgnoreCase(' Negeri Sembilan')}">selected</c:if>>Negeri Sembilan</option>
                                                <option value="Pahang" <c:if test="${addressLine[4].equalsIgnoreCase(' Pahang')}">selected</c:if>>Pahang</option>
                                                <option value="Penang" <c:if test="${addressLine[4].equalsIgnoreCase(' Penang')}">selected</c:if>>Penang</option>
                                                <option value="Perak" <c:if test="${addressLine[4].equalsIgnoreCase(' Perak')}">selected</c:if>>Perak</option>
                                                <option value="Perlis" <c:if test="${addressLine[4].equalsIgnoreCase(' Perlis')}">selected</c:if>>Perlis</option>
                                                <option value="Sabah" <c:if test="${addressLine[4].equalsIgnoreCase(' Sabah')}">selected</c:if>>Sabah</option>
                                                <option value="Sarawak" <c:if test="${addressLine[4].equalsIgnoreCase(' Sarawak')}">selected</c:if>>Sarawak</option>
                                                <option value="Selangor" <c:if test="${addressLine[4].equalsIgnoreCase(' Selangor')}">selected</c:if>>Selangor</option>
                                                <option value="Terengganu" <c:if test="${addressLine[4].equalsIgnoreCase(' Terengganu')}">selected</c:if>>Terengganu</option>
                                            </select>
                                            <br>	
                                        </div>
                                    </div>
                                    <center>
                                        <br><br>
                                        <a href="OrderController?action=createOrder&total=${totalprice}" class="btn btn-warning"><i class="fa fa-arrow-left" aria-hidden="true"></i> Back</a>
                                        <input type="submit" value="Update" class="btn btn-success" onclick="formValidation()">
                                        <br><br>
                                    </center>
                                </form>
                                <hr>
                            </div>
                            <script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
                            <script>
                                function formValidation() {
                                    var phone = document.getElementById("custPhone");
                                    var phoneValidity = phone.validity;
                                    var address = document.getElementById("custAddress");
                                    var addressValidity = address.validity;
                                    var city = document.getElementById("custCity");
                                    var cityValidity = city.validity;
                                    var state = document.getElementById("custState");
                                    var stateValidity = state.validity;
                                    var postcode = document.getElementById("custPostcode");
                                    var postcodeValidity = postcode.validity;
                                    
                                    if(phoneValidity.valueMissing) {
                                        phone.setCustomValidity("Please fill out this field!");
                                    }
                                    else if(phoneValidity.patternMismatch) {
                                        phone.setCustomValidity("Must contain 10 digits, has dash (-) character and please use the correct format! Example: xxx-xxxxxxx ");
                                    }
                                    else if(phoneValidity.tooLong) {
                                        phone.setCustomeValidity("Phone number entered exceeds 11 digits!");
                                    }
                                    else if(phoneValidity.tooShort) {
                                        phone.setCustomeValidity("Phone number entered subceeds 11 digits!");
                                    }
                                    else {
                                        phone.setCustomValidity("");
                                    }
                                    
                                    if(addressValidity.valueMissing) {
                                        address.setCustomValidity("Please fill out this field!");
                                    }
                                    else if(addressValidity.patternMismatch) {
                                        address.setCustomValidity("Please use the correct format! Example: No.1, Street, Area");
                                    }
                                    else if(addressValidity.tooShort) {
                                        address.setCustomValidity("Must be atleast 5 characters!");
                                    }
                                    else {
                                        address.setCustomValidity("");
                                    }
                                    
                                    
                                    if(cityValidity.valueMissing) {
                                        city.setCustomValidity("Please fill out this field!");
                                    }
                                    else if(cityValidity.patternMismatch) {
                                        city.setCustomValidity("Must be letters only!");
                                    }
                                    else if(cityValidity.tooShort) {
                                        city.setCustomValidity("Must be atleast 4 characters!");
                                    }
                                    else {
                                        city.setCustomValidity("");
                                    }
                                    
                                    if(stateValidity.valueMissing) {
                                        state.setCustomValidity("Please fill out this field!");
                                    }
                                    else {
                                        state.setCustomValidity("");
                                    }
                                    
                                    if(postcodeValidity.valueMissing) {
                                        postcode.setCustomValidity("Please fill out this field!");
                                    }
                                    else if(postcodeValidity.patternMismatch) {
                                        postcode.setCustomValidity("Must be digits only!");
                                    }
                                    else if(postcodeValidity.tooLong) {
                                        postcode.setCustomeValidity("Postcode entered exceeds 5 digits!");
                                    }
                                    else if(postcodeValidity.tooShort) {
                                        postcode.setCustomeValidity("Must be 5 digits!");
                                    }
                                    else {
                                        postcode.setCustomValidity("");
                                    }
   
                                    phone.reportValidity();
                                    address.reportValidity();
                                    city.reportValidity();
                                    state.reportValidity();
                                    postcode.reportValidity();
                                }
                                function showPassword() {
                                    var password = document.getElementById("custPassword")

                                    if(password.type === "password") {
                                        password.type = "text";
                                    }
                                    else {
                                        password.type = "password";
                                    }
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
        <%@ include file="custFooter.html" %>
	<!-- //footer -->
	<!-- copyright -->
	<div class="copy-right">
        <div class="container">
            <p>© 2021 Ramly Halal Mart. All rights reserved | Design by Zephyr.</p>
        </div>
	</div>
	<!-- //copyright -->
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