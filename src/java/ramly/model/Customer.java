package ramly.model;

public class Customer {
    private String custUsername, custName, custPhone, custEmail, custPassword, custAddress;
    private int custID;
    public boolean valid;
    
    public Customer() {
        super();
    }
    
    public Customer(int custID, String custUsername, String custName, String custPhone, String custEmail, String custPassword, String custAddress) { //UPDATE PROFILE
        super();
        this.custID = custID;
        this.custUsername = custUsername;
        this.custName = custName; 
        this.custPhone = custPhone;
        this.custEmail = custEmail; 
        this.custPassword = custPassword;
        this.custAddress = custAddress;
    }
    
     public Customer(String custUsername, String custName, String custPhone, String custEmail, String custPassword, String custAddress) { //REGISTER
        super();
        this.custUsername = custUsername;
        this.custName = custName; 
        this.custPhone = custPhone;
        this.custEmail = custEmail; 
        this.custPassword = custPassword;
        this.custAddress = custAddress;
    }
    
     public Customer(int custID, String custAddress, String custPhone) {
        super();
        this.custID = custID;
        this.custAddress = custAddress;
        this.custPhone = custPhone;
    } 
     
    public int getCustID() {
        return custID;
    }
    
    public void setCustID(int custID) {
        this.custID = custID;
    }
    
    public String getCustUsername() {
        return custUsername;
    }
    
    public void setCustUsername(String custUsername) {
        this.custUsername = custUsername;
    }
    
    public String getCustName() {
        return custName;
    }
    
    public void setCustName(String custName) {
        this.custName = custName;
    }
    
    public String getCustPhone() {
        return custPhone;
    }
    
    public void setCustPhone(String custPhone) {
        this.custPhone = custPhone;
    }
    
    public String getCustEmail() {
        return custEmail;
    }
    
    public void setCustEmail(String custEmail) {
        this.custEmail = custEmail;
    }
    
    public String getCustPassword() {
        return custPassword;
    }
    
    public void setCustPassword(String custPassword) {
        this.custPassword = custPassword;
    }
    
    public String getCustAddress() {
        return custAddress;
    }
    
    public void setCustAddress(String custAddress) {
        this.custAddress = custAddress;
    }
    
    public boolean isValid() {
        return valid;
    }

    public void setValid(boolean valid) {
        this.valid = valid;
    }
}
