import React from 'react';
import { Link } from 'react-router-dom';
import { Hero, Button, PageSection } from '../components';

export const HomePage = () => {
  return (
    <div>
      <Hero
        title="Welcome to Car Rental System"
        subtitle="Find and rent your perfect car today!"
      >
        <Link to="/cars">
          <Button variant="success" size="lg">
            Browse Available Cars
          </Button>
        </Link>
      </Hero>

      <div className="container">
        <PageSection title="Quick Actions">
          <div className="grid-container">
            <div className="card">
              <div style={{ fontSize: '48px', marginBottom: '15px' }}>🚙</div>
              <h3 className="card-title">Browse Cars</h3>
              <p className="card-text">
                View all available cars in our fleet with detailed information.
              </p>
              <Link to="/cars">
                <Button variant="primary" block>
                  View Cars
                </Button>
              </Link>
            </div>

            <div className="card">
              <div style={{ fontSize: '48px', marginBottom: '15px' }}>🔑</div>
              <h3 className="card-title">Rent a Car</h3>
              <p className="card-text">
                Select a user and car to start your rental today.
              </p>
              <Link to="/rent">
                <Button variant="primary" block>
                  Rent Now
                </Button>
              </Link>
            </div>

            <div className="card">
              <div style={{ fontSize: '48px', marginBottom: '15px' }}>📋</div>
              <h3 className="card-title">My Rentals</h3>
              <p className="card-text">
                Check your active and past rental records.
              </p>
              <Link to="/rentals">
                <Button variant="primary" block>
                  View Rentals
                </Button>
              </Link>
            </div>

            <div className="card">
              <div style={{ fontSize: '48px', marginBottom: '15px' }}>➕</div>
              <h3 className="card-title">Add New Car</h3>
              <p className="card-text">
                Add a new vehicle to our rental fleet.
              </p>
              <Link to="/add-car">
                <Button variant="primary" block>
                  Add Car
                </Button>
              </Link>
            </div>

            <div className="card">
              <div style={{ fontSize: '48px', marginBottom: '15px' }}>👤</div>
              <h3 className="card-title">Register User</h3>
              <p className="card-text">
                Create a new user account for car rentals.
              </p>
              <Link to="/add-user">
                <Button variant="primary" block>
                  Register
                </Button>
              </Link>
            </div>

            <div className="card">
              <div style={{ fontSize: '48px', marginBottom: '15px' }}>🗄️</div>
              <h3 className="card-title">Database Console</h3>
              <p className="card-text">
                Access the H2 database console for admin tasks.
              </p>
              <a href="http://localhost:8080/h2-console" target="_blank" rel="noopener noreferrer">
                <Button variant="secondary" block>
                  Open Console
                </Button>
              </a>
            </div>
          </div>
        </PageSection>

        <PageSection title="How It Works" subtitle="Simple 3-step process to rent a car">
          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(250px, 1fr))', gap: '30px' }}>
            <div style={{ textAlign: 'center' }}>
              <div style={{ fontSize: '48px', marginBottom: '15px' }}>1️⃣</div>
              <h3>Register or Login</h3>
              <p>Create a user account or use an existing one to get started.</p>
            </div>
            <div style={{ textAlign: 'center' }}>
              <div style={{ fontSize: '48px', marginBottom: '15px' }}>2️⃣</div>
              <h3>Browse & Select</h3>
              <p>Browse our available cars and select the one you need.</p>
            </div>
            <div style={{ textAlign: 'center' }}>
              <div style={{ fontSize: '48px', marginBottom: '15px' }}>3️⃣</div>
              <h3>Complete Rental</h3>
              <p>Complete your rental and enjoy your car!</p>
            </div>
          </div>
        </PageSection>
      </div>
    </div>
  );
};
