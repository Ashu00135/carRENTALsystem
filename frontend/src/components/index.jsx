import React, { useState } from 'react';
import '../styles/global.css';

export const Header = ({ onMenuToggle }) => {
  const [menuOpen, setMenuOpen] = useState(false);

  const toggleMenu = () => {
    setMenuOpen(!menuOpen);
    onMenuToggle?.(!menuOpen);
  };

  return (
    <header>
      <div className="header-container">
        <div className="logo">
          🚗 Car Rental System
        </div>
        <button className="mobile-menu-btn" onClick={toggleMenu}>
          ☰
        </button>
      </div>
    </header>
  );
};

export const Navigation = ({ isOpen }) => {
  return (
    <nav className={`nav-menu ${isOpen ? 'active' : ''}`}>
      <a href="/">🏠 Home</a>
      <a href="/cars">🚙 Browse Cars</a>
      <a href="/rent">🔑 Rent a Car</a>
      <a href="/rentals">📋 My Rentals</a>
      <a href="/add-car">➕ Add Car</a>
      <a href="/add-user">👤 Register User</a>
    </nav>
  );
};

export const Button = ({ 
  children, 
  variant = 'primary', 
  size = 'md', 
  block = false,
  loading = false,
  disabled = false,
  onClick,
  ...props 
}) => {
  const sizeClass = {
    sm: 'btn-sm',
    md: '',
    lg: 'btn-lg'
  }[size];

  return (
    <button
      className={`btn btn-${variant} ${sizeClass} ${block ? 'btn-block' : ''}`}
      onClick={onClick}
      disabled={disabled || loading}
      {...props}
    >
      {loading && <span className="loading"></span>}
      {children}
    </button>
  );
};

export const Alert = ({ 
  type = 'info', 
  message, 
  onClose,
  autoClose = 3000 
}) => {
  React.useEffect(() => {
    if (autoClose && onClose) {
      const timer = setTimeout(onClose, autoClose);
      return () => clearTimeout(timer);
    }
  }, [autoClose, onClose]);

  const icons = {
    success: '✓',
    danger: '✕',
    warning: '⚠',
    info: 'ℹ'
  };

  return (
    <div className={`alert alert-${type}`}>
      <span>{icons[type]}</span>
      <span>{message}</span>
    </div>
  );
};

export const Card = ({ children, hoverable = true, onClick }) => {
  return (
    <div className={`card ${hoverable ? '' : ''}`} onClick={onClick}>
      {children}
    </div>
  );
};

export const CarCard = ({ car, onAction, actionLabel = 'View' }) => {
  const { getCarImage } = require('../utils/carImages');
  
  return (
    <Card>
      <img 
        src={getCarImage(car.make, car.model)} 
        alt={`${car.make} ${car.model}`}
        className="card-image"
        onError={(e) => {
          e.target.style.display = 'none';
          e.target.nextSibling && (e.target.nextSibling.style.display = 'flex');
        }}
      />
      <div style={{ display: 'none', alignItems: 'center', justifyContent: 'center', fontSize: '48px' }}>
        🚗
      </div>
      <div className="card-title">{car.make} {car.model}</div>
      <div className="card-text">
        <div><strong>ID:</strong> {car.id}</div>
        <div><strong>Status:</strong> 
          <span className={`badge ${car.available ? 'badge-success' : 'badge-danger'}`}>
            {car.available ? 'Available' : 'Rented'}
          </span>
        </div>
      </div>
      <Button 
        variant={car.available ? 'primary' : 'secondary'}
        size="sm"
        block
        onClick={onAction}
        disabled={!car.available}
      >
        {actionLabel}
      </Button>
    </Card>
  );
};

export const Loading = ({ message = 'Loading...' }) => {
  return (
    <div className="loading-container">
      <div>
        <div className="loading"></div>
        <p style={{ marginTop: '15px' }}>{message}</p>
      </div>
    </div>
  );
};

export const FormGroup = ({ 
  label, 
  name, 
  type = 'text',
  value,
  onChange,
  error,
  required = false,
  placeholder,
  options = [],
  ...props
}) => {
  const isSelect = type === 'select';
  const isTextarea = type === 'textarea';
  const inputType = type !== 'select' && type !== 'textarea' ? type : 'text';

  return (
    <div className="form-group">
      {label && (
        <label htmlFor={name}>
          {label} {required && <span style={{ color: 'red' }}>*</span>}
        </label>
      )}
      {isSelect ? (
        <select
          id={name}
          name={name}
          value={value}
          onChange={onChange}
          className={error ? 'error-input' : ''}
          required={required}
          {...props}
        >
          <option value="">Select {label}</option>
          {options.map((option) => (
            <option key={option.value} value={option.value}>
              {option.label}
            </option>
          ))}
        </select>
      ) : isTextarea ? (
        <textarea
          id={name}
          name={name}
          value={value}
          onChange={onChange}
          className={error ? 'error-input' : ''}
          placeholder={placeholder}
          required={required}
          {...props}
        />
      ) : (
        <input
          id={name}
          name={name}
          type={inputType}
          value={value}
          onChange={onChange}
          className={error ? 'error-input' : ''}
          placeholder={placeholder}
          required={required}
          {...props}
        />
      )}
      {error && <span className="error-message">{error}</span>}
    </div>
  );
};

export const Hero = ({ title, subtitle, children }) => {
  return (
    <div className="hero">
      <h1>{title}</h1>
      {subtitle && <p>{subtitle}</p>}
      {children}
    </div>
  );
};

export const PageSection = ({ title, subtitle, children }) => {
  return (
    <div className="page-section">
      {title && <h2 className="section-title">{title}</h2>}
      {subtitle && <p className="section-subtitle">{subtitle}</p>}
      {children}
    </div>
  );
};

export const Table = ({ headers, rows, actions }) => {
  return (
    <div className="table-responsive">
      <table>
        <thead>
          <tr>
            {headers.map((header) => (
              <th key={header}>{header}</th>
            ))}
            {actions && <th>Actions</th>}
          </tr>
        </thead>
        <tbody>
          {rows.map((row, index) => (
            <tr key={index}>
              {headers.map((header) => (
                <td key={header}>{row[header]}</td>
              ))}
              {actions && (
                <td>
                  <div className="action-buttons">
                    {actions(row).map((action, i) => (
                      <Button
                        key={i}
                        variant={action.variant || 'primary'}
                        size="sm"
                        onClick={() => action.onClick(row)}
                      >
                        {action.label}
                      </Button>
                    ))}
                  </div>
                </td>
              )}
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export const Badge = ({ type = 'info', children }) => {
  return <span className={`badge badge-${type}`}>{children}</span>;
};
