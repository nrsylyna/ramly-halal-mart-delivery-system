package ramly.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import ramly.connection.ConnectionManager;
import ramly.model.Rider;

public class RiderDAO {
    static Connection currentCon = null; 
    static ResultSet rs = null; 
    static PreparedStatement ps = null;
    static Statement stmt = null;
    static String riderName, riderPhone, riderEmail, riderPassword, riderStatus, riderPlate;
    static int riderID;

    public Rider getRider(Rider rider) {
        riderEmail = rider.getRiderEmail();
        riderPlate = rider.getRiderPlate();
        String sql = "select * from RIDER where RIDEREMAIL = '" + riderEmail + "' or RIDERPLATENO = '" + riderPlate + "'";
 
        try {
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            rs = stmt.executeQuery(sql);
            boolean more = rs.next();

            if(more) {
                rider.setValid(true);
            }
            else if(!more) {            	
                rider.setValid(false);
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
                catch (Exception e) {
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
        return rider;
    }
	
    public void add(Rider rider) {	
        riderID = rider.getRiderID();
        riderName = rider.getRiderName();
        riderPhone = rider.getRiderPhone();
        riderEmail = rider.getRiderEmail();
        riderPassword = rider.getRiderPassword();
        riderStatus = rider.getRiderStatus();
        riderPlate = rider.getRiderPlate();
        
    	try {
            currentCon = ConnectionManager.getConnection();
            ps=currentCon.prepareStatement("insert into RIDER (RIDERNAME, RIDERPHONE, RIDEREMAIL, RIDERPASSWORD, RIDERPLATENO, RIDERSTATUS)values(?,?,?,?,?,?)");
            ps.setString(1,riderName);
            ps.setString(2,riderPhone);
            ps.setString(3,riderEmail);
            ps.setString(4,riderPassword);
            ps.setString(5,riderPlate);
            ps.setString(6,riderStatus);
            ps.executeUpdate();          
    	}
    	catch (Exception ex) {
            System.out.println("failed: An Exception has occurred! " + ex);
    	}
    	finally {
            if (ps != null) {
                try {
                    ps.close();
                } 
                catch(Exception e) {
                }
                ps = null;
            }
	
            if (currentCon != null) {
                try {
                    currentCon.close();
                } 
                catch(Exception e) {
                }
                currentCon = null;
            }
    	}	
    }
        
    public List<Rider> getAllRider() {
        List<Rider> riders = new ArrayList<Rider>();
        String sql = "select * from RIDER";

        try {
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                Rider rider = new Rider();
                rider.setRiderID(rs.getInt("riderID"));
                rider.setRiderName(rs.getString("riderName"));
                rider.setRiderPhone(rs.getString("riderPhone"));
                rider.setRiderEmail(rs.getString("riderEmail"));
                rider.setRiderPlate(rs.getString("riderPlate"));
                riders.add(rider);
            }
        }
        catch(SQLException e) {
            e.printStackTrace();
        }
        return riders;
    }
        
    public void deleteRider(int id) {
        String sql = "delete from RIDER where RIDERID = '" + id + "'";
        
        try {
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            stmt.executeUpdate(sql);
        } 
        catch(SQLException e) {
            e.printStackTrace();
        }
    }
	
    public Rider getRiderById(int id) {
        Rider rider = new Rider();
        
        try {
            currentCon = ConnectionManager.getConnection();
            ps = currentCon.prepareStatement("select * from RIDER where RIDERID = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                rider.setRiderID(rs.getInt("riderID"));
                rider.setRiderName(rs.getString("riderName"));
                rider.setRiderPhone(rs.getString("riderPhone"));
                rider.setRiderEmail(rs.getString("riderEmail"));
                rider.setRiderPassword(rs.getString("riderPassword"));
                rider.setRiderStatus(rs.getString("riderStatus"));
                rider.setRiderPlate(rs.getString("riderPlateNo"));
            }
        }
        catch(SQLException e) {
            e.printStackTrace();
        }
        return rider;
    }

    public Rider updateRider(Rider rider) {
        riderID = rider.getRiderID();
        riderName = rider.getRiderName();
        riderPhone = rider.getRiderPhone();
        riderEmail = rider.getRiderEmail();
        riderPassword = rider.getRiderPassword();
        riderPlate = rider.getRiderPlate();  
        String searchQuery = "UPDATE RIDER SET RIDERNAME='" + riderName  + "' , RIDERPHONE='" + riderPhone + "' , RIDEREMAIL='" + riderEmail + "' , RIDERPASSWORD='" + riderPassword + "' , RIDERPLATENO='" + riderPlate + "' WHERE RIDERID = '" + riderID + "'";

        try {
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            stmt.executeUpdate(searchQuery);   
        } 
        catch (SQLException e) {
            e.printStackTrace();
        }
        return rider;
    }
       
    public void updateRiderStatus(int id) {
        riderID = id;
        String searchQuery = "update RIDER set RIDERSTATUS = 'Available' where RIDERID = '" + riderID + "'";

        try {
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            stmt.executeUpdate(searchQuery);   
        } 
        catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public Rider manageRider(Rider rider) {
        riderID = rider.getRiderID();
        riderName = rider.getRiderName();
        riderStatus = rider.getRiderStatus();  
        String sql = "UPDATE RIDER SET RIDERNAME='" + riderName  + "'  , RIDERSTATUS='" + riderStatus + "' WHERE RIDERID = '" + riderID + "'";

        try {
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            stmt.executeUpdate(sql);
        } 
        catch(SQLException e) {
            e.printStackTrace();
        }
        return rider;
    }
        
        
    public Rider login(int riderID, String riderPassword) {
        Rider rider = null;
        String sql = "Select * from rider where riderID = ? and riderPassword = ?";

        try {
            currentCon = ConnectionManager.getConnection();
            PreparedStatement pst = this.currentCon.prepareStatement(sql);
            pst.setInt(1, riderID);
            pst.setString(2, riderPassword);

            ResultSet rs = pst.executeQuery();

            if(rs.next()) {
                rider = new Rider();
            }
            rider.setRiderID(rs.getInt("riderID"));
            rider.setRiderName(rs.getString("riderName"));
            rider.setRiderEmail(rs.getString("riderEmail"));
            rider.setRiderPassword(rs.getString("riderPassword"));  
            rider.setRiderPhone(rs.getString("riderPhone")); 
            rider.setRiderStatus(rs.getString("riderStatus"));  
            rider.setRiderPlate(rs.getString("riderPlateNo")); 
        }
        catch(Exception e) {
            e.printStackTrace();
        }
        return rider;
    }
    public boolean resetPassword(String riderEmail, String riderPassword) {
        String email = null;
        String sql1 = "Select riderEmail from rider where riderEmail = '" + riderEmail + "'";

        try {
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            rs = stmt.executeQuery(sql1);

            while(rs.next()) {
                email = rs.getString("riderEmail");
            }

            if(email != null) {
                String sql2 = "Update rider set riderPassword = '" + riderPassword + "' where riderEmail = '" + riderEmail + "'";

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

