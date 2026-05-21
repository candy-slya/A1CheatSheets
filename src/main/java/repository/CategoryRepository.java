package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.CategoryBean;
import model.UserBean;

public class CategoryRepository {

	 public void insert(CategoryBean category) {
	        String sql = "INSERT INTO category (name, description) VALUES (?, ?)";
	        try(Connection con = DBConnection.getConnection();
	            PreparedStatement ps = con.prepareStatement(sql)) {
	            
	            ps.setString(1, category.getName());
	            ps.setString(2, category.getDescription());
	          
	            ps.executeUpdate();
	        } catch(Exception e) {
	            e.printStackTrace();
	        }
	    }
	 
	 public List<CategoryBean> findAllActive() {
		    List<CategoryBean> list = new ArrayList<>();
		    String sql = "SELECT * FROM category WHERE status='active'";
		    try(Connection con = DBConnection.getConnection();
		        PreparedStatement ps = con.prepareStatement(sql);
		        ResultSet rs = ps.executeQuery()) {
		        
		        while(rs.next()) {
		            CategoryBean c = new CategoryBean();
		            c.setId(rs.getInt("id"));
		            c.setName(rs.getString("name"));
		            c.setDescription(rs.getString("description"));
		            c.setStatus(rs.getString("status"));
		            list.add(c);
		        }
		    } catch(Exception e) {
		        e.printStackTrace();
		    }
		    return list;
		}
	 
	 
	 public CategoryBean findById(int id){

		    CategoryBean category = null;

		    String sql =
		        "SELECT * FROM category WHERE id=?";

		    try{

		        Connection con =
		            DBConnection.getConnection();

		        PreparedStatement ps =
		            con.prepareStatement(sql);

		        ps.setInt(1, id);

		        ResultSet rs =
		            ps.executeQuery();

		        if(rs.next()){

		            category =
		                new CategoryBean();

		            category.setId(rs.getInt("id"));
		            category.setName(rs.getString("name"));
		            category.setDescription(rs.getString("description"));
		            category.setStatus(rs.getString("status"));
		        }

		    }catch(Exception e){
		        e.printStackTrace();
		    }

		    return category;
		}


		public void update(CategoryBean category){

		    String sql =
		        "UPDATE category " +
		        "SET name=?, description=? " +
		        "WHERE id=?";

		    try{

		        Connection con =
		            DBConnection.getConnection();

		        PreparedStatement ps =
		            con.prepareStatement(sql);

		        ps.setString(1, category.getName());
		        ps.setString(2, category.getDescription());
		        ps.setInt(3, category.getId());

		        ps.executeUpdate();

		    }catch(Exception e){
		        e.printStackTrace();
		    }
		}

		
		public void delete(int id){

		    String sql =
		        "UPDATE category " +
		        "SET status='inactive' " +
		        "WHERE id=?";

		    try{

		        Connection con =
		            DBConnection.getConnection();

		        PreparedStatement ps =
		            con.prepareStatement(sql);

		        ps.setInt(1, id);

		        ps.executeUpdate();

		    }catch(Exception e){
		        e.printStackTrace();
		    }
		}
		
	
		public List<CategoryBean> findActiveWithSearch(String keyword, int offset, int limit){

		    List<CategoryBean> list = new ArrayList<>();

		    String sql =
		        "SELECT * FROM category " +
		        "WHERE status='active' " +
		        "AND name LIKE ? " +
		        "ORDER BY id DESC " +
		        "LIMIT ? OFFSET ?";

		    try{
		        Connection con = DBConnection.getConnection();

		        PreparedStatement ps = con.prepareStatement(sql);

		        ps.setString(1, keyword + "%");
		        ps.setInt(2, limit);
		        ps.setInt(3, offset);

		        ResultSet rs = ps.executeQuery();

		        while(rs.next()){
		            CategoryBean c = new CategoryBean();

		            c.setId(rs.getInt("id"));
		            c.setName(rs.getString("name"));
		            c.setDescription(rs.getString("description"));
		            c.setStatus(rs.getString("status"));

		            list.add(c);
		        }

		    }catch(Exception e){
		        e.printStackTrace();
		    }

		    return list;
		}


		public int countActiveWithSearch(String keyword){

		    int count = 0;

		    String sql =
		        "SELECT COUNT(*) AS total FROM category " +
		        "WHERE status='active' " +
		        "AND name LIKE ?";

		    try{
		        Connection con = DBConnection.getConnection();

		        PreparedStatement ps = con.prepareStatement(sql);

		        ps.setString(1, keyword + "%");

		        ResultSet rs = ps.executeQuery();

		        if(rs.next()){
		            count = rs.getInt("total");
		        }

		    }catch(Exception e){
		        e.printStackTrace();
		    }

		    return count;
		}
		
		public int countActiveCategories(){

		    int count = 0;

		    String sql =
		        "SELECT COUNT(*) AS total " +
		        "FROM category " +
		        "WHERE status='active'";

		    try{

		        Connection con =
		            DBConnection.getConnection();

		        PreparedStatement ps =
		            con.prepareStatement(sql);

		        ResultSet rs =
		            ps.executeQuery();

		        if(rs.next()){

		            count =
		                rs.getInt("total");
		        }

		    }catch(Exception e){
		        e.printStackTrace();
		    }

		    return count;
		}

}
