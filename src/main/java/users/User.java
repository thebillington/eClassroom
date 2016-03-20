package users;

public class User {

	private String username;
	private String email;
	private String password;
	
	private int day;
	private int month;
	private int year;
	
	private int id;
	
	private String fname;
	private String lname;
	private String school;
	
	public User(String u, String e, String p, int d, int m, int y, int id) {
		username = u;
		email = e;
		password = p;
		day = d;
		month = m;
		year = y;
		this.id = id;
		fname = "First Name";
		lname = "Last Name";
		school = "School";
	}
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getDay() {
		return day;
	}
	public void setDay(int day) {
		this.day = day;
	}
	public int getMonth() {
		return month;
	}
	public void setMonth(int month) {
		this.month = month;
	}
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public int getID() {
		return id;
	}

	public String getFname() {
		return fname;
	}

	public void setFname(String fname) {
		this.fname = fname;
	}

	public String getLname() {
		return lname;
	}

	public void setLname(String lname) {
		this.lname = lname;
	}

	public String getSchool() {
		return school;
	}

	public void setSchool(String school) {
		this.school = school;
	}
	
	@Override
	public String toString() {
		return username + " " + email + " " + password + " " + fname + " " + lname + " " + school;
	}
	
}
