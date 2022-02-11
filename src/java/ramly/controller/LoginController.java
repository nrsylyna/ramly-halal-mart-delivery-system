package ramly.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import ramly.dao.AdminDAO;
import ramly.dao.RiderDAO;
import ramly.dao.CustomerDAO;
import ramly.model.Admin;
import ramly.model.Rider;
import ramly.model.Customer;

public class LoginController extends HttpServlet {
    private String HOMEPAGE_ADMIN = "HomepageAdmin.jsp"; 
    private String LOGIN_ADMIN = "LoginAdmin.jsp"; 
    private String HOMEPAGE_RIDER = "HomepageRider.jsp";
    private String LOGIN_RIDER = "LoginRider.jsp"; 
    private String FORGOTPASSWORD_RIDER = "ForgotPasswordRider.jsp"; 
    private String HOMEPAGE_CUSTOMER = "HomepageCustomer.jsp";
    private String LOGIN_CUSTOMER = "LoginCustomer.jsp"; 
    private String FORGOTPASSWORD_CUSTOMER = "ForgotPasswordCustomer.jsp"; 
    private AdminDAO daoAdmin;
    private RiderDAO daoRider;
    private CustomerDAO daoCustomer;
    boolean check;
    String forward = null;     

    public LoginController() {
        super();
        daoAdmin = new AdminDAO();
        daoRider = new RiderDAO();
        daoCustomer = new CustomerDAO();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if(action.equalsIgnoreCase("loginCustomer")) { 
            String custUsername = request.getParameter("custUsername");
            String custPassword = request.getParameter("custPassword");
            Customer customer = daoCustomer.login(custUsername, custPassword);

            if(customer != null) {
                HttpSession session = request.getSession();
                session.setAttribute("login", customer);
                request.setAttribute("successLogin","Successfully Login");
                forward = HOMEPAGE_CUSTOMER;
            }
            else {
                request.setAttribute("failLogin", "User Not Found!");
                forward = LOGIN_CUSTOMER;
            }
        }
        else if(action.equalsIgnoreCase("resetPasswordCustomer")) {
            String custEmail = request.getParameter("custEmail");
            String custPassword = request.getParameter("custNewPassword1");
            check = daoCustomer.resetPassword(custEmail, custPassword);
            
            if(check) {
                request.setAttribute("successResetPassword","Successfully Reset Password");
                forward = LOGIN_CUSTOMER;
            }
            else {
                request.setAttribute("failResetPassword","User Not Found!");
                forward = FORGOTPASSWORD_CUSTOMER;
            }
        }
        else if(action.equalsIgnoreCase("loginRider")) { 
            int riderID = Integer.parseInt(request.getParameter("riderID"));
            String riderPassword = request.getParameter("riderPassword");
            Rider rider = daoRider.login(riderID, riderPassword);

            if(rider != null) {
                HttpSession session = request.getSession();
                session.setAttribute("login", rider);
                request.setAttribute("successLogin","Successfully Login");
                forward = HOMEPAGE_RIDER;
            }
            else {
                request.setAttribute("failLogin", "User Not Found!");
                forward = LOGIN_RIDER;
            }
        }
        else if(action.equalsIgnoreCase("resetPasswordRider")) {
            String riderEmail = request.getParameter("riderEmail");
            String riderPassword = request.getParameter("riderNewPassword1");
            check = daoRider.resetPassword(riderEmail, riderPassword);
            
            if(check) {
                request.setAttribute("successResetPassword","Successfully Reset Password");
                forward = LOGIN_RIDER;
            }
            else {
                request.setAttribute("failResetPassword","User Not Found!");
                forward = FORGOTPASSWORD_RIDER;
            }
        }
        else if(action.equalsIgnoreCase("loginAdmin")) { 
            int adminID = Integer.parseInt(request.getParameter("adminID"));
            String adminPassword = request.getParameter("adminPassword");
            Admin admin = daoAdmin.login(adminID, adminPassword);

            if(admin != null) {
                HttpSession session = request.getSession();
                session.setAttribute("login", admin);
                request.setAttribute("in","Successfully Login");
                forward = HOMEPAGE_ADMIN;
            }
            else {
                request.setAttribute("error", "User not found! Please try again");
                forward = LOGIN_ADMIN;
            }
        }
        RequestDispatcher requestDispatcher = request.getRequestDispatcher(forward);
        requestDispatcher.forward(request, response);
    }
}
