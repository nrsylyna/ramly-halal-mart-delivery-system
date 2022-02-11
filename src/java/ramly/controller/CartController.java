package ramly.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import ramly.model.ItemCatalogue;
import ramly.dao.ItemCatalogueDAO;

public class CartController extends HttpServlet {  
    private static final long serialVersionUID = 1L;
    private ItemCatalogueDAO daoItem;
    static ArrayList<Integer> cartList = new ArrayList<>();
    static ArrayList<Integer> itemQuantity = new ArrayList<>();
    static ArrayList<Integer> qty = new ArrayList<>();
    String forward = null;
    int amount = 0;
    PrintWriter out;

    public CartController() {
        super();
        daoItem = new ItemCatalogueDAO();
    } 
    
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession cartSession = request.getSession();
            
        if(action.equalsIgnoreCase("addToCart")) {
            ItemCatalogue itemCatalogue = new ItemCatalogue();
            int id = Integer.parseInt(request.getParameter("id"));
            boolean check;     
            cartList = (ArrayList<Integer>)cartSession.getAttribute("cartlist"); 
            itemQuantity = (ArrayList<Integer>)cartSession.getAttribute("iQty"); 
            qty = (ArrayList<Integer>)cartSession.getAttribute("qty"); 
                
            if(cartList == null) {
                check = false;
            }
            else {
                check = itemCatalogue.check(cartList, id);
            }
                         
            if(check) {
                for(int i=0; i<itemQuantity.size(); i++) {
                    if(cartList.get(i) == id){
                        int itemFound = itemQuantity.get(i);
                        int quantity = itemFound + 1;
                        itemQuantity.set(i, quantity);
                        qty.set(i,quantity);
                        daoItem.removeStock(id, 1); //MINUS STOCK(DATABASE)WHEN ADDING ITEM TO CART
                    }
                }
                cartSession.setAttribute("cartlist", cartList);
                cartSession.setAttribute("iQty", itemQuantity);
                cartSession.setAttribute("qty", qty);
                request.setAttribute("successAddItem","Item Has Been Added To Cart");
                forward = "CartController?action=viewCart";
            }  
            else {
                if(cartList == null) {
                    cartList = new ArrayList<>();
                    itemQuantity = new ArrayList<>();
                    qty = new ArrayList<>();
                }
                    
                cartList.add(id);
                itemQuantity.add(1);
                qty.add(1);
                daoItem.removeStock(id, 1); //MINUS STOCK(DATABASE)WHEN ADDING ITEM TO CART
                cartSession.setAttribute("cartlist", cartList);
                cartSession.setAttribute("iQty", itemQuantity);
                cartSession.setAttribute("qty", qty);
                request.setAttribute("successAddItem","Item Has Been Added To Cart");
                forward = "CartController?action=viewCart";
            }
        }
        else if(action.equalsIgnoreCase("removeFromCart")) {  ;
            ItemCatalogue itemCatalogue = new ItemCatalogue();
            int id = Integer.parseInt(request.getParameter("id"));
            boolean check;
            cartList = (ArrayList<Integer>)cartSession.getAttribute("cartlist"); 
            itemQuantity = (ArrayList<Integer>)cartSession.getAttribute("iQty"); 
            qty = (ArrayList<Integer>)cartSession.getAttribute("qty");
            
            check = itemCatalogue.check(cartList, id);
            
            for(int i=0; i<qty.size(); i++) {
                if(cartList.get(i) == id) {
                    amount = qty.get(i);
                }
            }
            
            if(check) {
                for(int i=0; i<itemQuantity.size(); i++) {
                     if(cartList.get(i) == id) {
                        itemQuantity.remove(i);
                        cartList.remove(i);
                        qty.remove(i);
                        daoItem.addStock(id, amount); //ADD STOCK(DATABASE)WHEN REMOVING ITEM TO CART
                    }
                }
                cartSession.setAttribute("cartlist", cartList);
                cartSession.setAttribute("iQty", itemQuantity);
                cartSession.setAttribute("qty", qty);
               request.setAttribute("successRemoveItem","Item Has Been Removed From Cart");
                forward = "CartController?action=viewCart";
            }  
        }
        else if(action.equalsIgnoreCase("viewCart")) {   
            cartList = (ArrayList<Integer>)cartSession.getAttribute("cartlist");
            itemQuantity = (ArrayList<Integer>)cartSession.getAttribute("iQty");  
            ArrayList<ItemCatalogue> listitem = new ArrayList<>();
                
            if(cartList != null) {
                for( int i=0; i<cartList.size(); i++){
                    listitem.add(daoItem.getItemById(cartList.get(i), itemQuantity.get(i)));
                }    
                    request.setAttribute("items", listitem);
            }    
            forward = "ShoppingCart.jsp";
        }
        RequestDispatcher view = request.getRequestDispatcher(forward);
        view.forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession cartSession = request.getSession();
        
        if(action.equalsIgnoreCase("updateCart")) {
            int id = Integer.parseInt(request.getParameter("id"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            ItemCatalogue itemCatalogue = new ItemCatalogue();
            cartList = (ArrayList<Integer>)cartSession.getAttribute("cartlist");
            itemQuantity = (ArrayList<Integer>)cartSession.getAttribute("iQty"); 
            qty = (ArrayList<Integer>)cartSession.getAttribute("qty"); 

            boolean check = itemCatalogue.check(cartList, id);

            for(int i=0; i<qty.size(); i++) {
                if(cartList.get(i) == id) {
                    amount = qty.get(i);
                    daoItem.addStock(id, amount);
                }
            }

            if(check) {
                if(quantity <= daoItem.getStock(id)) {
                    for(int i=0; i<itemQuantity.size(); i++) {
                        if(cartList.get(i) == id){
                            itemQuantity.set(i, quantity);
                            qty.set(i, quantity);
                            daoItem.removeStock(id, quantity); //MINUS STOCK(DATABASE)WHEN ADDING ITEM TO CART
                        }
                    }
                    cartSession.setAttribute("cartlist", cartList);
                    cartSession.setAttribute("iQty", itemQuantity);
                    cartSession.setAttribute("qty", qty);
                    request.setAttribute("successUpdateItemQuantity","Item Quantity Has been Updated");
                    forward = "CartController?action=viewcart";
                }
                else if(quantity > daoItem.getStock(id)) {
                    daoItem.removeStock(id, amount);
                    request.setAttribute("failAddItem","Quantity Entered Exceeds Item Stock!");
                    forward = "CartController?action=viewcart";
                }
            }  
        }
        if(action.equalsIgnoreCase("updateCart2")) {
            int id = Integer.parseInt(request.getParameter("id"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            ItemCatalogue itemCatalogue = new ItemCatalogue();
            cartList = (ArrayList<Integer>)cartSession.getAttribute("cartlist");
            itemQuantity = (ArrayList<Integer>)cartSession.getAttribute("iQty"); 
            qty = (ArrayList<Integer>)cartSession.getAttribute("qty"); 

            boolean check = itemCatalogue.check(cartList, id);

            for(int i=0; i<qty.size(); i++) {
                if(cartList.get(i) == id) {
                    amount = qty.get(i);
                    daoItem.addStock(id, amount);
                }
            }

            if(check) {
                if(quantity < daoItem.getStock(id)) {
                    for(int i=0; i<itemQuantity.size(); i++) {
                        if(cartList.get(i) == id){
                            itemQuantity.set(i, quantity);
                            qty.set(i, quantity);
                            daoItem.removeStock(id, quantity); //MINUS STOCK(DATABASE)WHEN ADDING ITEM TO CART
                        }
                    }
                    cartSession.setAttribute("cartlist", cartList);
                    cartSession.setAttribute("iQty", itemQuantity);
                    cartSession.setAttribute("qty", qty);
                    request.setAttribute("successUpdateItemQuantity","Item Quantity Has been Updated");
                    forward = "CartController?action=viewcart";
                }
                else if(quantity > daoItem.getStock(id)) {
                    daoItem.removeStock(id, amount);
                    request.setAttribute("failAddItem","Quantity Entered Exceeds Item Stock!");
                    forward = "CartController?action=viewcart";
                }
                else if(quantity == daoItem.getStock(id)) {
                    daoItem.removeStock(id, amount);
                    request.setAttribute("errorAddItem","Item Out Of Stock!");
                    forward = "CartController?action=viewcart";
                }
            }  
        }
        else if(action.equalsIgnoreCase("viewcart")) {   
            cartList = (ArrayList<Integer>)cartSession.getAttribute("cartlist");
            itemQuantity = (ArrayList<Integer>)cartSession.getAttribute("iQty");  
            ArrayList<ItemCatalogue> listitem = new ArrayList<>();
                
            if(cartList != null) {
                for( int i=0; i<cartList.size(); i++){
                    listitem.add(daoItem.getItemById(cartList.get(i), itemQuantity.get(i)));
                }    
                    request.setAttribute("items", listitem);
            }    
            forward = "ShoppingCart.jsp";
        }
        RequestDispatcher view = request.getRequestDispatcher(forward);
        view.forward(request, response);
    }
}
