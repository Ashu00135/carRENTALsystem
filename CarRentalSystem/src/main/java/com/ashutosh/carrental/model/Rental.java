package com.ashutosh.carrental.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import java.time.LocalDateTime;

@Entity
public class Rental {
    @Id
    private int rentalId;
    @ManyToOne
    private User user;
    @ManyToOne
    private Car car;
    private LocalDateTime rentDate;

    // Default constructor for JPA
    public Rental() {}

    public Rental(int rentalId, User user, Car car, LocalDateTime rentDate) {
        this.rentalId = rentalId;
        this.user = user;
        this.car = car;
        this.rentDate = rentDate;
    }

    public int getRentalId() { return rentalId; }
    public void setRentalId(int rentalId) { this.rentalId = rentalId; }
    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
    public Car getCar() { return car; }
    public void setCar(Car car) { this.car = car; }
    public LocalDateTime getRentDate() { return rentDate; }
    public void setRentDate(LocalDateTime rentDate) { this.rentDate = rentDate; }

    @Override
    public String toString() {
        return "Rental [ID=" + rentalId + ", User=" + user.getName() + ", Car=" + car.getMake() + " " + car.getModel() + ", Date=" + rentDate + "]";
    }
}
