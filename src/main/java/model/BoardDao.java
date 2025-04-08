package model;
import java.sql.*;
import java.util.ArrayList;
import dto.*;

public class BoardDao {	
	// 새글 입력(부모글)
	public void insertBoard(Board b) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null; // 입력직후 PK값을 반환받기 위해
		String sql = "insert into board (name, subject, content, ref, pass, ip) values (?, ?, ?, ?, ?, ?)";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		conn.setAutoCommit(false); // executeUpdate()시마다 자동커밋기능을 false	
		stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		stmt.setString(1, b.getName());
		stmt.setString(2, b.getSubject());
		stmt.setString(3, b.getContent());
		stmt.setInt(4, b.getRef());
		stmt.setString(5, b.getPass());
		stmt.setString(6, b.getIp());
		stmt.executeUpdate();
		// ref == 0이면 입력직후 pk값을 반환 받아서 ref값을 동일하게
		rs = stmt.getGeneratedKeys();
		int pk = 0;
		if (rs.next()) {
			pk = rs.getInt(1);
		}

		PreparedStatement stmt2 = null;
		String sql2 = "update board set ref = ? where num = ?";
		stmt2 = conn.prepareStatement(sql2);
		// update쿼리가 실패하면 이전의 insert도 롤백 : conn.rollback();
		stmt2.setInt(1, pk);
		stmt2.setInt(2, pk);
		stmt2.executeUpdate();
		
		conn.commit(); // conn.setAutoCommit(false) 코드 때문에 필요
		conn.close();
	}
	
	// 답글 입력
	public void insertBoardReply(Board b) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt2 = null;
		String sql2 = "update board set pos = pos+1 where ref = ? and pos >= ?";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		// 트랜잭션 처리
		conn.setAutoCommit(false); // executeUpdate()시마다 자동커밋기능을 false
		// ref같고 pos값이 현재값보다 크거나 같아면 +1
		stmt2 = conn.prepareStatement(sql2);
		stmt2.setInt(1, b.getRef());
		stmt2.setInt(2, b.getPos());
		stmt2.executeUpdate();
		
		// 답글입력
		PreparedStatement stmt = null;
		String sql = "insert into board (name, subject, content, pos, ref, depth, pass, ip) values (?, ?, ?, ?, ?, ?, ?, ?)";
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, b.getName());
		stmt.setString(2, b.getSubject());
		stmt.setString(3, b.getContent());
		stmt.setInt(4, b.getPos());
		stmt.setInt(5, b.getRef());
		stmt.setInt(6, b.getDepth());
		stmt.setString(7, b.getPass());
		stmt.setString(8, b.getIp());
		stmt.executeUpdate();
		
		conn.commit(); // conn.setAutoCommit(false) 코드 때문에 필요
		conn.close();
	}
	
	public ArrayList<Board> selectBoardList(Paging p, String search) throws ClassNotFoundException, SQLException {
		ArrayList<Board> boardList = new ArrayList<Board>();
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select num, name, subject, content, pos, ref, depth, regdate, pass, ip, count from board where subject like ? order by ref desc, pos limit ?, ?";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%" + search + "%");
		stmt.setInt(2, p.getBeginRow());
		stmt.setInt(3, p.getRowPerPage());
		rs = stmt.executeQuery();
		
		while (rs.next()) {
			Board board = new Board();
			board.setNum(rs.getInt("num"));
			board.setName(rs.getString("name"));
			board.setSubject(rs.getString("subject"));
			board.setContent(rs.getString("content"));
			board.setPos(rs.getInt("pos"));
			board.setRef(rs.getInt("ref"));
			board.setDepth(rs.getInt("depth"));
			board.setRegdate(rs.getString("regdate"));
			board.setPass(rs.getString("pass"));
			board.setIp(rs.getString("ip"));
			board.setCount(rs.getInt("count"));
			
			boardList.add(board);
		}
		
		conn.close();
		return boardList;
	}
	
	public Board selectBoardOne(int num) throws ClassNotFoundException, SQLException {
		Board board = null;
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select num, name, subject, content, pos, ref, depth, regdate, pass, ip, count from board where num = ?";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, num);
		rs = stmt.executeQuery();
		
		if (rs.next()) {
			board = new Board();
			board.setNum(rs.getInt("num"));
			board.setName(rs.getString("name"));
			board.setSubject(rs.getString("subject"));
			board.setContent(rs.getString("content"));
			board.setPos(rs.getInt("pos"));
			board.setRef(rs.getInt("ref"));
			board.setDepth(rs.getInt("depth"));
			board.setRegdate(rs.getString("regdate"));
			board.setPass(rs.getString("pass"));
			board.setIp(rs.getString("ip"));
			board.setCount(rs.getInt("count"));
		}
		
		conn.close();
		return board;
	}
	
	public int updateBoardOne(Board b) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "update board set name = ?, subject = ?, content = ? where num = ? and pass = ?";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, b.getName());
		stmt.setString(2, b.getSubject());
		stmt.setString(3, b.getContent());
		stmt.setInt(4, b.getNum());
		stmt.setString(5, b.getPass());
		int row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
	
	public int deleteBoardOne(Board b) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "delete from board where num = ? and pass = ?";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, b.getNum());
		stmt.setString(2, b.getPass());
		int row = stmt.executeUpdate();
		
		if (row != 0) { // 삭제성공 -> 답글들도 모두 삭제
			deleteBoardReply(b.getNum());
		}
		
		conn.close();
		return row;
	}
	
	public void deleteBoardReply(int ref) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "delete from board where ref = ?";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ref);
		stmt.executeUpdate();
		
		conn.close();
	}
	
	public int getTotal(String search) throws ClassNotFoundException, SQLException {
		int total = 0;
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select count(*) cnt from board where subject like ?";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%" + search + "%");
		rs = stmt.executeQuery();
		rs.next();
		total = rs.getInt("cnt");
		
		conn.close();
		return total;
	}
}
