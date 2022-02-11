package ramly.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Date; 
import java.text.SimpleDateFormat; 

import ramly.connection.ConnectionManager;
import ramly.model.Cart;

public class CartDAO {
    static Connection currentCon = null;
    static ResultSet rs = null; 
    static PreparedStatement ps=null;
    static Statement stmt=null;
    
    static int id, item_OrderQty, item_ID, order_ID;
    static String status, deliverDate, deliverTime, notes; 
    static Double total,cart_Total;
    
      
    public static Cart getCart(Cart cart){
        
        id = cart.getCartID();
        String searchQuery = "select * from CART where CARTID = '"+id+"'";
        
        try {
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            rs = stmt.executeQuery(searchQuery);
            boolean more = rs.next();
            
            System.out.println(searchQuery);

            // if subject exists set the isValid variable to true
            if (more) {
                cart.setValid(true);
           	}
           
            else if (!more) {            	
            	cart.setValid(false);
            }
           
        }
        catch (Exception ex) {
            System.out.println("Log In failed: An Exception has occurred! " + ex);
        }

        finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                }
                rs = null;
            }

            if (stmt != null) {
                try {
                    stmt.close();
                } catch (Exception e) {
                }
                stmt = null;
            }

            if (currentCon != null) {
                try {
                    currentCon.close();
                } catch (Exception e) {
                }

                currentCon = null;
            }
        }
        return cart;
    }
        
        public List<Cart> getAllCart(int orderID)
        {
            List<Cart> carts = new ArrayList<Cart>();
            
            try
            {
                currentCon = ConnectionManager.getConnection();
	        ps=currentCon.prepareStatement("select c.CARTITEMQTY, c.CARTITEMTOTAL, c.ORDERID, c.ITEMID, c.CARTID, i.ITEMNAME from CART c join ITEMCATALOGUE i on c.ITEMID = i.ITEMID where c.ORDERID=?");
	        
	        ps.setInt(1, orderID);
	        ResultSet rs = ps.executeQuery();
                 
                while (rs.next()) 
                {
                    Cart cart = new Cart();
                    cart.setCartQty(rs.getInt("CARTITEMQTY"));
                    cart.setCartTotal(rs.getDouble("CARTITEMTOTAL"));
                    cart.setOrderID(rs.getInt("ORDERID"));
                    cart.setItemID(rs.getInt("ITEMID"));
                    cart.setCartID(rs.getInt("CARTID"));
                    cart.setItemName(rs.getString("ITEMNAME"));
                    carts.add(cart);
                }
            }
            catch (SQLException e) 
            {
                e.printStackTrace();
            }

            return carts;
	}
    
         public static Cart add(Cart cart){
        
        id = cart.getCartID();
        String searchQuery = "select * from CART where CARTID = '"+id+"'";
        
        try {
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            rs = stmt.executeQuery(searchQuery);
            boolean more = rs.next();
            
            System.out.println(searchQuery);

            // if subject exists set the isValid variable to true
            if (more) {
                cart.setValid(true);
           	}
           
            else if (!more) {            	
            	cart.setValid(false);
            }
           
        }
        catch (Exception ex) {
            System.out.println("Log In failed: An Exception has occurred! " + ex);
        }

        finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                }
                rs = null;
            }

            if (stmt != null) {
                try {
                    stmt.close();
                } catch (Exception e) {
                }
                stmt = null;
            }

            if (currentCon != null) {
                try {
                    currentCon.close();
                } catch (Exception e) {
                }

                currentCon = null;
            }
        }
        return cart;
    }
         
      public void addCart(Cart cart){
        
          item_OrderQty = cart.getCartQty();
          item_ID = cart.getItemID();
          order_ID = cart.getOrderID();
          cart_Total= cart.getCartTotal();
        
        try {
            currentCon = ConnectionManager.getConnection();
            ps = currentCon.prepareStatement("INSERT INTO CART (CARTITEMQTY, ITEMID, CARTITEMTOTAL, ORDERID) values (?,?,?,?)");
            ps.setInt(1,item_OrderQty);
            ps.setInt(2,item_ID);
            ps.setDouble(3,cart_Total);
            ps.setInt(4,order_ID);
            //ps.executeUpdate();
           
            int rowsInserted = ps.executeUpdate();
                if (rowsInserted > 0) {
                    System.out.println("Cart succesfully inserted");
                }
        }
        catch (Exception ex) {
            System.out.println("Log In failed: CARTDAO An Exception has occurred! " + ex);
        }

        finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                }
                rs = null;
            }

            if (stmt != null) {
                try {
                    stmt.close();
                } catch (Exception e) {
                }
                stmt = null;
            }

            if (currentCon != null) {
                try {
                    currentCon.close();
                } catch (Exception e) {
                }

                currentCon = null;
            }
        }
    }
}
