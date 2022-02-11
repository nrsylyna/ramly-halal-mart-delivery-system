package ramly.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import ramly.dao.PaymentDAO;
import ramly.model.OrderDelivery;
import ramly.model.Payment;

@MultipartConfig(maxFileSize = 16177215) 
public class PaymentController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static String LIST_PAYMENT = "ViewPaymentList.jsp";
    private static String UPDATE_PAYMENT = "UpdatePayStatus.jsp";
    private static String VIEW_PAYMENT = "ViewPayDetail.jsp";
    private static String VIEW_PAYMENTCOD = "ViewPayDetailCOD.jsp";
    private static String VIEW_RECEIPT = "Receipt.jsp";
    private static String SEARCH_PAYMENT = "ViewPaymentList.jsp";
    private PaymentDAO daoPayment;
    String forward = null;         
       
    public PaymentController() {
        super();
        daoPayment = new PaymentDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
        String action = request.getParameter("action");
        
        if(action.equalsIgnoreCase("listPayment")) { //ADMIN VIEWS ALL LIST PAYMENT 
            forward = LIST_PAYMENT;
            request.setAttribute("payments", daoPayment.getAllPayment());
        }
        else if(action.equalsIgnoreCase("deletePayment")) { //ADMIN DELETES PAYMENT
            int id = Integer.parseInt(request.getParameter("id"));
            daoPayment.deletePayment(id);
            forward = LIST_PAYMENT;
            request.setAttribute("payments", daoPayment.getAllPayment()); 
            request.setAttribute("successDeletePayment", "Payment Has Been Deleted");
	} 
        else if(action.equalsIgnoreCase("updatePayment")) { //ADMIN UPDATES PAYMENT STATUS	
            int id = Integer.parseInt(request.getParameter("id"));
            Payment payment = daoPayment.getPaymentById(id);
            forward = UPDATE_PAYMENT;
            request.setAttribute("payment", payment); 
        }
        else if (action.equalsIgnoreCase("viewPayment")) { //ADMIN VIEWS PAYMENT 
            int id = Integer.parseInt(request.getParameter("id"));
            Payment payment = daoPayment.getPaymentById(id);	
            String type = payment.getPayType();
            
            if(type.equalsIgnoreCase("COD")) {
                forward = VIEW_PAYMENTCOD;
                request.setAttribute("payment", payment);
            }
            else {
                payment = daoPayment.getPaymentOnlineById(id);  
                forward = VIEW_PAYMENT;       		
                request.setAttribute("payment", payment);  
            }   	
        }
        else if (action.equalsIgnoreCase("viewReceipt")) {  //CUSTOMER VIEWS RECEIPT
            int id = Integer.parseInt(request.getParameter("id"));
            Payment payment = daoPayment.getPaymentByOrderId(id); 
            OrderDelivery order = daoPayment.getTotalByOrderId(id);
            forward = VIEW_RECEIPT;
            request.setAttribute("orderdelivery", order);
            request.setAttribute("payment", payment);
            request.setAttribute("receipts", daoPayment.getAllReceipt(order.getOrderID()));           	
        }
        RequestDispatcher view = request.getRequestDispatcher(forward);
        view.forward(request,response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        //SimpleDateFormat date = new SimpleDateFormat("dd/mm/yyyy HH:mm:ss");  
        
        if(action.equalsIgnoreCase("updatePay")) { //ADMIN UPDATES PAYMENT STATUS
            int payID = Integer.parseInt(request.getParameter("payID"));
            double payAmount = Double.parseDouble(request.getParameter("payAmount"));
            String payType = request.getParameter("payType");
            String payStatus = request.getParameter("payStatus");
            int adminID = Integer.parseInt(request.getParameter("adminID"));
            Payment payment = new Payment(payID, payAmount, payType, payStatus, adminID);	
            payment.setPayID(payID);
            payment.setPayAmount(payAmount);
            payment.setPayType(payType);
            payment.setPayStatus(payStatus);
            payment.setAdminID(adminID);
            payment = daoPayment.updatePayment(payment);
            payment = daoPayment.getPaymentById(payID);
            forward = LIST_PAYMENT;
            request.setAttribute("payments", daoPayment.getAllPayment());
            request.setAttribute("successUpdatePayment", "Successfully Update Payment");
        }
        else if(action.equalsIgnoreCase("searchID")) { //SEARCH BY ORDERID
            String searchorder = request.getParameter("searchOrder");
            forward = SEARCH_PAYMENT;
            request.setAttribute("payments", daoPayment.getPaymentByOrderID(searchorder));
        }
        else if(action.equalsIgnoreCase("filterItem")) { //SEARCH FOR ITEM
            String filter = request.getParameter("filter");
            
            if(filter.equalsIgnoreCase("All")) { //ADMIN VIEWS ALL LIST PAYMENT 
                forward = SEARCH_PAYMENT;
                request.setAttribute("payments", daoPayment.getAllPayment());
            }
            else if(filter.equalsIgnoreCase("unpaid") || filter.equalsIgnoreCase("paid")) {
                forward = SEARCH_PAYMENT;
                request.setAttribute("payments", daoPayment.getPaymentByStatus(filter));
            } 
            else if(filter.equalsIgnoreCase("cod") || filter.equalsIgnoreCase("online payment")) {
                forward = SEARCH_PAYMENT;
                request.setAttribute("payments", daoPayment.getPaymentByType(filter));
            }
        }
        RequestDispatcher view = request.getRequestDispatcher(forward);
        view.forward(request, response);
    }

}