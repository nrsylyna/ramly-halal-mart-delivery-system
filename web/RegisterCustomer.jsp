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
            input[type=text], input[type=password], input[type=email], input[type=number],select{
                width: 90%;
                padding: 12px;
                border: 1px solid #ccc;
                border-radius: 4px;
                resize: vertical;
            }
            input[type=checkbox] {
                margin: 0px 12px 12px 65px;
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
                            <h3 class="agileinfo_sign">Registration </h3>
                            <p align="center">Let's join Ramly Family now!
                                <br>Already have an account?<b><a href="LoginCustomer.jsp"> Log In Here</a></b>
                            </p>
                            <form method="post" action="CustomerController?action=registerCustomer" onsubmit="return passwordComparison()">
                                <div class="row">
                                    <div class="col-25">
                                        <label for="name">Name</label>
                                    </div>
                                    <center>
                                        <div class="col-75">
                                            <input type="text" id="custName" name="custName" pattern="[a-zA-Z ]+" required>
                                        </div>
                                    </center>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-25">
                                        <label for="name">No. Phone</label>
                                        <br>
                                        <small>Example: "012-3456789"</small>
                                    </div>
                                    <center>
                                        <div class="col-75">
                                            <input type="text" id="custPhone" name="custPhone" pattern="[0-9]{3}-[0-9]{7}" minlength="11" maxlength="11" required>
                                        </div>
                                    </center>
                                </div>
                                <br>
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
                                <br>
                                <div class="row">
                                    <div class="col-25">
                                        <label for="name">Address Line</label>
                                        <br>
                                        <small>Example: "No.1, Street, Area"</small>
                                    </div>
                                    <center>
                                        <div class="col-75">
                                            <input type="text" id="custAddress" name="custAddress" pattern="^[\w\d./*]{1,},[^\S][\w\d./* ]{1,},[^\S][\w\d./* ]{1,}$"  minlength="5" required>
                                      </div>
                                    </center>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-25">
                                        <label for="name">Postcode</label>
                                    </div>
                                    <center>
                                        <div class="col-75">
                                            <input type="text" id="custPostcode" name="custPostcode" pattern="^[0-9]{0,}$" minlength="5" maxlength="5" required>
                                      </div>
                                    </center>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-25">
                                        <label for="name">City</label>
                                    </div>
                                    <center>
                                        <div class="col-75">
                                            <input type="text" id="custCity" name="custCity" pattern="^\S\D*$" minlength="4" required>
                                      </div>
                                    </center>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-25">
                                        <label for="name">State</label>
                                    </div>
                                    <center>
                                        <div class="col-75">
                                            <select id="custState" name="custState" required>
                                              <option value="" selected ></option>  
                                              <option value="Johor">Johor</option>
                                              <option value="Kedah">Kedah</option>
                                              <option value="Kelantan">Kelantan</option>
                                              <option value="Malacca">Malacca</option>
                                              <option value="Negeri Sembilan">Negeri Sembilan</option>
                                              <option value="Pahang">Pahang</option>
                                              <option value="Penang">Penang</option>
                                              <option value="Perak">Perak</option>
                                              <option value="Perlis">Perlis</option>
                                              <option value="Sabah">Sabah</option>
                                              <option value="Sarawak">Sarawak</option>
                                              <option value="Selangor">Selangor</option>
                                              <option value="Terengganu">Terengganu</option>
                                            </select>
                                        </div>
                                    </center>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-25">
                                        <label for="name">Username</label>
                                    </div>
                                    <center>
                                        <div class="col-75">
                                            <input type="text" id="custUsername" name="custUsername" pattern="[A-Za-z]+" required>
                                      </div>
                                    </center>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-25">
                                        <label for="name">Password</label>
                                        <br>
                                        <small>Example: "Aliabu123"</small>
                                    </div>
                                    <center>
                                        <div class="col-75">
                                            <input type="password" id="custPassword1" name="custPassword1"  pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}" minlength="6" required>
                                        </div>
                                    </center>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-25">
                                        <label for="name">Confirm Password</label>
                                    </div>
                                    <center>
                                        <div class="col-75">
                                            <input type="password" id="custPassword2" name="custPassword2" required>
                                        </div>
                                    </center>
                                </div>
                                <div class="row">
                                    <input type="checkbox" onclick="showPassword()">Show Password
                                    <br>
                                </div>
                                <div class="row" align="center">
                                    <br>
                                    <input type="reset" value="Reset">   <input type="submit" value="Register" onclick="formValidation()">
                                </div>
                            </form>
                            <c:set var="message" value="${requestScope.failRegister}"/> 
                            <c:if test="${message != null}">      
                                <script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
                                <script>
                                    Swal.fire({
                                        position: 'top-center',
                                        icon: 'error',
                                        title: 'Username/Email Has Been Used!',
                                        text: 'Please try another username or email',
                                        showConfirmButton: false,
                                        timer: 3000
                                    });
                                </script>
                            </c:if>
                            <script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
                            <script>
                                function formValidation() {
                                    var name = document.getElementById("custName");
                                    var nameValidity = name.validity;
                                    var phone = document.getElementById("custPhone");
                                    var phoneValidity = phone.validity;
                                    var email = document.getElementById("custEmail");
                                    var emailValidity = email.validity;
                                    var address = document.getElementById("custAddress");
                                    var addressValidity = address.validity;
                                    var city = document.getElementById("custCity");
                                    var cityValidity = city.validity;
                                    var state = document.getElementById("custState");
                                    var stateValidity = state.validity;
                                    var postcode = document.getElementById("custPostcode");
                                    var postcodeValidity = postcode.validity;
                                    var username = document.getElementById("custUsername");
                                    var usernameValidity = username.validity;
                                    var password = document.getElementById("custPassword1");
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
                                        phone.setCustomValidity("Must contain 10 digits, has dash (-) character and please use the correct format! Example: xxx-xxxxxxx");
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
                                    
                                    if(usernameValidity.valueMissing) {
                                        username.setCustomValidity("Please fill out this field!");
                                    }
                                    else if(usernameValidity.patternMismatch) {
                                        username.setCustomValidity("Must be letters only!");
                                    }
                                    else {
                                        username.setCustomValidity("");
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
                                    address.reportValidity();
                                    city.reportValidity();
                                    state.reportValidity();
                                    postcode.reportValidity();
                                    username.reportValidity();
                                    password.reportValidity();
                                }
                                function passwordComparison() {  
                                    var password1 = document.getElementById("custPassword1").value;  
                                    var password2 = document.getElementById("custPassword2").value;  

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
                                    var password1 = document.getElementById("custPassword1");
                                    var password2 = document.getElementById("custPassword2");

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