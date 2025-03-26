package com.RealState.services;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.RealState.model.UserAgentMassage;

import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Service for handling agent messages
 * Manages persistence using JSON files with Gson
 */
public class UsserAgentMassageService {
    private static final Logger LOGGER = Logger.getLogger(UsserAgentMassageService.class.getName());
    private static final String MESSAGES_FILE = "C:\\Users\\user\\Downloads\\project\\RealState\\src\\main\\webapp\\WEB-INF\\data\\userAgentMassage.json";
    private static final Gson gson = new GsonBuilder().setPrettyPrinting().create();
    private static final AtomicInteger messageIdGenerator = new AtomicInteger(1);
    
    /**
     * Save a new agent message to the JSON file
     * @param message The message to save
     * @return true if successful, false otherwise
     */
    public boolean saveMessage(UserAgentMassage message) {
        try {
            // Get existing messages
            List<UserAgentMassage> messages = getAllMessages();
            
            // Set a new ID for the message
            message.setMessageId(getNextMessageId(messages));
            
            // Add the new message to the list
            messages.add(message);
            
            // Save the updated list back to the file
            writeMessagesToFile(messages);
            
            // Send notification to the agent (in a real system)
            notifyAgent(message);
            
            return true;
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error saving message", e);
            return false;
        }
    }
    
    /**
     * Get all agent messages from the JSON file
     * @return List of all messages
     */
    public List<UserAgentMassage> getAllMessages() {
        try {
            File file = new File(MESSAGES_FILE);
            System.out.println(file);
            
            // Create file if it doesn't exist
            if (!file.exists()) {
                File directory = file.getParentFile();
                if (!directory.exists()) {
                    directory.mkdirs();
                }
                file.createNewFile();
                
                // Initialize with empty array
                try (FileWriter writer = new FileWriter(file)) {
                    writer.write("[]");
                }
                return new ArrayList<>();
            }
            
            // Read existing messages
            try (FileReader reader = new FileReader(file)) {
                Type listType = new TypeToken<ArrayList<UserAgentMassage>>(){}.getType();
                List<UserAgentMassage> messages = gson.fromJson(reader, listType);
                return messages != null ? messages : new ArrayList<>();
            }
            
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Error reading messages file", e);
            return new ArrayList<>();
        }
    }
    
    /**
     * Write messages back to the JSON file
     */
    private void writeMessagesToFile(List<UserAgentMassage> messages) throws IOException {
        try (FileWriter writer = new FileWriter(MESSAGES_FILE)) {
            gson.toJson(messages, writer);
        }
    }
    
    /**
     * Get the next available message ID
     */
    private int getNextMessageId(List<UserAgentMassage> messages) {
        if (messages.isEmpty()) {
            return messageIdGenerator.get();
        }
        
        // Find the highest existing ID
        int maxId = messages.stream()
            .mapToInt(UserAgentMassage::getMessageId)
            .max()
            .orElse(0);
        
        // Update the ID generator
        messageIdGenerator.set(Math.max(messageIdGenerator.get(), maxId + 1));
        
        return messageIdGenerator.get();
    }
    
    /**
     * Notify an agent about a new message
     * In a real system, this would send an email or push notification
     */
    private void notifyAgent(UserAgentMassage message) {
        // This is a placeholder for actual notification logic
        LOGGER.info("Notification sent to agent #" + message.getAgentId() + 
                   " about message #" + message.getMessageId() +
                   " from user " + message.getUserId());
        
        // In a real system, you might:
        // 1. Send an email to the agent
        // 2. Create a notification in the agent's dashboard
        // 3. Send a push notification to the agent's mobile app
    }
}