package ramly.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import ramly.connection.ConnectionManager;
import ramly.model.Customer;
import static java.util.Objects.isNull;


public class CustomerDAO {
    static Connection currentCon = null;
    static ResultSet rs = null; 
    static PreparedStatement ps = null;
    static Statement stmt = null;
    static String custUsername, custName, custPhone, custEmail, custPassword, custAddress;
    static int custID;

    public static Customer getCustomer(Customer customer) {
        custUsername = customer.getCustUsername();
        custEmail = customer.getCustEmail();
        String sql = "select * from CUSTOMER where CUSTUSERNAME = '" + custUsername + "' or CUSTEMAIL = '" + custEmail + "'";
 
        try {
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            rs = stmt.executeQuery(sql);
            boolean more = rs.next();

            if(more) {
                customer.setValid(true);
            }
            else if(!more) {            	
                customer.setValid(false);
            }      
        }
        catch(Exception ex) {
            System.out.println("Log In failed: An Exception has occurred! " + ex);
        }
        finally {
            if(rs != null) {
                try {
                    rs.close();
                } 
                catch(Exception e) {
                }
                rs = null;
            }

            if(stmt != null) {
                try {
                    stmt.close();
                } 
                catch(Exception e) {
                }
                stmt = null;
            }

            if(currentCon != null) {
                try {
                    currentCon.close();
                } 
                catch(Exception e) {
                }
                currentCon = null;
            }
        }
        return customer;
    }
	
    public void add(Customer customer) {
        custUsername = customer.getCustUsername();
        custName = customer.getCustName();
        custPhone =  customer.getCustPhone();
        custEmail = customer.getCustEmail();
        custPassword = customer.getCustPassword();
        custAddress = customer.getCustAddress();
        
    	try {   
            currentCon = ConnectionManager.getConnection();
            ps = currentCon.prepareStatement("insert into CUSTOMER (CUSTUSERNAME, CUSTNAME, CUSTPHONE, CUSTEMAIL, CUSTPASSWORD, CUSTADDRESS)values(?,?,?,?,?,?)");
            ps.setString(1, custUsername);
            ps.setString(2, custName);
            ps.setString(3, custPhone);
            ps.setString(4, custEmail);
            ps.setString(5, custPassword);
            ps.setString(6, custAddress);
            ps.executeUpdate(); 
    	}
    	catch(Exception ex) {
            System.out.println("failed: An Exception has occurred! " + ex);
        }
    	finally {
            if(ps != null) {
                try {
                    ps.close();
                } 
                catch(Exception e) {
                }
                ps = null;
            }
            
            if(currentCon != null) {
                try {
                    currentCon.close();
                }                 
                catch(Exception e) {
                }
                currentCon = null;
            }
    	}	
    }
    
    public List<Customer> getAllCustomer() {
        List<Customer> customers = new ArrayList<Customer>();
        String sql = "select * from CUSTOMER";
        
        try {
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            rs = stmt.executeQuery(sql);
            
            while(rs.next()) {
                Customer customer = new Customer();
                customer.setCustID(rs.getInt("custID"));
                customer.setCustUsername(rs.getString("custUsername"));
                customer.setCustName(rs.getString("custName"));
                customer.setCustPhone(rs.getString("custPhone"));
                customer.setCustEmail(rs.getString("custEmail"));
                customer.setCustPassword(rs.getString("custPassword"));
                customer.setCustAddress(rs.getString("custAddress"));
                customers.add(customer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }
    
     public void deleteCustomer(int id) {
        String sql = "delete from CUSTOMER where CUSTID = '" + id + "'";
        
        try {
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            stmt.executeUpdate(sql);
        } catch(SQLException e) {
            e.printStackTrace();
        }
    }
    public Customer getCustomerByOrder(int id) {
        Customer customer = new Customer();
        
        try {
            currentCon = ConnectionManager.getConnection();
            ps = currentCon.prepareStatement("select c.CUSTNAME, c.CUSTADDRESS, c.CUSTPHONE, c.CUSTID from CUSTOMER c join ORDERDELIVERY o on c.CUSTID = o.CUSTID where o.ORDERID = ?");           
            ps.setInt(1, id);
            rs = ps.executeQuery();
            
            if(rs.next()) {
                customer.setCustName(rs.getString("CUSTNAME"));
                customer.setCustAddress(rs.getString("CUSTADDRESS"));
                customer.setCustPhone(rs.getString("CUSTPHONE"));
                customer.setCustID(rs.getInt("CUSTID"));
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }
        return customer;
    }
    
    
    public Customer getCustomerById(int id) {
        Customer customer = new Customer();
        
        try {
            currentCon = ConnectionManager.getConnection();
            ps = currentCon.prepareStatement("Select * from CUSTOMER where CUSTID = ?");
            ps.setInt(1, id);
            rs = ps.executeQuery();
            
            if(rs.next()) {
                customer.setCustID(rs.getInt("custID"));
                customer.setCustUsername(rs.getString("custUsername"));
                customer.setCustName(rs.getString("custName"));
                customer.setCustPhone(rs.getString("custPhone"));
                customer.setCustEmail(rs.getString("custEmail"));
                customer.setCustPassword(rs.getString("custPassword"));
                customer.setCustAddress(rs.getString("custAddress"));
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }
        return customer;
    }
    
    public Customer updateCustomer(Customer customer) {
        custID = customer.getCustID();
        custUsername = customer.getCustUsername();
        custName = customer.getCustName();
        custPhone = customer.getCustPhone();
        custEmail = customer.getCustEmail();
        custPassword = customer.getCustPassword();
        custAddress = customer.getCustAddress();
        String sql = "update CUSTOMER set CUSTUSERNAME = '" + custUsername + "', CUSTNAME = '" + custName + "', CUSTPHONE = '" + custPhone + "', CUSTEMAIL = '" + custEmail + "', CUSTPASSWORD = '" + custPassword + "', CUSTADDRESS = '" + custAddress + "' where CUSTID = '" + custID + "'";
        
        try {
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            stmt.executeUpdate(sql);
        } catch(SQLException e) {
            e.printStackTrace();
        }       
        return customer;
    }
    
    public Customer updateaddress(Customer customer) { 
        custID = customer.getCustID();
        custAddress = customer.getCustAddress();
        custPhone = customer.getCustPhone();
        
        String sql = "update CUSTOMER set CUSTADDRESS = '" + custAddress + "', CUSTPHONE = '" + custPhone + "' where CUSTID = '" + custID + "'";
        
        try {
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            stmt.executeUpdate(sql);
        } catch(SQLException e) {
            e.printStackTrace();
        }
        
        return customer;
    } 
        
    public Customer login(String custUsername, String custPassword) {
        Customer cust = null;
        String sql = "Select * from customer where custUsername = ? and custPassword = ?";

        try {
            currentCon = ConnectionManager.getConnection();
            PreparedStatement pst = this.currentCon.prepareStatement(sql);
            pst.setString (1, custUsername);
            pst.setString(2, custPassword);         
            rs = pst.executeQuery();

            if(rs.next()) {
                cust = new Customer();
            }               
            cust.setCustID(rs.getInt("custID"));
            cust.setCustUsername(rs.getString("custUsername"));
            cust.setCustName(rs.getString("custName"));
            cust.setCustPhone(rs.getString("custPhone"));
            cust.setCustEmail(rs.getString("custEmail"));
            cust.setCustPassword(rs.getString("custPassword"));
            cust.setCustAddress(rs.getString("custAddress"));
        }
        catch(Exception e) {
            e.printStackTrace();
        }
        return cust;
    }	
    public boolean resetPassword(String custEmail, String custPassword) {
        String email = null;
        String sql1 = "select CUSTEMAIL from CUSTOMER where CUSTEMAIL = '" + custEmail + "'";

        try {
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            rs = stmt.executeQuery(sql1);

            while(rs.next()) {
                email = rs.getString("custEmail");
            }

            if(email != null) {
                String sql2 = "Update CUSTOMER set CUSTPASSWORD = '" + custPassword + "' where CUSTEMAIL = '" + custEmail + "'";

                currentCon = ConnectionManager.getConnection();
                stmt = currentCon.createStatement();
                stmt.executeUpdate(sql2);
                return true;
            }

        }
        catch(SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}

    