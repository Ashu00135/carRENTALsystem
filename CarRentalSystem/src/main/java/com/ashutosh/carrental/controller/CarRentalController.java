package com.ashutosh.carrental.controller;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ashutosh.carrental.model.Car;
import com.ashutosh.carrental.model.Rental;
import com.ashutosh.carrental.model.User;
import com.ashutosh.carrental.repository.CarRepository;
import com.ashutosh.carrental.repository.RentalRepository;
import com.ashutosh.carrental.repository.UserRepository;

@Controller
public class CarRentalController {
    @Autowired
    private CarRepository carRepository;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private RentalRepository rentalRepository;
    private int rentalCounter = 1;

    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("message", "Welcome to Car Rental System");
        return "index";
    }

    @GetMapping("/cars")
    public String listAvailableCars(Model model) {
        List<Car> availableCars = carRepository.findAll().stream()
                .filter(Car::isAvailable)
                .toList();
        model.addAttribute("cars", availableCars);
        return "cars";
    }

    @GetMapping("/rent")
    public String rentCarForm(Model model) {
        model.addAttribute("users", userRepository.findAll());
        model.addAttribute("cars", carRepository.findAll().stream()
                .filter(Car::isAvailable)
                .toList());
        return "rent";
    }

    @PostMapping("/rent")
    public String rentCar(@RequestParam int userId, @RequestParam int carId, Model model) {
        User user = userRepository.findById(userId).orElse(null);
        Car car = carRepository.findById(carId).orElse(null);
        if (user == null || car == null || !car.isAvailable()) {
            model.addAttribute("error", "Invalid user or car, or car not available!");
            return "rent";
        }
        car.setAvailable(false);
        carRepository.save(car);
        Rental rental = new Rental(rentalCounter++, user, car, LocalDateTime.now());
        rentalRepository.save(rental);
        model.addAttribute("message", "Car rented successfully!");
        return "rent";
    }

    @GetMapping("/rentals")
    public String viewRentals(Model model) {
        model.addAttribute("rentals", rentalRepository.findAll());
        return "rentals";
    }

    @GetMapping("/add-car")
    public String addCarForm() {
        return "add-car";
    }

    @PostMapping("/add-car")
    public String addCar(@RequestParam int id, @RequestParam String make, @RequestParam String carModel, Model model) {
        if (carRepository.existsById(id)) {
            model.addAttribute("error", "Car ID already exists!");
            return "add-car";
        }
        if (make.trim().isEmpty() || carModel.trim().isEmpty()) {
            model.addAttribute("error", "Make and model cannot be empty!");
            return "add-car";
        }
        carRepository.save(new Car(id, make, carModel, true));
        model.addAttribute("message", "Car added successfully!");
        return "add-car";
    }

    @GetMapping("/add-user")
    public String addUserForm() {
        return "add-user";
    }

    @PostMapping("/add-user")
    public String addUser(@RequestParam int id, @RequestParam String name, Model model) {
        if (userRepository.existsById(id)) {
            model.addAttribute("error", "User ID already exists!");
            return "add-user";
        }
        if (name.trim().isEmpty()) {
            model.addAttribute("error", "Name cannot be empty!");
            return "add-user";
        }
        userRepository.save(new User(id, name));
        model.addAttribute("message", "User added successfully!");
        return "add-user";
    }
}
