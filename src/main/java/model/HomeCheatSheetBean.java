package model;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

public class HomeCheatSheetBean {
	
	 private int id;
	 private int userId;
	    private String title;
	    private String note;
	    private String username;
	    private String tags;
	    private String status;
	    private String situation;
	    private String Categoryname;
	    private int categoryId;
	    private String tagData;
	    private Timestamp createdAt;
	   
	    private int viewCount;
	    private String link;
	    
	    private double averageRating;
	    private int ratingCount;

}
