package users;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class UserController {

	//Create a new list of users, to store teachers and students
	private List<User> users;

	//On initialization create a new array list
	public UserController() {
		users = new ArrayList<User>();
	}

	//Method to return a user given a username (no public facing code should access this method)
	public User getUser(String u) {

		//Run through our list of users
		for (User user : users) {

			//If the user we are looking at matches the email/username then return the object
			if (user.getUsername().equals(u) || user.getEmail().equals(u)) {
				return user;
			}

		}

		//Otherwise return null
		return null;

	}

	//Method to create a new user
	public String newUser(String u, String e, String p, int d, int m, int y, boolean teacher) {

		//Firstly run through each of our existing users to check for a clash in username/email
		for (User user : users) {

			//If username already taken return error
			if (user.getUsername().equals(u)) {
				return "user";
			}
			//If email already taken return error
			if (user.getEmail().equals(e)) {
				return "email";
			}

		}

		//Otherwise check if the type is teacher or student, and add a new User object to our list
		if (teacher) {
			users.add(new Teacher(u, e, p, d, m, y, users.size()));
		} else {
			users.add(new Student(u, e, p, d, m, y, users.size()));
		}

		//Return a success message
		return "success";
	}

	//Method to attempt a login given a username, email or password
	public String login(String u, String p) {

		//For each user in the list, check whether the email or username matches
		for (User user : users) {

			if (user.getEmail().equals(u) || user.getUsername().equals(u)) {
				//If it matches return a success message provided the password also matches
				if (user.getPassword().equals(p)) {
					return "success";
				}
				//If the password doesn't match return a bad password error
				return "badpass";
			}

		}

		//If the username/password doesn't exist in the database return a bad email error
		return "bademail";
	}

	//Method to update a user in the database
	public String updateUser(String e, String p, String fname, String lname, String school) {

		//Check through each user in the list to find the one that matches our current user
		for (User user : users) {

			if (user.getEmail().equals(e)) {
				
				//If the password matches then run the update and return a success message
				if (user.getPassword().equals(p)) {
					user.setFname(fname);
					user.setLname(lname);
					user.setSchool(school);
					return "success";
				}
				//Otherwise return a bad password message
				return "badpass";
			}
		}
		//If the code reaches here something drastic has gone wrong, return a fail message
		return "fail";
	}

	//Method to return the age of a user given the day, month and year they were born
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
