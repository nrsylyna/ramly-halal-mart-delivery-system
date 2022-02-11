<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        <!--//price range-->
	<!-- fonts -->
	<link href="//fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800" rel="stylesheet">
        <!--//fonts-->
        <script data-require="jquery@3.1.1" data-semver="3.1.1" src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
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
            /* -- quantity box -- */
            .quantity {
                display: inline-block; 
            }
            .quantity .input-text.qty {
                width: 50px;
                height: 35px;
                padding: 0 5px;
                text-align: center;
                background-color: transparent;
                border: 1px solid #000000;
                border-radius: 4px;
            }
            .quantity.buttons_added {
                text-align: left;
                position: relative;
                white-space: nowrap;
                vertical-align: top; 
            }
            .quantity.buttons_added input {
                display: inline-block;
                margin: 0;
                vertical-align: top;
                box-shadow: none;
            }
            .quantity.buttons_added .minus,
            .quantity.buttons_added .plus {
                padding: 6px 18px 8px;
                height: 35px;
                border: 1px solid #000000;
                border-radius: 4px;
                cursor: pointer;
                color: #000000;
            }
            .quantity.buttons_added .minus {
                border-right: 0;
/*                background-color: #c9302c;*/
            }
            .quantity.buttons_added .plus {
                border-left: 0;
/*                background-color: #5aba5a;*/
            }
            .quantity.buttons_added .minus:hover,
            .quantity.buttons_added .plus:hover {
                box-shadow: inset 0 0 0 50px rgba(0, 0, 0, 0.2);
            }
            .quantity input::-webkit-outer-spin-button,
            .quantity input::-webkit-inner-spin-button {
                -webkit-appearance: none;
                -moz-appearance: none;
                margin: 0; 
            }
            .quantity.buttons_added .minus:focus,
            .quantity.buttons_added .plus:focus {
                outline: none; 
            }
	</style>
    </head>
    <%@page import="ramly.model.Customer"%>
    <% Customer cust = (Customer) session.getAttribute("login");
        if(cust == null){
            response.sendRedirect("LoginCustomer.jsp");
        }
    %>
    <body>
        <!-- header-bot-->
	<%@ include file="CustNav.jsp" %>
        <!-- header-botS -->
        <div class="ads-grid">
            <div class="container">
                <!-- tittle heading -->
                <h3 class="tittle-w3l">Shopping Cart
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
                                <a href="ItemController?action=custCatalogue"><button class="btn btn-secondary"><span class="fa fa-backward" aria-hidden="true"></span> Continue Shopping</button></a>
                            </center>
                            <br><br>
                            <div class="table-responsive">
                                <table class="timetable_pay">
                                    <tr>
                                        <th>Item ID</th>
                                        <th>Name</th>
                                        <th>Quantity</th>
                                        <th>Unit Price </th>
                                        <th>Total</th>
                                        <th></th>
                                    </tr>
                                    <c:if test="${totalPrice == 0}">
                                      <tr>
                                        <td colspan="4">- Cart is currently empty -</td>
                                      </tr>
                                    </c:if>
                                    <c:set var="totalPrice" value="${0}" />
                                    <c:forEach var="item" items="${items}">                       
                                        <tr>
                                            <td><c:out value="${item.getitemID()}"/></td>
                                            <td><c:out value="${item.getitemName()}"/></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${item.itemQty >= 1}">
                                                        <div class="quantity buttons_added">
                                                            <form method="post" action="CartController?action=updateCart">
                                                                <input type="button" value="-" class="minus">
                                                                <input type="number" step="1" min="1" max="99" name="quantity" value="${item.getiQty()}" title="Qty" class="input-text qty text" size="4">
                                                                <input type="button" value="+" class="plus">
                                                                <input type="hidden" name="id" value="${item.getitemID()}">
                                                                <input type="submit" value="Update" class="btn btn-warning">
                                                            </form>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="quantity buttons_added">
                                                            <form method="post" action="CartController?action=updateCart2">
                                                                <input type="button" value="-" class="minus">
                                                                <input type="number" step="1" min="1" max="99" name="quantity" value="${item.getiQty()}" title="Qty" class="input-text qty text" size="4">
                                                                <input type="hidden" value="+" class="plus">
                                                                <input type="hidden" name="id" value="${item.getitemID()}">
                                                                <input type="submit" value="Update" class="btn btn-warning">
                                                                <br>
                                                                <small style="color: red;">**<c:out value="${item.getitemName()}"/> Out Of Stock**</small>
                                                                <br>
                                                                <small style="color: red;">**Reach Max Quantity Of Stock**</small>
                                                            </form>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>RM<c:out value="${item.getitemPrice()}"/></td>
                                            <td>RM <fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" value="${item.getitemPrice()*item.getiQty()}"/></td>
                                            <td>
                                                <a href="CartController?action=removeFromCart&id=${item.getitemID()}"><button class="btn btn-danger" onclick="del(event)">Remove</button></a>   
                                            </td>
                                        </tr>
                                        <c:set var="total" value="${item.getitemPrice() * item.getiQty()}"/>
                                        <c:set var="totalPrice" value="${totalPrice+total}"/>
                                        <tr>
                                            <th colspan="7"> </th>
                                        </tr>
                                    </c:forEach>
                                    <!--Total-->
                                    <tr>
                                        <th colspan="4"><b>TOTAL PRICE</th>
                                        <th><b>RM <fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" value="${totalPrice}"/></b></th>
                                        <th></th>
                                    </tr>
                                </table>
                                <br><br>
                                <center>
                                    <c:if test="${totalPrice == 0}">  
                                        <a disabled><button class="btn btn-success" disabled>Proceed to Payment</button></a>
                                        <br><br> 
                                    </c:if> 
                                    <c:if test="${totalPrice != 0}">  
                                        <a href="OrderController?action=createOrder&total=${totalPrice}"><button class="btn btn-success">Proceed to Payment</button></a>
                                        <br><br>
                                    </c:if> 
                                </center>        
                            </div>
                            <c:set var="message" value="${requestScope.successAddItem}"/> 
                            <c:if test="${message != null}">      
                                <script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
                                <script>
                                    Swal.fire({
                                        position: 'top-center',
                                        icon: 'success',
                                        title: 'Item Has Been Added To Cart',
                                        showConfirmButton: false,
                                        timer: 3000
                                    });
                                </script>
                            </c:if> 
                            <c:set var="message" value="${requestScope.successUpdateItemQuantity}"/> 
                            <c:if test="${message != null}">      
                                <script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
                                <script>
                                    Swal.fire({
                                        position: 'top-center',
                                        icon: 'success',
                                        title: 'Item Quantity Has been Updated',
                                        showConfirmButton: false,
                                        timer: 3000
                                    });
                                </script>
                            </c:if> 
                            <c:set var="message" value="${requestScope.successRemoveItem}"/> 
                            <c:if test="${message != null}">      
                                <script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
                                <script>
                                    Swal.fire({
                                        position: 'top-center',
                                        icon: 'success',
                                        title: 'Item Has Been Removed From Cart',
                                        showConfirmButton: false,
                                        timer: 3000
                                    });
                                </script>
                            </c:if> 
                            <c:set var="message" value="${requestScope.failAddItem}"/> 
                            <c:if test="${message != null}">      
                                <script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
                                <script>
                                    Swal.fire({
                                        position: 'top-center',
                                        icon: 'warning',
                                        title: 'Quantity Entered Exceeds Item Stock!',
                                        showConfirmButton: false,
                                        timer: 3000
                                    });
                                </script>
                            </c:if> 
                            <c:set var="message" value="${requestScope.errorAddItem}"/> 
                            <c:if test="${message != null}">      
                                <script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
                                <script>
                                    Swal.fire({
                                        position: 'top-center',
                                        icon: 'error',
                                        title: 'Item Out Of Stock!',
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
                                        title: 'Are You Sure?',
                                        text: "Do you want to remove this item from cart",
                                        icon: 'warning',
                                        showCancelButton: true,
                                        confirmButtonColor: '#3085d6',
                                        cancelButtonColor: '#d33',
                                        confirmButtonText: 'Yes'
                                    }).then((result) => {
                                        if (result.isConfirmed) {
                                            window.location.href = event.target.offsetParent.children[0].href;
                                        }
                                    })
                                 }
                                function wcqib_refresh_quantity_increments() {
                                    jQuery("div.quantity:not(.buttons_added), td.quantity:not(.buttons_added)").each(function(a, b) {
                                        var c = jQuery(b);
                                        c.addClass("buttons_added"), c.children().first().before('<input type="button" value="-" class="minus" />'), c.children().last().after('<input type="button" value="+" class="plus" />')
                                    })
                                }
                                String.prototype.getDecimals || (String.prototype.getDecimals = function() {
                                    var a = this,
                                        b = ("" + a).match(/(?:\.(\d+))?(?:[eE]([+-]?\d+))?$/);
                                    return b ? Math.max(0, (b[1] ? b[1].length : 0) - (b[2] ? +b[2] : 0)) : 0
                                }), jQuery(document).ready(function() {
                                    wcqib_refresh_quantity_increments()
                                }), jQuery(document).on("updated_wc_div", function() {
                                    wcqib_refresh_quantity_increments()
                                }), jQuery(document).on("click", ".plus, .minus", function() {
                                    var a = jQuery(this).closest(".quantity").find(".qty"),
                                        b = parseFloat(a.val()),
                                        c = parseFloat(a.attr("max")),
                                        d = parseFloat(a.attr("min")),
                                        e = a.attr("step");
                                    b && "" !== b && "NaN" !== b || (b = 0), "" !== c && "NaN" !== c || (c = ""), "" !== d && "NaN" !== d || (d = 0), "any" !== e && "" !== e && void 0 !== e && "NaN" !== parseFloat(e) || (e = 1), jQuery(this).is(".plus") ? c && b >= c ? a.val(c) : a.val((b + parseFloat(e)).toFixed(e.getDecimals())) : d && b <= d ? a.val(d) : b > 0 && a.val((b - parseFloat(e)).toFixed(e.getDecimals())), a.trigger("change")
                                });
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