package ramly.dao;

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
import ramly.model.ItemCatalogue;


public class ItemCatalogueDAO {
     static Connection currentCon = null;
    static ResultSet rs = null; 
    static PreparedStatement ps=null;
    static Statement stmt=null; 
    static String  ItemName, ItemType,ItemDescription,ItemImg;
    static double ItemPrice;
    static int ItemID,ItemQty;  
    
         public ItemCatalogue getItem(ItemCatalogue item){
        
        
        String searchQuery = "select * from ItemCatalogue where ItemID='"+ItemID+"'";
    
        try {
                currentCon = ConnectionManager.getConnection();
                stmt = currentCon.createStatement();
                rs = stmt.executeQuery(searchQuery);
                boolean more = rs.next();

                System.out.println(searchQuery);

                // if subject exists set the isValid variable to true
                if (more) {
                    item.setValid(true);
                    }

                else if (!more) {            	
                    item.setValid(false);
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
        return item;
    }
        public int uploadFile(String itemName, Double itemPrice, int itemQty, String itemType, String itemDescription, InputStream file) {
            int row = 0;
            try  {

                currentCon = ConnectionManager.getConnection();
                ps=currentCon.prepareStatement("insert into itemcatalogue(itemName,itemPrice,itemQty,itemType,itemDescription,itemImage)values(?,?,?,?,?,?)");
                //ps.setInt(1,itemID);
                ps.setString(1,itemName);
                ps.setDouble(2, itemPrice);
                ps.setInt(3, itemQty);
                ps.setString(4,itemType);
                ps.setString(5, itemDescription); 
                
                if (file != null) {
                    // fetches input stream of the upload file for the blob column
                    ps.setBlob(6,file);
                }
            ps.executeUpdate();

            } catch (SQLException e) {
                // process sql exception
                printSQLException(e);
            }
            return row;
        }

        private void printSQLException(SQLException ex) {
            for (Throwable e: ex) {
                if (e instanceof SQLException) {
                    e.printStackTrace(System.err);
                    System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                    System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                    System.err.println("Message: " + e.getMessage());
                    Throwable t = ex.getCause();
                    while (t != null) {
                        System.out.println("Cause: " + t);
                        t = t.getCause();
                    }
                }
            }
        }
        
        public ItemCatalogue get(int itemID) throws SQLException, IOException {
        ItemCatalogue item = null;
         

        try {
            currentCon = ConnectionManager.getConnection();
	        ps=currentCon.prepareStatement("select * from itemcatalogue where itemID = ?");
	        
	        ps.setInt(1, itemID);
	        ResultSet rs = ps.executeQuery();
                
            if (rs.next()) {
                item = new ItemCatalogue();
                item.setitemID(rs.getInt("ItemID"));
		item.setitemName(rs.getString("ItemName"));
                item.setitemType(rs.getString("ItemType"));          
                item.setitemPrice(rs.getDouble("ItemPrice"));
                item.setitemQty(rs.getInt("ItemQty"));
                item.setitemDescription(rs.getString("ItemDescription"));
                Blob itemImage = rs.getBlob("itemImage");

                 
                InputStream inputStream = itemImage.getBinaryStream();
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

                item.setBase64Image(base64Image);
            }          
             
        } catch (SQLException | IOException ex) {
            ex.printStackTrace();
            throw ex;
        }      
         
        return item;
    }
    public List<ItemCatalogue> getAllItem() throws IOException {
	List<ItemCatalogue> itemAll = new ArrayList<ItemCatalogue>();
	  
        try 
        {
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
		  
            String q = "select * from ITEMCATALOGUE order by itemID asc";
            ResultSet rs = stmt.executeQuery(q);
		      
            while (rs.next()) {
		ItemCatalogue item = new ItemCatalogue();
                item.setitemID(rs.getInt("ItemID"));
		item.setitemName(rs.getString("ItemName"));
                item.setitemType(rs.getString("ItemType"));          
                item.setitemPrice(rs.getDouble("ItemPrice"));
                item.setitemQty(rs.getInt("ItemQty"));
                item.setitemDescription(rs.getString("ItemDescription"));
                Blob itemImage = rs.getBlob("itemImage");

                 
                InputStream inputStream = itemImage.getBinaryStream();
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

                item.setBase64Image(base64Image);

                itemAll.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return itemAll;
    } 
    
    public void deleteItem(int id) {
		String searchQuery = "delete from ITEMCATALOGUE where ITEMID=" + "'" + id + "'";
		
		System.out.println(searchQuery);
		
		try {
	
	        currentCon = ConnectionManager.getConnection();
	        stmt = currentCon.createStatement();
	        stmt.executeUpdate(searchQuery);
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
		
	}

    public int updateItem(int itemID, String itemName, Double itemPrice, int itemQty, String itemType, String itemDescription, InputStream file) {
            int row = 0;
            try  {
                currentCon = ConnectionManager.getConnection();
                ps=currentCon.prepareStatement("update itemcatalogue set itemName=?, itemPrice=?, itemQty=?, itemType=?, itemDescription=?, itemImage=? where itemId=?");
                
                ps.setString(1,itemName);
                ps.setDouble(2, itemPrice);
                ps.setInt(3, itemQty);
                ps.setString(4,itemType);
                ps.setString(5, itemDescription); 
                if (file != null) {
                    ps.setBlob(6,file);
                }
                ps.setInt(7,itemID);
                ps.executeUpdate();

            } 
            catch (SQLException e) {
                // process sql exception
                printSQLException(e);
            }
            return row;
	}
      // <!-- AFIQ - Start. Tolak stock dlm database bila cust add dlm cart  -->
        public void removeStock(int id, int qty) {
	    String searchQuery = "UPDATE ITEMCATALOGUE SET ITEMQTY = ITEMQTY - " + qty  + " WHERE ITEMID = '" + id + "'";
		
		System.out.println(searchQuery);
		
		try {
	
	        currentCon = ConnectionManager.getConnection();
	        stmt = currentCon.createStatement();
	        stmt.executeUpdate(searchQuery);
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
		
	}
        // <!-- AFIQ - End. -->
        
        
    // <!-- AFIQ - Start. Tambah stock dlm database bila cust minus dari cart  -->
        public void addStock(int id, int qty) {
	    String searchQuery = "UPDATE ITEMCATALOGUE SET ITEMQTY = ITEMQTY + " + qty  + " WHERE ITEMID = '" + id + "'";
		
		System.out.println(searchQuery);
		
		try {
	
	        currentCon = ConnectionManager.getConnection();
	        stmt = currentCon.createStatement();
	        stmt.executeUpdate(searchQuery);
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
		
	}
      // <!-- AFIQ - End. -->
        
    public int getStock(int id) {
        int quantityStock = 0;
        String sql = "select ITEMQTY from ITEMCATALOGUE where ITEMID = '" + id + "'";
        
        try {
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            
            if(rs.next()) {
                quantityStock = rs.getInt(1);
            }
        } 
        catch (SQLException e) {
            e.printStackTrace();
        }
        return quantityStock;
    }
        
    public ItemCatalogue getItemById (int itemID, int qty){
        
        ItemCatalogue item = new ItemCatalogue();
        
        try{
            currentCon = ConnectionManager.getConnection();
            ps = currentCon.prepareStatement("Select * FROM ITEMCATALOGUE WHERE itemID = ? ");
            
            ps.setInt(1, itemID);
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()){
                item.setitemID(rs.getInt("ItemID"));
		item.setitemName(rs.getString("ItemName"));
                item.setitemType(rs.getString("ItemType"));          
                item.setitemPrice(rs.getDouble("ItemPrice"));
                item.setitemQty(rs.getInt("ItemQty"));
                item.setiQty(qty);
                //item.setitemDescription(rs.getString("ItemDescription"));
            }
        }
        catch (SQLException e) {
	        e.printStackTrace();
	    }
        
        return item;
    }
    
    public List<ItemCatalogue> search(String search) throws IOException{
        List<ItemCatalogue> itemAll = new ArrayList<>();
        InputStream inputStream;
    
        try 
        {
            currentCon = ConnectionManager.getConnection();
            stmt = currentCon.createStatement();
		  
            String q = "SELECT * FROM ITEMCATALOGUE WHERE LOWER(ITEMNAME) LIKE '%"+search+"%'";
            ResultSet rs = stmt.executeQuery(q);
		      
            while (rs.next()) {
		ItemCatalogue item = new ItemCatalogue();
                item.setitemID(rs.getInt("ItemID"));
		item.setitemName(rs.getString("ItemName"));
                item.setitemType(rs.getString("ItemType"));          
                item.setitemPrice(rs.getDouble("ItemPrice"));
                item.setitemQty(rs.getInt("ItemQty"));
                item.setitemDescription(rs.getString("ItemDescription"));
                Blob itemImage = rs.getBlob("itemImage");

                 
                inputStream = itemImage.getBinaryStream();
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

                item.setBase64Image(base64Image);

                itemAll.add(item);
            }
         } catch (SQLException e) {
            e.printStackTrace();
        }
        return itemAll;
    }
}

