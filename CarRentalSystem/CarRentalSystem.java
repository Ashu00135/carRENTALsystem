import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner; // Added for real-time date and time

class Car {
    private int id;
    private String make;
    private String model;
    private boolean available;

    public Car(int id, String make, String model) {
        this.id = id;
        this.make = make;
        this.model = model;
        this.available = true; // Car is available by default
    }

    public int getId() { return id; }
    public String getMake() { return make; }
    public String getModel() { return model; }
    public boolean isAvailable() { return available; }
    public void setAvailable(boolean available) { this.available = available; }

    @Override
    public String toString() {
        return "Car [ID=" + id + ", Make=" + make + ", Model=" + model + ", Available=" + available + "]";
    }
}

class User {
    private int id;
    private String name;

    public User(int id, String name) {
        this.id = id;
        this.name = name;
    }

    public int getId() { return id; }
    public String getName() { return name; }

    @Override
    public String toString() {
        return "User [ID=" + id + ", Name=" + name + "]";
    }
}

class Rental {
    private int rentalId;
    private User user;
    private Car car;
    private LocalDateTime rentDate; // Changed from String to LocalDateTime

    public Rental(int rentalId, User user, Car car, LocalDateTime rentDate) {
        this.rentalId = rentalId;
        this.user = user;
        this.car = car;
        this.rentDate = rentDate;
    }

    @Override
    public String toString() {
        return "Rental [ID=" + rentalId + ", User=" + user.getName() + ", Car=" + car.getMake() + " " + car.getModel() + ", Date=" + rentDate + "]";
    }
}

public class CarRentalSystem {
    private static List<Car> cars = new ArrayList<>();
    private static List<User> users = new ArrayList<>();
    private static List<Rental> rentals = new ArrayList<>();
    private static int rentalCounter = 1;

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // Add some sample data
        cars.add(new Car(1, "Toyota", "Corolla"));
        cars.add(new Car(2, "Honda", "Civic"));
        users.add(new User(1, "Ayush"));
        users.add(new User(2, "Adi"));

        while (true) {
            System.out.println("\n=== Car Rental System ===");
            System.out.println("1. List Available Cars");
            System.out.println("2. Rent a Car");
            System.out.println("3. View Rentals");
            System.out.println("4. Add New Car");
            System.out.println("5. Register New User");
            System.out.println("6. Exit");
            System.out.print("Choose an option: ");
            int choice;
            try {
                choice = Integer.parseInt(scanner.nextLine());
            } catch (NumberFormatException e) {
                System.out.println("Invalid input. Please enter a number.");
                continue;
            }

            switch (choice) {
                case 1:
                    listAvailableCars();
                    break;
                case 2:
                    rentCar(scanner);
                    break;
                case 3:
                    viewRentals();
                    break;
                case 4:
                    addNewCar(scanner);
                    break;
                case 5:
                    registerNewUser(scanner);
                    break;
                case 6:
                    System.out.println("Exiting...");
                    scanner.close();
                    return;
                default:
                    System.out.println("Invalid option. Try again.");
            }
        }
    }

    private static void listAvailableCars() {
        System.out.println("\nAvailable Cars:");
        boolean hasAvailable = false;
        for (Car car : cars) {
            if (car.isAvailable()) {
                System.out.println(car);
                hasAvailable = true;
            }
        }
        if (!hasAvailable) {
            System.out.println("No cars available.");
        }
    }

    private static void rentCar(Scanner scanner) {
        System.out.println("\nCurrent Users:");
        for (User u : users) {
            System.out.println(u);
        }
        System.out.print("Enter User ID: ");
        int userId;
        try {
            userId = Integer.parseInt(scanner.nextLine());
        } catch (NumberFormatException e) {
            System.out.println("Invalid User ID. Must be a number.");
            return;
        }

        User user = null;
        for (User u : users) {
            if (u.getId() == userId) {
                user = u;
                break;
            }
        }
        if (user == null) {
            System.out.println("User not found!");
            return;
        }

        listAvailableCars();
        System.out.print("Enter Car ID to rent: ");
        int carId;
        try {
            carId = Integer.parseInt(scanner.nextLine());
        } catch (NumberFormatException e) {
            System.out.println("Invalid Car ID. Must be a number.");
            return;
        }

        Car car = null;
        for (Car c : cars) {
            if (c.getId() == carId && c.isAvailable()) {
                car = c;
                break;
            }
        }
        if (car == null) {
            System.out.println("Car not available or not found!");
            return;
        }

        car.setAvailable(false);
        rentals.add(new Rental(rentalCounter++, user, car, LocalDateTime.now())); // Use real-time date and time
        System.out.println("Car rented successfully!");
    }

    private static void viewRentals() {
        System.out.println("\nRental History:");
        if (rentals.isEmpty()) {
            System.out.println("No rentals recorded.");
        } else {
            for (Rental rental : rentals) {
                System.out.println(rental);
            }
        }
    }

    private static void addNewCar(Scanner scanner) {
        System.out.print("Enter Car ID (unique number): ");
        int carId;
        try {
            carId = Integer.parseInt(scanner.nextLine());
        } catch (NumberFormatException e) {
            System.out.println("Invalid Car ID. Must be a number.");
            return;
        }

        // Check for duplicate car ID
        for (Car c : cars) {
            if (c.getId() == carId) {
                System.out.println("Car ID " + carId + " already exists!");
                return;
            }
        }

        System.out.print("Enter Car Make: ");
        String make = scanner.nextLine().trim();
        if (make.isEmpty()) {
            System.out.println("Car Make cannot be empty!");
            return;
        }

        System.out.print("Enter Car Model: ");
        String model = scanner.nextLine().trim();
        if (model.isEmpty()) {
            System.out.println("Car Model cannot be empty!");
            return;
        }

        cars.add(new Car(carId, make, model));
        System.out.println("Car added successfully: ID=" + carId + ", Make=" + make + ", Model=" + model);
    }

    private static void registerNewUser(Scanner scanner) {
        System.out.print("Enter User ID (unique number): ");
        int userId;
        try {
            userId = Integer.parseInt(scanner.nextLine());
        } catch (NumberFormatException e) {
            System.out.println("Invalid User ID. Must be a number.");
            return;
        }

        // Check for duplicate user ID
        for (User u : users) {
            if (u.getId() == userId) {
                System.out.println("User ID " + userId + " already exists!");
                return;
            }
        }

        System.out.print("Enter User Name: ");
        String name = scanner.nextLine().trim();
        if (name.isEmpty()) {
            System.out.println("User Name cannot be empty!");
            return;
        }

        users.add(new User(userId, name));
        System.out.println("User registered successfully: ID=" + userId + ", Name=" + name);
    }
}