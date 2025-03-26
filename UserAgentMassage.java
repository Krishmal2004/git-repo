package com.RealState.model;

import java.time.LocalDateTime;

/**
 * Bean class for agent contact messages
 * Used for JSON serialization/deserialization with Gson
 */
public class UserAgentMassage {
    private int messageId;
    private int propertyId;
    private int agentId;
    private String userName;
    private String userEmail;
    private String userPhone;
    private String messageContent;
    private String userId;
    private String timestamp;
    private boolean read;
    private String status;
    
    // Default constructor for Gson
    public UserAgentMassage() {
    }
    
    // Constructor with required fields
    public UserAgentMassage(int propertyId, int agentId, String userName, String userEmail, String userPhone, String messageContent, String userId, String timestamp) {
        this.propertyId = propertyId;
        this.agentId = agentId;
        this.userName = userName;
        this.userEmail = userEmail;
        this.userPhone = userPhone;
        this.messageContent = messageContent;
        this.userId = userId;
        this.timestamp = timestamp;
        this.read = false;
        this.status = "PENDING";
    }

    // Getters and setters
    public int getMessageId() {
        return messageId;
    }

    public void setMessageId(int messageId) {
        this.messageId = messageId;
    }

    public int getPropertyId() {
        return propertyId;
    }

    public void setPropertyId(int propertyId) {
        this.propertyId = propertyId;
    }

    public int getAgentId() {
        return agentId;
    }

    public void setAgentId(int agentId) {
        this.agentId = agentId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    public String getMessageContent() {
        return messageContent;
    }

    public void setMessageContent(String messageContent) {
        this.messageContent = messageContent;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }

    public boolean isRead() {
        return read;
    }

    public void setRead(boolean read) {
        this.read = read;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    @Override
    public String toString() {
        return "AgentMessage{" +
                "messageId=" + messageId +
                ", propertyId=" + propertyId +
                ", agentId=" + agentId +
                ", userName='" + userName + '\'' +
                ", userEmail='" + userEmail + '\'' +
                ", userId='" + userId + '\'' +
                ", timestamp='" + timestamp + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}