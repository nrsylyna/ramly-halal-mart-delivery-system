package ramly.controller;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import static java.util.Objects.isNull;
import javax.servlet.http.HttpSession;
import ramly.dao.CustomerDAO;
import ramly.dao.ItemCatalogueDAO;
import ramly.model.Customer;
import ramly.model.ItemCatalogue;

public class CustomerController extends HttpServlet {
    private static final long serialVersionUID = 1L; 
    static ArrayList<Integer> cartList = new ArrayList<>();
    static ArrayList<Integer> iQty = new ArrayList<>();
    private String LIST_CUSTOMER = "ListCustomer.jsp"; 
    private String UPDATE_CUSTOMER = "UpdateCustomer.jsp"; 
    private String UPDATE_CUSTOMER_ADDRESS = "UpdateCustomerAddress.jsp";
    private String VIEW_CUSTOMER = "ProfileCustomer.jsp";
    private String REGISTER_CUSTOMER = "RegisterCustomer.jsp";
    private String LOGIN_CUSTOMER = "LoginCustomer.jsp";
    private String VIEW_PAYMENT = "ViewPayment.jsp";
    private CustomerDAO daoCustomer;
    private ItemCatalogueDAO daoItem;
    String forward = null;         
       
    public CustomerController() {
        super();
        daoCustomer = new CustomerDAO();
        daoItem = new ItemCatalogueDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
        String action = request.getParameter("action");
        HttpSession cartsession = request.getSession();
         
        if(action.equalsIgnoreCase("listCustomer")) {
            forward = LIST_CUSTOMER;
            request.setAttribute("customers", daoCustomer.getAllCustomer());
        }
        else if(action.equalsIgnoreCase("updateCustomer")) { //CUSTOMER VIEWS THEIR DETAILS TO BE UPDATED
            String id = request.getParameter("id");
            int custID;
            
            if(isNull(id)) {
                custID = 0;
            }
            else {  
                custID = Integer.parseInt(id);
            }
            Customer customer = daoCustomer.getCustomerById(custID);
            forward = UPDATE_CUSTOMER;
            request.setAttribute("customer", customer);
        }
        else if(action.equalsIgnoreCase("updateCustomerAddress")) { //CUSTOMER VIEWS THEIR ADDRESS TO BE UPDATED
            String id = request.getParameter("id");
            int custID;
            
            if(isNull(id)) {
                custID = 0;
            }
            else {  
                custID = Integer.parseInt(id);
            }
            Customer customer = daoCustomer.getCustomerById(custID);
            double totalprice = Double.parseDouble(request.getParameter("total"));
            cartList = (ArrayList<Integer>)cartsession.getAttribute("cartlist");               
            iQty = (ArrayList<Integer>)cartsession.getAttribute("iQty");                  
            ArrayList<ItemCatalogue> listitem = new ArrayList<ItemCatalogue>();
                
            if(cartList != null){
                for( int i=0; i<cartList.size(); i++){
                    listitem.add(daoItem.getItemById(cartList.get(i),iQty.get(i)));
                }
                request.setAttribute("items", listitem);
            }
            forward = UPDATE_CUSTOMER_ADDRESS;
            request.setAttribute("totalprice", totalprice);           
            request.setAttribute("customer", customer);
        }
        else if(action.equalsIgnoreCase("viewCustomer")) { //CUSTOMER VIEWS PROFILE
            int id = Integer.parseInt(request.getParameter("id"));
            Customer customer = daoCustomer.getCustomerById(id);
            forward = VIEW_CUSTOMER;
            request.setAttribute("customer", customer);
        }
        RequestDispatcher view = request.getRequestDispatcher(forward);
        view.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession cartsession = request.getSession();
        
        if(action.equalsIgnoreCase("registerCustomer")) { //CUSTOMER REGISTERS ACCOUNT  
            String custUsername = request.getParameter("custUsername");
            String custName = request.getParameter("custName");
            String custPhone = request.getParameter("custPhone");
            String custEmail = request.getParameter("custEmail");
            String custPassword = request.getParameter("custPassword1");
            String address = request.getParameter("custAddress");
            String city = request.getParameter("custCity");
            String state = request.getParameter("custState");
            String postcode = request.getParameter("custPostcode");
            String custAddress = address + ", " + postcode + " " + city + ", " + state;
            
            Customer customer = new Customer(custUsername, custName, custPhone, custEmail, custPassword, custAddress);		
            customer = daoCustomer.getCustomer(customer);

            if(!customer.isValid()) {
                daoCustomer.add(customer);
                forward = LOGIN_CUSTOMER;
                request.setAttribute("successRegister", "Successfully Register Account");
            }
            else {
                daoCustomer.updateCustomer(customer);
                forward = REGISTER_CUSTOMER;
                request.setAttribute("failRegister", "Username/Email Has Been Used");
            }
        }
        else if(action.equalsIgnoreCase("updateCustomer"))  { //CUSTOMER UOPDATES PROFILE   
            int custID = Integer.parseInt(request.getParameter("custID"));
            String custUsername = request.getParameter("custUsername");
            String custName = request.getParameter("custName");
            String custPhone = request.getParameter("custPhone");
            String custEmail = request.getParameter("custEmail");
            String custPassword = request.getParameter("custPassword");
            String address = request.getParameter("custAddress");
            String city = request.getParameter("custCity");
            String state = request.getParameter("custState");
            String postcode = request.getParameter("custPostcode");
            String custAddress = address + ", " + postcode + " " + city + ", " + state;
            
            Customer customer = new Customer(custID, custUsername, custName, custPhone, custEmail, custPassword, custAddress);				
            customer.setCustID(custID);
            customer.setCustUsername(custUsername);
            customer.setCustName(custName);
            customer.setCustPhone(custPhone);
            customer.setCustEmail(custEmail);
            customer.setCustPassword(custPassword);
            customer.setCustAddress(custAddress);
            daoCustomer.updateCustomer(customer);
            customer = daoCustomer.getCustomerById(custID);
            HttpSession session = request.getSession();
            session.setAttribute("login", customer);
            forward = VIEW_CUSTOMER;
            request.setAttribute("customer", customer); 
            request.setAttribute("successUpdateProfile", "Successfully Update Profile"); 
        }
        else if(action.equalsIgnoreCase("updateCustomerAddress")) { //CUSTOMER UPDATES ADDRESS FOR DELIVERY    
            int custID = Integer.parseInt(request.getParameter("custID"));
            String address = request.getParameter("custAddress");
            String city = request.getParameter("custCity");
            String state = request.getParameter("custState");
            String postcode = request.getParameter("custPostcode");
            String custAddress = address + ", " + postcode + " " + city + ", " + state;
            String custPhone = request.getParameter("custPhone");
            Customer customer = new Customer(custID, custAddress, custPhone);				
            customer.setCustID(custID);
            customer.setCustAddress(custAddress);
            customer.setCustPhone(custPhone);
            customer = daoCustomer.updateaddress(customer);
            customer = daoCustomer.getCustomerById(custID);
            HttpSession session = request.getSession();
            session.setAttribute("login", customer);
            
            double totalprice = Double.parseDouble(request.getParameter("total"));
            cartList = (ArrayList<Integer>)cartsession.getAttribute("cartlist");
                
            iQty = (ArrayList<Integer>)cartsession.getAttribute("iQty");  
                
            ArrayList<ItemCatalogue> listitem = new ArrayList<ItemCatalogue>();
                
            if(cartList != null){
                for( int i=0; i<cartList.size(); i++){
                    listitem.add(daoItem.getItemById(cartList.get(i),iQty.get(i)));
                }
                request.setAttribute("items", listitem);
            }
            request.setAttribute("totalprice", totalprice);
            request.setAttribute("customer", customer); 
            forward = VIEW_PAYMENT;
            request.setAttribute("successUpdateAddress", "Successfully Update Address"); 
        }
	RequestDispatcher view = request.getRequestDispatcher(forward);
        view.forward(request, response);
    }
}