package lessons;

public class Lesson implements java.io.Serializable {

	// Create an empty error string
	private static String error = "TEST";

	// Return our errors to the server
	public String getError() {
		return error;
	}

	// Reset our error back to empty string
	public static void resetError() {
		error = "";
	}

	// Return a list of pens with infor about whether they are vacant or not
	public String getVacancies() {

		String info = "<a href=\"http://thebillington.co.uk\">link</a>";

		return info;
	}

	// Add a dog to a pen if that pen is empty
	public static void addDog(String username, String password, String size, String name, int kennelNo) {

	}

	// Remove a dog from a pen if the username and password match those stored
	public static void removeDog(String username, String password, int kennelNo) {

	}

}
