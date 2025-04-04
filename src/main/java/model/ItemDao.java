package model;
import java.sql.*;
import java.util.*;

import dto.Item;

//Table : question crud
public class ItemDao {
	public int selectItemCountByQnum(int qnum) throws ClassNotFoundException, SQLException {
		int count = 0;
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select sum(count) cnt from item group by qnum having qnum = ?";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnum);
		rs = stmt.executeQuery();
		if (rs.next()) {
			count = rs.getInt("cnt");
		}
		
		conn.close();
		return count;
	}
	
	
	public void updateItemCountPlus(int qnum, int inum) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "update item set count = count+1 where qnum = ? and inum = ?";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnum);
		stmt.setInt(2, inum);
		int row = stmt.executeUpdate();
		if (row == 1) {
			System.out.println("itemDao.updateItemCountPlus 입력성공");
		} else {
			System.out.println("itemDao.updateItemCountPlus 입력실패");
		}
		
		conn.close();
	}
	
	public void deleteItem(int qnum) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "delete from item where qnum = ?";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnum);
		stmt.executeUpdate();
				
		conn.close();
	}

	// updateItemForm, questionOneResult
	public ArrayList<Item> selectItem(int qnum) throws ClassNotFoundException, SQLException {
		ArrayList<Item> list = new ArrayList<>();
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select qnum, inum, content, count from item where qnum = ? order by inum asc";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnum);
		rs = stmt.executeQuery();
		
		while (rs.next()) {
			Item item = new Item();
			item.setQnum(rs.getInt("qnum"));
			item.setInum(rs.getInt("inum"));
			item.setContent(rs.getString("content"));
			item.setCount(rs.getInt("count"));
			
			list.add(item);
		}
		
		conn.close();
		return list;
	}
	
	public void insertItem(Item item) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "insert into item (qnum, inum, content) values (?, ?, ?)";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, item.getQnum());
		stmt.setInt(2, item.getInum());
		stmt.setString(3, item.getContent());
		int row = stmt.executeUpdate();
		
		if (row == 1) {
			System.out.println("ItemDao.insertItem - 입력성공");
		} else {
			System.out.println("ItemDao.insertItem - 입력실패");
		}
		
		conn.close();
	}
}
