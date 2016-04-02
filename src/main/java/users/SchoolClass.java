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
	
	public String deleteStudent(Student s) {
		for(Student st: students) {
			if(s.getUsername().equals(st.getUsername())) {
				students.remove(s);
				return "unsubsuccess";
			}
		}
		return "unsubfail";
	}
	
	public List<Student> getStudents() {
		return students;
	}
	
	public String addLesson(Lesson l) {
		for(Lesson ls: lessons) {
			if(ls.getName().equals(l.getName()) && (ls.getClassName().equals(l.getClassName()) && ls.getUsername().equals(l.getUsername()))) {
				return("lexists");
			}
		}
		
		lessons.add(l);
		return "lasuccess";
	}
	
	public String deleteLesson(Lesson l) {
		for(Lesson ls: lessons) {
			if(ls.getName().equals(l.getName()) && (ls.getClassName().equals(l.getClassName()) && ls.getUsername().equals(l.getUsername()))) {
				lessons.remove(ls);
				return("ldsuccess");
			}
		}
		
		return "ldfail";
	}
	
	public List<Lesson> getLessons() {
		return lessons;
	}
	
	public Lesson getLesson(String lessonName) {
		for(Lesson l : lessons) {
			if(l.getName().equals(lessonName)) {
				return l;
			}
		}
		return null;
	}
	
	public boolean hasLesson(String lessonName) {
		for(Lesson l : lessons) {
			if(l.getName().equals(lessonName)) {
				return true;
			}
		}
		return false;
	}
	
}
