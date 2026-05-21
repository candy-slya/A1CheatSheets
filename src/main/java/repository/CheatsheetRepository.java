package repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.CheatsheetBean;


public class CheatsheetRepository {

    public void createCheatsheet(String title, int categoryId, int userId, String note, String[] tags) {
        Connection con = null;
        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false); // Transaction start

            // ၁. Cheatsheet Table ထဲ ထည့်ခြင်း
            String sqlCS = "INSERT INTO cheatsheets (title, note, user_id, category_id) VALUES (?, ?, ?, ?)";
            PreparedStatement psCS = con.prepareStatement(sqlCS, Statement.RETURN_GENERATED_KEYS);
            psCS.setString(1, title);
            psCS.setString(2, note);
            psCS.setInt(3, userId);
            psCS.setInt(4, categoryId);
            psCS.executeUpdate();

            // Insert လုပ်လိုက်တဲ့ Cheatsheet ID ကို ယူခြင်း
            ResultSet rs = psCS.getGeneratedKeys();
            int cheatsheetId = 0;
            if (rs.next()) {
                cheatsheetId = rs.getInt(1);
            }

            // ၂. Tags တွေကို ကိုင်တွယ်ခြင်း
            for (String tagName : tags) {
                tagName = tagName.trim().toLowerCase();
                if (tagName.isEmpty()) continue;

                // Tag ရှိပြီးသားလား အရင်စစ်၊ မရှိရင် Insert လုပ်ပြီး ID ယူ
                int tagId = getOrCreateTag(con, tagName);

                // ၃. Join Table (cheatsheetsTag) ထဲ ထည့်ခြင်း
                String sqlJoin = "INSERT INTO cheatsheetsTag (tags_id, cheatsheets_id) VALUES (?, ?)";
                PreparedStatement psJoin = con.prepareStatement(sqlJoin);
                psJoin.setInt(1, tagId);
                psJoin.setInt(2, cheatsheetId);
                psJoin.executeUpdate();
            }

            con.commit(); // အားလုံးအဆင်ပြေမှ DB ထဲ အပြီးသွင်း
        } catch (Exception e) {
            try { if(con != null) con.rollback(); } catch(SQLException ex) { ex.printStackTrace(); }
            e.printStackTrace();
        } finally {
            try { if(con != null) con.close(); } catch(SQLException ex) { ex.printStackTrace(); }
        }
    }

    private int getOrCreateTag(Connection con, String tagName) throws SQLException {
        // Tag ရှိမရှိ စစ်
        String sqlCheck = "SELECT id FROM tags WHERE name = ?";
        PreparedStatement psCheck = con.prepareStatement(sqlCheck);
        psCheck.setString(1, tagName);
        ResultSet rs = psCheck.executeQuery();

        if (rs.next()) {
            return rs.getInt("id");
        } else {
            // မရှိရင် အသစ်ထည့်
            String sqlIns = "INSERT INTO tags (name) VALUES (?)";
            PreparedStatement psIns = con.prepareStatement(sqlIns, Statement.RETURN_GENERATED_KEYS);
            psIns.setString(1, tagName);
            psIns.executeUpdate();
            ResultSet rsIns = psIns.getGeneratedKeys();
            rsIns.next();
            return rsIns.getInt(1);
        }
       
        
    }
    
    public List<CheatsheetBean> cheatsheetslist(int userId) {
        List<CheatsheetBean> list = new ArrayList<>();
        String sql = "SELECT c.id, c.title, c.note, c.category_id, " +
                     "cat.name AS category_name, c.situation, c.status " +
                     "FROM cheatsheets c " +
                     "JOIN category cat ON c.category_id = cat.id " +
                     "WHERE c.user_id=? AND c.status='active'";
        try(Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()) {
                CheatsheetBean cs = new CheatsheetBean();
                cs.setId(rs.getInt("id"));
                cs.setTitle(rs.getString("title"));
                cs.setNote(rs.getString("note"));
                cs.setCategoryId(rs.getInt("category_id"));
                cs.setCategoryName(rs.getString("category_name"));
                cs.setSituation(rs.getString("situation"));   // ✅ new field
                cs.setStatus(rs.getString("status"));
                list.add(cs);
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    
}