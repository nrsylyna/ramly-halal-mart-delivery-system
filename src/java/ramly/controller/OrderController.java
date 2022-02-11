package ramly.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import ramly.dao.RiderDAO;
import ramly.dao.CartDAO;
import ramly.dao.CustomerDAO;
import ramly.dao.OrderDAO;
import ramly.dao.PaymentDAO;
import ramly.dao.ItemCatalogueDAO;
import ramly.model.Rider;
import ramly.model.Cart;
import ramly.model.Customer;
import ramly.model.ItemCatalogue;
import ramly.model.OrderDelivery;
import ramly.model.Payment;

@MultipartConfig(maxFileSize = 16177216)//1.5mb
public class OrderController extends HttpServlet {
    private static final long serialVersionUID = 1L; 
    static ArrayList<Integer> cartList = new ArrayList<>();
    static ArrayList<Integer> itemQuantity = new ArrayList<>();
    private String TRACK_ORDER = "TrackOrderCustomer.jsp";
    private static String ORDER_LIST_RIDER = "OrderListRider.jsp";
    private static String ORDER_LIST_ADMIN = "OrderListAdmin.jsp";
    private static String UPDATE_ORDER_RIDER = "UpdateOrderRider.jsp";
    private static String UPDATE_ORDER_ADMIN = "UpdateOrderAdmin.jsp";
    private static String VIEW_ORDER_RIDER = "OrderDetailsRider.jsp";
    private static String VIEW_ORDER_ADMIN = "OrderDetailsAdmin.jsp";
    private static String VIEW_PAYMENT = "ViewPayment.jsp";
    private static String PAYMENT_FORM = "PaymentForm.jsp";
    private String VIEW_RECEIPT = "receipt.jsp";
    private RiderDAO daoRider;
    private OrderDAO daoOrder;
    private CartDAO daoCart;
    private CustomerDAO daoCustomer;
    private ItemCatalogueDAO daoItem;
    private PaymentDAO daoPayment;
    String forward = null;         
       
    public OrderController() {
        super();
        daoRider = new RiderDAO();
        daoOrder = new OrderDAO();
        daoCart = new CartDAO();
        daoCustomer = new CustomerDAO();
        daoItem = new ItemCatalogueDAO();
        daoPayment = new PaymentDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
        String action = request.getParameter("action");
        HttpSession cartsession = request.getSession();
        
        if(action.equalsIgnoreCase("trackOrder")) { //CUSTOMER TRACKS THEIR ORDER
	    int custID = Integer.parseInt(request.getParameter("id"));
            forward = TRACK_ORDER;
            request.setAttribute("orders", daoOrder.getAllCustOrder(custID));
        }
        else if(action.equalsIgnoreCase("listOrderRider")) { //RIDER VIEWS LIST OF CUSTOMERS' ORDER THAT HAS BEEN ASSIGNED TO THEM
            int riderID = Integer.parseInt(request.getParameter("id"));
            forward = ORDER_LIST_RIDER;
            request.setAttribute("orders", daoOrder.getAllOrderRider(riderID));
        }
        else if(action.equalsIgnoreCase("listOrderAdmin")) { //ADMIN VIEWS LIST OF CUSTOMER ORDER
            forward = ORDER_LIST_ADMIN;
            request.setAttribute("orders", daoOrder.getAllOrders());
        }
        else if(action.equalsIgnoreCase("updateOrderRider")) { //RIDER UPDATE ORDER DELIVERY STATUS
            int orderID = Integer.parseInt(request.getParameter("id"));
            OrderDelivery order = daoOrder.getOrderById(orderID);
            Customer customer = daoCustomer.getCustomerByOrder(orderID);  
            forward = UPDATE_ORDER_RIDER;
            request.setAttribute("order", order); 
            request.setAttribute("carts", daoCart.getAllCart(orderID));
            request.setAttribute("customer", customer);
        } 
        else if(action.equalsIgnoreCase("updateOrderAdmin")) { //ADMIN UPDATE ORDER DELIVERY STATUS
            int orderID = Integer.parseInt(request.getParameter("id"));
            OrderDelivery order = daoOrder.getOrderById(orderID);
            Customer customer = daoCustomer.getCustomerByOrder(orderID);         	
            forward = UPDATE_ORDER_ADMIN;
            request.setAttribute("order", order); 
            request.setAttribute("carts", daoCart.getAllCart(orderID));
            request.setAttribute("customer", customer);
        } 
        else if(action.equalsIgnoreCase("viewOrderRider")) { //RIDER VIEW CUSTOMER ORDER DETAILS
            int id = Integer.parseInt(request.getParameter("id"));
            OrderDelivery order = daoOrder.getOrderById(id);  
            Customer customer = daoCustomer.getCustomerByOrder(id);   
            forward = VIEW_ORDER_RIDER;       		
            request.setAttribute("order", order);  
            request.setAttribute("carts", daoCart.getAllCart(id));  
            request.setAttribute("customer", customer);
        }
        else if(action.equalsIgnoreCase("viewOrderAdmin")) { //ADMIN VIEW CUSTOMER ORDER DETAILS
            int id = Integer.parseInt(request.getParameter("id"));
            OrderDelivery order = daoOrder.getOrderById(id);  
            Customer customer = daoCustomer.getCustomerByOrder(id);   
            forward = VIEW_ORDER_ADMIN;       		
            request.setAttribute("order", order);  
            request.setAttribute("carts", daoCart.getAllCart(id));  
            request.setAttribute("customer", customer);
        }
         else if(action.equalsIgnoreCase("deleteOrderAdmin")) { //ADMIN DELETE ORDER	
            int orderID = Integer.parseInt(request.getParameter("id"));
            int payID = Integer.parseInt(request.getParameter("pId")); 
            daoOrder.deleteOrder(orderID, payID);
            forward = ORDER_LIST_ADMIN;
            request.setAttribute("orders", daoOrder.getAllOrders());
            request.setAttribute("successDeleteOrder", "Order Has Been Deleted");
        } 
        else if(action.equalsIgnoreCase("createOrder")) {
            double totalprice = Double.parseDouble(request.getParameter("total"));
            cartList = (ArrayList<Integer>)cartsession.getAttribute("cartlist");
            itemQuantity = (ArrayList<Integer>)cartsession.getAttribute("iQty");  
            ArrayList<ItemCatalogue> listitem = new ArrayList<ItemCatalogue>();
                
            if(cartList != null){        
                for( int i=0; i<cartList.size(); i++){
                    listitem.add(daoItem.getItemById(cartList.get(i), itemQuantity.get(i)));
                }    
                request.setAttribute("items", listitem);
            }
            forward = VIEW_PAYMENT;  
            request.setAttribute("totalprice", totalprice);
        }
        else if(action.equalsIgnoreCase("paymentForm")) {
            double totalprice = Double.parseDouble(request.getParameter("total"));
            cartList = (ArrayList<Integer>)cartsession.getAttribute("cartlist");
            itemQuantity = (ArrayList<Integer>)cartsession.getAttribute("iQty");  
            ArrayList<ItemCatalogue> listitem = new ArrayList<ItemCatalogue>();
                
            if(cartList != null){
                for(int i=0; i<cartList.size(); i++){
                    listitem.add(daoItem.getItemById(cartList.get(i), itemQuantity.get(i)));
                }
                request.setAttribute("items", listitem);
            }
            forward = PAYMENT_FORM;  
            request.setAttribute("totalprice", totalprice);
        }
        else if(action.equalsIgnoreCase("viewReceipt")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Payment payment = daoPayment.getPaymentById(id);        	
            forward = VIEW_RECEIPT;       		
            request.setAttribute("payment", payment);        	
        }
        RequestDispatcher view = request.getRequestDispatcher(forward);
        view.forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession cartsession = request.getSession();
        
        if(action.equalsIgnoreCase("updateOrderRider")) { //RIDER UPDATE ORDER DELIVERY STATUS	
            int orderID = Integer.parseInt(request.getParameter("orderID"));
            int riderID = Integer.parseInt(request.getParameter("riderID"));
            String orderStatus = request.getParameter("orderStatus");
            OrderDelivery order = new OrderDelivery(orderID, orderStatus);				
            order = OrderDAO.getOrder(order);
            daoOrder.updateOrder(order);
            daoRider.updateRiderStatus(riderID);
            Rider rider = daoRider.getRiderById(riderID);
//            forward = ORDER_LIST_RIDER;
            forward = "ManageRiderStatus.jsp";
//            request.setAttribute("order", daoOrder.getOrderById(orderID));
//            request.setAttribute("carts", daoCart.getAllCart(orderID));
//            request.setAttribute("customer", daoCustomer.getCustomerByOrder(orderID));
            HttpSession session = request.getSession();
            session.setAttribute("login", rider);
//            request.setAttribute("orders", daoOrder.getAllOrderRider(riderID));
            request.setAttribute("successUpdateOrderStatus", "Order Has Been Delivered");
        }
        else if (action.equalsIgnoreCase("updateOrderAdmin")) { //ADMIN UPDATES CUSTOMERS' ORDER STATUS	
            int orderID = Integer.parseInt(request.getParameter("orderID"));
            String orderStatus = request.getParameter("orderStatus");
            OrderDelivery order = new OrderDelivery(orderID, orderStatus);				
            order = OrderDAO.getOrder(order);
            daoOrder.updateOrder(order);
            forward = VIEW_ORDER_ADMIN;
            request.setAttribute("order", daoOrder.getOrderById(orderID));
            request.setAttribute("carts", daoCart.getAllCart(orderID));
            request.setAttribute("customer", daoCustomer.getCustomerByOrder(orderID));
            request.setAttribute("successUpdateOrder", "Order Has Been Delivered");
        }
        else if (action.equalsIgnoreCase("checkout")){ //COD CHECKOUT
            Payment payment;
            OrderDelivery order;
            ItemCatalogue item;
            int custID = Integer.parseInt(request.getParameter("custID"));
            String payMethod = request.getParameter("payType");
            double total = 0.0;
            double totalC = 0.0;
            String payStatus = request.getParameter("payStatus");
            cartList = (ArrayList<Integer>)cartsession.getAttribute("cartlist");
            itemQuantity = (ArrayList<Integer>)cartsession.getAttribute("iQty");  
            
            for( int i=0; i<cartList.size(); i++) { 
                item = daoItem.getItemById(cartList.get(i), itemQuantity.get(i));
                total = total + (item.getitemPrice() * itemQuantity.get(i));
                totalC = total + 5;
            }
            //PAYMENT DB
            payment = new Payment(payMethod, totalC, payStatus);
            daoPayment.addPaymentCOD(payment);
            int payID = daoPayment.getLatestID();
            //ORDER DB
            order = new OrderDelivery(payID, total, custID);
            daoOrder.addOrder(order);
            int orderID = daoOrder.getLatestOrderID();
            //CART DB
            Cart cart;
            
            for (int i=0; i<cartList.size(); i++){               
                item = daoItem.getItemById(cartList.get(i), itemQuantity.get(i));
                double cartPrice = item.getitemPrice() * itemQuantity.get(i);
                cart = new Cart (itemQuantity.get(i), cartList.get(i), cartPrice, orderID);
                daoCart.addCart(cart);
            }
            order = daoOrder.getOrderDeliveryById(orderID);
            double grandtotal = Double.parseDouble(request.getParameter("grandtotal"));
            double totalprice = Double.parseDouble(request.getParameter("totalprice")); 
            request.setAttribute("totalPrice", totalprice);
            request.setAttribute("order", order);
            request.setAttribute("grandtotal", grandtotal);
            ArrayList<ItemCatalogue> listitem = new ArrayList<ItemCatalogue>();
            if(cartList!= null) {
                for (int i=0; i<cartList.size(); i++){
                    listitem.add(daoItem.getItemById(cartList.get(i), itemQuantity.get(i)));
            }
            request.setAttribute("items",listitem);
            cartsession.removeAttribute("cartList");
            cartsession.removeAttribute("iQty");
            System.out.println("Cart is now empty");
            }
            forward = TRACK_ORDER;
            request.setAttribute("orders", daoOrder.getAllCustOrder(custID));
            request.setAttribute("successPayOrder", "Order Has Been Placed");
        }
        else if (action.equalsIgnoreCase("checkoutOnline")){ //ONLINE PAYMENT CHECKOUT
            InputStream inputStream = null;
            Payment payment = new Payment();
            OrderDelivery order;
            int custID = Integer.parseInt(request.getParameter("custID"));
            String payMethod = request.getParameter("payType");
            double total = 0.0;
            double totalC = 0.0;
            String payStatus = request.getParameter("payStatus");
            cartList = (ArrayList<Integer>)cartsession.getAttribute("cartlist");
            itemQuantity = (ArrayList<Integer>)cartsession.getAttribute("iQty");  
            ItemCatalogue item;
            
            for( int i=0; i<cartList.size(); i++) {
                item = daoItem.getItemById(cartList.get(i), itemQuantity.get(i));
                total = total + (item.getitemPrice() * itemQuantity.get(i));
                totalC = total + 5;
            }
            Part filePart = request.getPart("payReceipt"); //TAKE RECEIPT FILE
                if (filePart != null) {
                    //PRINTS SOME INFORMATION FOR DEBUGGING
                    System.out.println(filePart.getName());
                    System.out.println(filePart.getSize());
                    System.out.println(filePart.getContentType());
                    //OBTAINS INPUT STREAM OF THE UPLOAD FILE
                    inputStream = filePart.getInputStream();
                }
            //PAYMENT DB
            int row = daoPayment.addPayment(totalC, payMethod, payStatus, inputStream);
            if(row>0){
                System.out.println("File uploaded and saved into database");
            }
            int payID = daoPayment.getLatestID();
            //ORDER DB
            order = new OrderDelivery(payID, total, custID);
            daoOrder.addOrder(order);
            int orderID = daoOrder.getLatestOrderID();
            System.out.print("orderID :" + orderID);
            //CART DB
            Cart cart;
            
            for (int i=0; i<cartList.size(); i++){ 
                item = daoItem.getItemById(cartList.get(i), itemQuantity.get(i));
                double cartPrice = item.getitemPrice() * itemQuantity.get(i);
                cart = new Cart (itemQuantity.get(i), cartList.get(i), cartPrice, orderID);
                daoCart.addCart(cart);
            }
            order = daoOrder.getOrderDeliveryById(orderID);        
            double grandtotal = Double.parseDouble(request.getParameter("grandtotal"));
            double totalprice = Double.parseDouble(request.getParameter("totalprice"));
            request.setAttribute("totalPrice", totalprice);
            request.setAttribute("order", order);
            request.setAttribute("grandtotal", grandtotal);
            ArrayList<ItemCatalogue> listitem = new ArrayList<ItemCatalogue>();
            if(cartList!= null) {
                for (int i=0; i<cartList.size(); i++){
                    listitem.add(daoItem.getItemById(cartList.get(i), itemQuantity.get(i)));
            }
                request.setAttribute("items",listitem);
                cartsession.removeAttribute("cartList");
                cartsession.removeAttribute("iQty");
            }
            forward = TRACK_ORDER;
            request.setAttribute("orders", daoOrder.getAllCustOrder(custID));
            request.setAttribute("successPayOrder", "Order Has Been Placed");
        }
        RequestDispatcher view = request.getRequestDispatcher(forward);
        view.forward(request, response);
    }  
 }
