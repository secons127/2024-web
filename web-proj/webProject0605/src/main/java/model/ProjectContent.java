package model;



	public class ProjectContent {
	    private int id;
	    private int projectId;
	    private String title;
	    private String subtitle;
	    private String content;

	    public ProjectContent(int id, int projectId, String title, String subtitle, String content) {
	        this.id = id;
	        this.projectId = projectId;
	        this.title = title;
	        this.subtitle = subtitle;
	        this.content = content;
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

	    public String getTitle() {
	        return title;
	    }

	    public void setTitle(String title) {
	        this.title = title;
	    }

	    public String getSubtitle() {
	        return subtitle;
	    }

	    public void setSubtitle(String subtitle) {
	        this.subtitle = subtitle;
	    }

	    public String getContent() {
	        return content;
	    }

	    public void setContent(String content) {
	        this.content = content;
	    }
	    public ProjectContent() {}
	}



