package lessons;

public class Lesson {
	
	//Add the class name and the teachers username, which will be used to identify the lesson
	private String lessonName;
	private String className;
	private String teacherUser;
	
	//Create the array to hold the placement questions
	//The 0th element is the easy question, the 1st element is a medium question, the 2nd element is a hard question
	Question[] placementQuestions;
	
	//Create the arrays to hold the 10 questions for each level
	Question[] easyQuestions;
	Question[] mediumQuestions;
	Question[] hardQuestions;
	
	public Lesson(String lessonName, String className, String teacherUser) {
		this.lessonName = lessonName;
		this.className = className;
		this.teacherUser = teacherUser;
		placementQuestions = new Question[3];
		easyQuestions = new Question[10];
		mediumQuestions = new Question[10];
		hardQuestions = new Question[10];
	}

	public String getName() {
		return lessonName;
	}

	public void setLessonName(String lessonName) {
		this.lessonName = lessonName;
	}

	public String getClassName() {
		return className;
	}

	public void setClass(String className) {
		this.className = className;
	}

	public String getUsername() {
		return teacherUser;
	}

	public void setUsername(String teacherUser) {
		this.teacherUser = teacherUser;
	}

	public Question[] getPlacementQuestions() {
		return placementQuestions;
	}

	public void setPlacementQuestions(Question[] placementQuestions) {
		this.placementQuestions = placementQuestions;
	}

	public Question[] getEasyQuestions() {
		return easyQuestions;
	}

	public void setEasyQuestions(Question[] easyQuestions) {
		this.easyQuestions = easyQuestions;
	}

	public Question[] getMediumQuestions() {
		return mediumQuestions;
	}

	public void setMediumQuestions(Question[] mediumQuestions) {
		this.mediumQuestions = mediumQuestions;
	}

	public Question[] getHardQuestions() {
		return hardQuestions;
	}

	public void setHardQuestions(Question[] hardQuestions) {
		this.hardQuestions = hardQuestions;
	}
	
}