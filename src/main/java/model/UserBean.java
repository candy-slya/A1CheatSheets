package model;


import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

public class UserBean {
	 private int id;

	   
	    private String name;

	   
	    private String email;

	   
	    private String password;

	    private String role;
	    private String status;
	    private Timestamp createdAt;
}
