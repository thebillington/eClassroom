package lessons;

public class Attempt {
	
	private String username;
	private int answer;
	
	public Attempt(String username, int answer) {
		this.username = username;
		this.answer = answer;
	}

	public String getUsername() {
		return username;
	}

	public int getAnswer() {
		return answer;
	}

	public boolean isCorrect() {
		if(answer == 0) {
			return true;
		}
		return false;
	}

}
