package model;
import java.sql.*;
import java.util.*;
import dto.Paging;
import dto.Question;

// Table : question crud
public class QuestionDao {
	public ArrayList<Question> selelctQuestionList(Paging p) throws ClassNotFoundException, SQLException {
		ArrayList<Question> list = new ArrayList<>();
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");

// 페이징....
//		PreparedStatement stmt1 = null;
//		ResultSet rs1 = null;
//		String sql1 = "select count(*) cnt from question";
//		stmt1 = conn.prepareStatement(sql1);
//		rs1 = stmt1.executeQuery();
//		rs1.next();
		
		PreparedStatement stmt2 = null;
		ResultSet rs2 = null;
		
		String sql2 = "select num, title, startdate, enddate, type from question limit ?, ?";
		stmt2 = conn.prepareStatement(sql2);
		stmt2.setInt(1, p.getBeginRow());
		stmt2.setInt(2, p.getRowPerPage());
		rs2 = stmt2.executeQuery();
		
		while (rs2.next()) {
			Question question = new Question();
			question.setNum(rs2.getInt("num"));
			question.setTitle(rs2.getString("title"));
			question.setStartdate(rs2.getString("startdate"));
			question.setEnddate(rs2.getString("enddate"));
			
			list.add(question);
		}
		
		return list;
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
