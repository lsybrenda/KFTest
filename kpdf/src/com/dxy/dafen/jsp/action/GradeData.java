package com.dxy.dafen.jsp.action;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;


public class GradeData {
	public GradeData(String examiner) {
		
	}

	public static HashMap<String, ArrayList<String>> getRelation(String examiner) {
		HashMap<String, ArrayList<String>> map = new HashMap<String, ArrayList<String>>();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			conn = MyConnect.getConnection();
			stmt = conn.createStatement();
			String selectStr = "select * from GRADE_RELATION where examiner='"+examiner+"'";
			rs = stmt.executeQuery(selectStr);
			while (rs.next()) {
				String candidate = rs.getString("candidate");
				String type = rs.getString("type"); 
				ArrayList<String> list = null;
				if(map.containsKey(type)){
					list = map.get(type);
				}else{
					list = new ArrayList<String>();
				}
				list.add(candidate);
				map.put(type, list);
			}
			rs.close();
			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}

	public static CandidateBean getCandidateBean(String userid) {
		CandidateBean bean = new CandidateBean();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			conn = MyConnect.getConnection();
			stmt = conn.createStatement();
			String selectStr = "select * from GRADE_USERINFO where id='"+userid+"'";
			rs = stmt.executeQuery(selectStr);
			if (rs.next()) {
				String name = rs.getString("name");
				String email = rs.getString("email");
				String position = rs.getString("position");
				String department = rs.getString("department");
				String hiredate = rs.getString("hiredate");
				bean.setId(userid);
				bean.setName(name);
				bean.setPosition(position);
				bean.setEmail(email);
				bean.setDepartment(department);
				bean.setHiredate(hiredate);
			}
			rs.close();
			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bean;
			
	}

	public static HashMap<String, ArrayList<String>> getExaminationQuestions(String examiner) {
		HashMap<String, ArrayList<String>> map = new HashMap<String, ArrayList<String>>();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			conn = MyConnect.getConnection();
			stmt = conn.createStatement();
			String selectStr = "select exa_id,examinationquestions,owner from GRADE_EXAMINATION t where " +
					"owner in (select candidate from grade_relation where examiner='"+examiner+"') order by exa_id";
			rs = stmt.executeQuery(selectStr);
			while (rs.next()) {
				String exa_id = rs.getString("exa_id");
				String examination = rs.getString("examinationquestions"); 
				String owner = rs.getString("owner");
				ArrayList<String> list = null;
				if(map.containsKey(owner)){
					list = map.get(owner);
				}else{
					list = new ArrayList<String>();
				}
				list.add(exa_id+examination);
				map.put(owner, list);
			}
			rs.close();
			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}

//	public static SameworkBean getSamework(String examiner) {
//		SameworkBean bean = new SameworkBean();
//		HashMap<String, ArrayList<String>> sign_idsMap = new HashMap<String, ArrayList<String>>();
//		HashMap<String, ArrayList<String>> sign_usersMap = new HashMap<String, ArrayList<String>>();
//		HashMap<String, ArrayList<String>> id_usersMap = new HashMap<String, ArrayList<String>>();
//		HashMap<String, String> id_signMap = new HashMap<String, String>();
//		Connection conn = null;
//		Statement stmt = null;
//		ResultSet rs = null;
//		try {
//			conn = MyConnect.getConnection();
//			stmt = conn.createStatement();
//			String selectStr = "select exa_id,owner,samework from GRADE_EXAMINATION t where " +
//					"owner in (select candidate from grade_relation where examiner='K0054')" +
//					"and samework is not null";
//			rs = stmt.executeQuery(selectStr);
//			while (rs.next()) {
//				String exa_id = rs.getString("exa_id");
//				String owner = rs.getString("owner");
//				String samework = rs.getString("samework");
//				id_signMap.put(exa_id, samework);
//				
//				ArrayList<String> list = null;
//				if(sign_idsMap.containsKey(samework)){
//					list = sign_idsMap.get(samework);
//				}else{
//					list = new ArrayList<String>();
//					
//				}
//				list.add(exa_id);
//				sign_idsMap.put(samework, list);
//				
//				
//				if(sign_usersMap.containsKey(samework)){
//					list = sign_usersMap.get(samework);
//				}else{
//					list = new ArrayList<String>();
//					list.add(samework);
//				}
//				list.add(owner);
//				sign_usersMap.put(samework, list);
//			}
//			rs.close();
//			stmt.close();
//			conn.close();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		
//		for (Iterator<String> iterator = sign_idsMap.keySet().iterator(); iterator.hasNext();) {
//			String sign = iterator.next();
//			ArrayList<String> idlist = sign_idsMap.get(sign);
//			for (int i = 0; i < idlist.size(); i++) {
//				String id = idlist.get(i);
//				id_usersMap.put(id, sign_usersMap.get(sign));
//			}
//		}
//		bean.setId_signMap(id_signMap);
//		bean.setId_usersMap(id_usersMap);
//		bean.setSign_idsMap(sign_idsMap);
//		bean.setSign_usersMap(sign_usersMap);
//		return bean;
//	}
	
	public static HashMap<String, ArrayList<String>> getSamework(String examiner) {
		HashMap<String, ArrayList<String>> sign_idsMap = new HashMap<String, ArrayList<String>>();
		HashMap<String, ArrayList<String>> id_idsMap = new HashMap<String, ArrayList<String>>();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			conn = MyConnect.getConnection();
			stmt = conn.createStatement();
			String selectStr = "select exa_id,owner,samework from GRADE_EXAMINATION t where " +
					"owner in (select candidate from grade_relation where examiner='"+examiner+"')" +
					"and samework is not null";
			//System.out.println(selectStr);
			rs = stmt.executeQuery(selectStr);
			while (rs.next()) {
				String exa_id = rs.getString("exa_id");
				String samework = rs.getString("samework");
				
				ArrayList<String> list = null;
				if(sign_idsMap.containsKey(samework)){
					list = sign_idsMap.get(samework);
				}else{
					list = new ArrayList<String>();
					
				}
				list.add(exa_id+samework);
				sign_idsMap.put(samework, list);
				
			}
			rs.close();
			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		for (Iterator<String> iterator = sign_idsMap.keySet().iterator(); iterator.hasNext();) {
			String sign = iterator.next();
			ArrayList<String> idlist = sign_idsMap.get(sign);
			for (int i = 0; i < idlist.size(); i++) {
				String bigid = idlist.get(i);
				String exa_id = bigid.substring(0,12);
				id_idsMap.put(exa_id, idlist);
			}
		}
		return id_idsMap;
	}

	public static HashMap<String, String> getUserNameMap() {
		// TODO Auto-generated method stub
		HashMap<String, String> map = new HashMap<String, String>();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			conn = MyConnect.getConnection();
			stmt = conn.createStatement();
			String selectStr = "select name,id from GRADE_USERINFO where isdafen='1'";
			rs = stmt.executeQuery(selectStr);
			while (rs.next()) {
				String name = rs.getString("name");
				String id = rs.getString("id");
				map.put(id, name);
			}
			rs.close();
			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
}
