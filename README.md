Car Rental System
A simple console-based Java application for managing car rentals. Users can list available cars, rent cars, view rental history, add new cars, and register new users. This project is ideal for beginners learning Java and object-oriented programming (OOP) concepts.
Features

Manage Cars and Users: Add cars and users with unique IDs.
Rent Cars: Rent available cars with real-time date tracking using LocalDateTime.
View Rentals: Display rental history with user and car details.
Input Validation: Ensures valid numeric IDs and non-empty fields.
Basic CRUD Operations: Create, read, and update functionality for cars and users.

Technologies Used

Java: Core language (JDK 17+ recommended).
Scanner: For user input.
ArrayList: For in-memory data storage.
LocalDateTime: For real-time rental date tracking.

Prerequisites

Java Development Kit (JDK) 17 or higher installed.
A terminal or IDE (e.g., IntelliJ IDEA, Eclipse) to compile and run the program.

How to Run

Clone the Repository:git clone https://github.com/your-username/car-rental-system.git
cd car-rental-system


Compile the Code:javac CarRentalSystem.java


Run the Application:java CarRentalSystem


Interact with the System: Follow the console prompts to choose options like listing cars, renting, or adding new cars/users.

Usage

Choose from the menu (1-6) to perform actions.
Enter numeric IDs for users and cars when prompted.
View rental history to track all transactions.

Project Structure

CarRentalSystem.java: Main file containing all classes (Car, User, Rental) and logic.

Contributing
Contributions are welcome! To contribute:

Fork the repository.
Create a new branch (git checkout -b feature/YourFeature).
Make your changes and commit (git commit -m "Add YourFeature").
Push to your branch (git push origin feature/YourFeature).
Open a Pull Request.

Future Improvements

Add a database (e.g., H2, MySQL) for persistent storage.
Implement a GUI or web interface.
Add car return functionality with rental duration tracking.

License
This project is licensed under the MIT License. See the LICENSE file for details.
Contact
For questions or feedback, open an issue on GitHub or reach out to ashutoshsain001@gmail.com.
🚗 Happy Renting!
