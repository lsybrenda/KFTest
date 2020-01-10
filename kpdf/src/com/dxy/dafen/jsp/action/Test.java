package com.dxy.dafen.jsp.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;

public class Test {
	public static void main(String[] args) {
		String examiner = "K0054";
//		HashMap<String, ArrayList<String>> map = GradeData.getRelation(examiner);
//		
//		for (Iterator<String> iterator = map.keySet().iterator(); iterator.hasNext();) {
//			String key = iterator.next();
//			ArrayList<String> userlist = map.get(key);
//			for (int i = 0; i < userlist.size(); i++) {
//				String userid = userlist.get(i);
//				CandidateBean bean = GradeData.getCandidateBean(userid);
//			}
//		}
//		String userid = "";
//		CandidateBean bean = GradeData.getCandidateBean(userid);
		HashMap<String, String> userNamemap = GradeData.getUserNameMap();
		HashMap<String, ArrayList<String>> exaMap = GradeData.getExaminationQuestions(examiner);
		HashMap<String, ArrayList<String>> sameworkmap = GradeData.getSamework(examiner);
		
		for (Iterator<String> iterator = exaMap.keySet().iterator(); iterator.hasNext();) {
			String candidate = iterator.next();
			ArrayList<String> list = exaMap.get(candidate);
			for (int i = 0; i < list.size(); i++) {
				String str = list.get(i);
				String exa_id = str.substring(0,12);
				System.out.println(exa_id+"	"+str.substring(12)+"	"+candidate);
				if(sameworkmap.containsKey(exa_id)){
					ArrayList<String> userlist = sameworkmap.get(exa_id);
					System.out.println(userlist.toString());
					for (int j = 0; j < userlist.size(); j++) {
						String userid = userlist.get(j);
						System.out.println(userNamemap.get(userid));
						if(userid.equals("")){
							continue;
						}
					}
				}
			}
		}
		
	}
}
