package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.HomeCheatSheetBean;



public class BookmarkRepository {

    public boolean isBookmarked(int userId, int cheatsheetId){

        boolean bookmarked = false;

        String sql =
            "SELECT id FROM bookmarks " +
            "WHERE user_id=? AND cheatsheet_id=?";

        try{
            Connection con =
                DBConnection.getConnection();

            PreparedStatement ps =
                con.prepareStatement(sql);

            ps.setInt(1, userId);
            ps.setInt(2, cheatsheetId);

            ResultSet rs =
                ps.executeQuery();

            if(rs.next()){
                bookmarked = true;
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return bookmarked;
    }


    public void addBookmark(int userId, int cheatsheetId){

        String sql =
            "INSERT INTO bookmarks(user_id, cheatsheet_id) " +
            "VALUES(?, ?)";

        try{
            Connection con =
                DBConnection.getConnection();

            PreparedStatement ps =
                con.prepareStatement(sql);

            ps.setInt(1, userId);
            ps.setInt(2, cheatsheetId);

            ps.executeUpdate();

        }catch(Exception e){
            e.printStackTrace();
        }
    }


    public void removeBookmark(int userId, int cheatsheetId){

        String sql =
            "DELETE FROM bookmarks " +
            "WHERE user_id=? AND cheatsheet_id=?";

        try{
            Connection con =
                DBConnection.getConnection();

            PreparedStatement ps =
                con.prepareStatement(sql);

            ps.setInt(1, userId);
            ps.setInt(2, cheatsheetId);

            ps.executeUpdate();

        }catch(Exception e){
            e.printStackTrace();
        }
    }


    public int countBookmarkByCheatsheetId(int cheatsheetId){

        int count = 0;

        String sql =
            "SELECT COUNT(*) FROM bookmarks " +
            "WHERE cheatsheet_id=?";

        try{
            Connection con =
                DBConnection.getConnection();

            PreparedStatement ps =
                con.prepareStatement(sql);

            ps.setInt(1, cheatsheetId);

            ResultSet rs =
                ps.executeQuery();

            if(rs.next()){
                count = rs.getInt(1);
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return count;
    }
    
    public List<HomeCheatSheetBean> findBookmarksByUserId(int userId){

        List<HomeCheatSheetBean> list =
            new ArrayList<>();

        String sql =
            "SELECT c.id, c.title, c.note, c.createdAt, " +
            "c.user_id, c.category_id, c.viewCount, " +
            "u.name AS username, " +
            "cat.name AS categoryName, " +
            "GROUP_CONCAT(t.name SEPARATOR ', ') AS tags, " +
            "GROUP_CONCAT(CONCAT(t.id, ':', t.name) SEPARATOR ',') AS tagData " +
            "FROM bookmarks b " +
            "JOIN cheatsheets c ON b.cheatsheet_id = c.id " +
            "JOIN user u ON c.user_id = u.id " +
            "LEFT JOIN category cat ON c.category_id = cat.id " +
            "LEFT JOIN cheatsheetsTag cht ON c.id = cht.cheatsheets_id " +
            "LEFT JOIN tags t ON cht.tags_id = t.id " +
            "WHERE b.user_id = ? " +
            "AND c.status = 'active' " +
            "AND c.situation = 'public' " +
            "GROUP BY c.id, c.title, c.note, c.createdAt, " +
            "c.user_id, c.category_id, c.viewCount, u.name, cat.name " +
            "ORDER BY b.createdAt DESC";

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
    
    
}