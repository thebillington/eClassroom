package users;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class UserController {

	private List<User> users;

	public UserController() {
		users = new ArrayList<User>();
	}

	public User getUser(String u) {
		
		for (User user : users) {

			if (user.getUsername().equals(u) || user.getEmail().equals(u)) {
				return user;
			}

		}
		
		return users.get(0);
		
		
	}

	public String newUser(String u, String e, String p, int d, int m, int y, boolean teacher) {

		for (User user : users) {

			if (user.getUsername().equals(u)) {
				return "user";
			}
			if (user.getEmail().equals(e)) {
				return "email";
			}

		}

		if (teacher) {
			users.add(new Teacher(u, e, p, d, m, y, users.size()));
		} else {
			users.add(new Student(u, e, p, d, m, y, users.size()));
		}

		return "success";
	}

	public String login(String u, String p) {

		for (User user : users) {

			if (user.getEmail().equals(u) || user.getUsername().equals(u)) {
				if (user.getPassword().equals(p)) {
					return "addsuccess";
				}
				return "badpass";
			}

		}

		return "bademail";
	}
	
	public User retrieveUser(String u) {

		for (User user : users) {

			if (user.getEmail().equals(u) || user.getUsername().equals(u)) {
				return user;
			}

		}

		return null;
	}

	private int getAge(int d, int m, int y) {

		int day = LocalDateTime.now().getDayOfYear();
		int month = LocalDateTime.now().getMonth().getValue();
		int year = LocalDateTime.now().getYear();

		int age = year - y;

		if (m > month) {
			age--;
		}
		if (m == month && d > day) {
			age--;
		}

		return age;

	}

}
