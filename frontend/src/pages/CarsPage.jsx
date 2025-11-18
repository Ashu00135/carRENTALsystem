import React, { useState, useEffect } from 'react';
import { getCars } from '../utils/api';
import { CarCard, Loading, Alert, PageSection } from '../components';

export const CarsPage = ({ onRentClick }) => {
  const [cars, setCars] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [filter, setFilter] = useState('all');

  useEffect(() => {
    loadCars();
  }, []);

  const loadCars = async () => {
    try {
      setLoading(true);
      const data = await getCars();
      // Data is already JSON array from API
      setCars(data || []);
      setError(null);
    } catch (err) {
      setError(err.message);
      // Show error but still load mock data for demo
      setCars([
        { id: 1, make: 'Toyota', model: 'Corolla', available: true },
        { id: 2, make: 'Honda', model: 'Civic', available: true }
      ]);
    } finally {
      setLoading(false);
    }
  };

  const filteredCars = cars.filter(car => {
    if (filter === 'available') return car.available;
    if (filter === 'rented') return !car.available;
    return true;
  });

  if (loading) return <Loading message="Loading cars..." />;

  return (
    <div className="container">
      <PageSection title="Available Cars" subtitle="Browse our fleet of rental vehicles">
        {error && <Alert type="warning" message={error} />}

        <div style={{ marginBottom: '20px', display: 'flex', gap: '10px' }}>
          <button
            className={`btn ${filter === 'all' ? 'btn-primary' : 'btn-secondary'}`}
            onClick={() => setFilter('all')}
          >
            All Cars ({cars.length})
          </button>
          <button
            className={`btn ${filter === 'available' ? 'btn-primary' : 'btn-secondary'}`}
            onClick={() => setFilter('available')}
          >
            Available ({cars.filter(c => c.available).length})
          </button>
          <button
            className={`btn ${filter === 'rented' ? 'btn-primary' : 'btn-secondary'}`}
            onClick={() => setFilter('rented')}
          >
            Rented ({cars.filter(c => !c.available).length})
          </button>
        </div>

        {filteredCars.length === 0 ? (
          <div style={{ textAlign: 'center', padding: '40px 20px' }}>
            <p style={{ fontSize: '18px', color: '#666' }}>
              No cars found matching your filter.
            </p>
          </div>
        ) : (
          <div className="grid-container">
            {filteredCars.map(car => (
              <CarCard
                key={car.id}
                car={car}
                onAction={() => onRentClick?.(car)}
                actionLabel={car.available ? 'Rent Now' : 'Unavailable'}
              />
            ))}
          </div>
        )}
      </PageSection>
    </div>
  );
};
