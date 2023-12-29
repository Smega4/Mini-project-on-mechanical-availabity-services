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

@WebServlet("/Regi")
public class Regi extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        // Get parameters from the form
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phoneNumber = request.getParameter("phoneNumber");
        String aadharNumber = request.getParameter("aadharNumber");
        String shopRegistrationNumber = request.getParameter("shopRegistrationNumber");
        String verificationCertificate = request.getParameter("verificationCertificate");
        String profilePicture = request.getParameter("profilePicture");
        String dateOfBirth = request.getParameter("dateOfBirth");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String location = request.getParameter("location");
        String yearsOfService = request.getParameter("yearsOfService");
        String gender = request.getParameter("gender"); // Corrected
        String[] serviceArray = request.getParameterValues("service"); // Corrected

        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.jdbc.Driver");

            // Connect to the database
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/grease", "root", "12345");

            // Prepare and execute SQL insert statement
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO registers values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            ps.setString(1, firstName);
            ps.setString(2, lastName);
            ps.setString(3, phoneNumber);
            ps.setString(4, aadharNumber);
            ps.setString(5, shopRegistrationNumber);
            ps.setString(6, verificationCertificate);
            ps.setString(7, profilePicture);
            ps.setString(8, dateOfBirth);
            ps.setString(9, city);
            ps.setString(10, state);
            ps.setString(11, location);
            ps.setString(12, yearsOfService);
            ps.setString(13, gender);
            ps.setString(14, String.join(",", serviceArray));

            // Execute the SQL statement
            int rowsAffected = ps.executeUpdate();

            con.close();

            if (rowsAffected > 0) {
                // Registration successful, redirect to a success page
                response.sendRedirect("Welcome.html");
            } 
            
            else {
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
