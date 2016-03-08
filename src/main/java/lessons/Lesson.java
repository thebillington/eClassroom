package lessons;

import users.UserController;

public class Lesson implements java.io.Serializable {

	// Create an empty error string
	private static String error = "";
	private static UserController uc = new UserController();

	// Return our errors to the server
	public String getError() {
		return error;
	}
	
	public static void setError(String error) {
		error = error;
	}

	// Reset our error back to empty string
	public static void resetError() {
		error = "";
	}
	
	public static void addUser(String e, String u, String p, int d, int m, int y, boolean teacher) {
		uc.newUser(u, e, p, d, m, y, teacher);
		error = "Signed up successfully!" + teacher;
	}

}
