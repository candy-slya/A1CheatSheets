package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.TagBean;

public class TagRepository {

    public List<TagBean> findPopularTags(){

        List<TagBean> list = new ArrayList<>();

        String sql =
            "SELECT t.id, t.name, COUNT(ct.cheatsheets_id) AS tagCount " +
            "FROM tags t " +
            "JOIN cheatsheetsTag ct ON t.id = ct.tags_id " +
            "JOIN cheatsheets c ON ct.cheatsheets_id = c.id " +
            "WHERE c.status='active' " +
            "AND c.situation='public' " +
            "GROUP BY t.id, t.name " +
            "ORDER BY tagCount DESC";

        try{

            Connection con =
                DBConnection.getConnection();

            PreparedStatement ps =
                con.prepareStatement(sql);

            ResultSet rs =
                ps.executeQuery();

            while(rs.next()){

                TagBean tag =
                    new TagBean();

                tag.setId(rs.getInt("id"));
                tag.setName(rs.getString("name"));
                tag.setCount(rs.getInt("tagCount"));

                list.add(tag);
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }
}