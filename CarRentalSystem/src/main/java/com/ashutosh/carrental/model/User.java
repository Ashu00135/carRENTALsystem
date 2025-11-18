package com.ashutosh.carrental.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "app_user")
public class User {
    @Id
    private int id;
    private String name;

    // Default constructor for JPA
    public User() {}

    public User(int id, String name) {
        this.id = id;
        this.name = name;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    @Override
    public String toString() {
        return "User [ID=" + id + ", Name=" + name + "]";
    }
}
