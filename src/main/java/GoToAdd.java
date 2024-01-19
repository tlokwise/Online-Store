

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Servlet implementation class GoToSearch
 */
public class GoToAdd extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.getRequestDispatcher("../addProduct.jsp").forward(request, response);	
	}
	
	//saving product info database
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String name = request.getParameter("product_name");
		float price = Integer.parseInt(request.getParameter("price"));
		String description = request.getParameter("product_description");
		String category = request.getParameter("product_category");
		
		try {
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/java_assignment", "wise", "");
			
			String getSizeQuery = "SELECT product_id FROM products";
			PreparedStatement sizeStatement = con.prepareStatement(getSizeQuery);
			ResultSet sizeSet = sizeStatement.executeQuery();
			int size = 0;
			while(sizeSet.next()) {
				size++;
			}
			size += 1;
			String addDataQuery = "INSERT INTO products (product_id, product_name, product_description, price, category_id) " + 
			"VALUES ( '" + size + "', '" + name + "', '" + description + "', '" + price + "', '" + category + "');";
			
			PreparedStatement addStatement = con.prepareStatement(addDataQuery);
			addStatement.executeUpdate();
			
			
			request.getRequestDispatcher("../index.jsp").forward(request, response);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	}

}
