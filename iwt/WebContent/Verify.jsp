<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mechanic Details</title>
    <style>
        table {
            font-family: Arial, sans-serif;
            border-collapse: collapse;
            width: 70%;
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

        .verification-checkbox {
            width: 20px;
            height: 20px;
        }

        .delete-button {
            background-color: red;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <h2>Mechanic Details</h2>
    <table>
        <tr>
            <th>First Name</th>
            <th>Location</th>
            <th>Mechanic Shop Registration Number</th>
            <th>Years of Service</th>
            <th>Service</th>
            <th>Verification</th>
            <th>Delete</th>
        </tr>
        <%
        try {
            // Load the JDBC driver and establish a database connection
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/grease", "root", "12345");

            // Prepare the SQL query to fetch selected columns from the "registers" table
            String query = "SELECT firstName, location, shopRegistrationNumber, yearsOfService, service FROM registers";
            PreparedStatement preparedStatement = con.prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();

            // Iterate through the result set and display data in the table
            while (resultSet.next()) {
                String firstName = resultSet.getString("firstName");
                String location = resultSet.getString("location");
                String shopRegistrationNumber = resultSet.getString("shopRegistrationNumber");
                String yearsOfService = resultSet.getString("yearsOfService");
                String service = resultSet.getString("service");
                
                // Check if the checkbox was previously checked (stored in session)
                boolean isChecked = Boolean.parseBoolean(session.getAttribute("checkbox_" + firstName) != null ? session.getAttribute("checkbox_" + firstName).toString() : "false");
        %>
        <tr>
            <td><%= firstName %></td>
            <td><%= location %></td>
            <td><%= shopRegistrationNumber %></td>
            <td><%= yearsOfService %></td>
            <td><%= service %></td>
            <td><input type="checkbox" class="verification-checkbox" <% if (isChecked) out.print("checked"); %> onclick="toggleCheckbox(this, '<%= firstName %>')"></td>
            <td><button class="delete-button" onclick="deleteRow(this)">Delete</button></td>
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
    <script>
        function toggleCheckbox(checkbox, firstName) {
            // Toggle the checkbox and store its state in session
            var isChecked = checkbox.checked;
            session.setAttribute("checkbox_" + firstName, isChecked);
        }

        function deleteRow(button) {
            // Delete the row containing the clicked "Delete" button
            var row = button.parentNode.parentNode;
            row.parentNode.removeChild(row);
        }
    </script>
</body>
</html>
