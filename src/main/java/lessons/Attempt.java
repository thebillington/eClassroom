package lessons;

public class Attempt {

	private String username;
	private int attemptNumber;

	private int[] questionLevel;
	private int[] answers;
	private boolean[] correct;

	private int qCompleted;
	private boolean complete;

	private int currentLevel;
	private int correctAtTier;
	private int points;

	public Attempt(String username, int attemptNumber) {
		this.username = username;
		questionLevel = new int[13];
		answers = new int[13];
		questionLevel[0] = 0;
		questionLevel[1] = 1;
		questionLevel[2] = 2;
		qCompleted = 0;
		this.attemptNumber = attemptNumber;
		complete = false;
		currentLevel = 0;
		correctAtTier = 0;
		points = 0;
	}

	public String getUsername() {
		return username;
	}

	public void setLevel(int loc, int lvl) {
		questionLevel[loc] = lvl;
	}

	public void answerQuestion(int answer) {
		if (!complete) {
			setLevel(answer, currentLevel);
			answers[qCompleted] = answer;
			if (answer == 0) {
				correct[qCompleted] = true;
				correctAtTier++;
				if (currentLevel == 0) {
					points++;
				}
				if (currentLevel == 1) {
					points += 3;
				}
				if (currentLevel == 2) {
					points += 5;
				}
			} else {
				correct[qCompleted] = false;
			}
			qCompleted++;
			if (qCompleted == 3) {
				if (correct[0] && correct[1]) {
					currentLevel++;
				}
				if (correct[2]) {
					currentLevel++;
				}
			}
			if (qCompleted >= 6) {
				if ((correct[qCompleted] && correct[qCompleted - 1]) && correct[qCompleted - 2]) {
					if (currentLevel < 2) {
						currentLevel++;
					}
				}
				if ((!correct[qCompleted] && !correct[qCompleted - 1]) && !correct[qCompleted - 2]) {
					if (currentLevel > 0) {
						currentLevel--;
					}
				}
			}
			if (qCompleted >= 8) {
				if (correctAtTier == 0 && currentLevel > 0) {
					currentLevel--;
				}
				if (correctAtTier == 5 && currentLevel < 2) {
					currentLevel++;
					correctAtTier = 0;
				}
			}
			if (qCompleted == 13) {
				complete = true;
			}
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

	public int getLevel() {
		return currentLevel;
	}

}
