package users;

import java.util.ArrayList;
import java.util.List;

public class Teacher extends User {
	
	private List<Class> classes;

	public Teacher(String u, String e, String p, int d, int m, int y, int id) {
		super(u, e, p, d, m, y, id, true);
		classes = new ArrayList<Class>();
	}

}
