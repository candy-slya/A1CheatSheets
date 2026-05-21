package model;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

public class RatingBean {
	
	private int id;
	private int userId;
	private int cheatsheetId;
	private int rating;
	private Timestamp createdAt;
	

}
