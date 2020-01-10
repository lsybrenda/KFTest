package dao;

import java.sql.Clob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import pojo.Relation;
import pojo.Scores;
import pojo.Staff;
import pojo.User;
import DB.OperateOracle;

public class OperateDao {
	
	//查询名字工号对应map
	public HashMap<String, String> searchNameMap(){
		HashMap<String, String> map = new HashMap<String, String>();
		try{
			Connection conn = OperateOracle.getConn();
			Statement stmt = conn.createStatement();
			ResultSet set = null;
			String sql="select id,name from grade_userinfo";
			set = stmt.executeQuery(sql);
			while(set.next()){
				String id = set.getString("id");
				String name = set.getString("name");
				map.put(name, id);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return map;
	}
	
	/*
	 * 删除某位员工的打分记录
	 */
	public void deleteScore(String id){
		try{
			Connection conn = OperateOracle.getConn();
			Statement stmt = conn.createStatement();
			ResultSet set = null;
			String sql = "delete from grade_scores where examiner='"+id+"'";
			System.out.println(sql);
			stmt.executeQuery(sql);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	/*
	 * 计算某个考官给考生的分数
	 */
	public String countOne(String examiner,String candidate){
		System.out.println("计算分数开始。。。");
		String firstScore = "";
		String secondScore = "";
		String thirdScore = "";
		try{
			Connection conn = OperateOracle.getConn();
			Statement stmt = conn.createStatement();
			ResultSet set = null;
			String s1 = "select examiner,candidate,type,SUM(score) from GRADE_SCORES,GRADE_RELATION where examiner='"+examiner+"' and candidate='"+candidate+"'";
			set = stmt.executeQuery(s1);
			while(set.next()){
				firstScore = set.getString("sum(score)");
				System.out.println(firstScore);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return firstScore;
	}
	
	/*
	 * 保存每张表分数
	 */
	public void savetable(String arr){
		System.out.println(arr);
		//按逗号分隔得分信息
		String[] result = arr.split(",");
		//System.out.println(result.length);
		List<Scores> list = new ArrayList<Scores>();
		int temp=0;
		for(int i=0;i<result.length;i+=4){
			Scores score = new Scores();
			score.setExaid(result[temp]);
			score.setExaminer(result[temp+1]);
			score.setCandidate(result[temp+2]);
			score.setScore(result[temp+3]);
			temp+=4;
			list.add(score);
		}
		try{
			Connection conn = OperateOracle.getConn();
			Statement stmt = conn.createStatement();
			PreparedStatement ps = null;
			String updateStr = "insert into grade_scores(exa_id,examiner,candidate,score) values (?,?,?,?)";
			ps = conn.prepareStatement(updateStr);
			for(int i=0;i<list.size();i++){
				String exaid = list.get(i).getExaid();
				String examiner = list.get(i).getExaminer();
				String candidate = list.get(i).getCandidate();
				String score = list.get(i).getScore();
				ps.setString(1, exaid);
				ps.setString(2, examiner);
				ps.setString(3, candidate);
				ps.setString(4, score);
				ps.addBatch();
			}
			ps.executeBatch();
			ps.close();

		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
	/*
	 * 保存每条分数
	 */
	public void insertScore(String exaid,String exeminer,String candidate,String score){
		try{
			Connection conn = OperateOracle.getConn();
			Statement stmt = conn.createStatement();
			String sql = "insert into GRADE_SCORES(exa_id,examiner,candidate,score) values('"+exaid+"','"+exeminer+"','"+candidate+"','"+score+"')";
			stmt.executeQuery(sql);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	/*
	 * 根据工号查询员工基本信息
	 */
	public User searchInfoById(String id){
		User user = new User();
		try{
			Connection conn = OperateOracle.getConn();
			Statement stmt = conn.createStatement();
			String sql = "select * from GRADE_USERINFO where id='"+id+"'";
			ResultSet set = stmt.executeQuery(sql);
			while(set.next()){
				user.setId(id);
				user.setName(set.getString("name"));
				user.setEmail(set.getString("email"));
				user.setPosition(set.getString("position"));
				user.setDepartment(set.getString("department"));
				user.setDafen(set.getString("isdafen"));
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return user;
	}
	
	/*
	 * 根据工号查询打分人员列表
	 */
	public List<Relation> searchKPList(String empId){
		List<Relation> list = new ArrayList<Relation>();
		try{
			Connection conn = OperateOracle.getConn();
			Statement stmt = conn.createStatement();
			String sql = "select R.candidate,R.type,R.groups,U.position,U.name,U.department from GRADE_RELATION R,GRADE_USERINFO U where R.examiner='"+empId+"' and U.id=R.candidate";
			String myposition = "";
			String mydepartment = "";
			ResultSet set1 = stmt.executeQuery("select position,department from grade_userinfo where id='"+empId+"'");
			while(set1.next()){
				myposition = set1.getString("position");
				mydepartment = set1.getString("department");
			}
			ResultSet set = stmt.executeQuery(sql);
			while(set.next()){
				Relation rel = new Relation();
				//考官ID
				rel.setExaminer(empId);
				//考官职位
				rel.setMyposition(myposition);
				//考官部门
				rel.setMydepartment(mydepartment);
				//考生ID
				rel.setCandidate(set.getString("candidate"));
				//考核类型
				rel.setType(set.getString("type"));
				//考生职位
				rel.setPosition(set.getString("position"));
				//考生姓名
				rel.setName(set.getString("name"));
				//考生部门
				rel.setDepartment(set.getString("department"));
				//考生分组
				rel.setGroups(set.getString("groups"));
				list.add(rel);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return list;
	}
	
	//存储每张打分表分数
	public void saveScore(String name,String firsts,String seconds,String thirds,String totals,String khtype,String thistype){
		try{
			Connection conn = OperateOracle.getConn();
			Statement stmt = conn.createStatement();
			String sql = "insert into score(name,firsts,seconds,thirds,totals,khtype,thistype) values('"+name+"','"+firsts+"','"+seconds+"','"+thirds+"','"+totals+"','"+khtype+"','"+thistype+"')";
			stmt.executeQuery(sql);

		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	//存储加权总得分
	public void saveTotals(String name,String type,Double totals){
		try{
			Connection conn = OperateOracle.getConn();
			Statement stmt = conn.createStatement();
			String sql = "insert into count(name,post,score) values('"+name+"','"+type+"','"+totals+"')";
			stmt.executeQuery(sql);
		} catch(Exception e){
			e.printStackTrace();
		}
	}
	

	/*
	 * 根据考生id查询上级平均分
	 */
	public String ld_higher(String id){
		String higher_score = null;
		try{
			Connection conn = OperateOracle.getConn();
			Statement stmt = conn.createStatement();
			ResultSet rs = null;
			String sqlhigher = "select s.exa_id,s.examiner,s.candidate,s.score,r.type from grade_scores s,grade_relation r where s.candidate=r.candidate and r.type='1'";
			while(rs.next()){
				higher_score = rs.getString("avg(totals)");
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return higher_score;
	}
	
	//获取上级平均分
	public String count_higher(String name){
		String higher_score = null;
		try{
			Connection conn = OperateOracle.getConn();
			Statement stmt = conn.createStatement();
			
			ResultSet rs = stmt.executeQuery("select avg(totals) from score where name='"+name+"' and khtype='上级'");
			while(rs.next()){
				higher_score = rs.getString("avg(totals)");
			}	
		} catch(Exception e){
			e.printStackTrace();
		}
		return higher_score;
	}
	
	/**
	 * 计算平级平均分（除掉最高分和最低分后）
	 * @param name
	 * @return
	 */
	public String count_same(String name){
		String same_score = null;
		try{
			Connection conn = OperateOracle.getConn();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select (sum(score.totals)-max(score.totals)-min(score.totals))/(count(*)-2) as avg from score where name='"+name+"' and khtype='同级'");
			while(rs.next()){
				same_score = rs.getString("avg");
			}
		} catch(Exception e){
			e.printStackTrace();
		}
		return same_score;
	}
	
	/**
	 * 计算下属平均分（除掉最高分和最低分后）
	 * @param name
	 * @param thistype
	 */
	public String count_lower(String name){
		String lower_score = null;
		try{
			Connection conn = OperateOracle.getConn();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select (sum(score.totals)-max(score.totals)-min(score.totals))/(count(*)-2) as avg from score where name='"+name+"' and khtype='下属'");
			while(rs.next()){
				lower_score = rs.getString("avg");
			}
		} catch(Exception e){
			e.printStackTrace();
		}
		return lower_score;
	}
	
	/**
	 * 计算服务对象平均分（除掉最高分和最低分后）
	 * @param name
	 * @param thistype
	 */
	public String count_fuwu(String name){
		String fuwu_score = null;
		try{
			Connection conn = OperateOracle.getConn();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select (sum(score.totals)-max(score.totals)-min(score.totals))/(count(*)-2) as avg from score where name='"+name+"' and khtype='服务对象'");
			while(rs.next()){
				fuwu_score = rs.getString("avg");
			}
		} catch(Exception e){
			e.printStackTrace();
		}
		return fuwu_score;
	}
	
/*	//计算每个人总得分
	public void countScore(String name,String thistype){
		try{
			Connection conn = OperateOracle.getConn();
			Statement stmt = conn.createStatement();
			//选择该员工所有打分表
			//ResultSet rs = stmt.executeQuery("select totals,khtype from score where name='"+name+"'");

			String sql = null;
			if(thistype.equals("领导")){
				//计算上级平均分
				ResultSet rs_higher = stmt.executeQuery("select avg(totals) from score where name='"+name+"' and khtype='上级'");
				//计算同级平均分
				ResultSet rs_same = stmt.executeQuery("select avg(totals) from score where name='"+name+"' and khtype='同级'");
				//计算下级平均分
				ResultSet rs_lower = stmt.executeQuery("select avg(totals) from score where name='"+name+"' and khtype='下属'");
			}else{
				
			}
			stmt.executeQuery(sql);
		} catch(Exception e){
			e.printStackTrace();
		}
	}*/
	
	//存入表格数据
	public void insertWord(String name,String kpi){
		try{
			Connection conn = OperateOracle.getConn();
			Statement stmt=conn.createStatement();
			String sql = "update emp set kpi='"+kpi+"'where name='"+name+"'";
			stmt.executeQuery(sql);
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	
	//按姓名查找员工数据
	public Staff getInfoByName(String name){
		
	    Staff staff = new Staff();
		try{
			Connection conn = OperateOracle.getConn();
			Statement stmt=conn.createStatement();
			//sql
			String sql = "select * from emp where name='"+name+"'";
			ResultSet rs=stmt.executeQuery(sql);
			while(rs.next()){
				String thisname = rs.getString("name");
				String thisdepartment = rs.getString("department");
				String thispost = rs.getString("post");
				String thistimein = rs.getString("timein");
				String thiskhtime = rs.getString("khtime");
				String thiskpi =rs.getString("kpi");
				String thistype = rs.getString("type");
				
				staff.setName(thisname);
				staff.setDepartment(thisdepartment);
				staff.setPost(thispost);
				staff.setTimein(thistimein);
				staff.setKhtime(thiskhtime);
				staff.setKpi(thiskpi);
				staff.setType(thistype);
			}
			
			/*OperateOracle.close(rs);
			OperateOracle.close(stmt);
			OperateOracle.close(conn);
			*/
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return staff;
	}

}
