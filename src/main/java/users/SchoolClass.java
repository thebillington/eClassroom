package users;

import java.util.ArrayList;
import java.util.List;

import lessons.Lesson;

public class SchoolClass {

	private List<Student> students;
	private String className;
	private List<Lesson> lessons;
	
	public SchoolClass(String name) {
		className = name;
		students = new ArrayList<Student>();
		lessons = new ArrayList<Lesson>();
	}
	
	public String getName() {
		return className;
	}
	
}
