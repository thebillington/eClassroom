package co.uk.thebillington.eClassroom;

import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;

import org.apache.tomcat.InstanceManager;
import org.apache.tomcat.SimpleInstanceManager;
import org.eclipse.jetty.annotations.ServletContainerInitializersStarter;
import org.eclipse.jetty.apache.jsp.JettyJasperInitializer;
import org.eclipse.jetty.plus.annotation.ContainerInitializer;
import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.servlet.ServletHolder;
import org.eclipse.jetty.webapp.WebAppContext;

import index.HomeController;

public class JettyServer {

	public static void main(String[] args) {
		
		//Add default user on startup of server
		HomeController.addUser("billy.rebecchi@googlemail.com", "thebillington", "irule", 29, 11, 1994, true);
		HomeController.addUser("charlotte.richardson77@virginmedia.com", "charlene", "irule", 14, 9, 1995, false);

		//Create a new server on port 8080
		Server server = new Server(8080);

		//Set the context path of the web root
		WebAppContext context = new WebAppContext();
		context.setContextPath("/");
		
		//Try and set the web root to the webapp folder (this should never fail unless the file system is changed)
		try {
			context.setResourceBase(JettyServer.class.getResource("/webapp/").toURI().toASCIIString());
		} catch (URISyntaxException e) {
			e.printStackTrace();
			System.out.println("Failed to set resource base of context.");
		}
		
		//Add the initializer
		final ContainerInitializer initializer = new ContainerInitializer(new JettyJasperInitializer(), null);
		List<ContainerInitializer> initializers = new ArrayList<ContainerInitializer>() {
			private static final long serialVersionUID = 1L;

			{
				add(initializer);
			}
		};
		
		//Set the initializer attribute of the context, and add the server instance manager
		context.setAttribute("org.eclipse.jetty.containerInitializers", initializers);
		context.setAttribute(InstanceManager.class.getName(), new SimpleInstanceManager());
		context.addBean(new ServletContainerInitializersStarter(context), true);
		
		//Create our servlets and give them names
		ServletHolder index = new ServletHolder("Index", IndexServlet.class);
		ServletHolder login = new ServletHolder("Login", LoginServlet.class);
		ServletHolder logout = new ServletHolder("Logout", LogoutServlet.class);
		ServletHolder profile = new ServletHolder("Profile", ProfileServlet.class);
		ServletHolder classes = new ServletHolder("Classes", ClassesServlet.class);
		ServletHolder lesson = new ServletHolder("Lesson", LessonServlet.class);
		ServletHolder attempt = new ServletHolder("Attempt", AttemptServlet.class);

		//Add each servlet to the context, providing a web path
		context.addServlet(index, "/index");
		context.addServlet(login, "/login");
		context.addServlet(logout, "/logout");
		context.addServlet(profile, "/profile");
		context.addServlet(classes, "/classes");
		context.addServlet(lesson, "/lesson");
		context.addServlet(attempt, "/attempt");

		//Set the context as the handler for the server
		server.setHandler(context);

		//Run the server
		try {
			server.start();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
}
