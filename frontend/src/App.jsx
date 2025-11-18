import React from 'react';
import { BrowserRouter as Router, Routes, Route, useNavigate } from 'react-router-dom';
import { useState } from 'react';
import './styles/global.css';

// Components
import { Header, Navigation } from './components';

// Pages
import { HomePage } from './pages/HomePage';
import { CarsPage } from './pages/CarsPage';
import { RentPage } from './pages/RentPage';
import { RentalsPage } from './pages/RentalsPage';
import { AddCarPage } from './pages/AddCarPage';
import { AddUserPage } from './pages/AddUserPage';

function App() {
  const [menuOpen, setMenuOpen] = useState(false);
  const navigate = useNavigate();

  const handleMenuToggle = (isOpen) => {
    setMenuOpen(isOpen);
  };

  const handleRentCar = (car) => {
    // Navigate to rent page and close menu
    setMenuOpen(false);
    navigate('/rent');
  };

  return (
    <div>
      <Header onMenuToggle={handleMenuToggle} />
      <Navigation isOpen={menuOpen} />
      
      <main style={{ minHeight: 'calc(100vh - 100px)' }}>
        <Routes>
          <Route path="/" element={<HomePage />} />
          <Route path="/cars" element={<CarsPage onRentClick={handleRentCar} />} />
          <Route path="/rent" element={<RentPage />} />
          <Route path="/rentals" element={<RentalsPage />} />
          <Route path="/add-car" element={<AddCarPage />} />
          <Route path="/add-user" element={<AddUserPage />} />
          <Route path="*" element={
            <div className="container" style={{ padding: '40px 20px', textAlign: 'center' }}>
              <h2>Page Not Found</h2>
              <p>The page you're looking for doesn't exist.</p>
              <button className="btn btn-primary" onClick={() => navigate('/')}>
                Go Home
              </button>
            </div>
          } />
        </Routes>
      </main>

      <footer style={{
        backgroundColor: '#f5f5f5',
        borderTop: '1px solid #ddd',
        padding: '20px',
        textAlign: 'center',
        color: '#666',
        marginTop: '40px'
      }}>
        <p>&copy; 2025 Car Rental System. All rights reserved.</p>
        <p style={{ fontSize: '12px', marginTop: '10px' }}>
          Backend: <a href="http://localhost:8080" target="_blank" rel="noopener noreferrer">http://localhost:8080</a>
        </p>
      </footer>
    </div>
  );
}

function AppWithRouter() {
  return (
    <Router>
      <App />
    </Router>
  );
}

export default AppWithRouter;
