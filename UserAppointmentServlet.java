package com.RealState.servlets;

import com.google.gson.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.*;
import java.util.*;
import java.text.SimpleDateFormat;

@WebServlet("/UserAppointmentServlet/*")
public class UserAppointmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Gson gson = new GsonBuilder().setPrettyPrinting().create();
    private static final String DATA_FILE = "WEB-INF/data/userAppointments.json";
    private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    // Current user data
    private static final String CURRENT_USER = "IT24102083";
    private static final String CURRENT_DATE = "2025-03-23 09:24:16";

    // Appointment model class
    private static class Appointment {
        String appointmentId;
        String buyerName;
        String buyerEmail;
        String buyerPhone;
        String appointmentDate;
        String appointmentTime;
        String agentId;
        String agentName;
        String status;
        String notes;
        String createdDate;
        String updatedDate;
        String createdBy;

        public Appointment() {
            this.appointmentId = "APT" + System.currentTimeMillis();
            this.createdDate = CURRENT_DATE;
            this.updatedDate = CURRENT_DATE;
            this.status = "Pending";
            this.createdBy = CURRENT_USER;
        }
    }

    // Data container class
    private static class AppointmentData {
        List<Appointment> appointments;
        Map<String, AgentInfo> agents;
        String lastUpdated;

        public AppointmentData() {
            appointments = new ArrayList<>();
            agents = new HashMap<>();
            lastUpdated = CURRENT_DATE;
        }
    }

    // Agent information class
    private static class AgentInfo {
        String agentId;
        String name;
        String specialty;
        boolean available;
        int appointmentCount;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check content type to determine how to process the request
        String contentType = request.getContentType();
        Appointment newAppointment;
        
        if (contentType != null && contentType.contains("application/json")) {
            // Handle JSON data
            newAppointment = handleJsonRequest(request);
        } else {
            // Handle form data
            newAppointment = handleFormRequest(request);
        }
        
        try {
            validateAppointment(newAppointment);
            
            try {
                // Try to save to JSON file
                AppointmentData data = loadAppointmentData(request.getServletContext());
                data.appointments.add(newAppointment);
                data.lastUpdated = CURRENT_DATE;
                
                // Update agent appointment count
                updateAgentAppointmentCount(data, newAppointment.agentId);
                
                saveAppointmentData(request.getServletContext(), data);
                
                System.out.println("Appointment saved successfully: " + newAppointment.appointmentId);
            } catch (Exception e) {
                // If file saving fails, log it and return error
                System.err.println("Error saving appointment data: " + e.getMessage());
                e.printStackTrace();
                throw new ServletException("Failed to save appointment data", e);
            }
            
            // For HTML form submissions, redirect back to the JSP page
            if (contentType == null || !contentType.contains("application/json")) {
                response.sendRedirect(request.getContextPath() + "/appointmnets.jsp?success=true");
                return;
            }
            
            // For JSON API calls, return JSON response
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
            JsonObject responseJson = new JsonObject();
            responseJson.addProperty("status", "success");
            responseJson.addProperty("message", "Appointment scheduled successfully");
            responseJson.addProperty("appointmentId", newAppointment.appointmentId);
            responseJson.addProperty("timestamp", CURRENT_DATE);
            
            PrintWriter out = response.getWriter();
            out.println(gson.toJson(responseJson));

        } catch (Exception e) {
            if (contentType != null && contentType.contains("application/json")) {
                // For JSON API calls, return error in JSON format
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                sendErrorResponse(response.getWriter(), e.getMessage());
            } else {
                // For form submissions, redirect with error parameter
                response.sendRedirect(request.getContextPath() + 
                    "/appointment.jsp?error=" + java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
            }
        }
    }

    // Handle JSON request
    private Appointment handleJsonRequest(HttpServletRequest request) throws IOException {
        String jsonData = readRequestData(request);
        return gson.fromJson(jsonData, Appointment.class);
    }
    
    // Handle HTML form request
    private Appointment handleFormRequest(HttpServletRequest request) {
        Appointment appointment = new Appointment();
        appointment.buyerName = request.getParameter("buyerName");
        appointment.buyerEmail = request.getParameter("buyerEmail");
        appointment.buyerPhone = request.getParameter("buyerPhone");
        appointment.appointmentDate = request.getParameter("appointmentDate");
        appointment.appointmentTime = request.getParameter("appointmentTime");
        appointment.agentId = request.getParameter("agent");
        appointment.status = request.getParameter("status");
        appointment.notes = request.getParameter("notes");
        
        // Map agent names based on agent ID
        if ("1".equals(appointment.agentId)) appointment.agentName = "John Doe";
        else if ("2".equals(appointment.agentId)) appointment.agentName = "Jane Smith";
        else if ("3".equals(appointment.agentId)) appointment.agentName = "Michael Brown";
        else if ("4".equals(appointment.agentId)) appointment.agentName = "Emily Wilson";
        else if ("5".equals(appointment.agentId)) appointment.agentName = "Robert Johnson";
        
        return appointment;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            String action = request.getPathInfo();
            AppointmentData data = loadAppointmentData(request.getServletContext());

            if (action != null && "/agents".equals(action)) {
                out.println(gson.toJson(data.agents));
                System.out.println("Returned " + data.agents.size() + " agents");
            } else {
                String agentId = request.getParameter("agentId");
                List<Appointment> filteredAppointments = filterAppointmentsByAgent(
                    data.appointments, agentId);
                out.println(gson.toJson(filteredAppointments));
                System.out.println("Returned " + filteredAppointments.size() + " appointments");
            }
        } catch (Exception e) {
            sendErrorResponse(out, "Error retrieving appointments: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private void validateAppointment(Appointment appointment) throws Exception {
        if (appointment.buyerName == null || appointment.buyerName.trim().isEmpty()) {
            throw new Exception("Buyer name is required");
        }
        if (appointment.buyerEmail == null || appointment.buyerEmail.trim().isEmpty()) {
            throw new Exception("Buyer email is required");
        }
        if (appointment.appointmentDate == null || appointment.appointmentDate.trim().isEmpty()) {
            throw new Exception("Appointment date is required");
        }
        if (appointment.agentId == null || appointment.agentId.trim().isEmpty()) {
            throw new Exception("Agent selection is required");
        }
    }

    private String readRequestData(HttpServletRequest request) throws IOException {
        StringBuilder jsonBuilder = new StringBuilder();
        try (BufferedReader reader = request.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) {
                jsonBuilder.append(line);
            }
        }
        return jsonBuilder.toString();
    }

    private AppointmentData loadAppointmentData(ServletContext context) throws IOException {
        // Get the real file path using ServletContext
        String realPath = (DATA_FILE);
        System.out.println(realPath);
        File file = new File(realPath);
        
        // If file doesn't exist or directory doesn't exist, create them
        if (!file.exists()) {
            file.getParentFile().mkdirs();
            AppointmentData newData = createInitialData();
            saveAppointmentData(context, newData);
            return newData;
        }
        
        // Read existing data
        try (Reader reader = new FileReader(file)) {
            AppointmentData data = gson.fromJson(reader, AppointmentData.class);
            // Handle case where file exists but data is null
            if (data == null) {
                return createInitialData();
            }
            return data;
        } catch (Exception e) {
            System.err.println("Error reading appointment data: " + e.getMessage());
            // If there's any error reading, return fresh data
            return createInitialData();
        }
    }

    private AppointmentData createInitialData() {
        AppointmentData data = new AppointmentData();
        
        // Add sample agents
        AgentInfo agent1 = new AgentInfo();
        agent1.agentId = "AGT001";
        agent1.name = "John Doe";
        agent1.specialty = "Residential Properties";
        agent1.available = true;
        agent1.appointmentCount = 0;
        data.agents.put(agent1.agentId, agent1);
        
        AgentInfo agent2 = new AgentInfo();
        agent2.agentId = "AGT002";
        agent2.name = "Jane Smith";
        agent2.specialty = "Commercial Properties";
        agent2.available = true;
        agent2.appointmentCount = 0;
        data.agents.put(agent2.agentId, agent2);
        
        AgentInfo agent3 = new AgentInfo();
        agent3.agentId = "AGT003";
        agent3.name = "Emily Wilson";
        agent3.specialty = "Rental Properties";
        agent3.available = true;
        agent3.appointmentCount = 0;
        data.agents.put(agent3.agentId, agent3);
        
        return data;
    }

    private void saveAppointmentData(ServletContext context, AppointmentData data) throws IOException {
        // Get the real file path using ServletContext
        String realPath = (DATA_FILE);
        System.out.println(realPath);
        File file = new File(realPath);
        
        // Create directories if they don't exist
        file.getParentFile().mkdirs();
        
        // Create backup before saving
        if (file.exists()) {
            File backup = new File(realPath + ".backup");
            copyFile(file, backup);
        }
        
        // Save new data
        try (Writer writer = new FileWriter(file)) {
            gson.toJson(data, writer);
            System.out.println("Appointment data saved successfully to: " + realPath);
        }
    }

    private void copyFile(File source, File dest) throws IOException {
        try (InputStream in = new FileInputStream(source);
             OutputStream out = new FileOutputStream(dest)) {
            byte[] buffer = new byte[1024];
            int length;
            while ((length = in.read(buffer)) > 0) {
                out.write(buffer, 0, length);
            }
        }
    }

    private List<Appointment> filterAppointmentsByAgent(List<Appointment> appointments, String agentId) {
        if (agentId == null) return appointments;
        
        List<Appointment> filtered = new ArrayList<>();
        for (Appointment apt : appointments) {
            if (agentId.equals(apt.agentId)) {
                filtered.add(apt);
            }
        }
        return filtered;
    }

    private void updateAgentAppointmentCount(AppointmentData data, String agentId) {
        AgentInfo agent = data.agents.get(agentId);
        if (agent != null) {
            agent.appointmentCount++;
        }
    }

    private void sendErrorResponse(PrintWriter out, String message) {
        JsonObject error = new JsonObject();
        error.addProperty("status", "error");
        error.addProperty("message", message);
        error.addProperty("timestamp", CURRENT_DATE);
        out.println(gson.toJson(error));
    }
}