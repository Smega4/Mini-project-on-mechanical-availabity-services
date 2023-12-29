 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Watch Service</title>
    <style>
        body {
            background-image: url("https://banner2.cleanpng.com/20180413/ejq/kisspng-diskedge-computer-icons-clock-watch-5ad12199a80a47.8782929415236550656883.jpg");
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            margin: 0;
            padding: 0;
            font-family: Arial, Helvetica, sans-serif;
        }

        .header {
            text-align: center;
            background-color: #333;
            color: white;
            padding: 20px;
        }

        .container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }

        table {
            background-color: black;
            color: white;
            margin-top: 20px;
        }

        table th {
            background-color: black;
        }

        table, th, td {
            border: 1px solid white;
        }

        /* Style for the phone icon column */
        .phone-icon {
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="header">
        <h2>Watch Service</h2>
    </div>
    <div class="container">
        <table border="1">
            <tr>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Phone Number</th>
                <th>Location</th>
                <th>State</th>
                <th>Action</th> <!-- New column for the phone icon -->
            </tr>
            <%
            try {
                // Load the JDBC driver and establish a database connection
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/grease", "root", "12345");

                // Prepare the SQL query to fetch data from the table where yearsOfService is "watch service"
                String query = "SELECT firstName, lastName, phoneNumber, location, state FROM registers WHERE yearsOfService = 'watch service'";
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
                <td class="phone-icon">
                    <!-- Display a phone icon for making a call -->
                    <a href="tel:<%= phoneNumber %>">&#128222;</a>
                </td>
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
    </div>
</body>
</html>
 