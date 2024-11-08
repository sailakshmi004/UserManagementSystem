<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Request Access</title>
</head>
<body>
    <h2>Request Access to Software</h2>
    <form action="requestAccess" method="post">
        Software:
        <select name="softwareId" required>
            <%-- Dynamically populate software options --%>
            <%
                try {
                    Connection conn = DatabaseConnection.getConnection();
                    String query = "SELECT id, name FROM software";
                    PreparedStatement stmt = conn.prepareStatement(query);
                    ResultSet rs = stmt.executeQuery();
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String name = rs.getString("name");
            %>
                        <option value="<%= id %>"><%= name %></option>
            <%
                    }
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            %>
        </select><br>
        Access Type:
        <select name="accessType">
            <option value="Read">Read</option>
            <option value="Write">Write</option>
            <option value="Admin">Admin</option>
        </select><br>
        Reason:
        <textarea name="reason" required></textarea><br>
        <input type="submit" value="Request Access">
    </form>
</body>
</html>
