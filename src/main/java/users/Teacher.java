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
		classes.add(new SchoolClass(className, getUsername()));
		return "success";
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
	
	public boolean hasClass(String className) {
		for(SchoolClass c : classes) {
			if(c.getName().equals(className)) {
				return true;
			}
		}
		return false;
	}
	
	//Method to delete a class
	public String deleteClass(String className) {
		
		//Get the class to be deleted as an object c
		for(SchoolClass c : classes) {
			if(c.getName().equals(className)) {
				
				//Get the students that are subscribed to the class
				List<Student> students = c.getStudents();
				
				//Unsubscribe each student from the class
				for(Student s: students) {
					s.unsubClass(c);
				}
				
				//Remove the class from the list
				classes.remove(c);
				
				//Return a success message
				return "cdsuccess";
			}
		}
		//Return a fail message
		return "cdfail";
	}

}
