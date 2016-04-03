package lessons;

public class Attempt {
	
	private String username;
	private int attemptNumber;
	private int[] questionLevel;
	private Question[] questions;
	private int[] answers;
	private int qCompleted;
	private boolean complete;
	
	public Attempt(String username, int level, int attemptNumber) {
		this.username = username;
		questionLevel = new int[13];
		questions = new Question[13];
		answers = new int[13];
		questionLevel[0] = 0;
		questionLevel[1] = 1;
		questionLevel[2] = 2;
		qCompleted = 0;
		this.attemptNumber = attemptNumber;
		complete = false;
	}

	public String getUsername() {
		return username;
	}
	
	public void setLevel(int loc, int lvl) {
		questionLevel[loc] = lvl;
	}
	
	public void addQuestion(Question q) {
		questions[qCompleted] = q;
	}
	
	public void answerQuestion(int answer) {
		answers[qCompleted] = answer;
		qCompleted++;
		if(qCompleted == 13) {
			complete = true;
		}
	}
	
	public int getAttemptNumber() {
		return attemptNumber;
	}
	
	public int getCompleted() {
		return qCompleted;
	}
	
	public boolean isComplete() {
		return complete;
	}

}
