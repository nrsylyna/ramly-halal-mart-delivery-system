
package ramly.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;
import java.util.Date;
import java.text.SimpleDateFormat;
import ramly.connection.ConnectionManager;
import ramly.model.OrderDelivery;


public class OrderDAO {
    static Connection currentCon = null;
    static ResultSet rs = null; 
    static PreparedStatement ps = null;
    static Statement stmt=null;
    
    static int id;
    static String status, deliverDate, deliverTime, notes; 
    static Double total;
    
    private static java.sql.Timestamp getCurrentTimeStamp() {
        java.util.Date today = new java.util.Date();
        return new java.sql.Timestamp(today.getTime());
    }
    
    public static OrderDelivery getOrder(OrderDelivery order){
        
        id = order.getOrderID();
        String searchQuery = "select * from ORDERDELIVERY where ORDERID = '"+id+"'";
        
        try {
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            rs = stmt.executeQuery(searchQuery);
            boolean more = rs.next();
            
            System.out.println(searchQuery);

            // if subject exists set the isValid variable to true
            if (more) {
                order.setValid(true);
           	}
           
            else if (!more) {            	
            	order.setValid(false);
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
        return order;
    }
    
    public void addOrder(OrderDelivery order) {
		
        total = order.getOrderTotalPrice();
        int custID = order.getCustID();
        int payID = order.getPayID();
       
    	try {
    		currentCon = ConnectionManager.getConnection();
    		ps=currentCon.prepareStatement("insert into  ORDERDELIVERY (ORDERSTATUS, ORDERTOTALPRICE, CUSTID, PAYID, ORDERDELIVERYTIME, ORDERDELIVERYDATE)values(?,?,?,?,?,?)");
    		ps.setString(1,"Pending");
                ps.setDouble(2,total);
    		ps.setInt(3,custID);
                ps.setInt(4,payID);
    		ps.setTimestamp(5,getCurrentTimeStamp());
                ps.setTimestamp(6,getCurrentTimeStamp());
    		ps.executeUpdate();
    	}

    	catch (Exception ex) {
    		System.out.println("failed: An Exception ADDORDER has occurred! " + ex);
    	}

    	finally {
    		if (ps != null) {
    			try {
    			ps.close();
    			} catch (Exception e) {
    			}
    			ps = null;
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

    public int getLatestOrderID(){
        
        int oid = 0;
        
        try{
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            rs = stmt.executeQuery("SELECT MAX(ORDERID) as ORDERID FROM ORDERDELIVERY");
            
            System.out.println("Your order id is " + id);
            
            while(rs.next()){
                oid = rs.getInt("ORDERID");
                return oid;
            }
        }
        catch (Exception ex) {
    		System.out.println("failed: An Exception has SINI KE occurred! " + ex);
    	}

    	finally {
    		if (ps != null) {
    			try {
    			ps.close();
    			} catch (Exception e) {
    			}
    			ps = null;
    		}
    		
    		if (currentCon != null) {
    			try {
    				currentCon.close();
    			} catch (Exception e) {
    			}
    			currentCon = null;
    		}
    	}
        
        return oid;
    }
    
    public List<OrderDelivery> getAllOrder(int custID) {
        List<OrderDelivery> orders = new ArrayList<OrderDelivery>();
        
        try {
            currentCon = ConnectionManager.getConnection();
			ps = currentCon.prepareStatement("select * from ORDERDELIVERY WHERE CUSTID = ?");
			ps.setInt(1, custID);
            
                        rs = ps.executeQuery();
            
            while(rs.next()) {
                OrderDelivery order = new OrderDelivery();
                order.setOrderID(rs.getInt("orderID"));
                order.setOrderStatus(rs.getString("orderStatus"));
                order.setOrderTotalPrice(rs.getDouble("orderTotalPrice"));
                
                Date date = rs.getDate("orderDeliveryDate");
                SimpleDateFormat dateFormatter = new SimpleDateFormat ("dd-MM-yyyy");
                String orderDeliveryDate = dateFormatter.format(date);
                order.setOrderDeliveryDate(orderDeliveryDate);
                
                Date time = rs.getTime("orderDeliveryTime");
                SimpleDateFormat timeFormatter = new SimpleDateFormat ("hh:mm aa");
                String orderDeliveryTime = timeFormatter.format(time);
                order.setOrderDeliveryTime(orderDeliveryTime);


                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }
    
        public List<OrderDelivery> getAllOrders()
        {
            List<OrderDelivery> orders = new ArrayList<OrderDelivery>();
            
            try
            {
                currentCon = ConnectionManager.getConnection();
	        ps=currentCon.prepareStatement("select * from ORDERDELIVERY order by orderID ASC");

	        ResultSet rs = ps.executeQuery();
                 
                while (rs.next()) 
                {
                    OrderDelivery order = new OrderDelivery();
                    order.setOrderID(rs.getInt("orderID"));
                    order.setOrderStatus(rs.getString("orderStatus"));
                    order.setOrderTotalPrice(rs.getDouble("orderTotalPrice"));
                    
                    Date date = rs.getDate("orderDeliveryDate");
                    SimpleDateFormat dateFormatter = new SimpleDateFormat("dd-MM-yyyy");  
                    String orderDeliveryDate = dateFormatter.format(date); 
                    order.setOrderDeliveryDate(orderDeliveryDate);
                    
                    Date time = rs.getTime("orderDeliveryTime");
                    SimpleDateFormat timeFormatter = new SimpleDateFormat("hh:mm aa"); 
                    String orderDeliveryTime = timeFormatter.format(time); 
                    order.setOrderDeliveryTime(orderDeliveryTime);
                    order.setPayID(rs.getInt("payID")); // AFIQ - Set payment ID
                    orders.add(order);
                }
            }
            catch (SQLException e) 
            {
                e.printStackTrace();
            }

            return orders;
	}
    
       public List<OrderDelivery> getAllOrderRider(int riderID)
        {
            List<OrderDelivery> orders = new ArrayList<OrderDelivery>();
            
            try
            {
                currentCon = ConnectionManager.getConnection();
	        ps=currentCon.prepareStatement("select * from ORDERDELIVERY WHERE RIDERID=?");
	        
	        ps.setInt(1, riderID);
	        ResultSet rs = ps.executeQuery();
                 
                while (rs.next()) 
                {
                    OrderDelivery order = new OrderDelivery();
                    order.setOrderID(rs.getInt("orderID"));
                    order.setOrderStatus(rs.getString("orderStatus"));
                    order.setOrderTotalPrice(rs.getDouble("orderTotalPrice"));
                    
                    Date date = rs.getDate("orderDeliveryDate");
                    SimpleDateFormat dateFormatter = new SimpleDateFormat("dd-MM-yyyy");  
                    String orderDeliveryDate = dateFormatter.format(date); 
                    order.setOrderDeliveryDate(orderDeliveryDate);
                    
                    Date time = rs.getTime("orderDeliveryTime");
                    SimpleDateFormat timeFormatter = new SimpleDateFormat("hh:mm aa"); 
                    String orderDeliveryTime = timeFormatter.format(time); 
                    order.setOrderDeliveryTime(orderDeliveryTime);

                    orders.add(order);
                }
            }
            catch (SQLException e) 
            {
                e.printStackTrace();
            }

            return orders;
	}
       
       public OrderDelivery getOrderById(int id) {
            OrderDelivery order = new OrderDelivery();
	    try {
	    	currentCon = ConnectionManager.getConnection();
	        ps=currentCon.prepareStatement("select * from ORDERDELIVERY where ORDERID=?");
	        
	        ps.setInt(1, id);
	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
                    order.setOrderID(rs.getInt("orderID"));
                    order.setOrderStatus(rs.getString("orderStatus"));
                    order.setOrderTotalPrice(rs.getDouble("orderTotalPrice"));
                    
                    Date date = rs.getDate("orderDeliveryDate");
                    SimpleDateFormat dateFormatter = new SimpleDateFormat("dd-MM-yyyy");  
                    String orderDeliveryDate = dateFormatter.format(date); 
                    order.setOrderDeliveryDate(orderDeliveryDate);
                    
                    Date time = rs.getTime("orderDeliveryTime");
                    SimpleDateFormat timeFormatter = new SimpleDateFormat("hh:mm aa"); 
                    String orderDeliveryTime = timeFormatter.format(time); 
                    order.setOrderDeliveryTime(orderDeliveryTime);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return order;
	}
       
       public OrderDelivery getOrderDeliveryById(int id) {
            OrderDelivery order = new OrderDelivery();
	    try {
	    	currentCon = ConnectionManager.getConnection();
	        ps=currentCon.prepareStatement("select * from ORDERDELIVERY where ORDERID=?");
	        
	        ps.setInt(1, id);
	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
                    order.setOrderID(rs.getInt("orderID"));
                    order.setOrderStatus(rs.getString("orderStatus"));
                    order.setOrderTotalPrice(rs.getDouble("orderTotalPrice"));
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return order;
	}
       
       public void updateOrder(OrderDelivery order) {
            id = order.getOrderID();
            status = order.getOrderStatus(); 
	
	    String searchQuery = "UPDATE ORDERDELIVERY SET ORDERSTATUS='" + status  + "' WHERE ORDERID = '" + id + "'";
		
            try {

            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            stmt.executeUpdate(searchQuery);
	        
	    } 
            catch (SQLException e) {
	        e.printStackTrace();
	    }
		
	}
       // AFIQ - Start. Delete order     
       public void deleteOrder(int id, int pId) {

	    String searchQuery = "DELETE FROM ORDERDELIVERY WHERE ORDERID = '" + id + "'";
            String searchQuery2 = "DELETE FROM PAYMENT WHERE PAYID = '" + pId + "'";
            
            System.out.println(searchQuery);
            System.out.println(searchQuery2);
            try {
	        currentCon = ConnectionManager.getConnection();
	        stmt = currentCon.createStatement();
	        stmt.executeUpdate(searchQuery);
                stmt.executeUpdate(searchQuery2);
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}
        // AFIQ - End.
       public List<OrderDelivery> getAllCustOrder(int custID) {
        List<OrderDelivery> orders = new ArrayList<OrderDelivery>();
        
        try {
            currentCon = ConnectionManager.getConnection();
			ps = currentCon.prepareStatement("select * from ORDERDELIVERY WHERE CUSTID = ?");
			ps.setInt(1, custID);
            
                        rs = ps.executeQuery();
            
            while(rs.next()) {
                OrderDelivery order = new OrderDelivery();
                order.setOrderID(rs.getInt("orderID"));
                order.setPayID(rs.getInt("payID"));
                order.setOrderStatus(rs.getString("orderStatus"));
                order.setOrderTotalPrice(rs.getDouble("orderTotalPrice"));
                
                Date date = rs.getDate("orderDeliveryDate");
                SimpleDateFormat dateFormatter = new SimpleDateFormat ("dd-MM-yyyy");
                String orderDeliveryDate = dateFormatter.format(date);
                order.setOrderDeliveryDate(orderDeliveryDate);
                
                Date time = rs.getTime("orderDeliveryTime");
                SimpleDateFormat timeFormatter = new SimpleDateFormat ("hh:mm aa");
                String orderDeliveryTime = timeFormatter.format(time);
                order.setOrderDeliveryTime(orderDeliveryTime);
                System.out.println("Time : " + orderDeliveryTime);
				
		order.setRiderID(rs.getInt("riderID")); //izzah 16-6
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }
     
     public OrderDelivery getSales(String startDate, String endDate) {
            OrderDelivery  order = new OrderDelivery ();
	    try {
	    	currentCon = ConnectionManager.getConnection();
	        ps=currentCon.prepareStatement("select SUM(ORDERTOTALPRICE) AS TOTALSALES, ROUND(AVG(ORDERTOTALPRICE),2) AS AVGTOTALSALES, COUNT(DISTINCT CUSTID) AS TOTALCUST, COUNT(ORDERID) AS TOTALORDER from ORDERDELIVERY where ORDERDELIVERYDATE between TO_DATE(?,'YYYY-MM-DD') and TO_DATE(?,'YYYY-MM-DD')");
                
	        ps.setString(1, startDate);
                ps.setString(2, endDate);
	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
                    order.setTotalSales(rs.getDouble("TOTALSALES"));
                    order.setTotalAvgSales(rs.getDouble("AVGTOTALSALES"));
                    order.setTotalCust(rs.getInt("TOTALCUST"));
                    order.setTotalOrder(rs.getInt("TOTALORDER"));
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return order;
	}
}
