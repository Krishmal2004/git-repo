<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agent Settings | Real Estate Portal</title>

    <!-- CSS Dependencies -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --primary-dark: #0A192F;
            --primary-medium: #112240;
            --primary-light: #1E3A8A;
            --accent-blue: #3B82F6;
            --accent-green: #10B981;
            --accent-yellow: #F59E0B;
            --text-white: #F8FAFC;
            --text-light: #CBD5E1;
            --text-muted: #94A3B8;
            --border-color: rgba(203, 213, 225, 0.1);
        }

        body {
            background-color: var(--primary-dark);
            color: var(--text-light);
            font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Arial, sans-serif;
            line-height: 1.6;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 20px;
        }

        .panel {
            background-color: var(--primary-medium);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 24px;
            margin-bottom: 24px;
        }

        .nav-link {
            color: var(--text-light);
            background: none;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 12px;
            transition: all 0.3s ease;
        }

        .nav-link:hover {
            background-color: rgba(59, 130, 246, 0.1);
            color: var(--text-white);
            transform: translateX(5px);
        }

        .nav-link.active {
            background-color: var(--accent-blue);
            color: var(--text-white);
            font-weight: 500;
        }

        .form-control, .form-select {
            background-color: rgba(17, 34, 64, 0.8);
            border: 1px solid var(--border-color);
            color: var(--text-white);
            padding: 12px 16px;
            border-radius: 8px;
            font-size: 0.95rem;
        }

        .form-control:focus, .form-select:focus {
            background-color: rgba(17, 34, 64, 0.9);
            color: var(--text-white);
            border-color: var(--accent-blue);
            box-shadow: 0 0 0 2px rgba(59, 130, 246, 0.2);
        }

        .form-label {
            color: var(--text-white);
            font-weight: 500;
            margin-bottom: 8px;
        }

        .btn-primary {
            background-color: var(--accent-blue);
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
        }

        .status-badge {
            background-color: var(--accent-green);
            color: var(--text-white);
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .agent-profile {
            position: relative;
        }

        .agent-photo {
            width: 140px;
            height: 140px;
            border-radius: 12px;
            object-fit: cover;
            border: 3px solid var(--accent-blue);
        }

        .photo-upload {
            position: absolute;
            bottom: -10px;
            right: -10px;
            background: var(--accent-blue);
            border-radius: 50%;
            width: 32px;
            height: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .photo-upload:hover {
            transform: scale(1.1);
        }

        .switch {
            position: relative;
            display: inline-block;
            width: 52px;
            height: 26px;
        }

        .switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(203, 213, 225, 0.2);
            transition: .4s;
            border-radius: 26px;
        }

        .slider:before {
            position: absolute;
            content: "";
            height: 18px;
            width: 18px;
            left: 4px;
            bottom: 4px;
            background-color: white;
            transition: .4s;
            border-radius: 50%;
        }

        input:checked + .slider {
            background-color: var(--accent-blue);
        }

        input:checked + .slider:before {
            transform: translateX(26px);
        }

        .document-card {
            background: rgba(17, 34, 64, 0.5);
            border-radius: 8px;
            padding: 16px;
            margin-bottom: 12px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .document-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .document-icon {
            width: 40px;
            height: 40px;
            background: rgba(59, 130, 246, 0.1);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--accent-blue);
        }

        .timeline {
            position: relative;
            padding-left: 32px;
        }

        .timeline-item {
            position: relative;
            padding-bottom: 24px;
        }

        .timeline-item::before {
            content: '';
            position: absolute;
            left: -32px;
            top: 0;
            width: 2px;
            height: 100%;
            background-color: var(--border-color);
        }

        .timeline-item::after {
            content: '';
            position: absolute;
            left: -37px;
            top: 0;
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background-color: var(--accent-blue);
        }

        @media (max-width: 768px) {
            .container {
                padding: 12px;
            }

            .panel {
                padding: 16px;
                margin-bottom: 16px;
            }

            .agent-photo {
                width: 100px;
                height: 100px;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <!-- Header Panel -->
    <div class="panel">
        <div class="row align-items-center">
            <div class="col-md-8">
                <div class="d-flex gap-4 align-items-center">
                    <div class="agent-profile">
                        <img src="https://via.placeholder.com/140" alt="Agent" class="agent-photo">
                        <div class="photo-upload">
                            <i class="fas fa-camera text-white"></i>
                        </div>
                    </div>
                    <div>
                        <h3 class="text-white mb-2">Krishmal2004</h3>
                        <div class="text-muted mb-3">
                            <i class="far fa-clock me-2"></i>2025-03-21 19:53:31
                        </div>
                        <div class="d-flex gap-3">
                            <span class="status-badge">
                                <i class="fas fa-check-circle"></i>Active Agent
                            </span>
                            <span class="status-badge" style="background-color: var(--accent-yellow)">
                                <i class="fas fa-star"></i>Top Performer
                            </span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4 text-end">
                <button action="savechanges"class="btn btn-primary" id="saveSettings">
                    <i class="fas fa-save me-2"></i>Save Changes
                </button>
            </div>
        </div>
    </div>

    <div class="row">
        <!-- Navigation -->
        <div class="col-md-3">
            <div class="panel">
                <div class="nav flex-column nav-pills">
                    <a class="nav-link active" href="#profile" data-bs-toggle="pill">
                        <i class="fas fa-user"></i>Profile Information
                    </a>
                    <a class="nav-link" href="#preferences" data-bs-toggle="pill">
                        <i class="fas fa-cog"></i>Preferences
                    </a>
                    <a class="nav-link" href="#notifications" data-bs-toggle="pill">
                        <i class="fas fa-bell"></i>Notifications
                    </a>
                    <a class="nav-link" href="#security" data-bs-toggle="pill">
                        <i class="fas fa-shield-alt"></i>Security
                    </a>
                    <a class="nav-link" href="#documents" data-bs-toggle="pill">
                        <i class="fas fa-file-alt"></i>Documents
                    </a>
                    <a class="nav-link" href="#activity" data-bs-toggle="pill">
                        <i class="fas fa-history"></i>Activity Log
                    </a>
                </div>
            </div>
        </div>

        <!-- Content -->
        <div class="col-md-9">
            <div class="tab-content">
                <!-- Profile Information -->
                <div class="tab-pane fade show active" id="profile">
                    <div class="panel">
                        <h5 class="text-white mb-4">Personal Information</h5>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Full Name</label>
                                    <input type="text" class="form-control" value="Krishmal2004">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Email</label>
                                    <input type="email" class="form-control" value="krishmal@example.com">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Phone</label>
                                    <input type="tel" class="form-control" value="+94 123 456 789">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">License Number</label>
                                    <input type="text" class="form-control" value="REA-2025-1234">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Specialization</label>
                                    <select class="form-select">
                                        <option>Residential</option>
                                        <option>Commercial</option>
                                        <option>Luxury</option>
                                        <option>Investment</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Service Areas</label>
                                    <input type="text" class="form-control" value="Colombo, Kandy, Galle">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="panel">
                        <h5 class="text-white mb-4">Professional Details</h5>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Years of Experience</label>
                                    <input type="number" class="form-control" value="5">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Languages</label>
                                    <input type="text" class="form-control" value="English, Sinhala">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Professional Certifications</label>
                                    <textarea class="form-control" rows="3">Licensed Real Estate Agent
Certified Property Manager
Luxury Property Specialist</textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Preferences -->
                <div class="tab-pane fade" id="preferences">
                    <div class="panel">
                        <h5 class="text-white mb-4">System Preferences</h5>
                        <div class="mb-3">
                            <label class="form-label">Default View</label>
                            <select class="form-select">
                                <option>Grid View</option>
                                <option>List View</option>
                                <option>Map View</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Language</label>
                            <select class="form-select">
                                <option>English</option>
                                <option>Sinhala</option>
                                <option>Tamil</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Time Zone</label>
                            <select class="form-select">
                                <option>UTC (00:00)</option>
                                <option>Asia/Colombo (+05:30)</option>
                                <option>Europe/London (+00:00)</option>
                            </select>
                        </div>
                    </div>
                </div>

                <!-- Notifications -->
                <div class="tab-pane fade" id="notifications">
                    <div class="panel">
                        <h5 class="text-white mb-4">Notification Settings</h5>
                        <div class="mb-4">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <div>
                                    <h6 class="text-white mb-1">Email Notifications</h6>
                                    <small class="text-muted">Receive updates via email</small>
                                </div>
                                <label class="switch">
                                    <input type="checkbox" checked>
                                    <span class="slider"></span>
                                </label>
                            </div>
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <div>
                                    <h6 class="text-white mb-1">SMS Notifications</h6>
                                    <small class="text-muted">Receive updates via SMS</small>
                                </div>
                                <label class="switch">
                                    <input type="checkbox">
                                    <span class="slider"></span>
                                </label>
                            </div>
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="text-white mb-1">Property Updates</h6>
                                    <small class="text-muted">Get notified about property changes</small>
                                </div>
                                <label class="switch">
                                    <input type="checkbox" checked>
                                    <span class="slider"></span>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Security -->
                <div class="tab-pane fade" id="security">
                    <div class="panel">
                        <h5 class="text-white mb-4">Security Settings</h5>
                        <div class="mb-3">
                            <label class="form-label">Current Password</label>
                            <input type="password" class="form-control">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">New Password</label>
                            <input type="password" class="form-control">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Confirm New Password</label>
                            <input type="password" class="form-control">
                        </div>
                        <div class="mb-4">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="text-white mb-1">Two-Factor Authentication</h6>
                                    <small class="text-muted">Enable extra security</small>
                                </div>
                                <label class="switch">
                                    <input type="checkbox">
                                    <span class="slider"></span>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Documents -->
                <div class="tab-pane fade" id="documents">
                    <div class="panel">
                        <h5 class="text-white mb-4">Document Management</h5>
                        <div class="document-card">
                            <div class="document-info">
                                <div class="document-icon">
                                    <i class="fas fa-file-pdf"></i>
                                </div>
                                <div>
                                    <h6 class="text-white mb-1">License Certificate</h6>
                                    <small class="text-muted">PDF - 2.5 MB</small>
                                </div>
                            </div>
                            <button class="btn btn-primary btn-sm">
                                <i class="fas fa-download me-2"></i>Download
                            </button>
                        </div>
                        <div class="document-card">
                            <div class="document-info">
                                <div class="document-icon">
                                    <i class="fas fa-file-alt"></i>
                                </div>
                                <div>
                                    <h6 class="text-white mb-1">Agent Agreement</h6>
                                    <small class="text-muted">DOC - 1.8 MB</small>
                                </div>
                            </div>
                            <button class="btn btn-primary btn-sm">
                                <i class="fas fa-download me-2"></i>Download
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Activity Log -->
                <div class="tab-pane fade" id="activity">
                    <div class="panel">
                        <h5 class="text-white mb-4">Recent Activity</h5>
                        <div class="timeline">
                            <div class="timeline-item">
                                <h6 class="text-white mb-1">Profile Updated</h6>
                                <small class="text-muted">2025-03-21 19:53:31</small>
                                <p class="mb-0">Updated contact information and service areas</p>
                            </div>
                            <div class="timeline-item">
                                <h6 class="text-white mb-1">New Document Uploaded</h6>
                                <small class="text-muted">2025-03-21 18:30:00</small>
                                <p class="mb-0">Uploaded new license certificate</p>
                            </div>
                            <div class="timeline-item">
                                <h6 class="text-white mb-1">Password Changed</h6>
                                <small class="text-muted">2025-03-21 15:45:00</small>
                                <p class="mb-0">Security settings updated</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Save settings
    document.getElementById('saveSettings').addEventListener('click', function() {
        this.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Saving...';
        setTimeout(() => {
            this.innerHTML = '<i class="fas fa-save me-2"></i>Save Changes';
            alert('Settings saved successfully!');
        }, 1000);
    });

    // Tab switching
    document.querySelectorAll('.nav-link').forEach(link => {
        link.addEventListener('click', function() {
            document.querySelectorAll('.nav-link').forEach(l => l.classList.remove('active'));
            this.classList.add('active');
        });
    });

    // File upload handling
    document.querySelector('.photo-upload').addEventListener('click', function() {
        const input = document.createElement('input');
        input.type = 'file';
        input.accept = 'image/*';
        input.onchange = function(e) {
            const file = e.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.querySelector('.agent-photo').src = e.target.result;
                }
                reader.readAsDataURL(file);
            }
        }
        input.click();
    });
</script>

</body>
</html>