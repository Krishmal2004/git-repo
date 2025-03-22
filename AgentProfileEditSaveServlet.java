package com.RealState.servlets;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import java.io.*;
import java.lang.reflect.Type;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@WebServlet("/AgentProfileEditSaveServlet")
@MultipartConfig
public class AgentProfileEditSaveServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DATA_FILE = "C:\\Users\\user\\Downloads\\project\\RealState\\src\\main\\webapp\\WEB-INF\\data\\agents.json";
    private final Gson gson = new GsonBuilder().setPrettyPrinting().create();

    // Agent class to match JSON structure
    public static class Agent {
        String firstName;
        String lastName;
        String email;
        String phone;
        String password;
        String userType;
        String registrationDate;
        String lastLogin;
        String status;
        String username;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        Map<String, Object> jsonResponse = new HashMap<>();
        
        try {
            switch (action) {
                case "saveProfile":
                    handleProfileSave(request, response);
                    break;
                case "savePreferences":
                    handlePreferencesSave(request, response);
                    break;
                case "saveNotifications":
                    handleNotificationsSave(request, response);
                    break;
                case "savePassword":
                    handlePasswordSave(request, response);
                    break;
                case "uploadPhoto":
                    handlePhotoUpload(request, response);
                    break;
                default:
                    throw new ServletException("Invalid action");
            }
            
        } catch (Exception e) {
            jsonResponse.put("success", false);
            jsonResponse.put("error", e.getMessage());
            sendJsonResponse(response, jsonResponse);
        }
    }

    private void handleProfileSave(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        // Read existing agents
        List<Agent> agents = readAgentsFromFile();
        String username = request.getParameter("email"); // Using email as username
        
        // Create updated agent profile
        Agent updatedAgent = new Agent();
        updatedAgent.firstName = request.getParameter("fullName");
        updatedAgent.email = request.getParameter("email");
        updatedAgent.phone = request.getParameter("phone");
        updatedAgent.userType = "agent";
        updatedAgent.registrationDate = getCurrentTimestamp();
        updatedAgent.status = "active";
        
        // Find and update the agent
        boolean found = false;
        for (int i = 0; i < agents.size(); i++) {
            if (agents.get(i).username != null && agents.get(i).username.equals(username)) {
                // Preserve existing password and other sensitive data
                updatedAgent.password = agents.get(i).password;
                agents.set(i, updatedAgent);
                found = true;
                break;
            }
        }
        
        // If agent not found, add as new
        if (!found) {
            agents.add(updatedAgent);
        }
        
        // Save updated list
        saveAgentsToFile(agents);
        
        // Send response
        Map<String, Object> response_data = new HashMap<>();
        response_data.put("success", true);
        response_data.put("message", "Profile updated successfully");
        sendJsonResponse(response, response_data);
    }

    private void handlePreferencesSave(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        Map<String, Object> response_data = new HashMap<>();
        response_data.put("success", true);
        response_data.put("message", "Preferences updated successfully");
        sendJsonResponse(response, response_data);
    }

    private void handleNotificationsSave(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        Map<String, Object> response_data = new HashMap<>();
        response_data.put("success", true);
        response_data.put("message", "Notification settings updated successfully");
        sendJsonResponse(response, response_data);
    }

    private void handlePasswordSave(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        List<Agent> agents = readAgentsFromFile();
        String username = request.getParameter("email");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        
        Map<String, Object> response_data = new HashMap<>();
        
        for (Agent agent : agents) {
            if (agent.username != null && agent.username.equals(username) && 
                agent.password.equals(currentPassword)) {
                agent.password = newPassword;
                saveAgentsToFile(agents);
                response_data.put("success", true);
                response_data.put("message", "Password updated successfully");
                sendJsonResponse(response, response_data);
                return;
            }
        }
        
        response_data.put("success", false);
        response_data.put("message", "Invalid current password");
        sendJsonResponse(response, response_data);
    }

    private void handlePhotoUpload(HttpServletRequest request, HttpServletResponse response) 
            throws IOException, ServletException {
        Part filePart = request.getPart("photo");
        String fileName = System.currentTimeMillis() + "_" + getSubmittedFileName(filePart);
        String uploadPath = getServletContext().getRealPath("/uploads/photos/");
        
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        
        filePart.write(uploadPath + File.separator + fileName);
        
        Map<String, Object> response_data = new HashMap<>();
        response_data.put("success", true);
        response_data.put("message", "Photo uploaded successfully");
        response_data.put("photoUrl", "uploads/photos/" + fileName);
        sendJsonResponse(response, response_data);
    }

    private List<Agent> readAgentsFromFile() throws IOException {
        try (Reader reader = new FileReader(DATA_FILE)) {
            Type listType = new TypeToken<ArrayList<Agent>>(){}.getType();
            return gson.fromJson(reader, listType);
        }
    }

    private void saveAgentsToFile(List<Agent> agents) throws IOException {
        try (Writer writer = new FileWriter(DATA_FILE)) {
            gson.toJson(agents, writer);
        }
    }

    private String getCurrentTimestamp() {
        return LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }

    private void sendJsonResponse(HttpServletResponse response, Object data) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(gson.toJson(data));
    }

    private String getSubmittedFileName(Part part) {
        String header = part.getHeader("content-disposition");
        for (String token : header.split(";")) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf('=') + 2, token.length() - 1);
            }
        }
        return "";
    }
}