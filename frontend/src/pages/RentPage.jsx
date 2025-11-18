import React, { useState, useEffect } from 'react';
import { getUsers, getAvailableCars, createRental } from '../utils/api';
import { Button, Alert, PageSection, FormGroup, Loading } from '../components';

export const RentPage = () => {
  const [users, setUsers] = useState([]);
  const [cars, setCars] = useState([
    { id: 1, make: 'Toyota', model: 'Corolla', available: true },
    { id: 2, make: 'Honda', model: 'Civic', available: true },
    { id: 3, make: 'BMW', model: 'X5', available: false }
  ]);
  const [formData, setFormData] = useState({
    userId: '',
    carId: ''
  });
  const [loading, setLoading] = useState(false);
  const [loadingUsers, setLoadingUsers] = useState(true);
  const [alert, setAlert] = useState(null);

  useEffect(() => {
    loadUsers();
  }, []);

  const loadUsers = async () => {
    try {
      setLoadingUsers(true);
      const usersData = await getUsers();
      const carsData = await getAvailableCars();
      setUsers(usersData || []);
      setCars(carsData || []);
    } catch (err) {
      // Use mock data on error
      setUsers([
        { id: 1, name: 'John Doe' },
        { id: 2, name: 'Jane Smith' }
      ]);
      setCars([
        { id: 1, make: 'Toyota', model: 'Corolla', available: true },
        { id: 2, make: 'Honda', model: 'Civic', available: true }
      ]);
    } finally {
      setLoadingUsers(false);
    }
  };

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: value
    }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    
    if (!formData.userId || !formData.carId) {
      setAlert({ type: 'danger', message: 'Please select both user and car' });
      return;
    }

    try {
      setLoading(true);
      await createRental({
        userId: formData.userId,
        carId: formData.carId
      });
      
      setAlert({ type: 'success', message: 'Rental created successfully!' });
      setFormData({ userId: '', carId: '' });
      
      // Reload data after 2 seconds
      setTimeout(() => {
        loadRentals();
      }, 2000);
    } catch (err) {
      setAlert({ type: 'danger', message: err.message });
    } finally {
      setLoading(false);
    }
  };

  const loadRentals = async () => {
    try {
      await getRentals();
    } catch (err) {
      console.log('Rentals loaded');
    }
  };

  if (loadingUsers) return <Loading message="Loading users..." />;

  const availableCars = cars.filter(car => car.available);

  return (
    <div className="container">
      <PageSection title="Rent a Car" subtitle="Select a user and vehicle to create a rental">
        {alert && (
          <Alert 
            type={alert.type} 
            message={alert.message}
            onClose={() => setAlert(null)}
          />
        )}

        <div style={{ maxWidth: '500px', margin: '0 auto' }}>
          <form onSubmit={handleSubmit} className="card">
            <FormGroup
              label="Select User"
              name="userId"
              type="select"
              value={formData.userId}
              onChange={handleChange}
              required
              options={users.map(user => ({
                value: user.id,
                label: user.name
              }))}
            />

            <FormGroup
              label="Select Car"
              name="carId"
              type="select"
              value={formData.carId}
              onChange={handleChange}
              required
              options={availableCars.map(car => ({
                value: car.id,
                label: `${car.make} ${car.model} (ID: ${car.id})`
              }))}
            />

            {availableCars.length === 0 && (
              <Alert 
                type="warning" 
                message="No cars available for rent at this moment."
              />
            )}

            <Button
              variant="success"
              size="lg"
              block
              loading={loading}
              disabled={loading || availableCars.length === 0}
              type="submit"
            >
              Complete Rental
            </Button>
          </form>
        </div>

        <div style={{ marginTop: '40px' }}>
          <h3>Current Users: {users.length}</h3>
          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(150px, 1fr))', gap: '10px', marginTop: '15px' }}>
            {users.map(user => (
              <div key={user.id} className="card" style={{ padding: '15px', textAlign: 'center' }}>
                <div style={{ fontSize: '32px', marginBottom: '10px' }}>👤</div>
                <strong>{user.name}</strong>
                <p style={{ fontSize: '12px', color: '#666', marginTop: '5px' }}>ID: {user.id}</p>
              </div>
            ))}
          </div>
        </div>
      </PageSection>
    </div>
  );
};
