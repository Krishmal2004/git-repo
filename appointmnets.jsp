<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date, java.text.SimpleDateFormat" %>

<%
    // Current user and timestamp as specified
    String currentUser = "IT24103866";
    String currentDate = "2025-03-23 08:16:47";
    
    // Process form submission (simplified)
    String message = "";
    boolean formSubmitted = false;
    if ("POST".equals(request.getMethod())) {
        try {
            String buyerName = request.getParameter("buyerName");
            String buyerEmail = request.getParameter("buyerEmail");
            
            if (buyerName != null && buyerName.trim().length() > 0 && 
                buyerEmail != null && buyerEmail.trim().length() > 0) {
                message = "Appointment successfully saved for " + buyerName + " with agent!";
                formSubmitted = true;
            } else {
                message = "Please fill in all required fields.";
            }
        } catch (Exception e) {
            message = "Error processing form: " + e.getMessage();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
	
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Buyer Appointments</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Animation CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    
    <style>
        :root {
            --primary-blue: #0a192f;
            --secondary-blue: #112240;
            --tertiary-blue: #1a365d;
            --accent-blue: #64ffda;
            --light-blue: #8892b0;
            --white: #e6f1ff;
            --dark: #020c1b;
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
            --border-color: rgba(255, 255, 255, 0.1);
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--primary-blue);
            color: var(--white);
            min-height: 100vh;
            overflow-x: hidden;
        }
        
        /* Animation Keyframes */
        @keyframes fadeIn {
            0% { opacity: 0; }
            100% { opacity: 1; }
        }
        
        @keyframes slideInUp {
            0% { 
                transform: translateY(30px);
                opacity: 0;
            }
            100% { 
                transform: translateY(0);
                opacity: 1;
            }
        }
        
        @keyframes slideInLeft {
            0% { 
                transform: translateX(-30px);
                opacity: 0;
            }
            100% { 
                transform: translateX(0);
                opacity: 1;
            }
        }
        
        @keyframes slideInRight {
            0% { 
                transform: translateX(30px);
                opacity: 0;
            }
            100% { 
                transform: translateX(0);
                opacity: 1;
            }
        }
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        
        @keyframes shimmer {
            0% {
                background-position: -1000px 0;
            }
            100% {
                background-position: 1000px 0;
            }
        }
        
        @keyframes float {
            0% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
            100% { transform: translateY(0); }
        }
        
        /* Background elements */
        .stars {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            pointer-events: none;
        }
        
        .star {
            position: absolute;
            background-color: var(--white);
            opacity: 0.3;
            border-radius: 50%;
        }
        
        .glow {
            position: fixed;
            top: 20%;
            right: -200px;
            width: 500px;
            height: 500px;
            background: radial-gradient(circle, rgba(100, 255, 218, 0.2) 0%, rgba(10, 25, 47, 0) 70%);
            z-index: -1;
            border-radius: 50%;
            filter: blur(50px);
            animation: float 8s infinite ease-in-out;
        }
        
        .glow:nth-child(2) {
            top: 60%;
            left: -200px;
            width: 400px;
            height: 400px;
            background: radial-gradient(circle, rgba(16, 185, 129, 0.1) 0%, rgba(10, 25, 47, 0) 70%);
            animation: float 10s infinite ease-in-out reverse;
        }
        
        /* Header */
        .navbar {
            background-color: rgba(1, 9, 21, 0.85);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid var(--border-color);
            padding: 15px 0;
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        
        .navbar-brand {
            font-weight: 600;
            color: var(--white);
            font-size: 1.25rem;
            letter-spacing: 0.5px;
            display: flex;
            align-items: center;
            animation: fadeIn 1s ease forwards;
        }
        
        .navbar-brand i {
            color: var(--accent-blue);
            margin-right: 10px;
        }
        
        .user-info {
            color: var(--light-blue);
            font-size: 0.9rem;
            animation: fadeIn 1s ease 0.3s forwards;
            opacity: 0;
        }
        
        .user-info i {
            color: var(--accent-blue);
            margin-right: 6px;
        }
        
        /* Main content */
        .main-content {
            padding: 40px 0;
            position: relative;
            overflow: hidden;
        }
        
        /* Cards */
        .app-card {
            background-color: var(--secondary-blue);
            border-radius: 12px;
            border: 1px solid var(--border-color);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            overflow: hidden;
            height: 100%;
            margin-bottom: 30px;
            transition: all 0.3s ease;
            opacity: 0;
            transform: translateY(20px);
            animation: slideInUp 0.8s ease forwards;
        }
        
        .form-card {
            animation-delay: 0.2s;
        }
        
        .table-card {
            animation-delay: 0.4s;
        }
        
        .agents-card {
            animation-delay: 0.6s;
        }
        
        .app-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
            border-color: rgba(100, 255, 218, 0.3);
        }
        
        .card-header {
            padding: 18px 20px;
            background-color: var(--tertiary-blue);
            border-bottom: 1px solid var(--border-color);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        
        .card-title {
            color: var(--white);
            font-weight: 600;
            margin: 0;
            display: flex;
            align-items: center;
            font-size: 1.1rem;
        }
        
        .card-title i {
            color: var(--accent-blue);
            margin-right: 10px;
        }
        
        .card-body {
            padding: 25px;
        }
        
        /* Form Elements */
        .form-label {
            font-weight: 500;
            margin-bottom: 8px;
            font-size: 0.9rem;
            color: var(--light-blue);
        }
        
        .form-control, .form-select {
            background-color: rgba(1, 9, 21, 0.3);
            border: 1px solid var(--border-color);
            border-radius: 8px;
            padding: 12px 15px;
            color: var(--white);
            font-size: 0.95rem;
            transition: all 0.3s ease;
        }
        
        .form-control:focus, .form-select:focus {
            background-color: rgba(1, 9, 21, 0.5);
            border-color: var(--accent-blue);
            box-shadow: 0 0 0 3px rgba(100, 255, 218, 0.15);
            color: var(--white);
        }
        
        .form-control::placeholder {
            color: rgba(230, 241, 255, 0.4);
        }
        
        .form-control option, .form-select option {
            background-color: var(--secondary-blue);
            color: var(--white);
        }
        
        .required::after {
            content: "*";
            color: var(--danger);
            margin-left: 4px;
        }
        
        /* Buttons */
        .btn-primary {
            background-color: transparent;
            color: var(--accent-blue);
            border: 1px solid var(--accent-blue);
            border-radius: 6px;
            padding: 12px 20px;
            font-weight: 500;
            font-size: 0.95rem;
            letter-spacing: 0.5px;
            position: relative;
            overflow: hidden;
            transition: all 0.3s ease;
            z-index: 1;
        }
        
        .btn-primary::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 0;
            height: 100%;
            background-color: rgba(100, 255, 218, 0.15);
            transition: width 0.3s ease;
            z-index: -1;
        }
        
        .btn-primary:hover {
            color: var(--white);
            background-color: transparent;
            border-color: var(--accent-blue);
            transform: translateY(-2px);
        }
        
        .btn-primary:hover::before {
            width: 100%;
        }
        
        .btn-outline-light {
            background-color: transparent;
            border: 1px solid var(--border-color);
            color: var(--light-blue);
            border-radius: 6px;
            transition: all 0.3s ease;
        }
        
        .btn-outline-light:hover {
            background-color: rgba(255, 255, 255, 0.05);
            border-color: var(--white);
            color: var(--white);
        }
        
        .btn-icon {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 36px;
            height: 36px;
            padding: 0;
            border-radius: 6px;
        }
        
        .btn-edit:hover {
            color: var(--success);
            border-color: var(--success);
        }
        
        .btn-delete:hover {
            color: var(--danger);
            border-color: var(--danger);
        }
        
        .btn-shimmer {
            background-image: linear-gradient(
                to right,
                rgba(100, 255, 218, 0) 0%,
                rgba(100, 255, 218, 0.3) 50%,
                rgba(100, 255, 218, 0) 100%
            );
            background-size: 200% 100%;
            animation: shimmer 3s infinite;
        }
        
        /* Home Button */
        .btn-home {
            position: fixed;
            bottom: 30px;
            right: 30px;
            background: var(--accent-blue);
            color: var(--white);
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(100, 255, 218, 0.3);
            z-index: 1000;
            animation: pulse 2s infinite ease-in-out;
        }
        
        .btn-home:hover {
            background: rgba(100, 255, 218, 0.2);
            color: var(--white);
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(100, 255, 218, 0.5);
        }
        
        .btn-home i {
            font-size: 1.5rem;
        }
        
        /* Alerts */
        .app-alert {
            border-radius: 8px;
            padding: 16px 20px;
            margin-bottom: 30px;
            display: flex;
            align-items: center;
            animation: slideInUp 0.5s ease forwards;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .app-alert i {
            font-size: 1.5rem;
            margin-right: 15px;
        }
        
        .app-alert.success {
            background-color: rgba(16, 185, 129, 0.15);
            border-left: 4px solid var(--success);
            color: #a7f3d0;
        }
        
        .app-alert.error {
            background-color: rgba(239, 68, 68, 0.15);
            border-left: 4px solid var(--danger);
            color: #fecaca;
        }
        
        /* Table */
        .table-responsive {
            border-radius: 8px;
            overflow: hidden;
            border: 1px solid var(--border-color);
        }
        
        .app-table {
            width: 100%;
            margin-bottom: 0;
            color: var(--white);
            border-collapse: separate;
            border-spacing: 0;
        }
        
        .app-table th {
            background-color: var(--tertiary-blue);
            padding: 15px;
            font-weight: 600;
            font-size: 0.85rem;
            letter-spacing: 0.5px;
            color: var(--light-blue);
            border: none;
            text-transform: uppercase;
        }
        
        .app-table td {
            padding: 15px;
            vertical-align: middle;
            border-top: 1px solid var(--border-color);
            transition: all 0.2s ease;
        }
        
        .app-table tbody tr {
            transition: all 0.2s ease;
        }
        
        .app-table tbody tr:hover {
            background-color: rgba(255, 255, 255, 0.03);
        }
        
        .app-table .row-animated {
            animation: fadeIn 0.5s ease forwards;
            opacity: 0;
        }
        
        .app-table .row-animated:nth-child(1) {
            animation-delay: 0.1s;
        }
        
        .app-table .row-animated:nth-child(2) {
            animation-delay: 0.2s;
        }
        
        .app-table .row-animated:nth-child(3) {
            animation-delay: 0.3s;
        }
        
        /* Status Badges */
        .status-badge {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 50px;
            font-size: 0.75rem;
            font-weight: 600;
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }
        
        .status-badge.confirmed {
            background-color: rgba(16, 185, 129, 0.15);
            color: var(--success);
            border: 1px solid rgba(16, 185, 129, 0.3);
        }
        
        .status-badge.pending {
            background-color: rgba(245, 158, 11, 0.15);
            color: var(--warning);
            border: 1px solid rgba(245, 158, 11, 0.3);
        }
        
        /* Agent Cards */
        .agent-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 20px;
        }
        
        .agent-card {
            background-color: rgba(1, 9, 21, 0.3);
            border-radius: 8px;
            border: 1px solid var(--border-color);
            padding: 16px;
            position: relative;
            transition: all 0.3s ease;
            overflow: hidden;
            opacity: 0;
            animation: fadeIn 0.5s ease forwards;
        }
        
        .agent-card:nth-child(1) {
            animation-delay: 0.2s;
        }
        
        .agent-card:nth-child(2) {
            animation-delay: 0.3s;
        }
        
        .agent-card:nth-child(3) {
            animation-delay: 0.4s;
        }
        
        .agent-card:nth-child(4) {
            animation-delay: 0.5s;
        }
        
        .agent-card:nth-child(5) {
            animation-delay: 0.6s;
        }
        
        .agent-card::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
        }
        
        .agent-card.available::before {
            background-color: var(--success);
        }
        
        .agent-card.unavailable::before {
            background-color: var(--danger);
        }
        
        .agent-card:hover {
            transform: translateY(-5px);
            background-color: rgba(1, 9, 21, 0.5);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            border-color: rgba(255, 255, 255, 0.1);
        }
        
        .agent-name {
            font-weight: 600;
            font-size: 1.05rem;
            margin-bottom: 5px;
            color: var(--white);
        }
        
        .agent-specialty {
            color: var(--light-blue);
            font-size: 0.85rem;
            margin-bottom: 15px;
        }
        
        .agent-status {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 50px;
            font-size: 0.75rem;
            font-weight: 600;
            letter-spacing: 0.5px;
        }
        
        .agent-status.available {
            background-color: rgba(16, 185, 129, 0.15);
            color: var(--success);
            border: 1px solid rgba(16, 185, 129, 0.3);
        }
        
        .agent-status.unavailable {
            background-color: rgba(239, 68, 68, 0.15);
            color: var(--danger);
            border: 1px solid rgba(239, 68, 68, 0.3);
        }
        
        .agent-actions {
            margin-top: 15px;
            display: flex;
            justify-content: flex-end;
        }
        
        /* Toast Notifications */
        .toast-container {
            position: fixed;
            bottom: 20px;
            right: 20px;
            z-index: 9999;
        }
        
        .app-toast {
            min-width: 300px;
            background-color: var(--secondary-blue);
            border-radius: 8px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            border: 1px solid var(--border-color);
            margin-bottom: 15px;
            overflow: hidden;
            animation: slideInRight 0.3s ease forwards;
        }
        
        .toast-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 12px 15px;
            background-color: var(--tertiary-blue);
            border-bottom: 1px solid var(--border-color);
            color: var(--white);
        }
        
        .toast-body {
            padding: 15px;
            color: var(--white);
        }
        
        /* Loading Spinner */
        .spinner {
            width: 20px;
            height: 20px;
            border: 2px solid rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            border-top-color: var(--accent-blue);
            animation: spin 0.8s infinite linear;
            display: inline-block;
            margin-right: 10px;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        /* Responsive Styles */
        @media (max-width: 991.98px) {
            .agent-grid {
                grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
            }
        }
        
        @media (max-width: 767.98px) {
            .navbar-brand {
                font-size: 1.1rem;
            }
            
            .user-info {
                font-size: 0.8rem;
            }
            
            .agent-grid {
                grid-template-columns: 1fr 1fr;
                gap: 15px;
            }
            
            .agent-name {
                font-size: 0.95rem;
            }
            
            .agent-specialty {
                font-size: 0.8rem;
            }
            
            .app-table th, .app-table td {
                padding: 12px 10px;
            }
        }
        
        @media (max-width: 575.98px) {
            .agent-grid {
                grid-template-columns: 1fr;
            }
            
            .card-title {
                font-size: 1rem;
            }
            
            .btn-primary {
                padding: 10px 15px;
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body>
    <!-- Stars Background -->
    <div class="stars" id="stars"></div>
    
    <!-- Glowing Elements -->
    <div class="glow"></div>
    <div class="glow"></div>
    
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand" href="#">
                <i class="fas fa-building"></i> Real Estate Appointments
            </a>
            <div class="user-info ms-auto">
                <span><i class="fas fa-user"></i> <%= currentUser %></span>
                <span class="mx-2">|</span>
                <span><i class="fas fa-clock"></i> <%= currentDate %> (UTC)</span>
            </div>
        </div>
    </nav>
    
    <!-- Main Content -->
    <div class="main-content">
        <div class="container">
            <!-- Alerts Section -->
            <% if (formSubmitted && message.indexOf("successfully") >= 0) { %>
                <div class="app-alert success">
                    <i class="fas fa-check-circle"></i>
                    <div><%= message %></div>
                </div>
            <% } else if (message.length() > 0) { %>
                <div class="app-alert error">
                    <i class="fas fa-exclamation-circle"></i>
                    <div><%= message %></div>
                </div>
            <% } %>
            
            <div class="row g-4">
                <!-- New Appointment Form -->
                <div class="col-lg-5">
                    <div class="app-card form-card">
                        <div class="card-header">
                            <h2 class="card-title">
                                <i class="fas fa-calendar-plus"></i> New Appointment
                            </h2>
                        </div>
                        <div class="card-body">
                            <form action="UserAppointmentServlet" method="post" id="appointmentForm">
                                <div class="mb-3">
                                    <label for="buyerName" class="form-label required">Buyer's Name</label>
                                    <input type="text" class="form-control" id="buyerName" name="buyerName" placeholder="Enter full name" required>
                                </div>
                                
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="buyerEmail" class="form-label required">Email</label>
                                        <input type="email" class="form-control" id="buyerEmail" name="buyerEmail" placeholder="email@example.com" required>
                                    </div>
                                    
                                    <div class="col-md-6 mb-3">
                                        <label for="buyerPhone" class="form-label">Phone Number</label>
                                        <input type="tel" class="form-control" id="buyerPhone" name="buyerPhone" placeholder="(123) 456-7890">
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="appointmentDate" class="form-label required">Date</label>
                                        <input type="date" class="form-control" id="appointmentDate" name="appointmentDate" required>
                                    </div>
                                    
                                    <div class="col-md-6 mb-3">
                                        <label for="appointmentTime" class="form-label required">Time</label>
                                        <input type="time" class="form-control" id="appointmentTime" name="appointmentTime" required>
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="agent" class="form-label required">Assign Agent</label>
                                    <select class="form-select" id="agent" name="agent" required>
                                        <option value="" selected disabled>-- Select an agent --</option>
                                        <option value="1">John Doe - Residential Properties</option>
                                        <option value="2">Jane Smith - Commercial Properties</option>
                                        <option value="3" disabled>Michael Brown - Luxury Estates (Unavailable)</option>
                                        <option value="4">Emily Wilson - Rental Properties</option>
                                        <option value="5" disabled>Robert Johnson - Investment Properties (Unavailable)</option>
                                    </select>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="status" class="form-label">Status</label>
                                    <select class="form-select" id="status" name="status">
                                        <option value="Pending" selected>Pending</option>
                                        <option value="Confirmed">Confirmed</option>
                                        <option value="Completed">Completed</option>
                                        <option value="Cancelled">Cancelled</option>
                                    </select>
                                </div>
                                
                                <div class="mb-4">
                                    <label for="notes" class="form-label">Notes</label>
                                    <textarea class="form-control" id="notes" name="notes" rows="3" placeholder="Add any additional information..."></textarea>
                                </div>
                                
                                <button type="submit" class="btn btn-primary w-100 btn-shimmer" id="saveBtn">
                                    <i class="fas fa-save me-2"></i>Save Appointment
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
                
                <!-- Right Column - Tables & Agent Cards -->
                <div class="col-lg-7">
                    <!-- Appointments Table -->
                    <div class="app-card table-card">
                        <div class="card-header">
                            <h2 class="card-title">
                                <i class="fas fa-list"></i> Saved Appointments
                            </h2>
                            <button class="btn btn-outline-light btn-sm" onclick="printTable()">
                                <i class="fas fa-print me-1"></i> Print
                            </button>
                        </div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <table class="app-table">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Buyer</th>
                                            <th>Date & Time</th>
                                            <th>Agent</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <!-- Sample data rows -->
                                        <tr class="row-animated">
                                            <td>1</td>
                                            <td>
                                                <div class="fw-bold">Alice Cooper</div>
                                                <div class="text-white-50 small">alice@example.com</div>
                                            </td>
                                            <td>2025-03-24 10:30</td>
                                            <td>John Doe</td>
                                            <td>
                                                <span class="status-badge confirmed">Confirmed</span>
                                            </td>
                                            <td>
                                                <div class="d-flex">
                                                    <button class="btn btn-outline-light btn-icon btn-edit me-2" title="Edit" onclick="editAppointment(1)">
                                                        <i class="fas fa-edit"></i>
                                                    </button>
                                                    <button class="btn btn-outline-light btn-icon btn-delete" title="Delete" onclick="deleteAppointment(1)">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr class="row-animated">
                                            <td>2</td>
                                            <td>
                                                <div class="fw-bold">Bob Johnson</div>
                                                <div class="text-white-50 small">bob@example.com</div>
                                            </td>
                                            <td>2025-03-25 14:15</td>
                                            <td>Jane Smith</td>
                                            <td>
                                                <span class="status-badge pending">Pending</span>
                                            </td>
                                            <td>
                                                <div class="d-flex">
                                                    <button class="btn btn-outline-light btn-icon btn-edit me-2" title="Edit" onclick="editAppointment(2)">
                                                        <i class="fas fa-edit"></i>
                                                    </button>
                                                    <button class="btn btn-outline-light btn-icon btn-delete" title="Delete" onclick="deleteAppointment(2)">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr class="row-animated">
                                            <td>3</td>
                                            <td>
                                                <div class="fw-bold">Carol Smith</div>
                                                <div class="text-white-50 small">carol@example.com</div>
                                            </td>
                                            <td>2025-03-26 11:00</td>
                                            <td>Robert Johnson</td>
                                            <td>
                                                <span class="status-badge confirmed">Confirmed</span>
                                            </td>
                                            <td>
                                                <div class="d-flex">
                                                    <button class="btn btn-outline-light btn-icon btn-edit me-2" title="Edit" onclick="editAppointment(3)">
                                                        <i class="fas fa-edit"></i>
                                                    </button>
                                                    <button class="btn btn-outline-light btn-icon btn-delete" title="Delete" onclick="deleteAppointment(3)">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Available Agents -->
                    <div class="app-card agents-card">
                        <div class="card-header">
                            <h2 class="card-title">
                                <i class="fas fa-user-tie"></i> Available Agents
                            </h2>
                        </div>
                        <div class="card-body">
                            <div class="agent-grid">
                                <!-- Agent cards with hardcoded data -->
                                <div class="agent-card available">
                                    <div class="agent-name">John Doe</div>
                                    <div class="agent-specialty">Residential Properties</div>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="agent-status available">Available</span>
                                    </div>
                                    <div class="agent-actions">
                                        <button class="btn btn-outline-light btn-sm" onclick="selectAgent(1, 'John Doe')">
                                            <i class="fas fa-user-check me-1"></i>Select
                                        </button>
                                    </div>
                                </div>
                                
                                <div class="agent-card available">
                                    <div class="agent-name">Jane Smith</div>
                                    <div class="agent-specialty">Commercial Properties</div>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="agent-status available">Available</span>
                                    </div>
                                    <div class="agent-actions">
                                        <button class="btn btn-outline-light btn-sm" onclick="selectAgent(2, 'Jane Smith')">
                                            <i class="fas fa-user-check me-1"></i>Select
                                        </button>
                                    </div>
                                </div>
                                
                                <div class="agent-card unavailable">
                                    <div class="agent-name">Michael Brown</div>
                                    <div class="agent-specialty">Luxury Estates</div>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="agent-status unavailable">Unavailable</span>
                                    </div>
                                    <div class="agent-actions">
                                        <button class="btn btn-outline-light btn-sm" disabled>
                                            <i class="fas fa-user-clock me-1"></i>Unavailable
                                        </button>
                                    </div>
                                </div>
                                
                                <div class="agent-card available">
                                    <div class="agent-name">Emily Wilson</div>
                                    <div class="agent-specialty">Rental Properties</div>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="agent-status available">Available</span>
                                    </div>
                                    <div class="agent-actions">
                                        <button class="btn btn-outline-light btn-sm" onclick="selectAgent(4, 'Emily Wilson')">
                                            <i class="fas fa-user-check me-1"></i>Select
                                        </button>
                                    </div>
                                </div>
                                
                                <div class="agent-card unavailable">
                                    <div class="agent-name">Robert Johnson</div>
                                    <div class="agent-specialty">Investment Properties</div>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="agent-status unavailable">Unavailable</span>
                                    </div>
                                    <div class="agent-actions">
                                        <button class="btn btn-outline-light btn-sm" disabled>
                                            <i class="fas fa-user-clock me-1"></i>Unavailable
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Home Button -->
    <a href="userDashboard.jsp" class="btn-home animate__animated animate__pulse animate__infinite animate__slower" title="Go to Homepage">
        <i class="fas fa-home"></i>
    </a>
    
    <!-- Toast Container -->
    <div class="toast-container"></div>
    
    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Create star background
            createStars();
            
            // Date validation to prevent choosing past dates
            var appointmentDateInput = document.getElementById('appointmentDate');
            var today = new Date();
            var year = today.getFullYear();
            var month = (today.getMonth() + 1).toString().padStart(2, '0');
            var day = today.getDate().toString().padStart(2, '0');
            var formattedDate = year + '-' + month + '-' + day;
            
            if (appointmentDateInput) {
                appointmentDateInput.setAttribute('min', formattedDate);
            }
            
            // Form submit animation
            var appointmentForm = document.getElementById('appointmentForm');
            var saveBtn = document.getElementById('saveBtn');
            
            if (appointmentForm && saveBtn) {
                appointmentForm.addEventListener('submit', function() {
                    var originalContent = saveBtn.innerHTML;
                    saveBtn.innerHTML = '<span class="spinner"></span> Saving...';
                    saveBtn.disabled = true;
                    
                    // Restore button state after 2 seconds (for demo purposes)
                    setTimeout(function() {
                        saveBtn.innerHTML = originalContent;
                        saveBtn.disabled = false;
                    }, 2000);
                });
            }
        });
        
        // Create star background
        function createStars() {
            var starsContainer = document.getElementById('stars');
            var starCount = 100;
            
            for (var i = 0; i < starCount; i++) {
                var star = document.createElement('div');
                star.className = 'star';
                
                // Random size between 1-3px
                var size = Math.random() * 2 + 1;
                star.style.width = size + 'px';
                star.style.height = size + 'px';
                
                // Random position
                star.style.left = Math.random() * 100 + 'vw';
                star.style.top = Math.random() * 100 + 'vh';
                
                // Random opacity
                star.style.opacity = Math.random() * 0.5 + 0.1;
                
                // Add to container
                starsContainer.appendChild(star);
            }
        }
        
        // Function to select an agent
        function selectAgent(agentId, agentName) {
            document.getElementById('agent').value = agentId;
            
            // Smooth scroll to the form
            document.getElementById('buyerName').scrollIntoView({ behavior: 'smooth' });
            
            // Add focus effect
            var agentSelect = document.getElementById('agent');
            agentSelect.classList.add('is-valid');
            
            // Add pulse animation
            agentSelect.style.animation = 'pulse 0.5s';
            setTimeout(function() {
                agentSelect.style.animation = '';
            }, 500);
            
            // Show toast notification
            showToast('info', 'Agent Selected', 'You selected ' + agentName + ' as the agent.');
        }
        
        // Function to edit appointment
        function editAppointment(id) {
            // In a real app, this would load data from the server
            showToast('info', 'Edit Appointment', 'Editing appointment #' + id);
            
            // For demo, just focus the form
            document.getElementById('buyerName').focus();
        }
        
        // Function to delete appointment
        function deleteAppointment(id) {
            if (confirm('Are you sure you want to delete appointment #' + id + '?')) {
                // In a real app, this would send a delete request to the server
                showToast('error', 'Appointment Deleted', 'Appointment #' + id + ' has been deleted successfully.');
                
                // Find and remove the row with animation
                var rows = document.querySelectorAll('.app-table tbody tr');
                for (var i = 0; i < rows.length; i++) {
                    if (rows[i].querySelector('td').textContent == id) {
                        rows[i].style.transition = 'all 0.5s ease';
                        rows[i].style.opacity = '0';
                        rows[i].style.transform = 'translateX(20px)';
                        
                        (function(row) {
                            setTimeout(function() {
                                row.parentNode.removeChild(row);
                            }, 500);
                        })(rows[i]);
                        break;
                    }
                }
            }
        }
        
        // Function to print table
        function printTable() {
            var printContents = document.querySelector('.app-table').outerHTML;
            var originalContents = document.body.innerHTML;
            
            document.body.innerHTML = 
                '<div style="padding: 30px;">' +
                '<h2 style="text-align: center; margin-bottom: 30px; color: #333;">Real Estate Appointments</h2>' +
                '<style>' +
                'body { font-family: Arial, sans-serif; }' +
                'table { width: 100%; border-collapse: collapse; }' +
                'th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }' +
                'th { background-color: #f2f2f2; }' +
                '</style>' +
                printContents +
                '</div>';
            
            window.print();
            document.body.innerHTML = originalContents;
            window.location.reload();
        }
        
        // Toast notification function
        function showToast(type, title, message) {
            // Get or create toast container
            var toastContainer = document.querySelector('.toast-container');
            
            // Create toast element
            var toast = document.createElement('div');
            toast.className = 'app-toast';
            
            // Set icon and color based on type
            var iconClass = 'info-circle';
            var iconColor = '#3498db';
            
            if (type === 'success') {
                iconClass = 'check-circle';
                iconColor = '#10b981';
            } else if (type === 'error') {
                iconClass = 'exclamation-circle';
                iconColor = '#ef4444';
            } else if (type === 'warning') {
                iconClass = 'exclamation-triangle';
                iconColor = '#f59e0b';
            }
            
            // Set toast content
            toast.innerHTML = 
                '<div class="toast-header">' +
                '<div><i class="fas fa-' + iconClass + '" style="color: ' + iconColor + '; margin-right: 8px;"></i> <strong>' + title + '</strong></div>' +
                '<button type="button" class="btn-close btn-close-white" aria-label="Close"></button>' +
                '</div>' +
                '<div class="toast-body">' + message + '</div>';
            
            // Add to container
            toastContainer.appendChild(toast);
            
            // Auto remove after 4 seconds
            setTimeout(function() {
                toast.style.opacity = '0';
                toast.style.transform = 'translateX(100%)';
                
                setTimeout(function() {
                    toast.remove();
                }, 300);
            }, 4000);
            
            // Add close button functionality
            var closeButton = toast.querySelector('.btn-close');
            closeButton.addEventListener('click', function() {
                toast.style.opacity = '0';
                toast.style.transform = 'translateX(100%)';
                
                setTimeout(function() {
                    toast.remove();
                }, 300);
            });
        }
    </script>
</body>
</html>