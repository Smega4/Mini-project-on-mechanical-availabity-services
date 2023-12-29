<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bike Servicet</title>
    <style>
        body {
            background-image: url("https://img.myloview.com/stickers/paper-cut-bicycle-rental-mobile-app-icon-isolated-on-grey-background-smart-service-for-rent-bicycles-in-the-city-mobile-app-for-sharing-system-paper-art-style-vector-700-261626630.jpg");
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            margin: 0; /* Remove default body margin */
            padding: 0; /* Remove default body padding */
            font-family: Arial, Helvetica, sans-serif;
        }

        .header {
            text-align: center;
            background-color: #333; /* Dark background color for the header */
            color: white; /* Text color for the header */
            padding: 20px; /* Add padding to the header for spacing */
        }

        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: calc(100vh - 40px); /* Subtract header height from viewport height */
        }

        table {
            background-color: black;
            color: white;
        }

        table th {
            background-color: black;
        }

        table, th, td {
            border: 1px solid white;
        }

        .call-icon {
            cursor: pointer;
            color: #007bff; /* Blue color for the phone icon, you can change it as needed */
        }
    </style>
</head>
<body>
    <div class="header">
        <h2>Bike Service</h2>
    </div>
    <div class="container">
        <table border="1">
            <tr>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Phone Number</th>
                <th>Location</th>
                <th>State</th>
                <th>Action</th> <!-- New column for the call icon -->
            </tr>
            <%
            try {
                // Load the JDBC driver and establish a database connection
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/grease", "root", "12345");

                // Prepare the SQL query to fetch data from the table where yearsOfService is "bike service"
                String query = "SELECT firstName, lastName, phoneNumber, location, state FROM registers WHERE yearsOfService = 'bike service'";
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
                <td>
                    <!-- Display a phone icon for making a call -->
                    <span class="call-icon" onclick="makeCall('<%= phoneNumber %>')">&#128222;</span>
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

    <script>
        function makeCall(phoneNumber) {
            // Replace this with the code to open the phone's keyboard for making a call
            // You may need to use a platform-specific solution for this
            alert("Open keyboard for making a call to " + phoneNumber);
        }
    </script>
</body>
</html>
