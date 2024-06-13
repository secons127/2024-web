package model;

public class User {
	
	protected String id;
	protected String password;
	protected String checkPassword;
	protected String name;
	protected String phoneNumber;
	protected String address;
	protected String paymentMethod;
	protected String accessPermission;
	protected Boolean loggedIn;
	
	protected String businessName;
	protected String businessNumber;

    
    public String isAccessPermission() {
        return accessPermission;
    }

    public void setAccessPermission(String string) {
        this.accessPermission = string;
    }

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	
	public String getCheckPassword() {
		return checkPassword;
	}
	public void setCheckPassword(String checkPassward) {
		this.checkPassword = checkPassward;
	}
	
	
	
	public String getPassword() {
		return password;
	}
	public void setPassword(String passward) {
		this.password = passward;
	}
	
	
	
	public void setName(String nickname) {
		this.name = nickname;}
	public String getName() {
		return name;
	}
	
	
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	
	public String getPhoneNumber() {
		return  phoneNumber;
	}
	
	public void setAddress(String address) {
		this.address = address;
	}
	
	public String getAddress() {
		return  address;
	}
	
	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}
	
	public String getPaymentMethod() {
		return  paymentMethod;
	}
	public User(String id, String passward,String checkPassward, String nickname,String phoneNumber,String address, String paymentMethod) {
		this.id=id;
		this.password=passward;
		this. checkPassword = checkPassward;
		this.name=nickname;
		this.phoneNumber = phoneNumber;
		this.address = address;
		this.paymentMethod = paymentMethod;
	}
	
	public User(String id, String passward,String checkPassward, String nickname,String phoneNumber,String address, String paymentMethod,String accessPermission,String businessName,String businessNumber) {
		this.id=id;
		this.password=passward;
		this.checkPassword = checkPassward;
		this.name=nickname;
		this.phoneNumber = phoneNumber;
		this.address = address;
		this.paymentMethod = paymentMethod;
		this.accessPermission =accessPermission;
		this.businessName = businessName;
		this.businessNumber = businessNumber;
	}
	public void setaccessPermission(String accessPermissionsion, String accessPermission) {
		this.accessPermission = accessPermission;
	}
	public String getAccessPermission() {
		return accessPermission;
	}
	
	public String getBusinessName() {
		return   businessName;
	}
	public void setBusinessName(String businessName) {
		this.businessName = businessName;
	}
	public void setBusinessNumber(String businessNumber) {
		this.businessNumber = businessNumber;
	}
	
	public String getBusinessNumber() {
		return   businessNumber;
	}

	
	
	public User(String userId) {
		// TODO Auto-generated constructor stub
	}
	public User() {
		// TODO Auto-generated constructor stub
	}

	public User(String string, String string2, String string3) {
		// TODO Auto-generated constructor stub
	}

	public void setloggedIn(Boolean loggedIn) {
		// TODO Auto-generated method stub
		this.loggedIn=loggedIn;
	}
	
}


