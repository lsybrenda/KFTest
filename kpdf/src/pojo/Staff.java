package pojo;

import java.sql.Clob;

public class Staff {
	
	//����
	private String name;
	//����
	private String department;
	//��λ
	private String post;
	//��ְʱ��
	private String timein;
	//������
	private String khtime;
	//ҵ��Ŀ��
	private String kpi;
	//�Ƿ��쵼
	private String type;
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public String getPost() {
		return post;
	}
	public void setPost(String post) {
		this.post = post;
	}
	public String getTimein() {
		return timein;
	}
	public void setTimein(String timein) {
		this.timein = timein;
	}
	public String getKhtime() {
		return khtime;
	}
	public void setKhtime(String khtime) {
		this.khtime = khtime;
	}
	public String getKpi() {
		return kpi;
	}
	public void setKpi(String kpi) {
		this.kpi = kpi;
	}
	

}
