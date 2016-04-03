package lessons;

import java.util.ArrayList;
import java.util.List;

import lessons.Question;

public class Lesson {

	// Add the class name and the teachers username, which will be used to
	// identify the lesson
	private String lessonName;
	private String className;
	private String teacherUser;

	// Create the array to hold the placement questions
	// The 0th element is the easy question, the 1st element is a medium
	// question, the 2nd element is a hard question
	private Question[] placementQuestions;

	// Create the arrays to hold the 10 questions for each level
	private Question[] easyQuestions;
	private Question[] mediumQuestions;
	private Question[] hardQuestions;

	//Create final ints to store the number of placement questions and total number of questions
	private final int noPQ = 3;
	private final int noQ = 10;
	
	//Create a list to store each attempt at the lesson
	List<Attempt> attempts;

	public Lesson(String lessonName, String className, String teacherUser) {
		this.lessonName = lessonName;
		this.className = className;
		this.teacherUser = teacherUser;
		placementQuestions = new Question[noPQ];
		easyQuestions = new Question[noQ];
		mediumQuestions = new Question[noQ];
		hardQuestions = new Question[noQ];
		attempts = new ArrayList<Attempt>();

		for (int i = 0; i < noQ; i++) {
			if (i < noPQ) {
				placementQuestions[i] = new Question("Question", "Correct Answer", "Incorrect Answer",
						"Incorrect Answer", "Incorrect Answer");
			}
			easyQuestions[i] = new Question("Question", "Correct Answer", "Incorrect Answer", "Incorrect Answer",
					"Incorrect Answer");
			mediumQuestions[i] = new Question("Question", "Correct Answer", "Incorrect Answer", "Incorrect Answer",
					"Incorrect Answer");
			hardQuestions[i] = new Question("Question", "Correct Answer", "Incorrect Answer", "Incorrect Answer",
					"Incorrect Answer");
		}
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
	
	public List<Attempt> getAttempts() {
		return attempts;
	}
	
	public List<Attempt> getAttempts(String usr) {
		List<Attempt> usrAttempts = new ArrayList<Attempt>();
		for(Attempt a: attempts) {
			if(a.getUsername().equals(usr)) {
				usrAttempts.add(a);
			}
		}
		return usrAttempts;
	}
	
	public String addAttempt(String user) {
		int noAttempt = 1;
		for(Attempt a: attempts) {
			if(a.getUsername().equals(user)) {
				if(!a.isComplete()) {
					return "aincomplete";
				}
				noAttempt++;
			}
		}
		attempts.add(new Attempt(user, noAttempt));
		return "success";
	}

	public String updateQuestion(String qst, String ca, String iAOne, String iATwo, String iAThree, String type,
			int location) {
		if (!(location >= 0)) {
			return "fail";
		}
		Question q = null;
		if (type.equals("placement")) {
			if (!(location < noPQ)) {
				return "fail";
			}
			q = placementQuestions[location];
		} else {
			if(!(location < noQ)) {
				return "fail";
			}
			if (type.equals("easy")) {
				q = easyQuestions[location];
			}
			if (type.equals("medium")) {
				q = mediumQuestions[location];
			}
			if (type.equals("hard")) {
				q = hardQuestions[location];
			}
		}
		if(q != null) {
			q.setQuestion(qst);
			q.setCorrectAnswer(ca);
			q.setAnswer(1, iAOne);
			q.setAnswer(2, iATwo);
			q.setAnswer(3, iAThree);
			return "qusuccess";
		}

		return "fail";
	}

}