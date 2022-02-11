package ramly.model;

public class Admin{
    private String adminName, adminPassword;
    private int adminID;
    public boolean valid;	
	
    public Admin() {
        super();
    }

    public Admin(String adminName, String adminPassword) {
        super();
        this.adminName = adminName;
        this.adminPassword = adminPassword;
    }
        
    //public Admin(int adminID, String riderName,  String riderPassword) {
        //super();
        //this.adminName = adminName;
        //this.adminPassword = adminPassword;
        //this.adminID = adminID;
    //}

    public int getAdminID() {
        return adminID;
    }
        
    public void setAdminID(int adminID) {
        this.adminID = adminID;
    }
        
    public String getAdminName() {
        return adminName;
    }

    public void setAdminName(String adminName) {
        this.adminName = adminName;
    }

    public String getAdminPassword() {
        return adminPassword;
    }

    public void setAdminPassword(String adminPassword) {
        this.adminPassword = adminPassword;
    }

    public boolean isValid() {
        return valid;
    }

    public void setValid(boolean valid) {
        this.valid = valid;
    }
}