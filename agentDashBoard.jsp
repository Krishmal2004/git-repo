<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Real Estate Agent Dashboard</title>
    <link rel="stylesheet" href="style.css" />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
    />
  </head>
  <body>
    <div class="dashboard">
      <!-- Sidebar -->
      <div class="sidebar">
        <div class="logo">
          <i class="fas fa-home"></i>
          <h2>RealEstate Pro</h2>
        </div>
        <ul class="nav-links">
          <li class="active">
            <a href="agentDashBoard.jsp"
              ><i class="fas fa-tachometer-alt"></i>Dashboard</a
            >
          </li>
          <li>
            <a href="agentPropertiesShow.jsp"><i class="fas fa-building"></i>Properties</a>
          </li>
          <li>
            <a href="#clients"><i class="fas fa-users"></i>Clients</a>
          </li>
          <li>
            <a href="appointmentsViewAll.jsp"
              ><i class="fas fa-calendar-check"></i>Appointments</a
            >
          </li>
          <li>
            <a href="https://www.bbc.com/news/us-canada"><i class="fas fa-newspaper"></i>News</a>
          </li>
          <li>
            <a href="agentDashBoardSetting.jsp"><i class="fas fa-cog"></i>Profile Settings</a>
          </li>
        </ul>
        <div class="logout">
          <a href="agentLogOut.jsp"><i class="fas fa-sign-out-alt"></i>Logout</a>
        </div>
        <div class="agent-info">
          <div class="avatar">
            <img
              src="https://randomuser.me/api/portraits/men/41.jpg"
              alt="Agent Profile"
            />
          </div>
          <div class="info">
            <h4>John Smith</h4>
            <p>Senior Real Estate Agent</p>
          </div>
        </div>
      </div>

      <!-- Main Content -->
      <div class="main-content">
        <div class="header">
          <div class="title">
            <h1>Dashboard</h1>
            <p>Welcome back, John!</p>
          </div>
          <div class="actions">
            <div class="search">
              <input type="text" placeholder="Search..." />
              <i class="fas fa-search"></i>
            </div>
            <div class="notifications">
              <i class="fas fa-bell"></i>
              <span class="badge">3</span>
            </div>
            <div class="messages">
              <i class="fas fa-envelope"></i>
              <span class="badge">5</span>
            </div>
          </div>
        </div>

        <!-- Statistics Cards -->
        <div class="stats-container">
          <div class="stat-card">
            <div class="stat-value">
              <h3>142</h3>
              <p>Total Properties</p>
            </div>
            <div class="stat-icon">
              <i class="fas fa-home"></i>
            </div>
          </div>
          <div class="stat-card">
            <div class="stat-value">
              <h3>87</h3>
              <p>Active Clients</p>
            </div>
            <div class="stat-icon">
              <i class="fas fa-user"></i>
            </div>
          </div>
          <div class="stat-card">
            <div class="stat-value">
              <h3>15</h3>
              <p>Appointments Today</p>
            </div>
            <div class="stat-icon">
              <i class="fas fa-calendar"></i>
            </div>
          </div>
          <div class="stat-card">
            <div class="stat-value">
              <h3>24</h3>
              <p>New Property Views</p>
            </div>
            <div class="stat-icon">
              <i class="fas fa-eye"></i>
            </div>
          </div>
        </div>

        <!-- Add Property Button -->
        <div class="add-property-section">
          <button class="add-property-btn">
            <i class="fas fa-plus"></i> Add New Property
          </button>
        </div>

        <!-- Main Sections -->
        <div class="sections-container">
          <!-- Recent Properties Section -->
          <div class="section recent-properties">
            <div class="section-header">
              <h2>Recent Properties</h2>
              <a href="agentPropertiesShow.jsp" class="view-all">View All</a>
            </div>
            <div class="property-list">
              <div class="property-card">
                <div class="property-img">
                  <img
                    src="https://images.unsplash.com/photo-1564013799919-ab600027ffc6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fGhvdXNlfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60"
                    alt="Property"
                  />
                  <span class="status for-sale">For Sale</span>
                </div>
                <div class="property-info">
                  <h3>Modern Villa in Beverly Hills</h3>
                  <p class="location">
                    <i class="fas fa-map-marker-alt"></i> Beverly Hills, CA
                  </p>
                  <p class="price">$1,250,000</p>
                  <div class="property-features">
                    <span><i class="fas fa-bed"></i> 4 beds</span>
                    <span><i class="fas fa-bath"></i> 3 baths</span>
                    <span
                      ><i class="fas fa-ruler-combined"></i> 2,800 sqft</span
                    >
                  </div>
                  <div class="property-actions">
                    <button class="edit-btn">
                      <i class="fas fa-edit"></i> Edit
                    </button>
                    <button class="delete-btn">
                      <i class="fas fa-trash"></i> Remove
                    </button>
                  </div>
                </div>
              </div>

              <div class="property-card">
                <div class="property-img">
                  <img
                    src="https://images.unsplash.com/photo-1570129477492-45c003edd2be?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8aG91c2V8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60"
                    alt="Property"
                  />
                  <span class="status for-rent">For Rent</span>
                </div>
                <div class="property-info">
                  <h3>Downtown Luxury Apartment</h3>
                  <p class="location">
                    <i class="fas fa-map-marker-alt"></i> Downtown, NY
                  </p>
                  <p class="price">$3,500/mo</p>
                  <div class="property-features">
                    <span><i class="fas fa-bed"></i> 2 beds</span>
                    <span><i class="fas fa-bath"></i> 2 baths</span>
                    <span
                      ><i class="fas fa-ruler-combined"></i> 1,200 sqft</span
                    >
                  </div>
                  <div class="property-actions">
                    <button class="edit-btn">
                      <i class="fas fa-edit"></i> Edit
                    </button>
                    <button class="delete-btn">
                      <i class="fas fa-trash"></i> Remove
                    </button>
                  </div>
                </div>
              </div>

              <div class="property-card">
                <div class="property-img">
                  <img
                    src="https://images.unsplash.com/photo-1582063289852-62e3ba2747f8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fGhvdXNlfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60"
                    alt="Property"
                  />
                  <span class="status for-sale">For Sale</span>
                </div>
                <div class="property-info">
                  <h3>Coastal View Home</h3>
                  <p class="location">
                    <i class="fas fa-map-marker-alt"></i> Malibu, CA
                  </p>
                  <p class="price">$3,750,000</p>
                  <div class="property-features">
                    <span><i class="fas fa-bed"></i> 5 beds</span>
                    <span><i class="fas fa-bath"></i> 4 baths</span>
                    <span
                      ><i class="fas fa-ruler-combined"></i> 4,200 sqft</span
                    >
                  </div>
                  <div class="property-actions">
                    <button class="edit-btn">
                      <i class="fas fa-edit"></i> Edit
                    </button>
                    <button class="delete-btn">
                      <i class="fas fa-trash"></i> Remove
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Appointments Section - More User Friendly -->
          <div class="section appointments">
            <div class="section-header">
              <h2>Today's Appointments</h2>
              <a href="appointmentsViewAll.jsp" class="view-all">View All</a>
            </div>
            <div class="appointments-list">
              <div class="appointment-card">
                <div class="appointment-time">
                  <h4>10:00 AM</h4>
                  <p>1 hour duration</p>
                </div>
                <div class="appointment-details">
                  <h3>Property Viewing with Emily Johnson</h3>
                  <p><i class="fas fa-map-marker-alt"></i> 123 Sunset Blvd</p>
                </div>
                <div class="appointment-actions">
                  <button class="edit-btn"><i class="fas fa-edit"></i></button>
                  <button class="delete-btn">
                    <i class="fas fa-trash"></i>
                  </button>
                </div>
              </div>

              <div class="appointment-card">
                <div class="appointment-time">
                  <h4>1:30 PM</h4>
                  <p>45 minutes duration</p>
                </div>
                <div class="appointment-details">
                  <h3>Contract Signing with Michael Brown</h3>
                  <p><i class="fas fa-map-marker-alt"></i> Office</p>
                </div>
                <div class="appointment-actions">
                  <button class="edit-btn"><i class="fas fa-edit"></i></button>
                  <button class="delete-btn">
                    <i class="fas fa-trash"></i>
                  </button>
                </div>
              </div>

              <div class="appointment-card">
                <div class="appointment-time">
                  <h4>4:00 PM</h4>
                  <p>1.5 hours duration</p>
                </div>
                <div class="appointment-details">
                  <h3>Home Inspection with Taylor Family</h3>
                  <p><i class="fas fa-map-marker-alt"></i> 456 Oak Lane</p>
                </div>
                <div class="appointment-actions">
                  <button class="edit-btn"><i class="fas fa-edit"></i></button>
                  <button class="delete-btn">
                    <i class="fas fa-trash"></i>
                  </button>
                </div>
              </div>

              <div class="appointment-card">
                <div class="appointment-time">
                  <h4>5:30 PM</h4>
                  <p>1 hour duration</p>
                </div>
                <div class="appointment-details">
                  <h3>Virtual Tour with Robert Davis</h3>
                  <p><i class="fas fa-map-marker-alt"></i> Remote (Zoom)</p>
                </div>
                <div class="appointment-actions">
                  <button class="edit-btn"><i class="fas fa-edit"></i></button>
                  <button class="delete-btn">
                    <i class="fas fa-trash"></i>
                  </button>
                </div>
              </div>
            </div>
          </div>

          <!-- Client Reviews Section - Moved to bottom -->
          <div class="section client-reviews">
            <div class="section-header">
              <h2>Client Reviews & Ratings</h2>
              <a href="#" class="view-all">View All</a>
            </div>
            <div class="reviews-list">
              <div class="review-card">
                <div class="review-header">
                  <img
                    src="https://randomuser.me/api/portraits/women/65.jpg"
                    alt="Client"
                  />
                  <div>
                    <h4>Sarah Thompson</h4>
                    <div class="rating">
                      <i class="fas fa-star"></i>
                      <i class="fas fa-star"></i>
                      <i class="fas fa-star"></i>
                      <i class="fas fa-star"></i>
                      <i class="fas fa-star"></i>
                    </div>
                  </div>
                </div>
                <p class="review-text">
                  John was amazing throughout the entire home buying process.
                  His knowledge of the market helped us secure our dream home!
                </p>
                <p class="review-date">March 15, 2025</p>
              </div>

              <div class="review-card">
                <div class="review-header">
                  <img
                    src="https://randomuser.me/api/portraits/men/32.jpg"
                    alt="Client"
                  />
                  <div>
                    <h4>Robert Davis</h4>
                    <div class="rating">
                      <i class="fas fa-star"></i>
                      <i class="fas fa-star"></i>
                      <i class="fas fa-star"></i>
                      <i class="fas fa-star"></i>
                      <i class="far fa-star"></i>
                    </div>
                  </div>
                </div>
                <p class="review-text">
                  Professional service from start to finish. Sold our property
                  above asking price within just two weeks.
                </p>
                <p class="review-date">March 10, 2025</p>
              </div>

              <div class="review-card">
                <div class="review-header">
                  <img
                    src="https://randomuser.me/api/portraits/women/42.jpg"
                    alt="Client"
                  />
                  <div>
                    <h4>Jennifer Wilson</h4>
                    <div class="rating">
                      <i class="fas fa-star"></i>
                      <i class="fas fa-star"></i>
                      <i class="fas fa-star"></i>
                      <i class="fas fa-star"></i>
                      <i class="fas fa-star-half-alt"></i>
                    </div>
                  </div>
                </div>
                <p class="review-text">
                  I was nervous about buying my first property, but John guided
                  me through every step with patience and expertise.
                </p>
                <p class="review-date">March 5, 2025</p>
              </div>
            </div>
          </div>

          <!-- Right Side Sections -->
          <div class="right-sections">
            <!-- Market News Section -->
            <div class="section market-news"> 
              <div class="section-header">
                <h2>Real Estate News</h2>
                <a href="https://www.bbc.com/news/us-canada" class="view-all">More News</a>
              </div>
              <div class="news-list">
                <div class="news-card">
                  <h4>Interest Rates Expected to Decrease in Q2</h4>
                  <p>
                    Experts predict favorable conditions for buyers as rates may
                    drop by up to 0.5%.
                  </p>
                  <span class="news-date">March 20, 2025</span>
                </div>
                <div class="news-card">
                  <h4>New Tax Benefits for First-time Home Buyers</h4>
                  <p>
                    Government introduces new incentives to help first-time
                    buyers enter the market.
                  </p>
                  <span class="news-date">March 18, 2025</span>
                </div>
              </div> 
            </div>
          </div>
        </div>
      </div>
    </div>

    <script src="script.js"></script>
  </body>
</html>