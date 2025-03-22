document.addEventListener('DOMContentLoaded', function() {
    // Navigation active state
    const navLinks = document.querySelectorAll('.nav-links li');
    navLinks.forEach(link => {
        link.addEventListener('click', function() {
            navLinks.forEach(item => item.classList.remove('active'));
            this.classList.add('active');
        });
    });
    
    // Property action buttons (Edit and Delete)
    const deleteButtons = document.querySelectorAll('.delete-btn');
    deleteButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            e.preventDefault();
            const propertyCard = this.closest('.property-card');
            if (confirm('Are you sure you want to remove this property?')) {
                propertyCard.style.opacity = '0';
                setTimeout(() => {
                    propertyCard.style.display = 'none';
                }, 300);
            }
        });
    });
    
    // Appointment action buttons
    const appointmentDeleteButtons = document.querySelectorAll('.appointment-actions .delete-btn');
    appointmentDeleteButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            e.preventDefault();
            const appointmentCard = this.closest('.appointment-card');
            if (confirm('Are you sure you want to cancel this appointment?')) {
                appointmentCard.style.opacity = '0';
                setTimeout(() => {
                    appointmentCard.style.display = 'none';
                }, 300);
            }
        });
    });
    
    // Add Property Button
    const addPropertyBtn = document.querySelector('.add-property-btn');
    addPropertyBtn.addEventListener('click', function() {
		window.location.href = 'addProperty.jsp';
        // Placeholder for Add Property functionality
        alert('Add Property Form will open here');
		
        // In a real application, this would open a modal or redirect to a form page
    });
    
    // Notifications and Messages Click
    const notifications = document.querySelector('.notifications');
    const messages = document.querySelector('.messages');
    
    notifications.addEventListener('click', function() {
        alert('Notifications panel will open here');
    });
    
    messages.addEventListener('click', function() {
        alert('Messages panel will open here');
    });
	
    
    // Search functionality
    const searchInput = document.querySelector('.search input');
    searchInput.addEventListener('keyup', function(e) {
        if (e.key === 'Enter') {
            alert(`Searching for: ${this.value}`);
            this.value = '';
        }
    });
    
    // Simple animation on page load
    document.querySelectorAll('.stat-card').forEach((card, index) => {
        setTimeout(() => {
            card.style.opacity = '1';
            card.style.transform = 'translateY(0)';
        }, 100 * index);
    });
});

// Initial animations
document.addEventListener('DOMContentLoaded', function() {
    const statCards = document.querySelectorAll('.stat-card');
    const propertyCards = document.querySelectorAll('.property-card');
    
    // Apply initial styles for animation
    statCards.forEach(card => {
        card.style.opacity = '0';
        card.style.transform = 'translateY(20px)';
        card.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
    });
    
    propertyCards.forEach(card => {
        card.style.opacity = '0';
        card.style.transform = 'translateY(20px)';
        card.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
    });
    
    // Animate in after a short delay
    setTimeout(() => {
        statCards.forEach((card, index) => {
            setTimeout(() => {
                card.style.opacity = '1';
                card.style.transform = 'translateY(0)';
            }, 100 * index);
        });
        
        setTimeout(() => {
            propertyCards.forEach((card, index) => {
                setTimeout(() => {
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, 100 * index);
            });
        }, 300);
    }, 300);
});

// Add this to your existing script.js file

// Update the agent info with the user's login ID
document.addEventListener('DOMContentLoaded', function() {
  
    // Update agent info with login ID
    const agentInfoSection = document.querySelector('.info');
    const loginIdElement = document.createElement('span');
    loginIdElement.classList.add('login-id');
    loginIdElement.style.fontSize = '0.7rem';
    loginIdElement.style.color = 'var(--accent-color)';
    loginIdElement.style.display = 'block';
    loginIdElement.style.marginTop = '0.2rem';
    loginIdElement.innerHTML = '<i class="fas fa-id-badge"></i> ID: IT24102083';
    agentInfoSection.appendChild(loginIdElement);
    
    // Real-time clock update function
    function updateDateTime() {
        const now = new Date();
        const year = now.getUTCFullYear();
        const month = String(now.getUTCMonth() + 1).padStart(2, '0');
        const day = String(now.getUTCDate()).padStart(2, '0');
        const hours = String(now.getUTCHours()).padStart(2, '0');
        const minutes = String(now.getUTCMinutes()).padStart(2, '0');
        const seconds = String(now.getUTCSeconds()).padStart(2, '0');
        
        const formattedDateTime = `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
        document.getElementById('current-datetime').textContent = formattedDateTime;
    }
    
    // Update time immediately and then every second
    updateDateTime();
    setInterval(updateDateTime, 1000);
    
    
});