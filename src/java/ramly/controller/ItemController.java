package ramly.controller;

import java.util.logging.Level;
import java.util.logging.Logger;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import ramly.dao.ItemCatalogueDAO;
import ramly.model.ItemCatalogue;

@MultipartConfig(maxFileSize = 16177216)//1.5mb
public class ItemController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private String MAIN = "MainProducts.jsp";
    private String SEARCH = "SearchItem.jsp";
    private String ADD_TO_CART = "AddToCart.jsp";
    private String CATALOGUE = "ItemCatalogue.jsp";
    private String UPDATE_ITEM = "UpdateItem.jsp";
    private ItemCatalogueDAO daoItem;
    String forward = null;
    PrintWriter out;
        
    public ItemController() {
        super();
        daoItem = new ItemCatalogueDAO();
    }    
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
		
        if(action.equalsIgnoreCase("mainCatalogue")) { 
            request.setAttribute("itemAll", daoItem.getAllItem());
            forward = MAIN;
        }
        else if(action.equalsIgnoreCase("custCatalogue")) { //CUSTOMER VIEW CATALOGUE
            request.setAttribute("itemAll", daoItem.getAllItem());
            forward = ADD_TO_CART;
        }
        else if(action.equalsIgnoreCase("catalogue")) { //ADMIN VIEW CATALOGUE
            request.setAttribute("itemAll", daoItem.getAllItem()); 
            forward = CATALOGUE;
        }
        else if(action.equalsIgnoreCase("deleteItem")) { //ADMIN DELETE ITEM
            int  id = Integer.parseInt(request.getParameter("id"));
            daoItem.deleteItem(id);
            forward = CATALOGUE;
            request.setAttribute("itemAll", daoItem.getAllItem()); 
            request.setAttribute("successDeleteItem", "Item Has Been Deleted"); 
	} 
        else if(action.equalsIgnoreCase("updateItem")) { //ADMIN UPDATE ITEM	
            int  id = Integer.parseInt(request.getParameter("id"));
            
            try {
                ItemCatalogue item = daoItem.get(id);
                request.setAttribute("item", item);
                forward = UPDATE_ITEM;
            } 
            catch(SQLException ex) {
                Logger.getLogger(ItemController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } 
        RequestDispatcher view = request.getRequestDispatcher(forward);
        view.forward(request,response);
    } 
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
		
        if (action.equalsIgnoreCase("addItem")) { 
            String itemName = request.getParameter("itemName");
            Double itemPrice = Double.parseDouble(request.getParameter("itemPrice"));
            int itemQty = Integer.parseInt(request.getParameter("itemQty"));
            String itemType = request.getParameter("itemType");
            String itemDescription = request.getParameter("itemDescription");
            InputStream inputStream = null; //INPUT STREAM OF UPLOAD FILE
            String message = null;
            //OBTAINS THE UPLOAD FILE PART IN THIS MULTIPART REQEUEST
            Part filePart = request.getPart("itemImg");
            if (filePart != null) {
                //PRINTS OUT SOME INFORMATION FOR DEBUGGING
                System.out.println(filePart.getName());
                System.out.println(filePart.getSize());
                System.out.println(filePart.getContentType());
                //OBTAINS INPUT STREAM OF THE UPLOAD FILE
                inputStream = filePart.getInputStream();
            }
            //SENDS THE STATEMENT TO THE DATABASE SERVER
            int row = daoItem.uploadFile(itemName,itemPrice, itemQty, itemType, itemDescription, inputStream);
            if(row > 0) {
                System.out.println("File uploaded and saved into database");
            }
            forward = CATALOGUE;
            request.setAttribute("itemAll", daoItem.getAllItem()); 
            request.setAttribute("successAddItem", "Successfull Add Item"); 
        }
        else if(action.equalsIgnoreCase("updateItem")) { 
            int itemID = Integer.parseInt(request.getParameter("itemID"));
            String itemName = request.getParameter("itemName");
            Double itemPrice = Double.parseDouble(request.getParameter("itemPrice"));
            int itemQty = Integer.parseInt(request.getParameter("itemQty"));
            String itemType = request.getParameter("itemType");
            String itemDescription = request.getParameter("itemDescription");
            InputStream inputStream = null;

            Part filePart = request.getPart("itemImg");
            if (filePart != null) {
                inputStream = filePart.getInputStream();
            }
            
            int row = daoItem.updateItem(itemID, itemName,itemPrice, itemQty, itemType, itemDescription, inputStream);
            if(row > 0) {
                System.out.println("File uploaded and saved into database");
            }
              forward = CATALOGUE;
              request.setAttribute("itemAll", daoItem.getAllItem()); 
              request.setAttribute("successUpdateItem", "Successfully Update Item"); 
              
        }
        else if(action.equalsIgnoreCase("searchItem")) { //SEARCH FOR ITEM
            String search = request.getParameter("search");
            List<ItemCatalogue> itemAll = daoItem.search(search.toLowerCase()); //ADD toLowerCase()FUNCTION 
            forward = SEARCH;

            if(itemAll.isEmpty() || search.length() == 0)
                request.setAttribute("alertMsg", "The keyword you entered is invalid. Please try another keyword");
            else
                request.setAttribute("itemAll", itemAll);
         }
        RequestDispatcher view = request.getRequestDispatcher(forward);
        view.forward(request,response);
    }
}