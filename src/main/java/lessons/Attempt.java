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
	
	private boolean tierChange;

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
		tierChange = false;
	}

	public String getUsername() {
		return username;
	}

	public void setLevel(int loc, int lvl) {
		questionLevel[loc] = lvl;
	}

	public void answerQuestion(int answer) {
		//If the attempt is not complete
		if (!complete) {
			//Set the level of this question
			setLevel(answer, currentLevel);
			
			//Set the answer
			answers[qCompleted] = answer;
			
			//If the answer is correct
			if (answer == 0) {
				//Set the boolean for correct to true
				correct[qCompleted] = true;
				
				//Increment the number of questions correct at this tier
				correctAtTier++;
				
				//If the current level is easy add 1 point, 3 for medium, 5 for hard
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
				//If the question is wrong set the correct boolean to false
				correct[qCompleted] = false;
			}
			
			//Increment number of questions completed
			qCompleted++;
			
			//If this is the third question
			if (qCompleted == 3) {
				//If the first and second question are correct, go to medium difficulty
				if (correct[0] && correct[1]) {
					currentLevel++;
				}
				//If the first 2 were correct go to hard difficulty
				//Otherwise go to medium difficulty
				if (correct[2]) {
					currentLevel++;
				}
			}
			//If there are three or more tiered questions answered
			if (qCompleted >= 6 && qCompleted < 13) {
				//If the last three questions were correct increment the tier level
				//Unless already at max
				if ((correct[qCompleted - 1] && correct[qCompleted - 2]) && correct[qCompleted - 3]) {
					if (currentLevel < 2) {
						currentLevel++;
						tierChange = true;
					}
				}
				//If the last three questions were incorrect decrement the tier level
				//Unless already at min
				if ((!correct[qCompleted - 1] && !correct[qCompleted - 2]) && !correct[qCompleted - 3]) {
					if (currentLevel > 0) {
						currentLevel--;
						tierChange = true;
					}
				}
			}
			//If there are 5 or more tiered questions answered
			if (qCompleted >= 8) {
				//If there were 5 questions overall and we aren't at max tier
				//And if this is the first tier change
				//Increment the tier
				if (correctAtTier == 5 && currentLevel < 2) {
					if(!tierChange) {
						currentLevel++;
						correctAtTier = 0;
					}
					tierChange = true;
				}
			}
			//If this is the 13th question answered, complete the attempt
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
