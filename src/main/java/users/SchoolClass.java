package users;

import java.util.ArrayList;
import java.util.List;

import lessons.Lesson;

public class SchoolClass {

	private List<Student> students;
	private String className;
	private String teacher;
	private List<Lesson> lessons;
	
	public SchoolClass(String name, String teacher) {
		className = name;
		students = new ArrayList<Student>();
		lessons = new ArrayList<Lesson>();
		this.teacher = teacher;
	}
	
	public String getName() {
		return className;
	}
	
	public String getTeacher() {
		return teacher;
	}
	
	public String addStudent(Student s) {
		for(Student st: students) {
			if(s.getUsername().equals(st.getUsername())) {
				return "subscribed";
			}
		}
		students.add(s);
		return "success";
	}
	
}
