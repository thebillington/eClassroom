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
				return "Username already in use!";
			}
			if (user.getEmail().equals(e)) {
				return "Email is already in use!";
			}

		}

		if (teacher) {
			users.add(new Teacher(u, e, p, d, m, y));
		} else {
			users.add(new Student(u, e, p, d, m, y));
		}

		return "Signed up successfully!";
	}

	public String login(String u, String p) {

		for (User user : users) {

			if (user.getEmail().equals(u) || user.getUsername().equals(u)) {
				if (user.getPassword().equals(p)) {
					return "Login was successful!";
				}
				return "Incorrect password!";
			}

		}

		return "Incorrect username or email!";
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
