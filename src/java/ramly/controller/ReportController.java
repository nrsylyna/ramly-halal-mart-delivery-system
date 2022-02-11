package ramly.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ramly.dao.OrderDAO;

public class ReportController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static String VIEW_REPORT = "Report.jsp";
    private OrderDAO daoOrder;  
    String forward = null;
        
    public ReportController() {
        super();
        daoOrder = new OrderDAO();
    }    
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action.equalsIgnoreCase("viewReport")) {	
            String startDate = request.getParameter("start");
            String endDate = request.getParameter("end"); 
            SimpleDateFormat formatter = new SimpleDateFormat("dd MMM yyyy");
            try {
                Date sD = new SimpleDateFormat("yyyy-MM-dd").parse(startDate);
                Date eD = new SimpleDateFormat("yyyy-MM-dd").parse(endDate);
                request.setAttribute("startDate", formatter.format(sD) );
                request.setAttribute("endDate", formatter.format(eD) );
            } catch (ParseException ex) {
                Logger.getLogger(ReportController.class.getName()).log(Level.SEVERE, null, ex);
            }
            
            forward = VIEW_REPORT;       		
            request.setAttribute("order", daoOrder.getSales(startDate,endDate) );  
        }
        RequestDispatcher view = request.getRequestDispatcher(forward);
        view.forward(request, response);
    }
}
