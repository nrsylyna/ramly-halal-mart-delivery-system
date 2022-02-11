package ramly.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.text.DecimalFormat;
import static java.util.Objects.isNull;

import ramly.connection.ConnectionManager;
import ramly.model.Rider;
import ramly.model.OrderDelivery;

public class AssignRiderDAO {
    static Connection currentCon = null;
    static ResultSet rs = null; 
    static PreparedStatement ps = null;
    static Statement stmt = null;
    static int riderID;
    static String riderName, riderStatus;
    static String search;
   
    public List<Rider> getAllRider() {
        List<Rider> riders = new ArrayList<Rider>();
        
        try {
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            String sql = "select * from RIDER";
            rs = stmt.executeQuery(sql);
            
            while(rs.next()) {
                Rider rider = new Rider();
                rider.setRiderID(rs.getInt("riderID"));
                rider.setRiderName(rs.getString("riderName"));
                rider.setRiderStatus(rs.getString("riderStatus"));
                riders.add(rider);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return riders;
    }
    
    public List<OrderDelivery> getAllOrder() {
        List<OrderDelivery> orders = new ArrayList<OrderDelivery>();
        
        try {
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            String sql = "select * from ORDERDELIVERY where ORDERSTATUS = 'Pending' ";
            rs = stmt.executeQuery(sql);
            
            while(rs.next()) {
                OrderDelivery order = new OrderDelivery();
                order.setOrderID(rs.getInt("orderID"));
                Date date = rs.getDate("orderDeliveryDate");
                SimpleDateFormat dateFormatter = new SimpleDateFormat ("dd-MM-yyyy");
                String orderDeliveryDate = dateFormatter.format(date);
                order.setOrderDeliveryDate(orderDeliveryDate);
                
                Date time = rs.getTime("orderDeliveryTime");
                SimpleDateFormat timeFormatter = new SimpleDateFormat ("hh:mm aa");
                String orderDeliveryTime = timeFormatter.format(time);
                order.setOrderDeliveryTime(orderDeliveryTime);
                
                order.setOrderTotalPrice(rs.getDouble("orderTotalPrice"));
                order.setOrderStatus(rs.getString("orderStatus"));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }
        
    public Rider getRiderById(int id) {
        Rider rider = new Rider();
        
        try {
            currentCon = ConnectionManager.getConnection();
            ps = currentCon.prepareStatement("Select * from RIDER where RIDERID = ?");
            ps.setInt(1, id);
            rs = ps.executeQuery();
            
            if(rs.next()) {
                rider.setRiderID(rs.getInt("riderID"));
                rider.setRiderName(rs.getString("riderName"));
                rider.setRiderPhone(rs.getString("riderPhone"));
                rider.setRiderEmail(rs.getString("riderEmail"));
                rider.setRiderPassword(rs.getString("riderPassword"));
                rider.setRiderStatus(rs.getString("riderStatus"));
                rider.setRiderPlate(rs.getString ("riderPlateNo"));
                rider.setAdminID(rs.getInt("adminID"));
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }
        return rider;
    }
    
    public OrderDelivery getOrderById(int id) {
        OrderDelivery order = new OrderDelivery();
        
        try {
            currentCon = ConnectionManager.getConnection();
            ps = currentCon.prepareStatement("Select * from ORDERDELIVERY where ORDERID = ?");
            ps.setInt(1, id);
            rs = ps.executeQuery();
            
            if(rs.next()) {
                order.setOrderID(rs.getInt("orderID"));
                order.setOrderStatus(rs.getString("orderStatus"));
                order.setOrderTotalPrice(rs.getDouble("orderTotalPrice"));  
                Date date = rs.getDate("orderDeliveryDate");
                SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
                String orderDeliveryDate = dateFormat.format(date);
                order.setOrderDeliveryDate(orderDeliveryDate);   
                
                Date time = rs.getTime("orderDeliveryTime");
                SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm aa");
                String orderDeliveryTime = timeFormat.format(time);
                order.setOrderDeliveryTime(orderDeliveryTime);  

                order.setRiderID(rs.getInt("riderID"));
                order.setAdminID(rs.getInt("adminID"));
                order.setCustID(rs.getInt("custID"));
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }
        return order;
    }
    
    public void updateRiderOrderStatus(int riderID, int orderID) {
        String idR = String.valueOf(riderID);
        String odR = String.valueOf(orderID);
        
        String sql1 = "update RIDER set RIDERSTATUS = '" + "Delivering" + "' where RIDERID = '" + idR + "'";
        String sql2 = "update ORDERDELIVERY set ORDERSTATUS = '" + "Delivering" + "', RIDERID = '" + idR + "' where ORDERID = '" + odR + "'";
        
        try {
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            stmt.executeUpdate(sql1);
            stmt.executeUpdate(sql2);
        } catch(SQLException e) {
            e.printStackTrace();
        }
    }
    
    public List<Rider> getAllRiderByFilter(String filter) {
        List<Rider> riders = new ArrayList<Rider>();
        
        try {
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            String sql = "select * from RIDER where RIDERSTATUS = '" + filter + "'";
            rs = stmt.executeQuery(sql);
            
            while(rs.next()) {
                Rider rider = new Rider();
                rider.setRiderID(rs.getInt("riderID"));
                rider.setRiderName(rs.getString("riderName"));
                rider.setRiderStatus(rs.getString("riderStatus"));
                riders.add(rider);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return riders;
    }
    
    
}