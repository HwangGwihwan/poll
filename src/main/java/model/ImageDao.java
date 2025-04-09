package model;

import java.sql.*;
import dto.*;
import java.util.ArrayList;

public class ImageDao {
	public void deleteImage(int num) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "delete from image where num = ?";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, num);
		stmt.executeUpdate();
		
		conn.close();
	}
	
	public ArrayList<Image> selectImageList(Paging p) throws ClassNotFoundException, SQLException {
		ArrayList<Image> list = new ArrayList<Image>();
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select num, memo, filename, createdate from image order by num desc limit ?, ?";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, p.getBeginRow());
		stmt.setInt(2, p.getRowPerPage());
		rs = stmt.executeQuery();
		
		while (rs.next()) {
			Image image = new Image();
			image.setNum(rs.getInt("num"));
			image.setMemo(rs.getString("memo"));
			image.setFilename(rs.getString("filename"));
			image.setCreatedate(rs.getString("createdate"));
			
			list.add(image);
		}
		
		conn.close();
		return list;
	}
	
	public void insertImage(Image image) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "insert into image (memo, filename) values (?, ?)";
	
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, image.getMemo());
		stmt.setString(2, image.getFilename());
		stmt.executeUpdate();
		
		conn.close();
	}
}
