package index;

import exceptions.UserNotFoundException;
import users.User;
import users.UserController;

public class HomeController implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	
	// Create an empty error string
	private static String error = "";
	private static UserController uc = new UserController();
	
	public static String login(String u, String p) {
		
		error = uc.login(u, p);
		
		return error;
	}
	
	public static User getUser(String u) throws UserNotFoundException {
		
		return uc.getUser(u);
	}
	
	public static String addUser(String e, String u, String p, int d, int m, int y, boolean teacher) {
		return uc.newUser(u, e, p, d, m, y, teacher);
	}
	
	public static String updateUser(String e, String p, String fname, String lname, String school) {
		return uc.updateUser(e, p, fname, lname, school);
	}

}