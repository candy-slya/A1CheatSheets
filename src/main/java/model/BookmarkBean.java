package model;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

public class BookmarkBean {
	
    private int id;
    private int userId;
    private int cheatsheetId;
    private Timestamp createdAt;

    private String username;
    private String cheatsheetTitle;
    private String categoryName;

}
