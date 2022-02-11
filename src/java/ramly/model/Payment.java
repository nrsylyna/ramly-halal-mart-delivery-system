package ramly.model;

public class Payment {
    private String payType, payStatus, payReceipt, base64Image;
    private double payAmount;
    private int payID, orderID, adminID, lastID;
    public boolean valid;
    
    public Payment(){
        super();
    }
    
    public Payment(int payID, double payAmount, String payType, String payStatus, int orderID){
        super();
        this.payID = payID;
        this.payAmount = payAmount;
        this.payType = payType;
        this.payStatus = payStatus;
        //this.payReceipt = payReceipt;
        this.orderID = orderID;
    }
    

    public Payment(double payAmount, String payType, String payReceipt, String payStatus){ //INSERT ONLINE PAYMENT TO DB
        super();
        this.payAmount = payAmount;
        this.payType = payType;
        this.payStatus = payStatus;
        this.payReceipt = payReceipt;
        //this.orderID = orderID;
    }
  
    public Payment(double payAmount, String payType, String payStatus){ //INSERT COD PAYMENT TO DB
        super();
        this.payAmount = payAmount;
        this.payType = payType;
        this.payStatus = payStatus;
        //this.payReceipt = payReceipt;String payReceipt,
        //this.orderID = orderID;, int orderID
    }
    
    public Payment(int payID, double payAmount, String payType, String payStatus, int orderID, int adminID) {
        super();
        this.payID = payID;
        this.payAmount = payAmount;
        this.payType = payType;
        this.payStatus = payStatus;
        //this.payReceipt = payReceipt;String payReceipt,
        this.orderID = orderID;
        this.orderID = adminID;
    }
    
    public Payment( double payAmount, String payType, String payReceipt, String payStatus, int orderID, int adminID) {
        super();
        //this.payID = payID;int payID,
        this.payAmount = payAmount;
        this.payType = payType;
        this.payStatus = payStatus;
        this.payReceipt = payReceipt;
        this.orderID = orderID;
        this.orderID = adminID;
    }
    
    public Payment(int payID, double payAmount, String payType, String payStatus) {
        super();
        this.payID = payID;
        this.payAmount = payAmount;
        this.payType = payType;
        this.payStatus = payStatus;
        //this.payReceipt = payReceipt;, String payReceipt
        //this.orderID = orderID;
    }
    
    //try
    public Payment( String payType, double payAmount, String payStatus) {
        super();
        //this.payID = payID;
        this.payAmount = payAmount;
        this.payType = payType;
        this.payStatus = payStatus;
        //this.payReceipt = payReceipt;, String payReceipt
        //this.orderID = orderID;
    }

    public int getPayID(){
        return payID;
    }
    
    public void setPayID(int payID){
        this.payID = payID;
    }
    
    public double getPayAmount(){
        return payAmount;
    }
    
    public void setPayAmount(double payAmount){
        this.payAmount = payAmount;
    }
    
    public String getPayType(){
        return payType;
    }
    
    public void setPayType(String payType){
        this.payType = payType;
    }
    
    public String getPayStatus(){
        return payStatus;
    }
    
    public void setPayStatus(String payStatus){
        this.payStatus = payStatus;
    }
    
    public String getPayReceipt(){
        return payReceipt;
    }
    
    public void setPayReceipt(String payReceipt){
        this.payReceipt = payReceipt;
    }
    
    public int getOrderID(){
        return orderID;
    }
    
    public void setOrderID(int orderID){
        this.orderID = orderID;
    }
    
    public int getAdminID(){
        return orderID;
    }
    
    public void setAdminID(int adminID){
        this.adminID = adminID;
    }

    public boolean isValid() {
        return valid;
    }

    public void setValid(boolean b) {
        this.valid = valid;
    }
   
    public int getLastPayID(){
        return lastID;
    }
    
    public void setLastPayID(int lastID){
        this.lastID = lastID;
    }
    
    public String getBase64Image() {
        return base64Image;
    }
 
    public void setBase64Image(String base64Image) {
        this.base64Image = base64Image;
    }
}
