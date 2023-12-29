<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Water Purifier Service</title>
    <style>
        body {
            background-image: url("https://assets.isu.pub/document-structure/230916071639-09100840a504d8a2ff0be3f5f7be14c0/v1/608bd085def8f7bf60acbbebc8818a7d.jpeg");
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
        }

        table {
            margin: 0 auto; /* Center-align the table horizontally */
            background-color: black; /* Set the table background color to black */
            color: white; /* Set the text color to white */
        }

        table th {
            background-color: black; /* Set the table header background color to black */
        }

        table, th, td {
            border: 1px solid white; /* Set border color to white for better visibility */
        }

        .call-icon {
            cursor: pointer;
        }
    </style>
</head>
<body>
    <h2>Water Purifier Service</h2>
    <table>
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

    <script>
        function makeCall(phoneNumber) {
            // Replace this with the code to open the phone's keyboard for making a call
            // You may need to use a platform-specific solution for this
            alert("Open keyboard for making a call to " + phoneNumber);
        }
    </script>
</body>
</html>
