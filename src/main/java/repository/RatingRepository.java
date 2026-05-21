package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.RatingRecordBean;



public class RatingRepository {

    public void saveOrUpdateRating(
            int userId,
            int cheatsheetId,
            int rating){

        try{

            Connection con =
                DBConnection.getConnection();

            String checkSql =
                "SELECT id FROM ratings " +
                "WHERE user_id=? " +
                "AND cheatsheet_id=?";

            PreparedStatement checkPs =
                con.prepareStatement(checkSql);

            checkPs.setInt(1, userId);
            checkPs.setInt(2, cheatsheetId);

            ResultSet rs =
                checkPs.executeQuery();

            if(rs.next()){

                String updateSql =
                    "UPDATE ratings " +
                    "SET rating=? " +
                    "WHERE user_id=? " +
                    "AND cheatsheet_id=?";

                PreparedStatement updatePs =
                    con.prepareStatement(updateSql);

                updatePs.setInt(1, rating);
                updatePs.setInt(2, userId);
                updatePs.setInt(3, cheatsheetId);

                updatePs.executeUpdate();

            }else{

                String insertSql =
                    "INSERT INTO ratings(" +
                    "user_id, cheatsheet_id, rating" +
                    ") VALUES(?,?,?)";

                PreparedStatement insertPs =
                    con.prepareStatement(insertSql);

                insertPs.setInt(1, userId);
                insertPs.setInt(2, cheatsheetId);
                insertPs.setInt(3, rating);

                insertPs.executeUpdate();
            }

        }catch(Exception e){
            e.printStackTrace();
        }
    }

    public double getAverageRating(
            int cheatsheetId){

        double avg = 0;

        try{

            Connection con =
                DBConnection.getConnection();

            String sql =
                "SELECT AVG(rating) AS avgRating " +
                "FROM ratings " +
                "WHERE cheatsheet_id=?";

            PreparedStatement ps =
                con.prepareStatement(sql);

            ps.setInt(1, cheatsheetId);

            ResultSet rs =
                ps.executeQuery();

            if(rs.next()){

                avg =
                    rs.getDouble("avgRating");
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return avg;
    }

    public int getRatingCount(
            int cheatsheetId){

        int count = 0;

        try{

            Connection con =
                DBConnection.getConnection();

            String sql =
                "SELECT COUNT(*) AS total " +
                "FROM ratings " +
                "WHERE cheatsheet_id=?";

            PreparedStatement ps =
                con.prepareStatement(sql);

            ps.setInt(1, cheatsheetId);

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

    public int getUserRating(
            int userId,
            int cheatsheetId){

        int rating = 0;

        try{

            Connection con =
                DBConnection.getConnection();

            String sql =
                "SELECT rating FROM ratings " +
                "WHERE user_id=? " +
                "AND cheatsheet_id=?";

            PreparedStatement ps =
                con.prepareStatement(sql);

            ps.setInt(1, userId);
            ps.setInt(2, cheatsheetId);

            ResultSet rs =
                ps.executeQuery();

            if(rs.next()){

                rating =
                    rs.getInt("rating");
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return rating;
    }
    
    public List<RatingRecordBean> findRatingRecordsByOwnerId(int ownerId){

        List<RatingRecordBean> list =
            new ArrayList<>();

        String sql =
            "SELECT r.id, r.rating, r.createdAt, " +
            "r.user_id AS raterId, " +
            "u.name AS raterName, " +
            "c.id AS cheatsheetId, " +
            "c.title AS cheatsheetTitle " +
            "FROM ratings r " +
            "JOIN user u ON r.user_id = u.id " +
            "JOIN cheatsheets c ON r.cheatsheet_id = c.id " +
            "WHERE c.user_id = ? " +
            "ORDER BY r.createdAt DESC";

        try{
            Connection con =
                DBConnection.getConnection();

            PreparedStatement ps =
                con.prepareStatement(sql);

            ps.setInt(1, ownerId);

            ResultSet rs =
                ps.executeQuery();

            while(rs.next()){

                RatingRecordBean bean =
                    new RatingRecordBean();

                bean.setId(rs.getInt("id"));
                bean.setRating(rs.getInt("rating"));
                bean.setCreatedAt(rs.getTimestamp("createdAt"));

                bean.setRaterId(rs.getInt("raterId"));
                bean.setRaterName(rs.getString("raterName"));

                bean.setCheatsheetId(rs.getInt("cheatsheetId"));
                bean.setCheatsheetTitle(rs.getString("cheatsheetTitle"));

                list.add(bean);
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }
    
    
    
}