package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.UserBean;

public class UserRepository {

	

    public int addUser(UserBean user) {
        int i = 0;

        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DBConnection.getConnection();
            String sql = "INSERT INTO user(name,email,password) VALUES (?,?,?)";

            ps = con.prepareStatement(sql);
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
           

            i = ps.executeUpdate();

        } catch (SQLException e) {
            System.out.println("insert fail : " + e.getMessage());
        } finally {
            try {
                if(ps != null) ps.close();
                if(con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return i;
    }
    
    public boolean emailExists(String email) {
        boolean exists = false;
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT id FROM user WHERE email=?")) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            exists = rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return exists;
    }

    
    public UserBean findByEmail(String email) {
        UserBean user = null;
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM user WHERE email=?")) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                user = new UserBean();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getString("status"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    
    public List<UserBean> findByStatus() {
        List<UserBean> list = new ArrayList<>();
        String sql = "SELECT * FROM user WHERE status=?";
        try(Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "active");
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                UserBean u = new UserBean();
                u.setId(rs.getInt("id"));
                u.setName(rs.getString("name"));
                u.setEmail(rs.getString("email"));
                u.setRole(rs.getString("role"));
                u.setStatus(rs.getString("status"));
                list.add(u);
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public void updateStatus(int id, String status) {
        String sql = "UPDATE user SET status=? WHERE id=?";
        try(Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, id);
            ps.executeUpdate();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    public List<UserBean> findByRoleAndStatus() {
        List<UserBean> list = new ArrayList<>();
        String sql = "SELECT * FROM user WHERE role=? AND status=?";
        try(Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, "user");   // e.g. "user"
            ps.setString(2, "active"); // e.g. "active"
            
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                UserBean u = new UserBean();
                u.setId(rs.getInt("id"));
                u.setName(rs.getString("name"));
                u.setEmail(rs.getString("email"));
                u.setRole(rs.getString("role"));
                u.setStatus(rs.getString("status"));
                list.add(u);
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<UserBean> searchUsers(String keyword){

        List<UserBean> list =
            new ArrayList<>();

        String sql =
            "SELECT * FROM user " +
            "WHERE role='user' " +
            "AND (" +
            "name LIKE ? " +
            "OR email LIKE ? " +
            "OR role LIKE ?)" +
            "ORDER BY id DESC";

        try{

            Connection con =
                DBConnection.getConnection();

            PreparedStatement ps =
                con.prepareStatement(sql);

            ps.setString(1, keyword + "%");
            ps.setString(2, keyword + "%");
            ps.setString(3, keyword + "%");

            ResultSet rs = ps.executeQuery();

            while(rs.next()){

                UserBean user =
                    new UserBean();

                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getString("status"));

                list.add(user);
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }
    
    
    public List<UserBean> findInactiveUsers(){

        List<UserBean> list =
            new ArrayList<>();

        String sql =
            "SELECT * FROM user " +
            "WHERE status='inactive' " +
            "ORDER BY id DESC";

        try{

            Connection con =
                DBConnection.getConnection();

            PreparedStatement ps =
                con.prepareStatement(sql);

            ResultSet rs =
                ps.executeQuery();

            while(rs.next()){

                UserBean user =
                    new UserBean();

                user.setId(
                    rs.getInt("id"));

                user.setName(
                    rs.getString("name"));

                user.setEmail(
                    rs.getString("email"));

                user.setRole(
                    rs.getString("role"));

                user.setStatus(
                    rs.getString("status"));

                list.add(user);
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }
    
    public void unbanUser(int id){

        String sql =
            "UPDATE user " +
            "SET status='active' " +
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
    
    
    public int countUsers(){

        int count = 0;

        String sql =
            "SELECT COUNT(*) AS total " +
            "FROM user";

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
    
    
    
    public boolean updateName(int id, String name){

        boolean result = false;

        String sql =
            "UPDATE user SET name=? WHERE id=?";

        try{
            Connection con =
                DBConnection.getConnection();

            PreparedStatement ps =
                con.prepareStatement(sql);

            ps.setString(1, name);
            ps.setInt(2, id);

            result =
                ps.executeUpdate() > 0;

        }catch(Exception e){
            e.printStackTrace();
        }

        return result;
    }


    public boolean checkPassword(int id, String oldPassword){

        boolean result = false;

        String sql =
            "SELECT id FROM user WHERE id=? AND password=?";

        try{
            Connection con =
                DBConnection.getConnection();

            PreparedStatement ps =
                con.prepareStatement(sql);

            ps.setInt(1, id);
            ps.setString(2, oldPassword);

            ResultSet rs =
                ps.executeQuery();

            if(rs.next()){
                result = true;
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return result;
    }

    public String findPasswordByUserId(int id){

        String password = null;

        String sql =
            "SELECT password FROM user WHERE id=?";

        try{
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if(rs.next()){
                password = rs.getString("password");
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return password;
    }

    public boolean updatePassword(int id, String hashedPassword){

        boolean result = false;

        String sql =
            "UPDATE user SET password=? WHERE id=?";

        try{
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, hashedPassword);
            ps.setInt(2, id);

            result = ps.executeUpdate() > 0;

        }catch(Exception e){
            e.printStackTrace();
        }

        return result;
    }
    
    
    public UserBean findUserById(int userId){

        UserBean user = null;

        String sql =
            "SELECT id, name, email, role, createdAt " +
            "FROM user " +
            "WHERE id=?";

        try{
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            if(rs.next()){
                user = new UserBean();

                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setCreatedAt(rs.getTimestamp("createdAt"));
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return user;
    }
    
    
}
