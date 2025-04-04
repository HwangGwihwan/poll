package model;
import java.sql.*;
import java.util.*;
import dto.Paging;
import dto.Question;

// Table : question crud
public class QuestionDao {
	public void deleteQuestion(int num) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "delete from question where num = ?";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, num);
		stmt.executeUpdate();
		
		conn.close();
	}
	
	public Question selectQuestion(int num) throws ClassNotFoundException, SQLException {
		Question question = null;
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select num, title, startdate, enddate, type from question where num = ?";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, num);
		rs = stmt.executeQuery();
		
		while (rs.next()) {
			question = new Question();
			question.setNum(rs.getInt("num"));
			question.setTitle(rs.getString("title"));
			question.setStartdate(rs.getString("startdate"));
			question.setEnddate(rs.getString("enddate"));
			question.setType(rs.getInt("type"));
		}

		conn.close();
		return question;
	}
	
	public void updateQuestion(Question question) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "update question set title = ?, startdate = ?, enddate = ?, type = ? where num = ?";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, question.getTitle());
		stmt.setString(2, question.getStartdate());
		stmt.setString(3, question.getEnddate());
		stmt.setInt(4, question.getType());
		stmt.setInt(5, question.getNum());
		stmt.executeUpdate();
		
		conn.close();
	}
	
	public ArrayList<HashMap<String, Object>> selelctQuestionList(Paging p) throws ClassNotFoundException, SQLException {
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select q.num, q.title, q.startdate, q.enddate, q.type, t.cnt from question q inner join"
					+ " (select qnum, sum(count) cnt from item group by qnum) t on q.num = t.qnum limit ?, ?";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, p.getBeginRow());
		stmt.setInt(2, p.getRowPerPage());
		rs = stmt.executeQuery();
		
		while (rs.next()) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("num", rs.getInt("q.num"));
			map.put("title", rs.getString("q.title"));
			map.put("startdate", rs.getString("q.startdate"));
			map.put("enddate", rs.getString("q.enddate"));
			map.put("type", rs.getInt("q.type"));
			map.put("cnt", rs.getInt("t.cnt"));
			
			list.add(map);
		}
		
		conn.close();
		return list;
	}
	
	public int getTotal() throws ClassNotFoundException, SQLException {
		int total = 0;
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select count(*) cnt from question";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		rs.next();
		total = rs.getInt("cnt");
		
		conn.close();
		return total;
	}
	
	// 입력 후 자동으로 생성된 키값을 반환값
	public int insertQuestion(Question question) throws ClassNotFoundException, SQLException {
		int pk = 0;
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		// 입력이지만 키값을 받아올때 사용
		ResultSet rs = null;
		String sql = "insert into question(title, startdate, enddate, type) values (?, ?, ?, ?)";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		// Statement.RETURN_GENERATED_KEYS 옵션: insert 후 select max(pk) from ... 실행
		stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		stmt.setString(1, question.getTitle());
		stmt.setString(2, question.getStartdate());
		stmt.setString(3, question.getEnddate());
		stmt.setInt(4, question.getType());
		int row = stmt.executeUpdate(); // insert
		rs = stmt.getGeneratedKeys(); // select max(num) from question
		
		if (rs.next()) {
			pk = rs.getInt(1);
		}
		conn.close();
		return pk;
	}
	
}
