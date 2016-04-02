package lessons;

import java.util.ArrayList;
import java.util.List;

public class Question {
	
	//Variables to store the question and answers
	private String question;
	//The 0th element of this array will always be equal to the correct answer
	private String[] answers = new String[4];
	
	//A list of attempts to store each attempt at the question by each student
	private List<Attempt> attempts;

	public Question(String q, String cAnswer, String iAnsOne, String iAnsTwo, String iAnsThree) {
		this.question = q;
		answers[0] = cAnswer;
		answers[1] = iAnsOne;
		answers[2] = iAnsTwo;
		answers[3] = iAnsThree;
		attempts = new ArrayList<Attempt>();
	}
	
	public String getQuestion() {
		return question;
	}
	
	public String[] getAnswers() {
		return answers;
	}
	
	public String getAnswer(int i) {
		if(i > 0 && i < answers.length) {
			return answers[i];
		}
		return "Index out of bounds";
	}
	
	public String correctAnswer() {
		return answers[0];
	}

}
