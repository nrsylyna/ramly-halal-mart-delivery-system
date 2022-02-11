package ramly.controller;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import ramly.dao.ItemCatalogueDAO;

public class LogoutController extends HttpServlet {
    private static final long serialVersionUID = 1L; //RESET STOCK AFTER LOGOUT
    static ArrayList<Integer> cartList = new ArrayList<>();
    static ArrayList<Integer> itemQuantity = new ArrayList<>();
    private ItemCatalogueDAO daoItem;
 
    public LogoutController() {
        super();
        daoItem = new ItemCatalogueDAO();
    } 
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { 
        String action = request.getParameter("action");
        HttpSession cartsession = request.getSession();
        
        if(action.equalsIgnoreCase("logoutCustomer")) { //CUSTOMER'S LOGOUT
            HttpSession session = request.getSession(false);    
            cartList = (ArrayList<Integer>)cartsession.getAttribute("cartlist"); //SESSION
            itemQuantity = (ArrayList<Integer>)cartsession.getAttribute("iQty"); //SESSION

            if(session != null) {                
                if(cartList != null && itemQuantity != null) {
                    for(int i=0; i<cartList.size(); i++) {
                        daoItem.addStock(cartList.get(i), itemQuantity.get(i));
                    }
                }
                session.invalidate(); //REMOVES ALL SESSION ATTRIBUTES BOUND TO THE SESSION
                request.setAttribute("errMessage", "You have logged out successfully");
                RequestDispatcher requestDispatcher = request.getRequestDispatcher("LoginCustomer.jsp");
                requestDispatcher.forward(request, response);
            }
        }
        else if(action.equalsIgnoreCase("logoutRider")) { //RIDER'S LOGOUT
            HttpSession session = request.getSession(false); 
 
            if(session != null) {
                session.invalidate(); //REMOVES ALL SESSION ATTRIBUTES BOUND TO THE SESSION
                request.setAttribute("errMessage", "You have logged out successfully");
                RequestDispatcher requestDispatcher = request.getRequestDispatcher("LoginRider.jsp");
                requestDispatcher.forward(request, response);
            }
        }
        else if(action.equalsIgnoreCase("logoutAdmin")) { //ADMIN'S LOGOUT
            HttpSession session = request.getSession(false); 
 
            if(session != null) {
                session.invalidate(); //REMOVES ALL SESSION ATTRIBUTES BOUND TO THE SESSION
                request.setAttribute("errMessage", "You have logged out successfully");
                RequestDispatcher requestDispatcher = request.getRequestDispatcher("LoginAdmin.jsp");
                requestDispatcher.forward(request, response);
            }
        }
    }
}
