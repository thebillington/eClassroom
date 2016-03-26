package lessons;

public class Lesson {
	
	//Add the class name and the teachers username, which will be used to identify the lesson
	private String className;
	private String teacherUser;
	
	//Create the array to hold the placement questions
	//The 0th element is the easy question, the 1st element is a medium question, the 2nd element is a hard question
	Question[] placementQuestions;
	
	//Create the arrays to hold the 10 questions for each level
	Question[] easyQuestions;
	Question[] mediumQuestions;
	Question[] hardQuestions;
	
	public Lesson(String className, String teacherUser) {
		this.className = className;
		this.teacherUser = teacherUser;
		placementQuestions = new Question[3];
		easyQuestions = new Question[10];
		mediumQuestions = new Question[10];
		hardQuestions = new Question[10];
	}
	
}