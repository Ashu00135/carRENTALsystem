package com.ashutosh.carrental.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ashutosh.carrental.model.Car;
import com.ashutosh.carrental.model.Rental;
import com.ashutosh.carrental.model.User;
import com.ashutosh.carrental.repository.CarRepository;
import com.ashutosh.carrental.repository.RentalRepository;
import com.ashutosh.carrental.repository.UserRepository;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "http://localhost:3000")
public class ApiController {
    
    @Autowired
    private CarRepository carRepository;
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private RentalRepository rentalRepository;

    // ==================== CARS ====================
    @GetMapping("/cars")
    public List<Car> getAllCars() {
        return carRepository.findAll();
    }

    @GetMapping("/cars/available")
    public List<Car> getAvailableCars() {
        return carRepository.findAll().stream()
                .filter(Car::isAvailable)
                .toList();
    }

    @GetMapping("/cars/{id}")
    public Car getCarById(@PathVariable int id) {
        return carRepository.findById(id).orElse(null);
    }

    @PostMapping("/cars")
    public Car addCar(@RequestBody Car car) {
        return carRepository.save(car);
    }

    @PutMapping("/cars/{id}")
    public Car updateCar(@PathVariable int id, @RequestBody Car car) {
        car.setId(id);
        return carRepository.save(car);
    }

    @DeleteMapping("/cars/{id}")
    public void deleteCar(@PathVariable int id) {
        carRepository.deleteById(id);
    }

    // ==================== USERS ====================
    @GetMapping("/users")
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    @GetMapping("/users/{id}")
    public User getUserById(@PathVariable int id) {
        return userRepository.findById(id).orElse(null);
    }

    @PostMapping("/users")
    public User addUser(@RequestBody User user) {
        return userRepository.save(user);
    }

    @PutMapping("/users/{id}")
    public User updateUser(@PathVariable int id, @RequestBody User user) {
        user.setId(id);
        return userRepository.save(user);
    }

    @DeleteMapping("/users/{id}")
    public void deleteUser(@PathVariable int id) {
        userRepository.deleteById(id);
    }

    // ==================== RENTALS ====================
    private int rentalCounter = 1;

    @GetMapping("/rentals")
    public List<Rental> getAllRentals() {
        return rentalRepository.findAll();
    }

    @GetMapping("/rentals/{id}")
    public Rental getRentalById(@PathVariable int id) {
        return rentalRepository.findById(id).orElse(null);
    }

    @PostMapping("/rentals")
    public Rental addRental(@RequestBody RentalRequest rentalRequest) {
        User user = userRepository.findById(rentalRequest.getUserId()).orElse(null);
        Car car = carRepository.findById(rentalRequest.getCarId()).orElse(null);
        
        if (user == null || car == null) {
            throw new IllegalArgumentException("Invalid user or car ID");
        }
        
        if (!car.isAvailable()) {
            throw new IllegalArgumentException("Car is not available for rental");
        }
        
        // Create rental
        Rental rental = new Rental(rentalCounter++, user, car, java.time.LocalDateTime.now());
        
        // Mark car as unavailable
        car.setAvailable(false);
        carRepository.save(car);
        
        return rentalRepository.save(rental);
    }
    
    // ==================== STATIC CLASS FOR REQUEST ====================
    public static class RentalRequest {
        private int userId;
        private int carId;
        
        public RentalRequest() {}
        public RentalRequest(int userId, int carId) {
            this.userId = userId;
            this.carId = carId;
        }
        
        public int getUserId() { return userId; }
        public void setUserId(int userId) { this.userId = userId; }
        public int getCarId() { return carId; }
        public void setCarId(int carId) { this.carId = carId; }
    }

    // ==================== HEALTH CHECK ====================
    @GetMapping("/health")
    public String health() {
        return "OK";
    }

    @GetMapping("/stats")
    public String getStats() {
        long carCount = carRepository.count();
        long userCount = userRepository.count();
        long rentalCount = rentalRepository.count();
        return String.format("Cars: %d, Users: %d, Rentals: %d", carCount, userCount, rentalCount);
    }
}
