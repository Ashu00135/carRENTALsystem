package com.ashutosh.carrental.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class Car {
    @Id
    private int id;
    private String make;
    private String model;
    private boolean available;

    // Default constructor for JPA
    public Car() {}

    public Car(int id, String make, String model, boolean available) {
        this.id = id;
        this.make = make;
        this.model = model;
        this.available = available;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getMake() { return make; }
    public void setMake(String make) { this.make = make; }
    public String getModel() { return model; }
    public void setModel(String model) { this.model = model; }
    public boolean isAvailable() { return available; }
    public void setAvailable(boolean available) { this.available = available; }

    @Override
    public String toString() {
        return "Car [ID=" + id + ", Make=" + make + ", Model=" + model + ", Available=" + available + "]";
    }
}
