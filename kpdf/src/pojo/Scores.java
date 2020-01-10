package pojo;

public class Scores {
	
	//打分项id
	private String exaid;
	//考官id
	private String examiner;
	//考生id
	private String candidate;
	public String getExaid() {
		return exaid;
	}
	public void setExaid(String exaid) {
		this.exaid = exaid;
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
	public String getScore() {
		return score;
	}
	public void setScore(String score) {
		this.score = score;
	}
	//得分
	private String score;

}
