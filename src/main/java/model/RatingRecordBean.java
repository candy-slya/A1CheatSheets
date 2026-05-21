package model;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;


@Getter
@Setter

public class RatingRecordBean {

	private int id;
	private int rating;
	private Timestamp createdAt;
	
	private int raterId;
	private String raterName;
	
	private int cheatsheetId;
	private String cheatsheetTitle;
	
}
