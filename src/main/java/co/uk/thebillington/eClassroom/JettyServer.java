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
		
		HomeController.addUser("billy.rebecchi@googlemail.com", "thebillington", "irule", 29, 11, 1994, true);

		Server server = new Server(8080);

		WebAppContext context = new WebAppContext();	
		context.setContextPath("/");
		
		try {
			context.setResourceBase(JettyServer.class.getResource("/webapp/").toURI().toASCIIString());
		} catch (URISyntaxException e) {
			e.printStackTrace();
			System.out.println("Failed to set resource base of context.");
		}
		
		final ContainerInitializer initializer = new ContainerInitializer(new JettyJasperInitializer(), null);
		List<ContainerInitializer> initializers = new ArrayList<ContainerInitializer>() {
			private static final long serialVersionUID = 1L;

			{
				add(initializer);
			}
		};
		
		context.setAttribute("org.eclipse.jetty.containerInitializers", initializers);
		context.setAttribute(InstanceManager.class.getName(), new SimpleInstanceManager());
		context.addBean(new ServletContainerInitializersStarter(context), true);
		
		ServletHolder index = new ServletHolder("Index", IndexServlet.class);
		ServletHolder login = new ServletHolder("Login", LoginServlet.class);
		ServletHolder logout = new ServletHolder("Logout", LogoutServlet.class);
		ServletHolder profile = new ServletHolder("Profile", ProfileServlet.class);

		context.addServlet(index, "/index");
		context.addServlet(login, "/login");
		context.addServlet(logout, "/logout");
		context.addServlet(profile, "/profile");

		server.setHandler(context);

		try {
			server.start();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
}
