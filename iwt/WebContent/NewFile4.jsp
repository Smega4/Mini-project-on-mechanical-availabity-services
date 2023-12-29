<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mechanic detials</title>
    <style>
        table {
            font-family: Arial, sans-serif;
            border-collapse: collapse;
            width: 50%;
            margin: 0 auto;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            text-align: left;
            padding: 8px;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        th {
            background-color: #007BFF;
            color: white;
        }
    </style>
</head>
<body>
    <h2>Mechanic Detials</h2>
    <table>
        <tr>
            <th>First Name</th>
            <th>Location</th>
            <th>Years of Service</th>
            <th>Service</th>
        </tr>
        <%
        try {
            // Load the JDBC driver and establish a database connection
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/grease", "root", "12345");

            // Prepare the SQL query to fetch selected columns from the "registers" table
            String query = "SELECT firstName, location, yearsOfService, service FROM registers";
            PreparedStatement preparedStatement = con.prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();

            // Iterate through the result set and display data in the table
            while (resultSet.next()) {
                String firstName = resultSet.getString("firstName");
                String location = resultSet.getString("location");
                String yearsOfService = resultSet.getString("yearsOfService");
                String service = resultSet.getString("service");
        %>
        <tr>
            <td><%= firstName %></td>
            <td><%= location %></td>
            <td><%= yearsOfService %></td>
            <td><%= service %></td>
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
