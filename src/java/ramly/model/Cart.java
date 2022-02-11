package ramly.model;

public class Cart {
    private String itemName;
    private double cartTotal, itemPrice, orderTotalPrice, totalCost;
    private int cartID, orderID, custID, cartQty, itemID, itemQty;
    public boolean valid;	
    
    public Cart() {
        super();
    }
    
    public Cart(int cartQty, Double cartTotal, int orderID, int itemID, int cartID ) {
        super();
        this.cartQty = cartQty;
        this.cartTotal = cartTotal;
        this.orderID = orderID;
        this.itemID = itemID;
        this.cartID = cartID;
    }

    public Cart(int cartQty, Double cartTotal, double itemPrice, double orderTotalPrice, int orderID, int itemID , String itemName) { //VIEW RECEIPT
        super();
        this.cartQty = cartQty;
        this.cartTotal = cartTotal;
        this.orderID = orderID;
        this.itemID = itemID;
        //this.cartID = cartID;
        this.itemPrice = itemPrice;
        this.orderTotalPrice = orderTotalPrice;
        this.itemName = itemName;
    }

    public Cart (int cartQty, int itemID, int orderID) { //ADD TO CART
        this.cartQty = cartQty;
        this.itemID = itemID;
        this.orderID = orderID;
    }
    
    public Cart (int cartQty, int itemID, double cartTotal, int orderID) {
        this.cartQty = cartQty;
        this.itemID = itemID;
        this.orderID = orderID;
        this.cartTotal = cartTotal;
    }
    
    public int getCartID() {
        return cartID;
    }
    
    public void setCartID(int cartID) {
        this.cartID = cartID;
    }   
    
    public int getItemID() {
        return itemID;
    }
    
    public void setItemID(int itemID) {
        this.itemID = itemID;
    }
    
    public int getItemQty() {
        return itemQty;
    }
    
    public void setItemQty(int itemQty) {
        this.itemQty = itemQty;
    }
    
    public int getCartQty() {
        return cartQty;
    }
    
    public void setCartQty(int cartQty) {
        this.cartQty = cartQty;
    }
    
    public Double getCartTotal() {
        return cartTotal;
    }
    
    public void setCartTotal(Double cartTotal) {
        this.cartTotal = cartTotal;
    }
    
    public Double getTotalCost() {
        return totalCost;
    }
    
    public void setTotalCost(Double totalCost) {
        this.totalCost = totalCost;
    }
    
    public int getCustID() {
        return custID;
    }
    
    public void setCustID(int custID) {
        this.custID = custID;
    }
    
    public int getOrderID() {
        return orderID;
    }
    
    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }
    
    public String getItemName() {
        return itemName;
    }
    
    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public boolean isValid() {
        return valid;
    }

    public void setValid(boolean valid) {
            this.valid = valid; 
    }
    
    //RECEIPT
    public Double getItemPrice() {
        return itemPrice;
    }
    
    public void setItemPrice(Double itemPrice) {
        this.itemPrice = itemPrice;
    }
    
    public Double getOrderTotalPrice() {
        return orderTotalPrice;
    }
    
    public void setOrderTotalPrice(Double orderTotalPrice) {
        this.orderTotalPrice = orderTotalPrice;
    }
}