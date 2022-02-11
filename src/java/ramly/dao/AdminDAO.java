package ramly.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import ramly.connection.ConnectionManager;
import ramly.model.Admin;

public class AdminDAO {
	
        
        static Connection currentCon = null; 
	static ResultSet rs = null; 
	static PreparedStatement ps=null;
	static Statement stmt=null;
        static int id;
	static String name, password;


	public Admin getAdminById(int id) {
            Admin rider = new Admin();
	    try {
	    	currentCon = ConnectionManager.getConnection();
	        ps=currentCon.prepareStatement("select * from admin where adminID=?");
	        
	        ps.setInt(1, id);
	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
                    rider.setAdminID(rs.getInt("adminID"));
                    rider.setAdminName(rs.getString("adminName"));
                    rider.setAdminPassword(rs.getString("adminPassword"));
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    
	    
	    return rider;
	}

        //admin login
        
        public Admin login(int adminID, String adminPassword)
        {
            Admin admin = null;
            
            try {
                currentCon = ConnectionManager.getConnection();
                String query = "Select * from admin where adminID = ? and adminPassword = ?";
                PreparedStatement pst = this.currentCon.prepareStatement(query);
                pst.setInt(1, adminID);
                pst.setString(2, adminPassword);
                
                ResultSet rs = pst.executeQuery();
                
                if(rs.next())
                {
                    admin = new Admin();
                }
                
                admin.setAdminID(rs.getInt("adminID"));
                admin.setAdminName(rs.getString("adminName"));
                admin.setAdminPassword(rs.getString("adminPassword"));  
            }
            catch(Exception e)
            {
                e.printStackTrace();
            }
            return admin;
        }	
}

