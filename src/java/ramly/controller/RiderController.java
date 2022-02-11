package ramly.controller;

import java.io.IOException;
import static java.util.Objects.isNull;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import ramly.dao.RiderDAO;
import ramly.model.Rider;

public class RiderController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static String LIST_RIDER = "viewRiderList.jsp";
    private String UPDATE_RIDER = "UpdateRider.jsp";
    private String VIEW_RIDER = "ProfileRider.jsp";
    private String REGISTER_RIDER = "RegisterRider.jsp";
    private String LOGIN_RIDER = "LoginRider.jsp";
    private String MANAGE_RIDER = "UpdateRiderStatus.jsp";
    private String VIEW_STATUS_RIDER = "ManageRiderStatus.jsp";
    private RiderDAO daoRider;
    String forward = null;
        
    public RiderController() {
        super();
        daoRider = new RiderDAO();
    }    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if(action.equalsIgnoreCase("listRider")) {
            forward = LIST_RIDER;
            request.setAttribute("riders", daoRider.getAllRider());
        } 
        else if (action.equalsIgnoreCase("updateRider")) { 
            String id = request.getParameter("id");
            int riderID;
            
            if(isNull(id)) {
                riderID = 0;
            }
            else {  
                riderID = Integer.parseInt(id);
            }
            Rider rider = daoRider.getRiderById(riderID); 	
            forward = UPDATE_RIDER;
            request.setAttribute("rider", rider); 
        } 
        else if (action.equalsIgnoreCase("viewRider")) { //RIDER VIEWS PROFILE
            int id = Integer.parseInt(request.getParameter("id"));
            Rider rider = daoRider.getRiderById(id);        	
            forward = VIEW_RIDER;       		
            request.setAttribute("rider", rider);        	
        }
        else if (action.equalsIgnoreCase("viewStatus")) { //RIDER VIEWS STATUS
            int id = Integer.parseInt(request.getParameter("riderID"));
            Rider rider = daoRider.getRiderById(id);        	
            forward = VIEW_STATUS_RIDER;       		
            request.setAttribute("rider", rider);        	
        }
        else if (action.equalsIgnoreCase("manageRider")) { 
            String id = request.getParameter("id");
            int riderID;
            
            if(isNull(id)) {
                riderID = 0;
            }
            else {  
                riderID = Integer.parseInt(id);
            }
            Rider rider = daoRider.getRiderById(riderID);      	
            forward = MANAGE_RIDER;
            request.setAttribute("rider", rider); 
        } 
        RequestDispatcher view = request.getRequestDispatcher(forward);
        view.forward(request,response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if(action.equalsIgnoreCase("registerRider")) { //RIDER REGISTERS ACCOUNT
            String riderName = request.getParameter("riderName");
            String riderPhone = request.getParameter("riderPhone");
            String riderEmail = request.getParameter("riderEmail");
            String riderPassword = request.getParameter("riderPassword1");
            String riderStatus= request.getParameter("riderStatus");
            String riderPlate= request.getParameter("riderPlate");
            Rider rider = new Rider(riderName, riderPhone, riderEmail, riderPassword, riderStatus, riderPlate);	
            rider = daoRider.getRider(rider);

            if(!rider.isValid()) {
                daoRider.add(rider);
                forward = LOGIN_RIDER;
                request.setAttribute("successRegister", "Successfully Register Account");
            }
            else {
                daoRider.updateRider(rider);		
                forward = REGISTER_RIDER;
                request.setAttribute("failRegister", "Email/Plate Number Has Been Used");
            }
        }
        else if(action.equalsIgnoreCase("updateRider")) { //RIDER UPDATES PROFILE
            int riderID = Integer.parseInt(request.getParameter("riderID"));
            String riderName = request.getParameter("riderName");
            String riderPhone = request.getParameter("riderPhone");
            String riderEmail = request.getParameter("riderEmail");
            String riderPassword = request.getParameter("riderPassword");
            String riderPlate= request.getParameter("riderPlate");
            Rider rider = new Rider(riderID, riderName, riderPhone, riderEmail, riderPassword, riderPlate);				
            rider.setRiderID(riderID);
            rider.setRiderName(riderName);
            rider.setRiderPhone(riderPhone);
            rider.setRiderEmail(riderEmail);
            rider.setRiderPassword(riderPassword);
            rider.setRiderPlate(riderPlate);
            daoRider.updateRider(rider);
            rider = daoRider.getRiderById(riderID);
            HttpSession session = request.getSession();
            session.setAttribute("login", rider);
            forward = VIEW_RIDER;
            request.setAttribute("rider", rider); 
            request.setAttribute("successUpdateProfile", "Successfully Update Profile"); 
        }
        else if(action.equalsIgnoreCase("manageStatus")) { //RIDER MANAGES STATUS
            int riderID = Integer.parseInt(request.getParameter("riderID"));
            String riderName = request.getParameter("riderName");
            String riderStatus = request.getParameter("status");
            Rider rider = new Rider(riderID, riderName,riderStatus);				
            rider.setRiderID(riderID);
            rider.setRiderName(riderName);
            rider.setRiderStatus(riderStatus);
            daoRider.manageRider(rider);
            rider = daoRider.getRiderById(riderID);
            HttpSession session = request.getSession();
            session.setAttribute("login", rider);
            forward = VIEW_STATUS_RIDER;
            request.setAttribute("rider", rider); 
            request.setAttribute("successUpdateStatus", "Successfully Update Status"); 
        }
        RequestDispatcher view = request.getRequestDispatcher(forward);
        view.forward(request, response);
    }
}
