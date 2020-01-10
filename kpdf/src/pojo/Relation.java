package pojo;

public class Relation {
	
	//考官ID
	private String examiner;
	//考官职位
	private String myposition;
	
	//考官部门
	private String mydepartment;
	
	//考生ID
	private String candidate;
	
	//考生姓名
	private String name;

	//考核类型
	private String type;
	
	//考生职位
	private String position;
	
	//考生部门
	private String department;
	
	//考核分组
	private String groups;
	
	
	public String getGroups() {
		return groups;
	}

	public void setGroups(String groups) {
		this.groups = groups;
	}

	public String getMydepartment() {
		return mydepartment;
	}

	public void setMydepartment(String mydepartment) {
		this.mydepartment = mydepartment;
	}

	public String getMyposition() {
		return myposition;
	}

	public void setMyposition(String myposition) {
		this.myposition = myposition;
	}
	
	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getExaminer() {
		return examiner;
	}

	public void setExaminer(String examiner) {
		this.examiner = examiner;
	}

	public String getCandidate() {
		return candidate;
	}

	public void setCandidate(String candidate) {
		this.candidate = candidate;
	}
    
    
}
