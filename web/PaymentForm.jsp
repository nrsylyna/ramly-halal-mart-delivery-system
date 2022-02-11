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
        <script>
            function fileValidation() { 
                var fileInput =  document.getElementById('pay_receipt'); 
                var filePath = fileInput.value; 
                // Allowing file type 
                var allowedExtensions = /(\.jpg|\.jpeg|\.png)$/i; 
              
                if(!allowedExtensions.exec(filePath)) { 
                    alert('Invalid file type'); 
                    fileInput.value = ''; 
                    return false; 
                }  
                else  { 
                    // Image preview 
                    if (fileInput.files && fileInput.files[0]) { 
                        var reader = new FileReader(); 
                        reader.onload = function(e) { 
                            document.getElementById('imagePreview').innerHTML ='<img src="' + e.target.result + '"/>'; 
                        }; 
                        reader.readAsDataURL(fileInput.files[0]); 
                    } 
                }   		
            } 
        </script>
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
                <h3 class="tittle-w3l">Online Payment
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
                            <h4><ins>Instruction</ins></h4>									
                            <ol>
                                <li>Please refer the total amount before make payment.</li>
                                <li>Please set the order id in reference details when make payment.</li>
                                <li>Make payment to the account information that have given</li>
                                <li>Make your payment and <strong>upload receipt payment</strong> in the required section to proceed.</li>
                                <li>Please upload a valid receipt payment before do the confirmation.</li>
                            </ol>
                            <br>
                            <p><strong>Please read all the instruction above.</strong></p>
                            <h4>Account information</h4>
                            <p>Bank: Maybank</p>
                            <p>Name: Ramly Halal Mart SDN BHD</p>
                            <p>Account No: 12345678910101</p>
                            <form id="ff" name="paymentForm" method="post" action="OrderController?action=checkoutOnline" enctype="multipart/form-data">
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
                                                <td>RM<c:out value="${item.getitemPrice() * item.getiQty()}" /></td>
                                            </tr>
                                        </c:forEach>
                                        <tr>
                                            <td colspan=4 class="timetable_pay2"> Subtotal </td>
                                            <td> RM <c:out value="${totalprice}"/></td>
                                            <c:set var="total" value="${totalprice}"/>
                                        </tr>
                                        <tr>
                                            <th colspan=4 class="timetable_pay2"> Delivery charge (fix)</th>
                                            <th> RM 5.00 </th>
                                        </tr>
                                        <tr>
                                            <th colspan=4 class="timetable_pay2"><b>TOTAL PRICE</b></th>
                                            <th> 
                                                <b>
                                                <c:set var="grandtotal" value="${0}"/>
                                                <c:set var="grandtotal" value="${totalprice + 5.0}"/>
                                                RM<c:out value="${grandtotal}"/>
                                                </b>
                                            </th>
                                        </tr>		
                                    </table>
                                </div>
                                <input type="hidden" name="totalprice" id="totalprice" value="<c:out value="${totalprice}"/>"/>
                                <input type="hidden" name="grandtotal" id="grandtotal" value="<c:out value="${grandtotal}"/>"/>
                                <br>
                                Please attach your receipt payment here as a proof:<br>
                                Receipt:<br>
                                <input type="file" name="payReceipt" accept="image/png, image/jpeg"  id="payReceipt" onchange="return fileValidation()" required />
                                <input type="hidden" name="payStatus" id="payStatus" value="UNPAID" /><!-- comment -->
                                <input type="hidden" name="payType" id="payType" value="ONLINE PAYMENT" />
                                <input type="hidden" name="custID" id="custID" value="<%=cust.getCustID()%>"/>  
                                <br><br>
                                <a href="OrderController?action=createOrder&total=${total}" class="btn btn-warning" style="display: inline-table;"><i class="fa fa-arrow-left" aria-hidden="true"></i> Back</a>
                                <input type="submit" value="Submit" class="btn btn-success">
                            </form>
                            <!-- start alert cod -->
                            <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
                            <script src="https://code.jquery.com/jquery-3.5.0.js"></script>
                            <script>
                                $('#ff').submit(function(event){
                                 event.preventDefault();   
                                 Swal.fire({
                                   title: 'Are you sure?',
                                   text: "Order cancellation can only be done before payment. Do you want to proceed?",
                                   icon: 'warning',
                                   showCancelButton: true,
                                   confirmButtonColor: '#3085d6',
                                   cancelButtonColor: '#d33',
                                   confirmButtonText: 'Yes'
                                 }).then((result) => {
                                   if (result.isConfirmed) {
                                     $(this).unbind('submit').submit()
                                   }
                                 })
                                 })
                            </script>  
                         <!-- end alert cod -->    
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