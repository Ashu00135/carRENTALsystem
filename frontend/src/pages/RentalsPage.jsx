import React, { useState, useEffect } from 'react';
import { getRentals } from '../utils/api';
import { Loading, Alert, PageSection, Table, Badge } from '../components';

export const RentalsPage = () => {
  const [rentals, setRentals] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [filter, setFilter] = useState('all');

  useEffect(() => {
    loadRentals();
  }, []);

  const loadRentals = async () => {
    try {
      setLoading(true);
      const rentalsData = await getRentals();
      
      // Format rental data for display
      const formattedRentals = (rentalsData || []).map((rental, index) => ({
        id: rental.id || (index + 1),
        userId: rental.user?.id || 'N/A',
        userName: rental.user?.name || 'Unknown',
        carId: rental.car?.id || 'N/A',
        carMake: rental.car?.make || 'Unknown',
        carModel: rental.car?.model || 'Unknown',
        rentalDate: rental.rentalDate || new Date().toISOString().split('T')[0],
        returnDate: rental.returnDate || 'N/A',
        status: rental.returnDate ? 'Completed' : 'Active'
      }));
      
      setRentals(formattedRentals);
      setError(null);
    } catch (err) {
      setError(err.message);
      // Use mock data on error
      setRentals([
        {
          id: 1,
          userId: 1,
          userName: 'John Doe',
          carId: 1,
          carMake: 'Toyota',
          carModel: 'Corolla',
          rentalDate: '2025-11-01',
          returnDate: '2025-11-05',
          status: 'Completed'
        },
        {
          id: 2,
          userId: 2,
          userName: 'Jane Smith',
          carId: 2,
          carMake: 'Honda',
          carModel: 'Civic',
          rentalDate: '2025-11-10',
          returnDate: 'N/A',
          status: 'Active'
        }
      ]);
    } finally {
      setLoading(false);
    }
  };

  const filteredRentals = rentals.filter(rental => {
    if (filter === 'active') return rental.status === 'Active';
    if (filter === 'completed') return rental.status === 'Completed';
    return true;
  });

  if (loading) return <Loading message="Loading rentals..." />;

  const tableHeaders = ['ID', 'Customer', 'Car', 'Rental Date', 'Return Date', 'Status'];
  const tableRows = filteredRentals.map(rental => ({
    'ID': rental.id,
    'Customer': rental.userName,
    'Car': `${rental.carMake} ${rental.carModel}`,
    'Rental Date': rental.rentalDate,
    'Return Date': rental.returnDate,
    'Status': rental.status === 'Active' 
      ? <Badge type="success">Active</Badge>
      : <Badge type="info">Completed</Badge>
  }));

  return (
    <div className="container">
      <PageSection title="Rental Records" subtitle="View all rental transactions">
        {error && <Alert type="warning" message={error} />}

        <div style={{ marginBottom: '20px', display: 'flex', gap: '10px', flexWrap: 'wrap' }}>
          <button
            className={`btn ${filter === 'all' ? 'btn-primary' : 'btn-secondary'}`}
            onClick={() => setFilter('all')}
          >
            All Rentals ({rentals.length})
          </button>
          <button
            className={`btn ${filter === 'active' ? 'btn-primary' : 'btn-secondary'}`}
            onClick={() => setFilter('active')}
          >
            Active ({rentals.filter(r => r.status === 'Active').length})
          </button>
          <button
            className={`btn ${filter === 'completed' ? 'btn-primary' : 'btn-secondary'}`}
            onClick={() => setFilter('completed')}
          >
            Completed ({rentals.filter(r => r.status === 'Completed').length})
          </button>
        </div>

        {filteredRentals.length === 0 ? (
          <div style={{ textAlign: 'center', padding: '40px 20px' }}>
            <p style={{ fontSize: '18px', color: '#666' }}>
              No rentals found matching your filter.
            </p>
          </div>
        ) : (
          <Table headers={tableHeaders} rows={tableRows} />
        )}
      </PageSection>

      <PageSection title="Rental Statistics" subtitle="">
        <div className="grid-container" style={{ gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))' }}>
          <div className="card" style={{ textAlign: 'center' }}>
            <div style={{ fontSize: '36px', color: 'var(--primary-color)' }}>
              {rentals.length}
            </div>
            <p style={{ margin: '10px 0 0 0' }}>Total Rentals</p>
          </div>
          <div className="card" style={{ textAlign: 'center' }}>
            <div style={{ fontSize: '36px', color: 'var(--success-color)' }}>
              {rentals.filter(r => r.status === 'Active').length}
            </div>
            <p style={{ margin: '10px 0 0 0' }}>Active Rentals</p>
          </div>
          <div className="card" style={{ textAlign: 'center' }}>
            <div style={{ fontSize: '36px', color: 'var(--info-color)' }}>
              {rentals.filter(r => r.status === 'Completed').length}
            </div>
            <p style={{ margin: '10px 0 0 0' }}>Completed</p>
          </div>
        </div>
      </PageSection>
    </div>
  );
};
