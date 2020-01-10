package test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

import com.dxy.dafen.jsp.action.CandidateBean;
import com.dxy.dafen.jsp.action.GradeData;

public class Test {
	
	Test(){
		String examiner = "K0051";
		HashMap<String, String> userNamemap = GradeData.getUserNameMap();
		HashMap<String, ArrayList<String>> map = GradeData.getRelation(examiner);
		HashMap<String, ArrayList<String>> exaMap = GradeData.getExaminationQuestions(examiner);
		HashMap<String, ArrayList<String>> id_idsMap = GradeData.getSamework(examiner);
		//out.print(id_idsMap.get(0));
		int num = 1;
		for (Iterator<String> iterator = map.keySet().iterator(); iterator.hasNext();) {
			String examinertype = iterator.next();
			String examinertypeCN = "";
			if(examinertype.equals("A")){
				examinertypeCN="上级";
			}else if(examinertype.equals("B")){
				examinertypeCN="同级";
			}else if(examinertype.equals("C")){
				examinertypeCN="下级/服务对象";
			}
			
			ArrayList<String> userlist = map.get(examinertype);
			
			for (int i = 0; i < userlist.size(); i++) {
				String candidate = userlist.get(i);
				System.out.println(candidate);
				ArrayList<String> examinationQlist = exaMap.get(candidate);
				CandidateBean bean = GradeData.getCandidateBean(candidate);
				for (int j = 0; j < examinationQlist.size(); j++) {
					String str = examinationQlist.get(j);
					String exa_id = str.substring(0,12);
					String examinationQ = str.substring(12);
					if(id_idsMap.containsKey(exa_id)){
					//if(id_idsMap.size()!=0){
						ArrayList<String> bigIdlist = id_idsMap.get(exa_id);

						String sign = bigIdlist.get(0).substring(12);
						for (int k = 0; k < bigIdlist.size(); k++) {
							String bigId = bigIdlist.get(k);
							String this_exa_id = bigId.substring(0,12);
							String this_userid = bigId.substring(5,10);
							String this_username = userNamemap.get(this_userid);
						}
					}
				}
			}	
		}
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO 自动生成的方法存根
		new Test();
	}

}
