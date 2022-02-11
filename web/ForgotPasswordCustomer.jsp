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
            small {
                padding: 0px 12px 12px 60px;
                display: inline-block;
            }
            input[type=text], input[type=password]{
                width: 90%;
                padding: 12px;
                border: 1px solid #ccc;
                border-radius: 4px;
                resize: vertical;
            }
            input[type=checkbox] {
                margin: 12px 12px 12px 65px;
            }
            input[type=reset], input[type=submit] {
                font-weight: bold;
                border: 3px solid #644334;
                color: #644334;
                padding: 12px 20px;
                border-radius: 4px;
                cursor: pointer;
                float: center;
                width: 20%;
            }
            input[type=reset]:hover, input[type=submit]:hover {
                background-color: #644334;
                color: #fff;
            }
            a:hover {
                text-decoration: underline;
              }
        </style>
    </head>
    <body>
        <!-- header-bot-->
        <%@ include file="MainNav.jsp" %>
	<!-- //header-bot -->
	<!-- top Products -->
	<div class="ads-grid">
            <div class="container">
                <!-- tittle heading -->
                <h3 class="tittle-w3l">Customer
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
                            <h3 class="agileinfo_sign">Reset Password </h3>
                            <form method="post" action="LoginController?action=resetPasswordCustomer" onsubmit="return passwordComparison()">				  
                                <div class="row">
                                    <div class="col-25">
                                        <label for="name">Email</label>
                                        <br>
                                        <small>Example: "aliabu@gmail.com"</small>
                                    </div>
                                    <center>
                                        <div class="col-75">
                                            <input type="text" id="custEmail" name="custEmail" pattern="[a-z0-9._%+-]+@gmail.com" required>
                                        </div>
                                    </center>
                                </div> 
                                <div class="row">
                                    <div class="col-25">
                                        <label for="name">New Password</label>
                                        <br>
                                        <small>Example: "Aliabu123"</small>
                                    </div>
                                    <center>
                                        <div class="col-75">
                                            <input type="password" id="custNewPassword1" name="custNewPassword1" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}" minlength="6" required> 
                                        </div>
                                    </center>
                                </div>  
                                <div class="row">
                                    <div class="col-25">
                                        <label for="name">Confirm New Password</label>
                                    </div>
                                    <center>
                                        <div class="col-75">
                                            <input type="password" id="custNewPassword2" name="custNewPassword2" required>
                                        </div>
                                    </center>
                                </div>
                                <div class="row">
                                    <input type="checkbox" onclick="showPassword()">Show Password
                                    <br>
                                </div>
                                <div class="row" align="center">
                                    <br>
                                    <input type="submit" value="Reset" onclick="formValidation()">
                                </div>
                            </form>
                            <c:set var="message" value="${requestScope.failResetPassword}"/> 
                            <c:if test="${message != null}">      
                                <script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
                                <script>
                                    Swal.fire({
                                        position: 'top-center',
                                        icon: 'error',
                                        title: 'User Not Found!',
                                        text: 'Please try another email',
                                        showConfirmButton: false,
                                        timer: 3000
                                    });
                                </script>
                            </c:if>
                            <script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
                            <script>
                                function formValidation() {
                                    var email = document.getElementById("custEmail");
                                    var emailValidity = email.validity;
                                    var password = document.getElementById("custNewPassword1");
                                    var passwordValidity = password.validity;

                                    if(emailValidity.valueMissing) {
                                        email.setCustomValidity("Please fill out this field!");
                                    }
                                    else if(emailValidity.patternMismatch) {
                                        email.setCustomValidity("Please use the correct format! Example: xxxx@gmail.com");
                                    }
                                    else {
                                        email.setCustomValidity('');
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
                                    email.reportValidity();
                                    password.reportValidity();
                                }
                                function passwordComparison() {  
                                    var password1 = document.getElementById("custNewPassword1").value;  
                                    var password2 = document.getElementById("custNewPassword2").value;  

                                    if(password1 !== password2)  {                              
                                        Swal.fire({
                                            position: 'top-center',
                                            icon: 'error',
                                            title: 'Password Did Not Match!',
                                            showConfirmButton: true,
                                            timer: 3000
                                        });
                                       return false; 
                                    }
                                    return true;
                                }
                                function showPassword() {
                                    var password1 = document.getElementById("custNewPassword1");
                                    var password2 = document.getElementById("custNewPassword2");

                                    if(password1.type === "password") {
                                        password1.type = "text";
                                    }
                                    else {
                                        password1.type = "password";
                                    }
                                    
                                    if(password2.type === "password") {
                                        password2.type = "text";
                                    }
                                    else {
                                        password2.type = "password";
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