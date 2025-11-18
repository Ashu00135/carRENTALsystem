import React, { useState } from 'react';
import { addUser } from '../utils/api';
import { Button, Alert, PageSection, FormGroup } from '../components';

export const AddUserPage = () => {
  const [formData, setFormData] = useState({
    id: '',
    name: '',
    email: '',
    phone: '',
    driverLicense: ''
  });

  const [loading, setLoading] = useState(false);
  const [alert, setAlert] = useState(null);
  const [errors, setErrors] = useState({});

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: value
    }));
    // Clear error for this field
    if (errors[name]) {
      setErrors(prev => ({
        ...prev,
        [name]: ''
      }));
    }
  };

  const validateForm = () => {
    const newErrors = {};

    if (!formData.id || isNaN(formData.id)) {
      newErrors.id = 'Please enter a valid User ID (number)';
    }
    if (!formData.name || formData.name.trim() === '') {
      newErrors.name = 'Please enter full name';
    }
    if (formData.email && !formData.email.match(/^[^\s@]+@[^\s@]+\.[^\s@]+$/)) {
      newErrors.email = 'Please enter a valid email address';
    }
    if (formData.phone && !formData.phone.match(/^[0-9\-\+\(\)\s]+$/)) {
      newErrors.phone = 'Please enter a valid phone number';
    }

    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    if (!validateForm()) {
      setAlert({ type: 'danger', message: 'Please fix the errors above' });
      return;
    }

    try {
      setLoading(true);
      await addUser(formData);
      
      setAlert({ type: 'success', message: 'User registered successfully!' });
      setFormData({
        id: '',
        name: '',
        email: '',
        phone: '',
        driverLicense: ''
      });

      setTimeout(() => {
        window.location.href = '/';
      }, 1500);
    } catch (err) {
      setAlert({ type: 'danger', message: err.message });
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="container">
      <PageSection title="Register New User" subtitle="Create a new customer account">
        {alert && (
          <Alert 
            type={alert.type} 
            message={alert.message}
            onClose={() => setAlert(null)}
          />
        )}

        <div style={{ maxWidth: '600px', margin: '0 auto' }}>
          <form onSubmit={handleSubmit} className="card">
            <div className="form-row">
              <FormGroup
                label="User ID"
                name="id"
                type="number"
                value={formData.id}
                onChange={handleChange}
                error={errors.id}
                required
                placeholder="e.g., 1, 2, 3"
              />
              <FormGroup
                label="Full Name"
                name="name"
                type="text"
                value={formData.name}
                onChange={handleChange}
                error={errors.name}
                required
                placeholder="e.g., John Doe"
              />
            </div>

            <div className="form-row">
              <FormGroup
                label="Email"
                name="email"
                type="email"
                value={formData.email}
                onChange={handleChange}
                error={errors.email}
                placeholder="e.g., john@example.com"
              />
              <FormGroup
                label="Phone"
                name="phone"
                type="tel"
                value={formData.phone}
                onChange={handleChange}
                error={errors.phone}
                placeholder="e.g., +1 (555) 123-4567"
              />
            </div>

            <FormGroup
              label="Driver's License Number"
              name="driverLicense"
              type="text"
              value={formData.driverLicense}
              onChange={handleChange}
              placeholder="e.g., DL123456"
            />

            <div style={{ display: 'flex', gap: '10px', marginTop: '30px' }}>
              <Button
                variant="success"
                size="lg"
                loading={loading}
                disabled={loading}
                type="submit"
                style={{ flex: 1 }}
              >
                Register User
              </Button>
              <Button
                variant="secondary"
                size="lg"
                onClick={() => window.history.back()}
                disabled={loading}
              >
                Cancel
              </Button>
            </div>
          </form>
        </div>

        <div style={{ marginTop: '40px' }}>
          <h3>Registration Requirements:</h3>
          <ul style={{ lineHeight: '1.8' }}>
            <li>Each user must have a unique ID</li>
            <li>Full Name is required</li>
            <li>Email must be in valid format (optional)</li>
            <li>Phone number format is flexible (optional)</li>
            <li>Driver's License Number is optional but recommended</li>
            <li>All users can immediately rent available cars</li>
          </ul>
        </div>
      </PageSection>
    </div>
  );
};
