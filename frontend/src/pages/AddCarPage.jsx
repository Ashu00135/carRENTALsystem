import React, { useState } from 'react';
import { addCar } from '../utils/api';
import { Button, Alert, PageSection, FormGroup } from '../components';

export const AddCarPage = () => {
  const [formData, setFormData] = useState({
    id: '',
    make: '',
    model: '',
    year: '',
    color: '',
    licensePlate: ''
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
      newErrors.id = 'Please enter a valid Car ID (number)';
    }
    if (!formData.make || formData.make.trim() === '') {
      newErrors.make = 'Please enter car make';
    }
    if (!formData.model || formData.model.trim() === '') {
      newErrors.model = 'Please enter car model';
    }
    if (formData.year && isNaN(formData.year)) {
      newErrors.year = 'Year must be a number';
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
      await addCar(formData);
      
      setAlert({ type: 'success', message: 'Car added successfully!' });
      setFormData({
        id: '',
        make: '',
        model: '',
        year: '',
        color: '',
        licensePlate: ''
      });

      setTimeout(() => {
        window.location.href = '/cars';
      }, 1500);
    } catch (err) {
      setAlert({ type: 'danger', message: err.message });
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="container">
      <PageSection title="Add New Car" subtitle="Register a new vehicle in the rental system">
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
                label="Car ID"
                name="id"
                type="number"
                value={formData.id}
                onChange={handleChange}
                error={errors.id}
                required
                placeholder="e.g., 1, 2, 3"
              />
              <FormGroup
                label="Make"
                name="make"
                type="text"
                value={formData.make}
                onChange={handleChange}
                error={errors.make}
                required
                placeholder="e.g., Toyota, Honda, BMW"
              />
            </div>

            <div className="form-row">
              <FormGroup
                label="Model"
                name="model"
                type="text"
                value={formData.model}
                onChange={handleChange}
                error={errors.model}
                required
                placeholder="e.g., Corolla, Civic, X5"
              />
              <FormGroup
                label="Year"
                name="year"
                type="number"
                value={formData.year}
                onChange={handleChange}
                error={errors.year}
                placeholder="e.g., 2023"
              />
            </div>

            <div className="form-row">
              <FormGroup
                label="Color"
                name="color"
                type="text"
                value={formData.color}
                onChange={handleChange}
                placeholder="e.g., Red, Blue, Black"
              />
              <FormGroup
                label="License Plate"
                name="licensePlate"
                type="text"
                value={formData.licensePlate}
                onChange={handleChange}
                placeholder="e.g., ABC-1234"
              />
            </div>

            <div style={{ display: 'flex', gap: '10px', marginTop: '30px' }}>
              <Button
                variant="success"
                size="lg"
                loading={loading}
                disabled={loading}
                type="submit"
                style={{ flex: 1 }}
              >
                Add Car
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
          <h3>Car Registration Tips:</h3>
          <ul style={{ lineHeight: '1.8' }}>
            <li>Each car must have a unique ID</li>
            <li>Make and Model are required fields</li>
            <li>Year should be between 1990 and current year</li>
            <li>Color and License Plate are optional</li>
            <li>New cars are added as "Available" by default</li>
          </ul>
        </div>
      </PageSection>
    </div>
  );
};
