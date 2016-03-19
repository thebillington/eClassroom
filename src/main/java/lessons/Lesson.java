package lessons;

import exceptions.UserNotFoundException;
import users.User;
import users.UserController;

public class Lesson implements java.io.Serializable {

	// Create an empty error string
	private static String error = "";
	private static UserController uc = new UserController();
	private static User thisUser;

	// Return our errors to the server
	public String getError() {
		return error;
	}
	
	public static void setError(String e) {
		error = e;
	}

	// Reset our error back to empty string
	public static void resetError() {
		error = "";
	}
	
	public static void login(String u, String p) throws UserNotFoundException {
		
		error = uc.login(u, p);
		
		if(!error.equals("Login was successful!")) {
			throw new UserNotFoundException(error);
		}
		
		thisUser = uc.getUser(u);
	}
	
	public static void addUser(String e, String u, String p, int d, int m, int y, boolean teacher) {
		error = uc.newUser(u, e, p, d, m, y, teacher);
	}
	
	public String getUsername() {
		return thisUser.getUsername();
	}
	
	public String getEmail() {
		return thisUser.getEmail();
	}

}
