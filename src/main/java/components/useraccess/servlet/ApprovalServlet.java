package com.useraccess.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.useraccess.util.DatabaseConnection;
import java.sql.*;

@WebServlet("/approval")
public class ApprovalServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Retrieve the request ID and action (approve or reject) from the form
        int requestId = Integer.parseInt(request.getParameter("requestId"));
        String action = request.getParameter("action");
        
        // Determine the status based on the action
        String status = action.equals("approve") ? "Approved" : "Rejected";

        // Establish a connection to the database
        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "UPDATE requests SET status = ? WHERE id = ?";
            
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, status);
                stmt.setInt(2, requestId);
                
                // Execute the update
                int rowsUpdated = stmt.executeUpdate();
                
                // Check if the update was successful
                if (rowsUpdated > 0) {
                    System.out.println("Request ID " + requestId + " was successfully updated to " + status);
                } else {
                    System.out.println("Failed to update the status for Request ID " + requestId);
                }
            }
            
            // Redirect back to the pending requests page
            response.sendRedirect("pendingRequests.jsp");
            
        } catch (SQLException e) {
            // Log the exception and redirect to an error page
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
