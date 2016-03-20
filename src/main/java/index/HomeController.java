package index;

import users.User;
import users.UserController;

public class HomeController {
	
	//Create a new User Controller object
	private static UserController uc = new UserController();
	
	//Forward our request to the user controller login method
	public static String login(String u, String p) {
		return uc.login(u, p);
	}
	
	//Forward our request to the user controller get user method
	public static User getUser(String u) {
		return uc.getUser(u);
	}
	
	//Forward our request to the user controller add user method
	public static String addUser(String e, String u, String p, int d, int m, int y, boolean teacher) {
		return uc.newUser(u, e, p, d, m, y, teacher);
	}
	
	//Forward our request to the user controller update user method
	public static String updateUser(String e, String p, String fname, String lname, String school) {
		return uc.updateUser(e, p, fname, lname, school);
	}

}
