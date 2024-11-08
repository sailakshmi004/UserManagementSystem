<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Pending Requests</title>
</head>
<body>
    <h2>Pending Access Requests</h2>
    <table border="1">
        <tr>
            <th>Employee Name</th>
            <th>Software</th>
            <th>Access Type</th>
            <th>Reason</th>
            <th>Action</th>
        </tr>
        <% 
            try {
                Connection conn = DatabaseConnection.getConnection();
                String query = "SELECT r.id, u.username, s.name, r.access_type, r.reason FROM requests r " +
                               "JOIN users u ON r.user_id = u.id " +
                               "JOIN software s ON r.software_id = s.id " +
                               "WHERE r.status = 'Pending'";
                PreparedStatement stmt = conn.prepareStatement(query);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    int requestId = rs.getInt("id");
                    String employeeName = rs.getString("username");
                    String softwareName = rs.getString("name");
                    String accessType = rs.getString("access_type");
                    String reason = rs.getString("reason");
        %>
                    <tr>
                        <td><%= employeeName %></td>
                        <td><%= softwareName %></td>
                        <td><%= accessType %></td>
                        <td><%= reason %></td>
                        <td>
                            <form action="approval" method="post" style="display:inline;">
                                <input type="hidden" name="requestId" value="<%= requestId %>">
                                <button type="submit" name="action" value="approve">Approve</button>
                            </form>
                            <form action="approval" method="post" style="display:inline;">
                                <input type="hidden" name="requestId" value="<%= requestId %>">
                                <button type="submit" name="action" value="reject">Reject</button>
                            </form>
                        </td>
                    </tr>
        <% 
                }
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        %>
    </table>
</body>
</html>
