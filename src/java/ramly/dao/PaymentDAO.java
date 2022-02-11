package ramly.dao;

import java.io.ByteArrayOutputStream;
import java.util.List;
import static java.util.Objects.isNull;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.io.InputStream;
import java.sql.Blob;

import ramly.connection.ConnectionManager;
import ramly.model.Cart;
import ramly.model.OrderDelivery;
import ramly.model.Payment;

public class PaymentDAO {

	static Connection currentCon = null;
	static ResultSet rs = null; 
	static PreparedStatement ps=null;
	static Statement stmt=null;
        static int payid, orderid, adminid,custid,cartQty,itemid;
	static String type, status, receipt, paytype, orderStatus, orderDate, orderTime, orderNotes;
        static double amount,orderTotalPrice,cartPrice;
        static String search;

	public static Payment getPayment(Payment payment) {
		payid = payment.getPayID();
                paytype = payment.getPayType();
                
        if(isNull(payid)) {
            search = "select * from PAYMENT where PAYTYPE='" + paytype + "'"; 
        }
        else{
            search = "select * from PAYMENT where PAYID='" + payid + "'";   
        }

        try {
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            rs = stmt.executeQuery(search);
            boolean more = rs.next();
            // if subject exists set the isValid variable to true
            if (more) {
                payment.setValid(true);
                System.out.println("true");
            }
            else if (!more) {            	
            	payment.setValid(false);
                System.out.println("false");
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

        return payment;
	}
	
        //insert online payment
        public int addPayment(double payAmount, String payType,  String payStatus, InputStream payReceipt) {
     
        int row = 0;
    	try {
                
    		currentCon = ConnectionManager.getConnection();
    		ps=currentCon.prepareStatement("insert into PAYMENT (PAYAMOUNT, PAYTYPE, PAYSTATUS, PAYRECEIPT)values(?,?,?,?)");
    		ps.setDouble(1,payAmount);
    		ps.setString(2,payType);
                ps.setString(3,payStatus);
                if (payReceipt != null) {
                // fetches input stream of the upload file for the blob column
                    ps.setBlob(4, payReceipt);
                }
    		ps.executeUpdate();
    	
    	}
    	catch (Exception ex) {
    		System.out.println("payment failed: An Exception has occurred! " + ex);
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
        
        return row;
	}
        
        //insert payment cod
        public Payment addPaymentCOD(Payment payment) {
           
            amount = payment.getPayAmount();
            type = payment.getPayType();
            status = payment.getPayStatus();
       
    	try {
                currentCon = ConnectionManager.getConnection();
                String sql = "insert into PAYMENT (PAYAMOUNT, PAYTYPE, PAYSTATUS)values(?,?,?)";
 
                ps = currentCon.prepareStatement(sql);
                ps.setDouble(1, amount);
                ps.setString(2, type);
                ps.setString(3, status);

                int rowsInserted = ps.executeUpdate();
                if (rowsInserted > 0) {
                    System.out.println("payment succesfully inserted");
                }
                
                
    	}

    	catch (Exception ex) {
    		System.out.println("failed: An Exception has occurred! " + ex);
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
        
        return payment;
	}
    //view all payment
    public List<Payment> getAllPayment()
        {
            List<Payment> payments = new ArrayList<Payment>();
            
            try
            {
                currentCon = ConnectionManager.getConnection();
                stmt = currentCon.createStatement();
                
                String q = "select p.*, o.ORDERID from PAYMENT p join ORDERDELIVERY o on p.PAYID = o.PAYID order by orderID ASC ";
                ResultSet rs = stmt.executeQuery(q);
                
                while (rs.next()) 
                {
                    Payment payment = new Payment();
                    payment.setPayID(rs.getInt("payID"));
                    payment.setPayAmount(rs.getDouble("payAmount"));
                    payment.setPayType(rs.getString("payType"));
                    payment.setPayStatus(rs.getString("payStatus"));
                    //payment.setPayReceipt(rs.getString("payReceipt"));
                    payment.setOrderID(rs.getInt("orderID"));
                    payments.add(payment);
                }
            }
            catch (SQLException e) 
            {
                e.printStackTrace();
            }

            return payments;
	}
    
    public void deletePayment(int id) {
		String searchQuery = "delete from PAYMENT where PAYID=" + "'" + id + "'";
		
		System.out.println(searchQuery);
		
		try {
	
	        currentCon = ConnectionManager.getConnection();
	        stmt = currentCon.createStatement();
	        stmt.executeUpdate(searchQuery);
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
		
	}
    //view payment detail
    public Payment getPaymentById(int id) throws IOException {
            Payment payment = new Payment();
	    try {
	    	currentCon = ConnectionManager.getConnection();
	        ps=currentCon.prepareStatement("select p.*, o.ORDERID from PAYMENT p join ORDERDELIVERY o on p.PAYID = o.PAYID where o.PAYID=?");
	        
	        ps.setInt(1, id);
	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
                    payment.setPayID(rs.getInt("PAYID"));
                    payment.setPayAmount(rs.getDouble("PAYAMOUNT"));
                    payment.setPayStatus(rs.getString("PAYSTATUS"));
                    payment.setOrderID(rs.getInt("ORDERID"));
                    payment.setPayType(rs.getString("PAYTYPE"));
                    
	        }
                
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    
	    
	    return payment;
	}
    //view payment online
    public Payment getPaymentOnlineById(int id) throws IOException {
            Payment payment = new Payment();
	    try {
	    	currentCon = ConnectionManager.getConnection();
	        ps=currentCon.prepareStatement("select p.*, o.ORDERID from PAYMENT p join ORDERDELIVERY o on p.PAYID = o.PAYID where o.PAYID=?");
	        
	        ps.setInt(1, id);
	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
                    payment.setPayID(rs.getInt("PAYID"));
                    payment.setPayAmount(rs.getDouble("PAYAMOUNT"));
                    payment.setPayStatus(rs.getString("PAYSTATUS"));
                    payment.setOrderID(rs.getInt("ORDERID"));
                    payment.setPayType(rs.getString("PAYTYPE"));
                    Blob payReceipt = rs.getBlob("PAYRECEIPT");

                 
                    InputStream inputStream = payReceipt.getBinaryStream();
                    ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                    byte[] buffer = new byte[4096];
                    int bytesRead = -1;

                    while ((bytesRead = inputStream.read(buffer)) != -1) {
                        outputStream.write(buffer, 0, bytesRead);                  
                    }

                    byte[] imageBytes = outputStream.toByteArray();
                    String base64Image = Base64.getEncoder().encodeToString(imageBytes);


                    inputStream.close();
                    outputStream.close();

                    payment.setBase64Image(base64Image);
	        }
                
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    
	    
	    return payment;
	}
    //view payment cod
    public Payment getPaymentCODById(int id) throws IOException {
            Payment payment = new Payment();
	    try {
	    	currentCon = ConnectionManager.getConnection();
	        ps=currentCon.prepareStatement("select * from PAYMENT where PAYID=?");
	        
	        ps.setInt(1, id);
	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
                    payment.setPayID(rs.getInt("payID"));
                    payment.setPayAmount(rs.getDouble("payAmount"));
                    payment.setPayStatus(rs.getString("payStatus"));
                    payment.setOrderID(rs.getInt("orderID"));
                    payment.setPayType(rs.getString("payType"));
                }
                
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    
	    
	    return payment;
	}
    //use for payment type
    public String getPaymentType(int id) {
            //Payment payment = new Payment();
            String paytype = null;
            
	    try {
	    	        
                currentCon = ConnectionManager.getConnection();
                stmt=currentCon.createStatement();
	        ResultSet rs = stmt.executeQuery("SELECT PAYTYPE FROM PAYMENT WHERE PAYID=?");
                
	        if (rs.next()) {
                    paytype = rs.getString(1);
	        }
                
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    
	    return paytype;
	}
    //use for update payment status
    public Payment updatePayment(Payment payment) {
            orderid = payment.getOrderID();
            payid = payment.getPayID();
            amount = payment.getPayAmount();
            type = payment.getPayType();
            status = payment.getPayStatus();
            //receipt = payment.getPayReceipt();
            adminid = payment.getAdminID();
	
	    String searchQuery = "UPDATE PAYMENT SET PAYSTATUS='" + status + "' , ADMINID='" + adminid + "'  WHERE PAYID = '" + payid + "'";
		
            try {

            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            stmt.executeUpdate(searchQuery);
	        
	    } 
            catch (SQLException e) {
	        e.printStackTrace();
	    }
	
            return payment;
	}
    //receipt
    public List<Cart> getAllReceipt(int id)
        {
            List<Cart> receipts = new ArrayList<Cart>();
            
            try
            {
                currentCon = ConnectionManager.getConnection();
	        ps=currentCon.prepareStatement("select c.CARTITEMQTY, c.CARTITEMTOTAL, c.ORDERID, c.ITEMID, i.ITEMNAME, i.ITEMPRICE, o.ORDERTOTALPRICE from CART c join ITEMCATALOGUE i on c.ITEMID = i.ITEMID join orderdelivery o on c.orderid = o.orderid where c.ORDERID=?");
	        
	        ps.setInt(1, id);
	        ResultSet rs = ps.executeQuery();
                 
                while (rs.next()) 
                {
                    Cart receipt = new Cart();
                    receipt.setCartQty(rs.getInt("CARTITEMQTY"));
                    receipt.setCartTotal(rs.getDouble("CARTITEMTOTAL"));
                    receipt.setOrderID(rs.getInt("ORDERID"));
                    receipt.setItemID(rs.getInt("ITEMID"));
                    receipt.setItemPrice(rs.getDouble("ITEMPRICE"));
                    receipt.setItemName(rs.getString("ITEMNAME"));
                    receipt.setOrderTotalPrice(rs.getDouble("ORDERTOTALPRICE"));
                    receipts.add(receipt);
                }
            }
            catch (SQLException e) 
            {
                e.printStackTrace();
            }

            return receipts;
	}
    //use for receipt
    public Payment getPaymentByOrderId(int id) {
            Payment payment = new Payment();
	    try {
	    	currentCon = ConnectionManager.getConnection();
	        ps=currentCon.prepareStatement("select p.*, o.ORDERID from PAYMENT p join ORDERDELIVERY o on p.PAYID = o.PAYID where o.PAYID=?");
	        
	        ps.setInt(1, id);
	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
                    payment.setPayID(rs.getInt("payID"));
                    payment.setPayAmount(rs.getDouble("payAmount"));
                    payment.setPayType(rs.getString("payType"));
                    payment.setPayStatus(rs.getString("payStatus"));
                    //payment.setPayReceipt(rs.getString("payReceipt"));
                    payment.setOrderID(rs.getInt("orderID"));
	        }
                
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    
	    
	    return payment;
	}
    //use for receipt
    public OrderDelivery getTotalByOrderId(int id) {
            OrderDelivery orderdelivery = new OrderDelivery();
	    try {
	    	currentCon = ConnectionManager.getConnection();
	        ps=currentCon.prepareStatement("select * from ORDERDELIVERY where PAYID=?");
	        
	        ps.setInt(1, id);
	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
                    orderdelivery.setOrderID(rs.getInt("ORDERID"));
                    orderdelivery.setOrderTotalPrice(rs.getDouble("ORDERTOTALPRICE"));
                    
                    Date date = rs.getDate("orderDeliveryDate");
                    SimpleDateFormat dateFormatter = new SimpleDateFormat ("dd-MM-yyyy");
                    String orderDeliveryDate = dateFormatter.format(date);
                    orderdelivery.setOrderDeliveryDate(orderDeliveryDate);
                
                    Date time = rs.getTime("orderDeliveryTime");
                    SimpleDateFormat timeFormatter = new SimpleDateFormat ("hh:mm aa");
                    String orderDeliveryTime = timeFormatter.format(time);
                    orderdelivery.setOrderDeliveryTime(orderDeliveryTime);
                    System.out.println("Time : " + orderDeliveryTime);

                    orderdelivery.setOrderStatus(rs.getString("ORDERSTATUS"));
	        }
                
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    
	    
	    return orderdelivery;
	}
    

        public int addPay(Payment payment) {
     
        int payID = payment.getPayID();
    	try {
    		currentCon = ConnectionManager.getConnection();
    		ps=currentCon.prepareStatement("insert into PAYMENT (PAYAMOUNT, PAYTYPE, PAYSTATUS, PAYRECEIPT, ORDERID)values(?,?,?,?,?)");
    		ps.setInt(1,payID );
    		ps.executeUpdate();
                
    	}
    	catch (Exception ex) {
    		System.out.println("failed: An Exception has occurred! " + ex);
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
        
        return payID;
	}
        
        public int getLatestID(){
            int id = 0;
            
            try{
                currentCon = ConnectionManager.getConnection();
    		stmt=currentCon.createStatement();
                rs = stmt.executeQuery("SELECT MAX(PAYID) as payid FROM PAYMENT ");
                
                System.out.println("Payment id : " + payid);
                
                while(rs.next()){
                    id = rs.getInt("PAYID");
                    return id;
                }
            }
            catch (Exception ex) {
    		System.out.println("failed: An Exception has occurred! " + ex);
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
            return id;
        }
    /**
     *
     * @param search
     * @return
     */
      //<!-- UPDATE 26/6/2021  -->  
    public List<Payment> getPaymentByStatus(String search) {
        List<Payment> payments = new ArrayList<Payment>();
        
        try {
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            String sql = "select p.*, o.ORDERID from PAYMENT p join ORDERDELIVERY o on p.PAYID = o.PAYID WHERE PAYSTATUS = '"+search.toUpperCase()+"' order by orderID ASC";
            rs = stmt.executeQuery(sql);
             
            while (rs.next()) 
                {
                    Payment payment = new Payment();
                    payment.setPayID(rs.getInt("payID"));
                    payment.setPayAmount(rs.getDouble("payAmount"));
                    payment.setPayType(rs.getString("payType"));
                    payment.setPayStatus(rs.getString("payStatus"));
                    //payment.setPayReceipt(rs.getString("payReceipt"));
                    payment.setOrderID(rs.getInt("orderID"));
                    payments.add(payment);
                }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return payments;
    }
    //getPaymentbytype
    public List<Payment> getPaymentByType(String search) {
        List<Payment> payments = new ArrayList<Payment>();
        
        try {
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            String sql = "select p.*, o.ORDERID from PAYMENT p join ORDERDELIVERY o on p.PAYID = o.PAYID WHERE PAYTYPE = '" + search.toUpperCase() + "' order by orderID ASC";
            rs = stmt.executeQuery(sql);
             
            while (rs.next()) 
                {
                    Payment payment = new Payment();
                    payment.setPayID(rs.getInt("payID"));
                    payment.setPayAmount(rs.getDouble("payAmount"));
                    payment.setPayType(rs.getString("payType"));
                    payment.setPayStatus(rs.getString("payStatus"));
                    //payment.setPayReceipt(rs.getString("payReceipt"));
                    payment.setOrderID(rs.getInt("orderID"));
                    payments.add(payment);
                }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return payments;
    }
    //getPaymentbyOrderID
    public List<Payment> getPaymentByOrderID(String search) {
        List<Payment> payments = new ArrayList<Payment>();
        
        try {
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            String sql = "select p.*, o.ORDERID from PAYMENT p join ORDERDELIVERY o on p.PAYID = o.PAYID WHERE ORDERID = '" + search + "' order by orderID ASC";
            rs = stmt.executeQuery(sql);
             
            while (rs.next()) 
                {
                    Payment payment = new Payment();
                    payment.setPayID(rs.getInt("payID"));
                    payment.setPayAmount(rs.getDouble("payAmount"));
                    payment.setPayType(rs.getString("payType"));
                    payment.setPayStatus(rs.getString("payStatus"));
                    //payment.setPayReceipt(rs.getString("payReceipt"));
                    payment.setOrderID(rs.getInt("orderID"));
                    payments.add(payment);
                }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return payments;
    }
    //<!-- UPDATE 26/6/2021  -->
}
