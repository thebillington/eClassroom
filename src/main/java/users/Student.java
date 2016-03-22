package users;

import java.util.ArrayList;
import java.util.List;

public class Student extends User{

	private List<SchoolClass> classes;
	
	public Student(String u, String e, String p, int d, int m, int y, int id) {
		super(u, e, p, d, m, y, id, false);
		classes = new ArrayList<SchoolClass>();
	}
	
	public List<SchoolClass> getClasses() {
		return classes;
	}
	
	public SchoolClass getClass(String className) {
		for(SchoolClass c : classes) {
			if(c.getName().equals(className)) {
				return c;
			}
		}
		return null;
	}
	
	public String subClass(SchoolClass sc) {
		for(SchoolClass s: classes) {
			if(s.getName().equals(sc.getName()) && s.getTeacher().equals(sc.getTeacher())) {
				return "subscribed";
			}
		}
		classes.add(sc);
		return "success";
	}
	
	public String unsubClass(SchoolClass sc) {
		for(SchoolClass s: classes) {
			if(s.getName().equals(sc.getName()) && s.getTeacher().equals(sc.getTeacher())) {
				classes.remove(sc);
				return "unsubsuccess";
			}
		}
		return "unsubfail";
	}

}
