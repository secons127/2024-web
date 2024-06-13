package model;

public class FundingBoard {
	private String category;
    private int id;
    private String userId;
    private String productName;
    
    private String startDate;
    private String endDate;
    
    private String paymentEndDate;
    
    private int remainingDays;
    private String creationTime;
    
    private double targetAmount;
    private double amountRaised;
    
	private Long achievementRate;
    
	private String selfIntroduction;
	

	private int sponsorCount;
	
	public FundingBoard(String userId, String category, String productName, String startDate, String endDate, String paymentEndDate, double targetAmount, String selfIntroduction) {
        this.userId = userId;
        this.category = category;
        this.productName = productName;
        this.startDate = startDate;
        this.endDate = endDate;
        this.paymentEndDate = paymentEndDate;
        this.targetAmount = targetAmount;
        this.selfIntroduction = selfIntroduction;
     
    }
     public Object getImage(){return null;}
    // Getter와 Setter 메서드들...

    public FundingBoard() {
		// TODO Auto-generated constructor stub
	}



	public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getPaymentEndDate() {
        return paymentEndDate;
    }

    public void setPaymentEndDate(String paymentEndDate) {
        this.paymentEndDate = paymentEndDate;
    }


    public int getRemainingDays() {
        return remainingDays;
    }

    public void setRemainingDays(int remainingDays) {
        this.remainingDays = remainingDays;
    }

    public double getTargetAmount() {
        return targetAmount;
    }

    public void setTargetAmount(double targetAmount) {
        this.targetAmount = targetAmount;
    }

	public void setSponsorCount(int sponsorCount) {
		this.sponsorCount = sponsorCount;
		
	}
	
	public int getSponsorCount() {
		return sponsorCount;}

	public void setAchievementRate(double d) {
		this.achievementRate = (long) d;
		
	}
	public Long getAchievementRate() {
		return  achievementRate;
		
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}


	public String getSelfIntroduction() {
		return selfIntroduction;
	}

	public void setSelfIntroduction(String selfIntroduction) {
		this.selfIntroduction = selfIntroduction;
	}

	public double getAmountRaised() {
		return amountRaised;
	}

	public void setAmountRaised(double amountRaised) {
		this.amountRaised = amountRaised;
	}
	


	public String getCreationTime() {
		return creationTime;
	}

	public void setCreationTime(String creationTime) {
		this.creationTime = creationTime;
	}

	
	
	
}

    