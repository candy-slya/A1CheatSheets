package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.HomeCheatSheetBean;

public class HomeCheatSheetRepository {

	
	public List<HomeCheatSheetBean> findPublicByCategoryId(int categoryId){

	    List<HomeCheatSheetBean> list = new ArrayList<>();

	    String sql =
	        "SELECT c.id, c.title, c.note, c.createdAt, " +
	        "c.user_id, c.category_id, c.viewCount, " +
	        "u.name AS username, " +
	        "cat.name AS categoryName, " +
	        "GROUP_CONCAT(t.name SEPARATOR ', ') AS tags, " +
	        "GROUP_CONCAT(CONCAT(t.id, ':', t.name) SEPARATOR ',') AS tagData " +
	        "FROM cheatsheets c " +
	        "JOIN user u ON c.user_id = u.id " +
	        "LEFT JOIN category cat ON c.category_id = cat.id " +
	        "LEFT JOIN cheatsheetsTag cht ON c.id = cht.cheatsheets_id " +
	        "LEFT JOIN tags t ON cht.tags_id = t.id " +
	        "WHERE c.category_id = ? " +
	        "AND c.status='active' " +
	        "AND c.situation='public' " +
	        "GROUP BY c.id, c.title, c.note, c.createdAt, c.user_id, c.category_id, c.viewCount, u.name, cat.name " +
	        "ORDER BY c.createdAt DESC";

	    try{
	        Connection con = DBConnection.getConnection();
	        PreparedStatement ps = con.prepareStatement(sql);

	        ps.setInt(1, categoryId);

	        ResultSet rs = ps.executeQuery();

	        while(rs.next()){
	            HomeCheatSheetBean bean = new HomeCheatSheetBean();

	            bean.setId(rs.getInt("id"));
	            bean.setTitle(rs.getString("title"));
	            bean.setNote(rs.getString("note"));
	            bean.setCreatedAt(rs.getTimestamp("createdAt"));
	            bean.setUserId(rs.getInt("user_id"));
	            bean.setCategoryId(rs.getInt("category_id"));
	            bean.setViewCount(rs.getInt("viewCount"));
	            bean.setUsername(rs.getString("username"));
	            bean.setCategoryname(rs.getString("categoryName"));
	            bean.setTags(rs.getString("tags"));
	            bean.setTagData(rs.getString("tagData"));

	            list.add(bean);
	        }

	    }catch(Exception e){
	        e.printStackTrace();
	    }

	    return list;
	}
	
	public List<HomeCheatSheetBean> findPublicByUserId(int userId){

	    List<HomeCheatSheetBean> list = new ArrayList<>();

	    String sql =
	        "SELECT c.id, c.title, c.note, c.createdAt, " +
	        "c.user_id, c.category_id, c.viewCount, " +
	        "u.name AS username, " +
	        "cat.name AS categoryName, " +
	        "GROUP_CONCAT(t.name SEPARATOR ', ') AS tags, " +
	        "GROUP_CONCAT(CONCAT(t.id, ':', t.name) SEPARATOR ',') AS tagData " +
	        "FROM cheatsheets c " +
	        "JOIN user u ON c.user_id = u.id " +
	        "LEFT JOIN category cat ON c.category_id = cat.id " +
	        "LEFT JOIN cheatsheetsTag cht ON c.id = cht.cheatsheets_id " +
	        "LEFT JOIN tags t ON cht.tags_id = t.id " +
	        "WHERE c.user_id = ? " +
	        "AND c.situation='public' " +
	        "AND c.status='active' " +
	        "GROUP BY c.id, c.title, c.note, c.createdAt, c.user_id, c.category_id, c.viewCount, u.name, cat.name " +
	        "ORDER BY c.createdAt DESC";

	    try{
	        Connection con = DBConnection.getConnection();
	        PreparedStatement ps = con.prepareStatement(sql);

	        ps.setInt(1, userId);

	        ResultSet rs = ps.executeQuery();

	        while(rs.next()){
	            HomeCheatSheetBean bean = new HomeCheatSheetBean();

	            bean.setId(rs.getInt("id"));
	            bean.setTitle(rs.getString("title"));
	            bean.setNote(rs.getString("note"));
	            bean.setCreatedAt(rs.getTimestamp("createdAt"));
	            bean.setUserId(rs.getInt("user_id"));
	            bean.setCategoryId(rs.getInt("category_id"));
	            bean.setViewCount(rs.getInt("viewCount"));
	            bean.setUsername(rs.getString("username"));
	            bean.setCategoryname(rs.getString("categoryName"));
	            bean.setTags(rs.getString("tags"));
	            bean.setTagData(rs.getString("tagData"));

	            list.add(bean);
	        }

	    }catch(Exception e){
	        e.printStackTrace();
	    }

	    return list;
	}
	
	public List<HomeCheatSheetBean> findPrivateByUserId(int userId){

	    List<HomeCheatSheetBean> list =
	        new ArrayList<>();

	    String sql =
	        "SELECT c.id, c.title, c.note, c.createdAt, " +
	        "c.user_id, c.category_id, c.viewCount, " +
	        "c.situation, " +
	        "u.name AS username, " +
	        "cat.name AS categoryName, " +
	        "GROUP_CONCAT(t.name SEPARATOR ', ') AS tags, " +
	        "GROUP_CONCAT(CONCAT(t.id, ':', t.name) SEPARATOR ',') AS tagData " +
	        "FROM cheatsheets c " +
	        "JOIN user u ON c.user_id = u.id " +
	        "LEFT JOIN category cat ON c.category_id = cat.id " +
	        "LEFT JOIN cheatsheetsTag cht ON c.id = cht.cheatsheets_id " +
	        "LEFT JOIN tags t ON cht.tags_id = t.id " +
	        "WHERE c.user_id = ? " +
	        "AND c.situation='draft' " +
	        "AND c.status='active' " +
	        "GROUP BY c.id, c.title, c.note, c.createdAt, " +
	        "c.user_id, c.category_id, c.viewCount, " +
	        "c.situation, u.name, cat.name " +
	        "ORDER BY c.createdAt DESC";

	    try{

	        Connection con =
	            DBConnection.getConnection();

	        PreparedStatement ps =
	            con.prepareStatement(sql);

	        ps.setInt(1, userId);

	        ResultSet rs =
	            ps.executeQuery();

	        while(rs.next()){

	            HomeCheatSheetBean bean =
	                new HomeCheatSheetBean();

	            bean.setId(rs.getInt("id"));
	            bean.setTitle(rs.getString("title"));
	            bean.setNote(rs.getString("note"));
	            bean.setCreatedAt(
	                rs.getTimestamp("createdAt"));

	            bean.setUserId(
	                rs.getInt("user_id"));

	            bean.setCategoryId(
	                rs.getInt("category_id"));

	            bean.setViewCount(
	                rs.getInt("viewCount"));

	            bean.setSituation(
	                rs.getString("situation"));

	            bean.setUsername(
	                rs.getString("username"));

	            bean.setCategoryname(
	                rs.getString("categoryName"));

	            bean.setTags(
	                rs.getString("tags"));

	            bean.setTagData(
	                rs.getString("tagData"));

	            list.add(bean);
	        }

	    }catch(Exception e){
	        e.printStackTrace();
	    }

	    return list;
	}
	
	
	public HomeCheatSheetBean findById(int id){

	    HomeCheatSheetBean bean = null;

	    String sql =
	        "SELECT c.id, c.title, c.note, c.status, c.situation, " +
	        "c.user_id, c.category_id, c.viewCount, c.createdAt, " +
	        "u.name AS username, " +
	        "cat.name AS categoryName, " +
	        "GROUP_CONCAT(t.name SEPARATOR ', ') AS tags " +
	        "FROM cheatsheets c " +
	        "JOIN user u ON c.user_id = u.id " +
	        "LEFT JOIN category cat ON c.category_id = cat.id " +
	        "LEFT JOIN cheatsheetsTag cht ON c.id = cht.cheatsheets_id " +
	        "LEFT JOIN tags t ON cht.tags_id = t.id " +
	        "WHERE c.id = ? " +
	        "GROUP BY c.id, c.title, c.note, c.status, c.situation, " +
	        "c.user_id, c.category_id, c.viewCount, c.createdAt, " +
	        "u.name, cat.name";

	    try{
	        Connection con = DBConnection.getConnection();
	        PreparedStatement ps = con.prepareStatement(sql);

	        ps.setInt(1, id);

	        ResultSet rs = ps.executeQuery();

	        if(rs.next()){
	            bean = new HomeCheatSheetBean();

	            bean.setId(rs.getInt("id"));
	            bean.setTitle(rs.getString("title"));
	            bean.setNote(rs.getString("note"));
	            bean.setStatus(rs.getString("status"));
	            bean.setSituation(rs.getString("situation"));

	            bean.setUserId(rs.getInt("user_id"));
	            bean.setCategoryId(rs.getInt("category_id"));
	            bean.setViewCount(rs.getInt("viewCount"));
	            bean.setCreatedAt(rs.getTimestamp("createdAt"));

	            bean.setUsername(rs.getString("username"));
	            bean.setCategoryname(rs.getString("categoryName"));
	            bean.setTags(rs.getString("tags"));
	        }

	    }catch(Exception e){
	        e.printStackTrace();
	    }

	    return bean;
	}
    
  
    
    
    public void publishCheatsheet(int id){

        String sql =
            "UPDATE cheatsheets " +
            "SET situation='public' " +
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
    
    
    public void makePrivate(int id){

        String sql =
            "UPDATE cheatsheets " +
            "SET situation='draft' " +
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

    
    public void deleteCheatsheet(int id){

        String sql =
            "UPDATE cheatsheets " +
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
    
    public HomeCheatSheetBean findCheatsheetForEdit(int id){

        HomeCheatSheetBean bean = null;

        String sql =
            "SELECT c.id, c.title, c.note, c.situation, c.status, " +
            "GROUP_CONCAT(t.name SEPARATOR ',') AS tags " +
            "FROM cheatsheets c " +
            "LEFT JOIN cheatsheetsTag ct ON c.id = ct.cheatsheets_id " +
            "LEFT JOIN tags t ON ct.tags_id = t.id " +
            "WHERE c.id=? " +
            "GROUP BY c.id, c.title, c.note, c.situation, c.status";

        try{
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if(rs.next()){
                bean = new HomeCheatSheetBean();

                bean.setId(rs.getInt("id"));
                bean.setTitle(rs.getString("title"));
                bean.setNote(rs.getString("note"));
                bean.setSituation(rs.getString("situation"));
                bean.setStatus(rs.getString("status"));
                bean.setTags(rs.getString("tags"));
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return bean;
    }


    public void updateCheatsheetWithTags(
            int id,
            String title,
            String note,
            String tags){

        try{
            Connection con = DBConnection.getConnection();

            String updateSql =
                "UPDATE cheatsheets SET title=?, note=? WHERE id=?";

            PreparedStatement ps = con.prepareStatement(updateSql);
            ps.setString(1, title);
            ps.setString(2, note);
            ps.setInt(3, id);
            ps.executeUpdate();

            String deleteSql =
                "DELETE FROM cheatsheetsTag WHERE cheatsheets_id=?";

            PreparedStatement deletePs = con.prepareStatement(deleteSql);
            deletePs.setInt(1, id);
            deletePs.executeUpdate();

            if(tags != null && !tags.trim().isEmpty()){

                String[] tagArr = tags.split(",");

                for(String tagName : tagArr){

                    tagName = tagName.trim().toLowerCase();

                    if(tagName.isEmpty()){
                        continue;
                    }

                    int tagId = 0;

                    String findSql =
                        "SELECT id FROM tags WHERE name=?";

                    PreparedStatement findPs =
                        con.prepareStatement(findSql);

                    findPs.setString(1, tagName);

                    ResultSet rs = findPs.executeQuery();

                    if(rs.next()){
                        tagId = rs.getInt("id");
                    }else{
                        String insertSql =
                            "INSERT INTO tags(name) VALUES(?)";

                        PreparedStatement insertPs =
                            con.prepareStatement(
                                insertSql,
                                PreparedStatement.RETURN_GENERATED_KEYS);

                        insertPs.setString(1, tagName);
                        insertPs.executeUpdate();

                        ResultSet keyRs = insertPs.getGeneratedKeys();

                        if(keyRs.next()){
                            tagId = keyRs.getInt(1);
                        }
                    }

                    if(tagId > 0){
                        String linkSql =
                            "INSERT INTO cheatsheetsTag(cheatsheets_id, tags_id) VALUES(?,?)";

                        PreparedStatement linkPs =
                            con.prepareStatement(linkSql);

                        linkPs.setInt(1, id);
                        linkPs.setInt(2, tagId);
                        linkPs.executeUpdate();
                    }
                }
            }

        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    
    public List<HomeCheatSheetBean> findCheatsheetsByTagId(int tagId){

        List<HomeCheatSheetBean> list =
            new ArrayList<>();

        String sql =
            "SELECT c.id, c.title, c.note, " +
            "u.name AS username, " +
            "GROUP_CONCAT(t.name SEPARATOR ', ') AS tags, " +
            "GROUP_CONCAT(CONCAT(t.id, ':', t.name) SEPARATOR ',') AS tagData " +
            "FROM cheatsheets c " +
            "JOIN user u ON c.user_id = u.id " +
            "LEFT JOIN cheatsheetsTag cht ON c.id = cht.cheatsheets_id " +
            "LEFT JOIN tags t ON cht.tags_id = t.id " +
            "WHERE c.status='active' " +
            "AND c.situation='public' " +
            "AND c.id IN ( " +
            "   SELECT cheatsheets_id " +
            "   FROM cheatsheetsTag " +
            "   WHERE tags_id=? " +
            ") " +
            "GROUP BY c.id";

        try{
            Connection con =
                DBConnection.getConnection();

            PreparedStatement ps =
                con.prepareStatement(sql);

            ps.setInt(1, tagId);

            ResultSet rs =
                ps.executeQuery();

            while(rs.next()){

                HomeCheatSheetBean bean =
                    new HomeCheatSheetBean();

                bean.setId(rs.getInt("id"));
                bean.setTitle(rs.getString("title"));
                bean.setNote(rs.getString("note"));
                bean.setUsername(rs.getString("username"));
                bean.setTags(rs.getString("tags"));
                bean.setTagData(rs.getString("tagData"));

                list.add(bean);
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }
    
    public void requestPublish(int id){

        String sql =
            "UPDATE cheatsheets " +
            "SET situation='pending' " +
            "WHERE id=?";

        try{
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);

            ps.executeUpdate();

        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public List<HomeCheatSheetBean> findPendingCheatsheets(){

        List<HomeCheatSheetBean> list = new ArrayList<>();

        String sql =
            "SELECT c.id, c.title, c.note, u.name AS username, " +
            "GROUP_CONCAT(t.name SEPARATOR ', ') AS tags " +
            "FROM cheatsheets c " +
            "JOIN user u ON c.user_id = u.id " +
            "LEFT JOIN cheatsheetsTag cht ON c.id = cht.cheatsheets_id " +
            "LEFT JOIN tags t ON cht.tags_id = t.id " +
            "WHERE c.situation='pending' " +
            "AND c.status='active' " +
            "GROUP BY c.id";

        try{
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                HomeCheatSheetBean bean = new HomeCheatSheetBean();

                bean.setId(rs.getInt("id"));
                bean.setTitle(rs.getString("title"));
                bean.setNote(rs.getString("note"));
                bean.setUsername(rs.getString("username"));
                bean.setTags(rs.getString("tags"));

                list.add(bean);
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }
    
    public void approveCheatsheet(int id){

        String sql =
            "UPDATE cheatsheets " +
            "SET situation='public' " +
            "WHERE id=?";

        try{
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);

            ps.executeUpdate();

        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    
    public List<HomeCheatSheetBean> searchPublicByKeyword(String keyword){

        List<HomeCheatSheetBean> list = new ArrayList<>();

        String sql =
            "SELECT c.id, c.title, c.note, " +
            "u.name AS username, " +
            "GROUP_CONCAT(t.name SEPARATOR ', ') AS tags, " +
            "GROUP_CONCAT(CONCAT(t.id, ':', t.name) SEPARATOR ',') AS tagData " +
            "FROM cheatsheets c " +
            "JOIN user u ON c.user_id = u.id " +
            "LEFT JOIN cheatsheetsTag cht ON c.id = cht.cheatsheets_id " +
            "LEFT JOIN tags t ON cht.tags_id = t.id " +
            "WHERE c.status='active' " +
            "AND c.situation='public' " +
            "AND (c.title LIKE ? OR t.name LIKE ?) " +
            "GROUP BY c.id, c.title, c.note, u.name";

        try{
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);

            String search = "%" + keyword + "%";

            ps.setString(1, search);
            ps.setString(2, search);

            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                HomeCheatSheetBean bean = new HomeCheatSheetBean();

                bean.setId(rs.getInt("id"));
                bean.setTitle(rs.getString("title"));
                bean.setNote(rs.getString("note"));
                bean.setUsername(rs.getString("username"));
                bean.setTags(rs.getString("tags"));
                bean.setTagData(rs.getString("tagData"));

                list.add(bean);
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }
    
    public int countPendingCheatsheets(){

        int count = 0;

        String sql =
            "SELECT COUNT(*) AS total " +
            "FROM cheatsheets " +
            "WHERE situation='pending' " +
            "AND status='active'";

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
    
  
    
    public void updateCheatsheetStatus(
            int id,
            String status){

        String sql =

            "UPDATE cheatsheets " +
            "SET status=? " +
            "WHERE id=?";

        try(

            Connection con =
                DBConnection.getConnection();

            PreparedStatement ps =
                con.prepareStatement(sql);

        ){

            ps.setString(1, status);

            ps.setInt(2, id);

            ps.executeUpdate();

        }catch(Exception e){

            e.printStackTrace();
        }
    }
    
    public List<HomeCheatSheetBean>
    getAllPublicActiveRecords(){

        List<HomeCheatSheetBean> list =
            new ArrayList<>();

        String sql =

            "SELECT c.id, " +
            "c.title, " +
            "c.status, " +
            "c.createdAt, " +

            "u.name AS username, " +

            "cat.name AS categoryName " +

            "FROM cheatsheets c " +

            "JOIN user u " +
            "ON c.user_id = u.id " +

            "LEFT JOIN category cat " +
            "ON c.category_id = cat.id " +

            "WHERE c.situation = ? " +
            "AND c.status IN (?, ?) " +

            "ORDER BY c.createdAt DESC";

        try(

            Connection con =
                DBConnection.getConnection();

            PreparedStatement ps =
                con.prepareStatement(sql);

        ){

            ps.setString(1, "public");

            ps.setString(2, "active");

            ps.setString(3, "inactive");

            ResultSet rs =
                ps.executeQuery();

            while(rs.next()){

                HomeCheatSheetBean bean =
                    new HomeCheatSheetBean();

                bean.setId(
                    rs.getInt("id"));

                bean.setTitle(
                    rs.getString("title"));

                bean.setStatus(
                    rs.getString("status"));

                bean.setUsername(
                    rs.getString("username"));

                bean.setCategoryname(
                    rs.getString("categoryName"));

                bean.setCreatedAt(
                    rs.getTimestamp("createdAt"));

                list.add(bean);
            }

        }catch(Exception e){

            e.printStackTrace();
        }

        return list;
    }
    
    public int countAllCheatsheets(){

        int count = 0;

        String sql =

            "SELECT COUNT(*) " +
            "FROM cheatsheets";

        try(

            Connection con =
                DBConnection.getConnection();

            PreparedStatement ps =
                con.prepareStatement(sql);

            ResultSet rs =
                ps.executeQuery();

        ){

            if(rs.next()){

                count =
                    rs.getInt(1);
            }

        }catch(Exception e){

            e.printStackTrace();
        }

        return count;
    }
    
    
    public void increaseViewCount(int id){

        String sql =
            "UPDATE cheatsheets " +
            "SET viewCount = viewCount + 1 " +
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
    public List<HomeCheatSheetBean> searchCheatsheets(String keyword){

        List<HomeCheatSheetBean> list = new ArrayList<>();

        String sql =
            "SELECT c.id, c.title, c.note, c.createdAt, " +
            "c.user_id, c.category_id, c.viewCount, " +
            "u.name AS username, " +
            "cat.name AS categoryName, " +
            "GROUP_CONCAT(t.name SEPARATOR ', ') AS tags, " +
            "GROUP_CONCAT(CONCAT(t.id, ':', t.name) SEPARATOR ',') AS tagData " +
            "FROM cheatsheets c " +
            "JOIN user u ON c.user_id = u.id " +
            "LEFT JOIN category cat ON c.category_id = cat.id " +
            "LEFT JOIN cheatsheetsTag cht ON c.id = cht.cheatsheets_id " +
            "LEFT JOIN tags t ON cht.tags_id = t.id " +
            "WHERE c.status='active' " +
            "AND c.situation='public' " +
            "AND (c.title LIKE ? OR t.name LIKE ? OR cat.name LIKE ?) " +
            "GROUP BY c.id, c.title, c.note, c.createdAt, c.user_id, c.category_id, c.viewCount, u.name, cat.name " +
            "ORDER BY c.createdAt DESC";

        try{
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);

            String key = "%" + keyword + "%";

            ps.setString(1, key);
            ps.setString(2, key);
            ps.setString(3, key);

            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                HomeCheatSheetBean bean = new HomeCheatSheetBean();

                bean.setId(rs.getInt("id"));
                bean.setTitle(rs.getString("title"));
                bean.setNote(rs.getString("note"));
                bean.setCreatedAt(rs.getTimestamp("createdAt"));
                bean.setUserId(rs.getInt("user_id"));
                bean.setCategoryId(rs.getInt("category_id"));
                bean.setViewCount(rs.getInt("viewCount"));
                bean.setUsername(rs.getString("username"));
                bean.setCategoryname(rs.getString("categoryName"));
                bean.setTags(rs.getString("tags"));
                bean.setTagData(rs.getString("tagData"));

                list.add(bean);
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }
    
    public List<HomeCheatSheetBean> findByTagId(int tagId){

        List<HomeCheatSheetBean> list = new ArrayList<>();

        String sql =
            "SELECT c.id, c.title, c.note, c.createdAt, " +
            "c.user_id, c.category_id, c.viewCount, " +
            "u.name AS username, " +
            "cat.name AS categoryName, " +
            "GROUP_CONCAT(t2.name SEPARATOR ', ') AS tags, " +
            "GROUP_CONCAT(CONCAT(t2.id, ':', t2.name) SEPARATOR ',') AS tagData " +
            "FROM cheatsheets c " +
            "JOIN user u ON c.user_id = u.id " +
            "LEFT JOIN category cat ON c.category_id = cat.id " +
            "JOIN cheatsheetsTag chtFilter ON c.id = chtFilter.cheatsheets_id " +
            "LEFT JOIN cheatsheetsTag chtAll ON c.id = chtAll.cheatsheets_id " +
            "LEFT JOIN tags t2 ON chtAll.tags_id = t2.id " +
            "WHERE chtFilter.tags_id = ? " +
            "AND c.status='active' " +
            "AND c.situation='public' " +
            "GROUP BY c.id, c.title, c.note, c.createdAt, c.user_id, c.category_id, c.viewCount, u.name, cat.name " +
            "ORDER BY c.createdAt DESC";

        try{
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, tagId);

            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                HomeCheatSheetBean bean = new HomeCheatSheetBean();

                bean.setId(rs.getInt("id"));
                bean.setTitle(rs.getString("title"));
                bean.setNote(rs.getString("note"));
                bean.setCreatedAt(rs.getTimestamp("createdAt"));
                bean.setUserId(rs.getInt("user_id"));
                bean.setCategoryId(rs.getInt("category_id"));
                bean.setViewCount(rs.getInt("viewCount"));
                bean.setUsername(rs.getString("username"));
                bean.setCategoryname(rs.getString("categoryName"));
                bean.setTags(rs.getString("tags"));
                bean.setTagData(rs.getString("tagData"));

                list.add(bean);
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }
   
    
    public List<HomeCheatSheetBean> findPublicProfileCheatsheetsByUserId(int userId){

        List<HomeCheatSheetBean> list = new ArrayList<>();

        String sql =
            "SELECT c.id, c.title, c.note, c.createdAt, " +
            "c.user_id, c.category_id, c.viewCount, " +
            "u.name AS username, " +
            "cat.name AS categoryName, " +
            "GROUP_CONCAT(t.name SEPARATOR ', ') AS tags, " +
            "GROUP_CONCAT(CONCAT(t.id, ':', t.name) SEPARATOR ',') AS tagData " +
            "FROM cheatsheets c " +
            "JOIN user u ON c.user_id = u.id " +
            "LEFT JOIN category cat ON c.category_id = cat.id " +
            "LEFT JOIN cheatsheetsTag cht ON c.id = cht.cheatsheets_id " +
            "LEFT JOIN tags t ON cht.tags_id = t.id " +
            "WHERE c.user_id = ? " +
            "AND c.situation='public' " +
            "AND c.status='active' " +
            "GROUP BY c.id, c.title, c.note, c.createdAt, c.user_id, c.category_id, c.viewCount, u.name, cat.name " +
            "ORDER BY c.createdAt DESC";

        try{
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                HomeCheatSheetBean bean = new HomeCheatSheetBean();

                bean.setId(rs.getInt("id"));
                bean.setTitle(rs.getString("title"));
                bean.setNote(rs.getString("note"));
                bean.setCreatedAt(rs.getTimestamp("createdAt"));
                bean.setUserId(rs.getInt("user_id"));
                bean.setCategoryId(rs.getInt("category_id"));
                bean.setViewCount(rs.getInt("viewCount"));
                bean.setUsername(rs.getString("username"));
                bean.setCategoryname(rs.getString("categoryName"));
                bean.setTags(rs.getString("tags"));
                bean.setTagData(rs.getString("tagData"));

                list.add(bean);
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }
    
    
    public List<HomeCheatSheetBean> findRecentCheatsheets(){

        List<HomeCheatSheetBean> list = new ArrayList<>();

        String sql =
            "SELECT c.id, c.title, c.note, c.createdAt, " +
            "c.user_id, c.category_id, c.viewCount, " +
            "u.name AS username, " +
            "cat.name AS categoryName, " +
            "GROUP_CONCAT(t.name SEPARATOR ', ') AS tags, " +
            "GROUP_CONCAT(CONCAT(t.id, ':', t.name) SEPARATOR ',') AS tagData " +
            "FROM cheatsheets c " +
            "JOIN user u ON c.user_id = u.id " +
            "LEFT JOIN category cat ON c.category_id = cat.id " +
            "LEFT JOIN cheatsheetsTag cht ON c.id = cht.cheatsheets_id " +
            "LEFT JOIN tags t ON cht.tags_id = t.id " +
            "WHERE c.status='active' " +
            "AND c.situation='public' " +
            "GROUP BY c.id, c.title, c.note, c.createdAt, c.user_id, c.category_id, c.viewCount, u.name, cat.name " +
            "ORDER BY c.createdAt DESC";

        try{
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                HomeCheatSheetBean bean = new HomeCheatSheetBean();

                bean.setId(rs.getInt("id"));
                bean.setTitle(rs.getString("title"));
                bean.setNote(rs.getString("note"));
                bean.setCreatedAt(rs.getTimestamp("createdAt"));
                bean.setUserId(rs.getInt("user_id"));
                bean.setCategoryId(rs.getInt("category_id"));
                bean.setViewCount(rs.getInt("viewCount"));
                bean.setUsername(rs.getString("username"));
                bean.setCategoryname(rs.getString("categoryName"));
                bean.setTags(rs.getString("tags"));
                bean.setTagData(rs.getString("tagData"));

                list.add(bean);
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }
    
   
    
    public List<HomeCheatSheetBean> findPopularCheatsheets(){

        List<HomeCheatSheetBean> list =
            new ArrayList<>();

        String sql =
            "SELECT c.id, c.title, c.note, " +
            "c.createdAt, c.user_id, " +
            "c.category_id, c.viewCount, " +

            "u.name AS username, " +
            "cat.name AS categoryName, " +

            "GROUP_CONCAT(t.name SEPARATOR ', ') AS tags, " +

            "GROUP_CONCAT(CONCAT(t.id, ':', t.name) SEPARATOR ',') AS tagData, " +

            "IFNULL(AVG(r.rating),0) AS avgRating, " +
            "COUNT(r.id) AS ratingCount " +

            "FROM cheatsheets c " +

            "JOIN user u ON c.user_id = u.id " +

            "LEFT JOIN category cat " +
            "ON c.category_id = cat.id " +

            "LEFT JOIN cheatsheetsTag cht " +
            "ON c.id = cht.cheatsheets_id " +

            "LEFT JOIN tags t " +
            "ON cht.tags_id = t.id " +

            "LEFT JOIN ratings r " +
            "ON c.id = r.cheatsheet_id " +

            "WHERE c.status='active' " +
            "AND c.situation='public' " +

            "GROUP BY c.id, c.title, c.note, " +
            "c.createdAt, c.user_id, " +
            "c.category_id, c.viewCount, " +
            "u.name, cat.name " +

            "ORDER BY avgRating DESC, ratingCount DESC " +
            "LIMIT 12";

        try{

            Connection con =
                DBConnection.getConnection();

            PreparedStatement ps =
                con.prepareStatement(sql);

            ResultSet rs =
                ps.executeQuery();

            while(rs.next()){

                HomeCheatSheetBean bean =
                    new HomeCheatSheetBean();

                bean.setId(rs.getInt("id"));
                bean.setTitle(rs.getString("title"));
                bean.setNote(rs.getString("note"));

                bean.setCreatedAt(
                    rs.getTimestamp("createdAt"));

                bean.setUserId(
                    rs.getInt("user_id"));

                bean.setCategoryId(
                    rs.getInt("category_id"));

                bean.setViewCount(
                    rs.getInt("viewCount"));

                bean.setUsername(
                    rs.getString("username"));

                bean.setCategoryname(
                    rs.getString("categoryName"));

                bean.setTags(
                    rs.getString("tags"));

                bean.setTagData(
                    rs.getString("tagData"));

                bean.setAverageRating(
                    rs.getDouble("avgRating"));

                bean.setRatingCount(
                    rs.getInt("ratingCount"));

                list.add(bean);
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }
    
    
    
}