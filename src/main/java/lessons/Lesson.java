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

}
