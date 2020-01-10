package score.count;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import DB.OperateOracle;

import pojo.Relation;
import dao.OperateDao;

public class CountTotals {
	
	
	OperateDao dao = new OperateDao();
	
	
	//���ݿ���id�������ÿ�������ķ���
	public void countById(String examiner){

		String candidate = "";
		String position = "";
		String sql_reg="";
		String sql_per="";
		String counts="";
		String sums="";
		String mytype="";
		double regular = 0;
		double personal = 0;
		//System.out.println(examiner);
		List<Relation> list = new ArrayList<Relation>();
		list = dao.searchKPList(examiner);

		for(int i=0;i<list.size();i++){
			//�̶���÷�
			//��ȡ����ְλ��Ϣ
			candidate = list.get(i).getCandidate();
			position = list.get(i).getPosition();
			mytype = list.get(i).getType();
			try{
				Connection conn = OperateOracle.getConn();
				Statement stmt = conn.createStatement();
				sql_reg = "select sum(score) from grade_scores where candidate='"+candidate+"' and examiner='"+examiner+"' and exa_id like 'R%'";
				ResultSet rs_reg = stmt.executeQuery(sql_reg);
				while(rs_reg.next()){
					System.out.println(examiner+"+"+candidate);
					regular = Double.parseDouble(rs_reg.getString("sum(score)"))*0.5;
					
					if(regular == 0){
						System.out.println("����");
					}
				}
				//System.out.println(regular);
				sql_per = "select sum(score) as sums,count(score) as counts from grade_scores where candidate='"+candidate+"' and examiner='"+examiner+"' and exa_id like '2019%'";

				ResultSet rs_per = stmt.executeQuery(sql_per);
				while(rs_per.next()){
					counts = rs_per.getString("counts");
					sums = rs_per.getString("sums");	
					//System.out.println(sums);
					if(position.equals("Ա��")){

						personal = Double.parseDouble(sums)/Double.parseDouble(counts)*4;
						if(personal == 0){
							System.out.println("����");
						}
					}else{
						
						personal = Double.parseDouble(sums)/Double.parseDouble(counts)*6;
						if(personal == 0){
							System.out.println("����");
						}
					}
				}
				//System.out.println(personal);
				rs_reg.close();
				rs_per.close();
				stmt.close();
			}catch(Exception e){
				e.printStackTrace();
			}
			
			//���ݶ�Ӧ�Ĵ�ֹ�ϵ������ʱͳ�Ʒ���
			saveScore(candidate,examiner,mytype,regular,personal);
		}
		
		
	}
	//�������
	public void saveScore(String candidate,String examiner,String type,double regular,double personal){
		try{
			Connection conn = OperateOracle.getConn();
			Statement stmt = conn.createStatement();
			double total = regular+personal;
			String sql = "insert into grade_totals (candidate,examiner,type,regular,personal,total) values ('"+candidate+"','"+examiner+"','"+type+"','"+regular+"','"+personal+"','"+total+"')";
			stmt.executeQuery(sql);
			stmt.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	//����ÿ���������յ÷�
	public void saveAllTotals(String candidate,Double totals,Double higher,Double same,Double lower){
		try{
			Connection conn = OperateOracle.getConn();
			Statement stmt = conn.createStatement();
			String sql = "insert into grade_all (id,score,higher,same,lower) values ('"+candidate+"','"+totals+"','"+higher+"','"+same+"','"+lower+"')";
			stmt.executeQuery(sql);
			stmt.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	//���ݿ���id��ȡ�ϼ�ƽ����
	public double get_higher(String candidate){
		double avg=0;
		try{
			Connection conn = OperateOracle.getConn();
			Statement stmt = conn.createStatement();
			ResultSet rs = null;
			String sql = "select avg(total) from(select t.candidate,t.examiner,t.total,r.type from grade_totals t,grade_relation r where t.candidate=r.candidate and t.examiner=r.examiner) where type='A' and candidate='"+candidate+"'";
			rs=stmt.executeQuery(sql);
			while(rs.next()){
				if(rs.getString("avg(total)") == null ||rs.getString("avg(total)").equals("")){
					avg=0;
				}else{
					avg = Double.parseDouble(rs.getString("avg(total)"));
				}
			}
			rs.close();
			stmt.close();
			//System.out.println("higher:"+avg);
		}catch(Exception e){
			e.printStackTrace();
		}
		return avg;
	}
	
	//���ݿ���id��ȡͬ��ƽ����
	public double get_same(String candidate){
		double avg=0;
		try{
			Connection conn = OperateOracle.getConn();
			Statement stmt = conn.createStatement();
			ResultSet rs = null;
			String sql = "select avg(total) from(select t.candidate,t.examiner,t.total,r.type from grade_totals t,grade_relation r where t.candidate=r.candidate and t.examiner=r.examiner) where type='B' and candidate='"+candidate+"'";
			rs=stmt.executeQuery(sql);
			while(rs.next()){
				if(rs.getString("avg(total)") == null ||rs.getString("avg(total)").equals("")){
					avg=0;
				}else{
					avg = Double.parseDouble(rs.getString("avg(total)"));
				}
			}
			rs.close();
			stmt.close();
			//System.out.println("same:"+avg);
		}catch(Exception e){
			e.printStackTrace();
		}
		return avg;
	}

	//���ݿ���id��ȡ�¼���������ƽ����
	public double get_lower(String candidate){
		double avg=0;
		try{
			Connection conn = OperateOracle.getConn();
			Statement stmt = conn.createStatement();
			ResultSet rs = null;
			String sql = "select avg(total) from(select t.candidate,t.examiner,t.total,r.type from grade_totals t,grade_relation r where t.candidate=r.candidate and t.examiner=r.examiner) where type='C' and candidate='"+candidate+"'";
			rs=stmt.executeQuery(sql);
			while(rs.next()){
				if(rs.getString("avg(total)") == null ||rs.getString("avg(total)").equals("")){
					avg=0;
				}else{
					avg = Double.parseDouble(rs.getString("avg(total)"));
				}
			}
			rs.close();
			stmt.close();
			//System.out.println("lower:"+avg);
		}catch(Exception e){
			e.printStackTrace();
		}
		return avg;
	}
	
	//���ݿ���id��ѯ�����ܵ÷�
	public double searchAllById(String emp){
		String allscore="";
		try{
			Connection conn = OperateOracle.getConn();
			Statement stmt = conn.createStatement();
			String sql = "select score from grade_all where id='"+emp+"'";
			//System.out.println(sql);
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()){
				allscore = rs.getString("score");
			}
			rs.close();
			stmt.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return Double.parseDouble(allscore);
	}
	
	//���ݿ���id��������ܵ÷�
	public void countAllById(String candidate){
		double score_higher=0;
		double score_same=0;
		double score_lower=0;
		double score_total=0;
		String position="";
		score_lower=get_lower(candidate);
		score_same=get_same(candidate);
		score_higher=get_higher(candidate);
		try{
			Connection conn = OperateOracle.getConn();
			Statement stmt = conn.createStatement();
			String sql="select position from grade_userinfo where id='"+candidate+"'";
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()){
				position = rs.getString("position");
				//System.out.println("ְλΪ��"+position);
			}
			if(position == "Ա��"||position.equals("Ա��")){
				//�ϼ�ƽ����*0.5+�������ƽ����*0.5
				score_total = score_higher*0.5 + score_lower*0.5;
			}else{
				//�ϼ�ƽ����*0.4+ͬ��ƽ����*0.2+�¼�ƽ����*0.4
				score_total = score_higher*0.4 + score_same*0.2+score_lower*0.4;
			}
			//System.out.println("�ܷ�Ϊ��"+score_total);
			rs.close();
			stmt.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		saveAllTotals(candidate,score_total,score_higher,score_same,score_lower);
		System.out.println("Ա��"+candidate+"���շ���Ϊ:" + score_total);
	}
	
	//��ȡ�����ֵ���Ա����
	public List<String> getIdList(){
		List<String> list = new ArrayList<String>();
		try{
			Connection conn = OperateOracle.getConn();
			Statement stmt = conn.createStatement();
			String sql = "select distinct examiner from GRADE_SCORES";
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()){
				list.add(rs.getString("examiner"));
				//System.out.println(rs.getString("examiner"));
			}
			rs.close();
			stmt.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return list;
	}
	
	//��ȡ�������Ա����
	public List<String> getCanList(){
		List<String> list = new ArrayList<String>();
		try{
			Connection conn = OperateOracle.getConn();
			Statement stmt = conn.createStatement();
			String sql = "select distinct candidate from GRADE_SCORES";
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()){
				list.add(rs.getString("candidate"));
				//System.out.println(rs.getString("candidate"));
			}
			rs.close();
			stmt.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return list;
	}
	


	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO �Զ����ɵķ������
		CountTotals cs = new CountTotals();	
		
		//��ȡ��ɴ����Ա����
		List<String> idlist = new ArrayList<String>();
		idlist = cs.getIdList();
		
		for(int i=0;i<idlist.size();i++){
			cs.countById(idlist.get(i).toString());
		}
		
		
		//��ȡ�������Ա����
		List<String> canlist = new ArrayList<String>();
		canlist = cs.getCanList();
		
		for(int j=0;j<canlist.size();j++){
			cs.countAllById(canlist.get(j).toString());
		}
		
		//cs.countAllById("K0405");
		
	}
	
	

}
