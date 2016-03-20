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

}
