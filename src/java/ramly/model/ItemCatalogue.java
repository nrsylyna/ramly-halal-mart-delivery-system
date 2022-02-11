
package ramly.model;

import java.util.ArrayList;
import java.util.List;

public class ItemCatalogue {
    private int itemID; 
    private String itemName;
    private double itemPrice;
    private int itemQty;
    private int iQty =0;
    private String itemType;
    private String itemDescription;
    private String itemImg;
    public boolean valid;
    private double TotalCost;
    private List<ItemCatalogue> items;
    private String base64Image;

    public  ItemCatalogue(){
        super();
    }

    public  ItemCatalogue(int itemID, String itemName,String itemType,double itemPrice, int itemQty, String itemDescription,String itemImg) {
        this.itemID = itemID;
        this.itemName = itemName;
        this.itemType = itemType;
        this.itemImg=itemImg;
        this.itemPrice = itemPrice;
        this.itemQty = itemQty;
        this.itemDescription = itemDescription;
    }
    
     public  ItemCatalogue(int itemID, String itemName,String itemType,double itemPrice, int itemQty, String itemDescription) {
        this.itemID = itemID;
        this.itemName = itemName;
        this.itemType = itemType;
        this.itemPrice = itemPrice;
        this.itemQty = itemQty;
        this.itemDescription = itemDescription;
    }
 
    public void setitemImage(String itemImg) {
        this.itemImg = itemImg;
    }
    
    public void setitemID(int itemID) {
        this.itemID = itemID;
    }

    public void setitemName(String itemName) {
        this.itemName = itemName;
    }

    public void setitemPrice(double itemPrice) {
        this.itemPrice = itemPrice;
    }

    public void setitemQty(int itemQty) {
        this.itemQty = itemQty;
    }

    public void setitemType(String itemType) {
        this.itemType = itemType;
    }

    public void setitemDescription(String itemDescription) {
        this.itemDescription = itemDescription;
    }
    
    public void setValid(boolean valid) {
        this.valid = valid;
    }

    public boolean isValid() {
        return valid;
    }

    public String getitemImage() {
        return itemImg;
    }
     
    public int getitemID() {
        return itemID;
    }

    public String getitemName() {
        return itemName;
    }

    public double getitemPrice() {
        return itemPrice;
    }

    public int getitemQty() {
        return itemQty;
    }

    public String getitemType() {
        return itemType;
    }

    public String getitemDescription() {
        return itemDescription;
    }

    public double getTotalCost() {
        return TotalCost;
    }

    public void setTotalCost(double TotalCost) {
        this.TotalCost = TotalCost;
    }
    
    public String getBase64Image() {
        return base64Image;
    }
 
    public void setBase64Image(String base64Image) {
        this.base64Image = base64Image;
    }
    
    public List<ItemCatalogue> getItems(){
        return items;
    }
    
    public void setItems(List<ItemCatalogue> items){
        this.items = items;
    }
    
    public int getiQty() {
        return iQty;
    }
    
    public void setiQty(int iQty) {
        this.iQty = iQty;
    }
    
    public boolean check(ArrayList<Integer> cartlist, int itemid2){
        for (Integer itemid : cartlist){
            if(itemid == itemid2)
                return true;
        }
        return false;
    }
    
    public double calcItemPrice(){
        double calc = 0.0;
        
        calc = itemPrice * iQty;
        
        return calc;
    }
   
}
