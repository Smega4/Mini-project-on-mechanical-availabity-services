package Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Use")
public class Use extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Get parameters from the form
        String newUsername = request.getParameter("new_username");
        String newPassword = request.getParameter("new_password");

        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.jdbc.Driver");

            // Connect to the database (replace with your database URL, username, and password)
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/grease", "root", "12345");

            // Prepare and execute SQL insert statement
            PreparedStatement ps = con.prepareStatement("INSERT INTO Users (Username, Password) VALUES (?, ?)");
            ps.setString(1, newUsername);
            ps.setString(2, newPassword);

            // Execute the SQL statement
            int rowsAffected = ps.executeUpdate();

            con.close();

            if (rowsAffected > 0) {
                // Registration successful, redirect to a success page
                response.sendRedirect("Welcome.html");
            } else {
                // Registration failed, you can handle this case as needed
                out.println("Registration failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle the exception and redirect to an error page if needed
            out.println("Error: " + e.getMessage());
        }
    }
}
