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
		correct = new boolean[13];
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
				System.out.println("Correct answer");
				correct[qCompleted] = true;
				correctAtTier++;
				if (currentLevel == 0) {
					System.out.println("Add one point");
					points++;
				}
				if (currentLevel == 1) {
					System.out.println("Add three points");
					points += 3;
				}
				if (currentLevel == 2) {
					System.out.println("Add five points");
					points += 5;
				}
			} else {
				System.out.println("Incorrect answer");
				correct[qCompleted] = false;
			}
			qCompleted++;
			if (qCompleted == 3) {
				System.out.print("3 questions complete");
				if (correct[0] && correct[1]) {
					System.out.println("1 and 2 correct");
					currentLevel++;
				}
				if (correct[2]) {
					System.out.println("3 correct");
					currentLevel++;
				}
			}
			if (qCompleted >= 6 && qCompleted < 13) {
				if ((correct[qCompleted] && correct[qCompleted - 1]) && correct[qCompleted - 2]) {
					if (currentLevel < 2) {
						System.out.println("Up a tier 3 in a row");
						currentLevel++;
					}
				}
				if ((!correct[qCompleted] && !correct[qCompleted - 1]) && !correct[qCompleted - 2]) {
					if (currentLevel > 0) {
						System.out.println("Down a tier 3 in a row");
						currentLevel--;
					}
				}
			}
			if (qCompleted >= 8) {
				if (correctAtTier == 0 && currentLevel > 0) {
					System.out.println("Down a tier 5 overall");
					currentLevel--;
				}
				if (correctAtTier == 5 && currentLevel < 2) {
					System.out.println("Up a tier 5 overall");
					currentLevel++;
					correctAtTier = 0;
				}
			}
			if (qCompleted == 13) {
				System.out.println("Lesson completed");
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
