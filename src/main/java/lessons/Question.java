package lessons;

import java.util.Random;

public class Question {
	
	//Variables to store the question and answers
	private String question;
	//The 0th element of this array will always be equal to the correct answer
	private String[] answers = new String[4];

	public Question(String q, String cAnswer, String iAnsOne, String iAnsTwo, String iAnsThree) {
		this.question = q;
		answers[0] = cAnswer;
		answers[1] = iAnsOne;
		answers[2] = iAnsTwo;
		answers[3] = iAnsThree;
	}
	
	public String getQuestion() {
		return question;
	}
	
	public String[] getAnswers() {
		return answers;
	}
	
	public String getAnswer(int i) {
		if(i >= 0 && i < answers.length) {
			return answers[i];
		}
		return "Index out of bounds";
	}
	
	public String correctAnswer() {
		return answers[0];
	}
	
	public void setQuestion(String q) {
		this.question = q;
	}
	
	public void setCorrectAnswer(String ca) {
		this.answers[0] = ca;
	}
	
	public String setAnswer(int location, String answer) {
		if(location >= 0 && location < 4) {
			this.answers[location] = answer;
			return "success";
		}
		return "fail";
	}
	
	public static String[] shuffleAnswers(String[] answers) {
		String[] shuffled = answers;
		Random r = new Random();
		for(int i = 0; i < shuffled.length; i++) {
			int x = r.nextInt(4);
			System.out.print(x);
			String temp = shuffled[i];
			shuffled[i] = shuffled[x];
			shuffled[x] = temp;
		}
		return shuffled;
	}
}
