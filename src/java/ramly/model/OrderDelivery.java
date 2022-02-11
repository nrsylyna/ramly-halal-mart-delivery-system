package ramly.model;

public class OrderDelivery {
    private String orderStatus, orderDeliveryDate, orderDeliveryTime;
    private double orderTotalPrice;
    private int orderID, riderID, adminID, custID, payID;
    public boolean valid;	
    
    //REPORT
    private double totalSales,totalAvgSales;
    private int totalCust,totalOrder;
    
    public OrderDelivery(){
        super();
    }
    
    public OrderDelivery(int orderID, String orderStatus, double orderTotalPrice, String orderDeliveryDate, String orderDeliveryTime){
        super();
        this.orderID = orderID;
        this.orderStatus = orderStatus;
        this.orderTotalPrice = orderTotalPrice;
        this.orderDeliveryDate = orderDeliveryDate;
        this.orderDeliveryTime = orderDeliveryTime;
    }
    
    public OrderDelivery(int orderID, String orderStatus){
        super();
        this.orderID = orderID;
        this.orderStatus = orderStatus;
    }

    public OrderDelivery(int payID,double orderTotalPrice, int custID){
        this.payID = payID;
        this.orderTotalPrice = orderTotalPrice;
        this.custID = custID;
    }
     
    public OrderDelivery(String orderStatus, double orderTotalPrice){
        this.orderStatus = orderStatus;
        this.orderTotalPrice = orderTotalPrice;
    }
    
    public int getOrderID() {
        return orderID;
    }
    
    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }
    
    public String getOrderStatus() {
        return orderStatus;
    }
    
    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }
    
    public Double getOrderTotalPrice() {
        return orderTotalPrice;
    }
    
    public void setOrderTotalPrice(double orderTotalPrice) {
        this.orderTotalPrice = orderTotalPrice;
    }
    
    public String getOrderDeliveryDate() {
        return orderDeliveryDate;
    }
    
    public void setOrderDeliveryDate(String orderDeliveryDate) {
        this.orderDeliveryDate = orderDeliveryDate;
    }
    
    public String getOrderDeliveryTime() {
        return orderDeliveryTime;
    }
    
    public void setOrderDeliveryTime(String orderDeliveryTime) {
        this.orderDeliveryTime = orderDeliveryTime;
    }
 
    public int getRiderID() {
        return riderID;
    }
    
    public void setRiderID(int riderID) {
        this.riderID = riderID;
    }
    
    public int getAdminID() {
        return adminID;
    }
    
    public void setAdminID(int adminID) {
        this.adminID = adminID;
    }
    
    public int getCustID() {
        return custID;
    }
    
    public void setCustID(int custID) {
        this.custID = custID;
    }
    
    public int getPayID() {
        return payID;
    }
    
    public void setPayID(int payID) {
        this.payID = payID;
    }
    
    public boolean isValid() {
        return valid;
    }

    public void setValid(boolean valid) {
        this.valid = valid;
    }
    
    //REPORT
    public Double getTotalSales() {
        return totalSales;
    }
    
    public void setTotalSales(Double totalSales) {
        this.totalSales = totalSales;
    }
    
    public Double getTotalAvgSales() {
        return totalAvgSales;
    }
    
    public void setTotalAvgSales(Double totalAvgSales) {
        this.totalAvgSales = totalAvgSales;
    }
    
    public int getTotalCust() {
        return totalCust;
    }
    
    public void setTotalCust(int totalCust) {
        this.totalCust = totalCust;
    }
    
    public int getTotalOrder() {
        return totalOrder;
    }
    
    public void setTotalOrder(int totalOrder) {
        this.totalOrder = totalOrder;
    }
}
