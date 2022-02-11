package ramly.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import ramly.dao.AssignRiderDAO;
import ramly.model.Rider;
import ramly.model.OrderDelivery;

public class AssignRiderController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static String LIST_RIDER = "ViewRiderList.jsp";
    private static String LIST_ORDER = "ViewOrderList.jsp"; 
    private static String ORDER_DETAILS = "ViewOrderDetails.jsp"; 
    private String VIEW_RIDER = "ViewRider.jsp";
    private AssignRiderDAO daoAssignRider;
    String forward = null;         
       
    public AssignRiderController() {
        super();
        daoAssignRider = new AssignRiderDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
        String action = request.getParameter("action");
        
        if(action.equalsIgnoreCase("listRider")) { //LIST ALL RIDERS
            forward = LIST_RIDER;
            request.setAttribute("riders", daoAssignRider.getAllRider());
        }
        else if(action.equalsIgnoreCase("listOrder")) { //LIST ALL CUSTOMERS' ORDERS
            int id = Integer.parseInt(request.getParameter("riderID"));
            Rider rider = daoAssignRider.getRiderById(id);
            forward = LIST_ORDER;
            request.setAttribute("rider", rider);
            request.setAttribute("orders", daoAssignRider.getAllOrder());
        }
        else if(action.equalsIgnoreCase("orderDetails")) { //VIEW CUSTOMER'S ORDER DETAILS
            int riderID = Integer.parseInt(request.getParameter("riderID"));
            Rider rider = daoAssignRider.getRiderById(riderID);
            int orderID = Integer.parseInt(request.getParameter("orderID"));
            OrderDelivery order = daoAssignRider.getOrderById(orderID);
            forward = ORDER_DETAILS;
            request.setAttribute("rider", rider);
            request.setAttribute("order", order);
        }
        else if(action.equalsIgnoreCase("orderConfirmation")) { //PROMPT ALERT MESSAGE
            int riderID = Integer.parseInt(request.getParameter("riderID"));
            int orderID = Integer.parseInt(request.getParameter("orderID"));
            daoAssignRider.updateRiderOrderStatus(riderID, orderID);
            forward = "AssignRiderController?action=listRider";         
            request.setAttribute("successAssignRider", "Rider Has Been Assigned");
        }
        else if (action.equalsIgnoreCase("viewRider")) { //CUSTOMER VIEW RIDER
            int riderID = Integer.parseInt(request.getParameter("riderID"));
            Rider rider = daoAssignRider.getRiderById(riderID);  
            int orderID = Integer.parseInt(request.getParameter("orderID"));
            OrderDelivery order = daoAssignRider.getOrderById(orderID);
            forward = VIEW_RIDER;       		
            request.setAttribute("rider", rider);
            request.setAttribute("order", order);     	
        }
        RequestDispatcher view = request.getRequestDispatcher(forward);
        view.forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String filter = request.getParameter("filter"); //FILTERING RIDER BASED ON STATUS
        
        if(filter.equalsIgnoreCase("All")) {
            forward = LIST_RIDER;
            request.setAttribute("riders", daoAssignRider.getAllRider());
        }
        else {
            forward = LIST_RIDER;
            request.setAttribute("riders", daoAssignRider.getAllRiderByFilter(filter));
        }
        RequestDispatcher view = request.getRequestDispatcher(forward);
        view.forward(request, response);
    }
}