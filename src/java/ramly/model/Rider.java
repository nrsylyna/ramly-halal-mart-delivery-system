package ramly.model;

public class Rider {
    private String riderName, riderPhone, riderEmail, riderPassword, riderStatus, riderPlate;
    private int riderID, adminID;
    public boolean valid;	
	
    public Rider() {
        super();
    }
        
    public Rider(String riderName, String riderPhone, String riderEmail, String riderPassword, String riderStatus, String riderPlate) { //REGISTER
        super();
        this.riderName = riderName;
        this.riderPhone = riderPhone;
        this.riderEmail = riderEmail;
        this.riderPassword = riderPassword;
        this.riderStatus = riderStatus;
        this.riderPlate = riderPlate;
    }
        
    public Rider(int riderID, String riderName, String riderPhone, String riderEmail, String riderPassword,  String riderStatus, String riderPlate, int adminID) {
        super();
        this.riderID = riderID;
        this.riderName = riderName;
        this.riderPhone = riderPhone;
        this.riderEmail = riderEmail;
        this.riderPassword = riderPassword;
        this.riderStatus = riderStatus;
        this.riderPlate = riderPlate;
        this.adminID = adminID;
    }

    public Rider(int riderID, String riderName, String riderPhone, String riderEmail, String riderPassword, String riderPlate) { //UPDATEPROFILE
        super();
        this.riderName = riderName;
        this.riderPhone = riderPhone;
        this.riderEmail = riderEmail;
        this.riderPassword = riderPassword;
        this.riderID = riderID;
        this.riderPlate = riderPlate;
    }

    public Rider(int riderID, String riderName,String riderStatus) { //MANAGE STATUS
        super();
        this.riderName = riderName;
        this.riderID = riderID;
        this.riderStatus=riderStatus;
    }
          
    public int getRiderID() {
        return riderID;
    }

    public void setRiderID(int riderID) {
        this.riderID = riderID;
    }
        
    public String getRiderName() {
        return riderName;
    }

    public void setRiderName(String riderName) {
        this.riderName = riderName;
    }

    public String getRiderPhone() {
        return riderPhone;
    }

    public void setRiderPhone(String riderPhone) {
        this.riderPhone = riderPhone;
    }

    public String getRiderEmail() {
        return riderEmail;
    }

    public void setRiderEmail(String riderEmail) {
        this.riderEmail = riderEmail;
    }
        
    public String getRiderPassword() {
        return riderPassword;
    }

    public void setRiderPassword(String riderPassword) {
        this.riderPassword = riderPassword;
    }
        
    public String getRiderStatus() {
        return riderStatus;
    }
        
    public void setRiderStatus(String riderStatus) {
        this.riderStatus = riderStatus;
    }
        
    public String getRiderPlate() {
        return riderPlate;
    }
        
    public void setRiderPlate(String riderPlate) {
        this.riderPlate = riderPlate;
    }
        
    public int getAdminID() {
        return adminID;
    }

    public void setAdminID(int adminID) {
        this.adminID = adminID;
    }
    
    public boolean isValid() {
        return valid;
    }

    public void setValid(boolean valid) {
        this.valid = valid;
    }
}