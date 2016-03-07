package users;

import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class UserController {

	private List<User> users;
	
	public UserController() {
		users = new ArrayList<User>();
	}
	
	public String newUser(String u, String e, String p, int d, int m, int y, boolean teacher) {
		
		for(User user: users) {
			
			if(user.getUsername().equals(u)) {
				return "error: username already in use";
			}
			if(user.getEmail().equals(e)) {
				return "error: email already in use";
			}
			
			if(teacher) {
				users.add(new Teacher(u, e, p, d, m, y));
			}
			else {
				users.add(new Student(u, e, p, d, m, y));
			}
			
		}
		
		return "success";
	}
	
	private int getAge(int d, int m, int y) {
		
		int day = LocalDateTime.now().getDayOfYear();
		int month = LocalDateTime.now().getMonth().getValue();
		int year = LocalDateTime.now().getYear();
		
		int age = year - y;
		
		if(m > month) {
			age--;
		}
		if(m == month && d > day) {
			age--;
		}
		
		return age;
		
	}
	
}
