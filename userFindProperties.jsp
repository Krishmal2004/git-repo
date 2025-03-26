<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Property Finder</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="findPropertiesUser.css">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
        <!-- Back to Dashboard Button -->
    <a href="userDashboard.jsp" class="dashboard-btn animate__animated animate__fadeIn">
        <i class="fas fa-tachometer-alt me-2"></i>
        <span>Back to Dashboard</span>
    </a>

    <!-- Hero Section -->
    <div class="container-fluid hero-section py-5 text-white text-center">
        <h1>Find Your Dream Property</h1>
        <p class="lead">Browse thousands of listings curated just for you</p>
    </div>

    <!-- Filter Section -->
    <div class="container mt-4 mb-4">
        <div class="card filter-card">
            <div class="card-header bg-primary text-white">
                <h5 class="mb-0">Filter Properties</h5>
            </div>
            <div class="card-body">
                <form id="filterForm">
                    <div class="row">
                        <div class="col-md-3 mb-3">
                            <label for="propertyType" class="form-label">Property Type</label>
                            <select class="form-select" id="propertyType" name="propertyType">
                                <option value="">All Types</option>
                                <option value="apartment">Apartment</option>
                                <option value="house">House</option>
                                <option value="villa">Villa</option>
                                <option value="condo">Condo</option>
                            </select>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label for="priceRange" class="form-label">Price Range</label>
                            <select class="form-select" id="priceRange" name="priceRange">
                                <option value="">All Prices</option>
                                <option value="0-50000">$0 - $50,000</option>
                                <option value="50000-100000">$50,000 - $100,000</option>
                                <option value="100000-200000">$100,000 - $200,000</option>
                                <option value="200000-500000">$200,000 - $500,000</option>
                                <option value="500000-plus">$500,000+</option>
                            </select>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label for="bedrooms" class="form-label">Bedrooms</label>
                            <select class="form-select" id="bedrooms" name="bedrooms">
                                <option value="">Any</option>
                                <option value="1">1+</option>
                                <option value="2">2+</option>
                                <option value="3">3+</option>
                                <option value="4">4+</option>
                                <option value="5">5+</option>
                            </select>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label for="location" class="form-label">Location</label>
                            <select class="form-select" id="location" name="location">
                                <option value="">All Locations</option>
                                <option value="downtown">Downtown</option>
                                <option value="suburb">Suburb</option>
                                <option value="rural">Rural</option>
                                <option value="beachfront">Beachfront</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <button type="button" id="applyFilters" class="btn btn-primary">Apply Filters</button>
                            <button type="button" id="resetFilters" class="btn btn-outline-secondary">Reset</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Properties Section -->
    <div class="container mt-4">
        <h2 class="mb-4">Available Properties</h2>
        <div class="row" id="propertyList">
            <!-- Property listings will be loaded here dynamically -->
        </div>
        
        <!-- Loading Spinner (for infinite scroll) -->
        <div class="text-center py-3" id="loadingSpinner" style="display: none;">
            <div class="spinner-border text-primary" role="status">
                <span class="visually-hidden">Loading...</span>
            </div>
        </div>
    </div>

    <!-- Property Detail Modal -->
    <div class="modal fade" id="propertyModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title" id="modalPropertyTitle">Property Details</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" id="propertyDetails">
                    <!-- Property details will be loaded here dynamically -->
                    <div class="text-center py-3">
                        <div class="spinner-border text-primary" role="status">
                            <span class="visually-hidden">Loading...</span>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" id="contactAgentBtn">Contact Agent</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Agent Contact Modal -->
    <div class="modal fade" id="agentModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title">Contact Agent</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div id="agentInfo" class="mb-3">
                        <!-- Agent info will be loaded here -->
                        
                    </div>
                    <!-- Add this inside the modal body, after the agent info section -->
<div class="mb-3">
    <div class="session-info mb-2">
        <small class="text-muted">
            <i class="bi bi-clock"></i> Session time: <span id="sessionTimestamp">2025-03-25 22:32:09</span> |
            <i class="bi bi-person-badge"></i> User ID: <span id="sessionUserId">IT24103866</span>
        </small>
    </div>
    <div class="alert alert-info">
        <small>
            Your message will be sent as IT24103866. The agent will respond to your registered email.
        </small>
    </div>
</div>
                    <form id="contactForm">
                        <div class="mb-3">
                            <label for="name" class="form-label">Your Name</label>
                            <input type="text" class="form-control" id="name" required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Your Email</label>
                            <input type="email" class="form-control" id="email" required>
                        </div>
                        <div class="mb-3">
                            <label for="phone" class="form-label">Your Phone</label>
                            <input type="text" class="form-control" id="phone">
                        </div>
                        <div class="mb-3">
                            <label for="message" class="form-label">Message</label>
                            <textarea class="form-control" id="message" rows="3" required></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" id="sendMessageBtn">Send Message</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-white py-4 mt-5">
        <div class="container">
            <div class="row">
                <div class="col-md-3">
                    <h5>PropertyFinder</h5>
                    <p>Your trusted real estate partner.</p>
                </div>
                <div class="col-md-3">
                    <h5>Quick Links</h5>
                    <ul class="list-unstyled">
                        <li><a href="#" class="text-white">Home</a></li>
                        <li><a href="#" class="text-white">Properties</a></li>
                        <li><a href="#" class="text-white">Agents</a></li>
                        <li><a href="#" class="text-white">Contact</a></li>
                    </ul>
                </div>
                <div class="col-md-3">
                    <h5>Contact Us</h5>
                    <address>
                        <p>123 Main Street<br>City, State 12345<br>Phone: (123) 456-7890<br>Email: info@propertyfinder.com</p>
                    </address>
                </div>
                <div class="col-md-3">
                    <h5>Follow Us</h5>
                    <div class="d-flex gap-3">
                        <a href="#" class="text-white"><i class="bi bi-facebook"></i></a>
                        <a href="#" class="text-white"><i class="bi bi-twitter"></i></a>
                        <a href="#" class="text-white"><i class="bi bi-instagram"></i></a>
                        <a href="#" class="text-white"><i class="bi bi-linkedin"></i></a>
                    </div>
                </div>
            </div>
            <hr>
            <div class="text-center">
                <p>&copy; 2025 PropertyFinder. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <!-- Custom JS -->
    <script src="findPropertiesUser.js"></script>
</body>
</html>