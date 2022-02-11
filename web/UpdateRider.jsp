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
                margin-left: 15px;
            }
            .col-75 {
                float: left;
                width: 80%;
                margin-top: 15px;
                text-align: left;
            }
            /* Clear floats after the columns */
            .row:after {
                content: "";
                display: table;
                clear: both;
            }
            input[type=text], input[type=password], input[type=email], input[type=tel], textarea{
                width: 100%;
                padding: 12px;
                border: 1px solid #ccc;
                border-radius: 4px;
                resize: vertical;
            }
            input[type=checkbox] {
                margin: 12px 12px 12px 200px;
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
            small {
                font-size: 80%;
            }
            .product-sec2 {
                box-shadow: 0px 10px 15px 0px #D6D6D6;
                padding: 0px;
                margin-bottom: 14px;
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
                <h3 class="tittle-w3l">Update profile
                    <span class="heading-style">
                        <i></i>
                        <i></i>
                        <i></i>
                    </span>
                </h3>
                <!-- //tittle heading -->
                <div class="product-sec2">
                    <br>
                    <div class="card">
                        <div class="card-body">           
                            <form method="post" action="RiderController?action=updateRider">
                                <center>
                                    <div class="row">
                                        <div class="col-25">
                                            <label for="name">User ID :</label>
                                        </div>	
                                        <div class="col-75">
                                            <input type="text" name="riderID" id="riderID" value="<%=rider.getRiderID()%>" readonly><br>	
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-25">
                                            <label for="name">Name:</label>
                                        </div>	
                                        <div class="col-75">
                                            <input type="text" name="riderName" id="riderName" pattern="[a-zA-Z ]+" value="<%=rider.getRiderName()%>" required><br>	
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-25">
                                            <label for="name">No. Phone:</label>
                                        </div>
                                        <div class="col-75">
                                            <small>Example: "012-3456789" | Maximum 10 digits</small>
                                            <input type="tel" name="riderPhone" id="riderPhone" pattern="[0-9]{3}-[0-9]{7}" minlength="11" maxlength="11" value="<%=rider.getRiderPhone()%>" required><br>
                                        </div>
                                     </div>
                                    <div class="row">
                                        <div class="col-25">
                                            <label for="name">Email :</label>
                                        </div>
                                        <div class="col-75">
                                            <input type="email" name="riderEmail" id="riderEmail" pattern="[a-z0-9._%+-]+@gmail.com" value="<%=rider.getRiderEmail()%>" readonly><br>
                                        </div>
                                     </div>
                                    <div class="row">
                                        <div class="col-25">
                                            <label for="name">Plate Number:</label>
                                        </div>
                                        <div class="col-75">
                                            <small>Example: "ABC1234 or AB1234C"</small>
                                            <input type="text" name="riderPlate" id="riderPlate" pattern="^([A-Z]{3}[0-9]{4})?([A-Z]{2}[0-9]{4}[A-Z]{1})?$" minlength="7" maxlength="7" value="<%=rider.getRiderPlate()%>" required><br>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-25">
                                            <label for="name">Password :</label>
                                        </div>
                                        <div class="col-75">
                                            <small>Example: "Aliabu123" | Mininum 6 characters</small>
                                            <input type="password" name="riderPassword" id="riderPassword"  pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}" minlength="6" value="<%=rider.getRiderPassword()%>" required><br>
                                        </div>
                                    </div>
                                </center>
                                <div class="row">
                                    <input type="checkbox" onclick="showPassword()">Show Password
                                </div>
                                <center>
                                    <br><br>
                                    <a href="RiderController?action=viewRider&id=<%=rider.getRiderID()%>" class="btn btn-warning" style="font-size: 17px;"><i class="fa fa-arrow-left" aria-hidden="true"></i> Back</a>
                                    <input type="submit" value="Update" class="btn btn-success" style="font-size: 17px;" onclick="formValidation()"> 
                                    <br><br>
                                </center>
                            </form>
                            <script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
                            <script>
                                function formValidation() {
                                    var name = document.getElementById("riderName");
                                    var nameValidity = name.validity;
                                    var phone = document.getElementById("riderPhone");
                                    var phoneValidity = phone.validity;
                                    var email = document.getElementById("riderEmail");
                                    var emailValidity = email.validity;
                                    var plateNumber = document.getElementById("riderPlate");
                                    var plateNumberValidity = plateNumber.validity;
                                    var password = document.getElementById("riderPassword");
                                    var passwordValidity = password.validity;

                                    if(nameValidity.valueMissing) {
                                        name.setCustomValidity("Please fill out this field!");
                                    }
                                    else if(nameValidity.patternMismatch) {
                                        name.setCustomValidity("Must be letters only!");
                                    }
                                    else {
                                        name.setCustomValidity("");
                                    }

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

                                    if(emailValidity.valueMissing) {
                                        email.setCustomValidity("Please fill out this field!");
                                    }
                                    else if(emailValidity.patternMismatch) {
                                        email.setCustomValidity("Please use the correct format! Example: xxxx@gmail.com");
                                    }
                                    else {
                                        email.setCustomValidity('');
                                    }

                                    if(plateNumberValidity.valueMissing) {
                                        plateNumber.setCustomValidity("Please fill out this field!");
                                    }
                                    else if(plateNumberValidity.patternMismatch) {
                                        plateNumber.setCustomValidity("Must contain 3 uppercase letters, 4 digits and no spacing!");
                                    }
                                    else if(plateNumberValidity.tooLong) {
                                        plateNumber.setCustomeValidity("Plate number entered exceeds 7 digits!");
                                    }
                                    else if(plateNumberValidity.tooShort) {
                                        plateNumber.setCustomeValidity("Plate number entered subceeds 7 digits!");
                                    }
                                    else {
                                        plateNumber.setCustomValidity("");
                                    }

                                    if(passwordValidity.valueMissing) {
                                        password.setCustomValidity("Please fill out this field!");
                                    } 
                                    else if(passwordValidity.patternMismatch) {
                                        password.setCustomValidity("Must contain a digit, a lowercase letter, a uppercase letter and at least 6 characters!");
                                    }
                                    else if(passwordValidity.tooShort) {
                                        password.setCustomValidity("Password entered subceeds 6 digits!");
                                    }
                                    else {
                                        password.setCustomValidity("");
                                    }
                                    name.reportValidity();
                                    phone.reportValidity();
                                    email.reportValidity();
                                    plateNumber.reportValidity();
                                    password.reportValidity();
                                }
                                function showPassword() {
                                    var password = document.getElementById("riderPassword")

                                    if(password.type === "password") {
                                        password.type = "text";
                                    }
                                    else {
                                        password.type = "password";
                                    }
                                }
                            </script>
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
</html>`