import axios from 'axios';

const API_BASE_URL = 'http://localhost:8080/api';

// Create axios instance with base URL
export const apiClient = axios.create({
  baseURL: API_BASE_URL,
  headers: {
    'Content-Type': 'application/json',
  }
});

// ==================== CARS ====================
export const getCars = async () => {
  try {
    const response = await apiClient.get('/cars');
    return response.data;
  } catch (error) {
    throw new Error(`Failed to fetch cars: ${error.message}`);
  }
};

export const getAvailableCars = async () => {
  try {
    const response = await apiClient.get('/cars/available');
    return response.data;
  } catch (error) {
    throw new Error(`Failed to fetch available cars: ${error.message}`);
  }
};

export const addCar = async (carData) => {
  try {
    const response = await apiClient.post('/cars', {
      id: parseInt(carData.id),
      make: carData.make,
      model: carData.model,
      available: true
    });
    return response.data;
  } catch (error) {
    throw new Error(`Failed to add car: ${error.message}`);
  }
};

// ==================== USERS ====================
export const getUsers = async () => {
  try {
    const response = await apiClient.get('/users');
    return response.data;
  } catch (error) {
    throw new Error(`Failed to fetch users: ${error.message}`);
  }
};

export const addUser = async (userData) => {
  try {
    const response = await apiClient.post('/users', {
      id: parseInt(userData.id),
      name: userData.name,
      email: userData.email || null,
      phone: userData.phone || null
    });
    return response.data;
  } catch (error) {
    throw new Error(`Failed to add user: ${error.message}`);
  }
};

// ==================== RENTALS ====================
export const getRentals = async () => {
  try {
    const response = await apiClient.get('/rentals');
    return response.data;
  } catch (error) {
    throw new Error(`Failed to fetch rentals: ${error.message}`);
  }
};

export const createRental = async (rentalData) => {
  try {
    const response = await apiClient.post('/rentals', {
      userId: parseInt(rentalData.userId),
      carId: parseInt(rentalData.carId)
    });
    return response.data;
  } catch (error) {
    throw new Error(`Failed to create rental: ${error.message}`);
  }
};

// ==================== UTILITY ====================
export const checkHealth = async () => {
  try {
    const response = await apiClient.get('/');
    return response.status === 200;
  } catch (error) {
    return false;
  }
};
