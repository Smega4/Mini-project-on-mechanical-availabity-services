<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User List</title>
</head>
<body>
    <h2>User List</h2>
    <table border="1">
        <tr>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Phone Number</th>
            <th>Location</th>
            <th>State</th>
        </tr>
        <%
        try {
            // Load the JDBC driver and establish a database connection
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/grease", "root", "12345");

            // Prepare the SQL query to fetch data from the table where yearsOfService is "car service"
            String query = "SELECT firstName, lastName, phoneNumber, location, state FROM registers WHERE yearsOfService = 'car service'";
            PreparedStatement preparedStatement = con.prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();

            // Iterate through the result set and display data in the table
            while (resultSet.next()) {
                String firstName = resultSet.getString("firstName");
                String lastName = resultSet.getString("lastName");
                String phoneNumber = resultSet.getString("phoneNumber");
                String location = resultSet.getString("location");
                String state = resultSet.getString("state");
        %>
        <tr>
            <td><%= firstName %></td>
            <td><%= lastName %></td>
            <td><%= phoneNumber %></td>
            <td><%= location %></td>
            <td><%= state %></td>
        </tr>
        <%
            }
            // Close resources
            resultSet.close();
            preparedStatement.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        %>
    </table>
</body>
</html>
