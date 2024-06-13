package model;

public class ProjectProduct {
    private int id;
    private int projectId;
    private String productName;
    private int productPrice;
    private byte[] productImage;

    public ProjectProduct(int id, int projectId, String productName, int productPrice, byte[] productImage) {
        this.id = id;
        this.projectId = projectId;
        this.productName = productName;
        this.productPrice = productPrice;
        this.productImage = productImage;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProjectId() {
        return projectId;
    }

    public void setProjectId(int projectId) {
        this.projectId = projectId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(int productPrice) {
        this.productPrice = productPrice;
    }

    public byte[] getProductImage() {
        return productImage;
    }

    public void setProductImage(byte[] productImage) {
        this.productImage = productImage;
    }
    public ProjectProduct() {}
}
