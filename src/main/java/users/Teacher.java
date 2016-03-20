package users;

import java.util.ArrayList;
import java.util.List;

public class Teacher extends User {
	
	private List<SchoolClass> classes;

	public Teacher(String u, String e, String p, int d, int m, int y, int id) {
		super(u, e, p, d, m, y, id, true);
		classes = new ArrayList<SchoolClass>();
	}
	
	public String createClass(String className) {
		for(SchoolClass c : classes) {
			if(c.getName().equals(className)) {
				return "classexists";
			}
		}
		classes.add(new SchoolClass(className));
		return "success";
	}
	
	public List<SchoolClass> getClasses() {
		return classes;
	}

}
