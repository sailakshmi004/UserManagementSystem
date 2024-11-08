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
        
        int requestId = Integer.parseInt(request.getParameter("requestId"));
        String action = request.getParameter("action");
        
        String status = action.equals("approve") ? "Approved" : "Rejected";

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "UPDATE requests SET status = ? WHERE id = ?";
            
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, status);
                stmt.setInt(2, requestId);
                
                int rowsUpdated = stmt.executeUpdate();
                
                if (rowsUpdated > 0) {
                    System.out.println("Request ID " + requestId + " was successfully updated to " + status);
                } else {
                    System.out.println("Failed to update the status for Request ID " + requestId);
                }
            }
            
            response.sendRedirect("pendingRequests.jsp");
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
