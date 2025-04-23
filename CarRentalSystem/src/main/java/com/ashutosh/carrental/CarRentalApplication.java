package com.ashutosh.carrental;

import com.ashutosh.carrental.model.Car;
import com.ashutosh.carrental.model.User;
import com.ashutosh.carrental.repository.CarRepository;
import com.ashutosh.carrental.repository.UserRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class CarRentalApplication {
    public static void main(String[] args) {
        SpringApplication.run(CarRentalApplication.class, args);
    }

    @Bean
    CommandLineRunner initDatabase(CarRepository carRepository, UserRepository userRepository) {
        return args -> {
            carRepository.save(new Car(1, "Toyota", "Corolla", true));
            carRepository.save(new Car(2, "Honda", "Civic", true));
            userRepository.save(new User(1, "Ayush"));
            userRepository.save(new User(2, "Adi"));
        };
    }
}
