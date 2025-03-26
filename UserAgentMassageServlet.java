package com.RealState.servlets;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.RealState.model.UserAgentMassage;
import com.RealState.services.UsserAgentMassageService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Servlet for handling agent contact messages
 * Processes JSON data using Gson
 */
@WebServlet("/sendAgentMessage")
public class UserAgentMassageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(UserAgentMassageServlet.class.getName());
    private final Gson gson = new Gson();
    private final UsserAgentMassageService messageService = new UsserAgentMassageService();
    
    /**
     * Handle POST requests for sending messages to agents
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JsonObject jsonResponse = new JsonObject();
        
        try {
            // Read the JSON data from the request
            BufferedReader reader = request.getReader();
            UserAgentMassage message = gson.fromJson(reader, UserAgentMassage.class);
            
            // Set current timestamp if not provided
            if (message.getTimestamp() == null || message.getTimestamp().isEmpty()) {
                message.setTimestamp(getCurrentTimestamp());
            }
            
            // Set user ID if not provided
            if (message.getUserId() == null || message.getUserId().isEmpty()) {
                // Get from session or use default
                String userId = (String) request.getSession().getAttribute("userId");
                message.setUserId(userId != null ? userId : "IT24103866");
            }
            
            // Process and save the message
            boolean success = messageService.saveMessage(message);
            
            // Prepare response
            jsonResponse.addProperty("success", success);
            if (success) {
                jsonResponse.addProperty("messageId", message.getMessageId());
                jsonResponse.addProperty("timestamp", message.getTimestamp());
                jsonResponse.addProperty("message", "Your message has been sent successfully");
            } else {
                jsonResponse.addProperty("message", "Failed to send message. Please try again.");
            }
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error processing agent message", e);
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "An error occurred: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
        
        out.print(jsonResponse);
        out.flush();
    }
    
    /**
     * Get current timestamp in the format: YYYY-MM-DD HH:MM:SS
     */
    private String getCurrentTimestamp() {
        return LocalDateTime.now()
                .format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }
}