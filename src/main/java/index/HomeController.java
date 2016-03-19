package index;

import exceptions.UserNotFoundException;
import users.User;
import users.UserController;

public class HomeController implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	
	// Create an empty error string
	private static String error = "";
	private static UserController uc = new UserController();
	
	public static void login(String u, String p) throws UserNotFoundException {
		
		error = uc.login(u, p);
		
		if(!error.equals("Login was successful!")) {
			throw new UserNotFoundException(error);
		}
	}
	
	public static User retrieveUser(String u) throws UserNotFoundException {
		
		return uc.retrieveUser(u);
	}
	
	public static void addUser(String e, String u, String p, int d, int m, int y, boolean teacher) {
		error = uc.newUser(u, e, p, d, m, y, teacher);
	}

}
