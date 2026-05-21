package model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

public class CheatsheetBean {
	
	private int id;
	private String title;
	private String note;
	private int categoryId;
	private String categoryName;
	private String situation;
	private String status;

}
