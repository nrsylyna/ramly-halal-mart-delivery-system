<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
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
                padding: 12px 12px 12px 60px;
                display: inline-block;
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
                            <center>
                                <a href="CartController?action=viewCart"><button class="btn btn-secondary"><span class="fa fa-backward" aria-hidden="true"></span> Back To Shopping Cart</button></a>
                            </center>
                            <br><br>
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
                                        <td>RM<fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" value="${totalprice}"/></td>
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
                                            RM<fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" value="${grandtotal}"/>
                                            </b>
                                        </th>
                                    </tr>		
                                </table>
                            </div>
                            <div style="background-color: #f9f9f9">
                                <br>
                                <p style="color:#000; font-weight:600"><span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span> Delivery Address </p>
                                <p style="color:#000; font-size:15px; margin-left:22px"><%=cust.getCustName()%> | <%=cust.getCustPhone()%></p>
                                <p style="color:#000; font-size:15px; margin-left:22px; display:inline"><%=cust.getCustAddress()%> </p>
                                <p style="display:inline; float:right; margin-right:20px "><a href="CustomerController?action=updateCustomerAddress&id=<%=cust.getCustID()%>&total=${totalprice}"><button class="btn btn-warning">Change</button></a></p>
                                <hr>
                            </div>
                            <!-- Payment method -->
                            <center>
                                <div class="pay-opt">
                                    <p style=" color: #000; text-align: center;">Payment Option: </p>
                                    <button type="button" class="btn btn-info"<a data-toggle="tab" href="#COD">COD</a></button>
                                    <button type="button" class="btn btn-info"<a data-toggle="tab" href="#OnlinePayment">Online Payment</a></button>
                                </div>
                            </center>
                            <br><br>
                            <div class="tab-content">
                                <div id="COD" class="tab-pane fade">
                                    <h3 class="agileinfo_sign">Cash On Delivery</h3>
                                    <h4><b><ins>Instruction</ins></b></h4>
                                    <form id="ff" name="codForm" method="post" action="OrderController?action=checkout">
                                        <ol>
                                            <li>Extra charge for delivery order <strong>RM5.00</strong></li>
                                            <li>Confirmation can <strong>only make once</strong>. Please check your item details before proceed.</li>
                                            <li>Please prepare exactly amount money, our rider will reach your doorstep as soon as possible.</li>
                                            <li>Cash Payment only</li>
                                        </ol>
                                        <br>
                                        <p>Please read all the instruction above.</p>
                                        <input type="hidden" name="totalprice" id="totalprice" value="<c:out value="${totalprice}"/>"/>
                                        <input type="hidden" name="grandtotal" id="grandtotal" value="<c:out value="${grandtotal}"/>"/>
                                        <input type="hidden" name="payStatus" id="payStatus" value="UNPAID" />
                                        <input type="hidden" name="payType" id="payType" value="COD" />
                                        <input type="hidden" name="custID" id="custID" value="<%=cust.getCustID()%>"/>  
                                        <input type="submit" value="Confirm" class="btn btn-success"> 
                                    </form>
                                </div>
                                <div id="OnlinePayment" class="tab-pane fade">
                                    <h3 class="agileinfo_sign">Online Payment</h3>
                                    <h4><b><ins>Instruction</ins></b></h4>
                                    <ol>
                                        <li>Extra charge for delivery order <strong>RM5.00</strong></li>
                                        <li>Confirmation can <strong>only make once</strong>. Please check your item details before proceed.</li>
                                        <li>Customer are required to do online payment using external application.</li>
                                        <li>Then, customer are required to upload the receipt online transaction.</li>
                                        <li>Please set the order id in reference details when make payment.</li>
                                        <li>Make your payment and <strong>upload receipt payment</strong> in the required section to proceed.</li>
                                    </ol>
                                    <br>
                                    <p>Please read all the instruction above.</p>
                                    <a href="OrderController?action=paymentForm&total=${totalprice}"><button class="btn btn-success">Confirm</button></a>
                                </div>
                            </div>  
                             <!-- Payment method end -->
                            <!-- start alert cod -->
                            <c:set var="message" value="${requestScope.successUpdateAddress}"/> 
                            <c:if test="${message != null}">      
                                <script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
                                <script>
                                    Swal.fire({
                                        position: 'top-center',
                                        icon: 'success',
                                        title: 'Successfully Update Address',
                                        showConfirmButton: false,
                                        timer: 3000
                                    });
                                </script>
                            </c:if> 
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