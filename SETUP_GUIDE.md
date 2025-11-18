# Car Rental System - Java Spring Boot Application

A complete Car Rental Management System built with **Java 17**, **Spring Boot 3.3.4**, and **H2 Database**.

## 📋 Table of Contents

- [System Requirements](#system-requirements)
- [Quick Start](#quick-start)
- [Installation & Setup](#installation--setup)
- [Running the Application](#running-the-application)
- [Project Structure](#project-structure)
- [Dependencies](#dependencies)
- [Database](#database)
- [Troubleshooting](#troubleshooting)
- [Development](#development)

---

## 📦 System Requirements

- **Java**: JDK 17 or later (tested with Java 24)
- **Maven**: 3.9 or later
- **OS**: Windows, macOS, or Linux
- **Memory**: Minimum 2GB RAM

### Check Installation

```powershell
# Check Java version
java -version

# Check Maven version
mvn -v
```

If not installed:
- **Java**: Download from [oracle.com](https://www.oracle.com/java/technologies/downloads/)
- **Maven**: Download from [maven.apache.org](https://maven.apache.org/download.cgi)

---

## 🚀 Quick Start

### Using PowerShell (Windows)

```powershell
# Navigate to project directory
cd d:\PROJECTS\car_manager\carRENTALsystem

# Build and run the application
.\build-run.ps1 build-run

# Or build only
.\build-run.ps1 build

# Or run existing JAR
.\build-run.ps1 run

# Run in development mode (hot reload)
.\build-run.ps1 dev -port 8080
```

### Using Command Prompt (Windows)

```cmd
cd d:\PROJECTS\car_manager\carRENTALsystem
build-run.bat build-run
```

### Manual Build & Run

```powershell
cd d:\PROJECTS\car_manager\carRENTALsystem\CarRentalSystem

# Build
mvn clean package

# Run
java -jar target/carrental-0.0.1-SNAPSHOT.jar
```

---

## 💻 Installation & Setup

### Step 1: Verify Environment

```powershell
# Check Java installation
java -version

# Check Maven installation
mvn -v
```

### Step 2: Make Scripts Executable (Optional)

```powershell
# For PowerShell script
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Allow the script
.\build-run.ps1
```

### Step 3: Clone/Extract Project

```powershell
cd d:\PROJECTS\car_manager\carRENTALsystem
ls -la  # Verify structure
```

### Step 4: Configure Environment (Optional)

Copy the example environment file:

```powershell
cp .env.example .env
```

Edit `.env` file to customize settings (database, port, etc.)

---

## 🏃 Running the Application

### Development Mode (with Hot Reload)

```powershell
.\build-run.ps1 dev -port 8080
```

**Features:**
- ✅ Automatic code recompilation
- ✅ Hot reload on file changes
- ✅ Live debugging
- ✅ H2 Console at `http://localhost:8080/h2-console`

### Production Mode (JAR)

```powershell
.\build-run.ps1 build-run -port 8080
```

### Run on Different Port

```powershell
# PowerShell
.\build-run.ps1 run -port 9090

# Command Prompt
build-run.bat run 9090

# Direct
java -jar target/carrental-0.0.1-SNAPSHOT.jar --server.port=9090
```

### Access the Application

- **Web UI**: `http://localhost:8080/`
- **H2 Console** (dev only): `http://localhost:8080/h2-console`
  - JDBC URL: `jdbc:h2:mem:carrental`
  - Username: `sa`
  - Password: (leave empty)

---

## 📁 Project Structure

```
carRENTALsystem/
├── CarRentalSystem/              # Main application source
│   ├── src/
│   │   └── main/
│   │       ├── java/com/ashutosh/carrental/
│   │       │   ├── CarRentalApplication.java   # Main Spring Boot class
│   │       │   ├── controller/
│   │       │   │   └── CarRentalController.java # REST endpoints
│   │       │   ├── model/
│   │       │   │   ├── Car.java
│   │       │   │   ├── User.java
│   │       │   │   └── Rental.java
│   │       │   └── repository/
│   │       │       ├── CarRepository.java
│   │       │       ├── UserRepository.java
│   │       │       └── RentalRepository.java
│   │       └── resources/
│   │           ├── application.properties     # Main config
│   │           ├── application-dev.properties # Dev config
│   │           ├── application-prod.properties# Prod config
│   │           ├── static/                    # Static files
│   │           └── templates/                 # HTML templates
│   ├── target/                      # Build output (auto-generated)
│   └── pom.xml                      # Maven dependencies & config
├── build-run.ps1                    # PowerShell build script
├── build-run.bat                    # Batch build script
├── .env.example                     # Environment template
└── README.md                        # This file
```

---

## 📚 Dependencies

### Core Dependencies (Auto-managed by Maven)

| Dependency | Version | Purpose |
|-----------|---------|---------|
| `spring-boot-starter-web` | 3.3.4 | Web & REST API support |
| `spring-boot-starter-data-jpa` | 3.3.4 | Database & ORM |
| `spring-boot-starter-thymeleaf` | 3.3.4 | Template engine for HTML |
| `h2database` | latest | In-memory database |
| `spring-boot-starter-test` | 3.3.4 | Testing framework |

### View Dependencies

```powershell
# Show dependency tree
mvn dependency:tree

# Show resolved dependencies
mvn dependency:resolve

# Using script
.\build-run.ps1 dependencies
```

### Add New Dependency

1. Edit `CarRentalSystem/pom.xml`
2. Add dependency in `<dependencies>` section
3. Rebuild: `mvn clean install`

Example:
```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-security</artifactId>
</dependency>
```

---

## 🗄️ Database

### Development Database (H2)

- **Type**: In-memory database
- **Location**: Memory (auto-deleted on shutdown)
- **Console**: `http://localhost:8080/h2-console`
- **Auto-DDL**: Enabled (`update` mode)

### Database Entities

1. **User**
   - Stores user information for rentals
   - Fields: `id`, `name`

2. **Car**
   - Stores car inventory
   - Fields: `id`, `make`, `model`, `available`

3. **Rental**
   - Tracks car rentals
   - Fields: `id`, `userId`, `carId`, `rentalDate`

### Switching to MySQL (Production)

Edit `application-prod.properties`:

```properties
# Remove or comment out H2
# spring.datasource.url=jdbc:h2:mem:carrental

# Add MySQL
spring.datasource.url=jdbc:mysql://localhost:3306/carrental
spring.datasource.driverClassName=com.mysql.cj.jdbc.Driver
spring.datasource.username=carrental_user
spring.datasource.password=your_password
spring.jpa.database-platform=org.hibernate.dialect.MySQLDialect

# Add to pom.xml:
# <dependency>
#     <groupId>mysql</groupId>
#     <artifactId>mysql-connector-java</artifactId>
#     <version>8.0.33</version>
# </dependency>
```

---

## 🛠️ Build Commands Reference

### Full Build & Run Commands

```powershell
# PowerShell - Build only
.\build-run.ps1 build

# PowerShell - Run only
.\build-run.ps1 run -port 8080

# PowerShell - Build & Run
.\build-run.ps1 build-run

# PowerShell - Dev mode (hot reload)
.\build-run.ps1 dev

# PowerShell - Clean build artifacts
.\build-run.ps1 clean

# PowerShell - Show dependencies
.\build-run.ps1 dependencies

# PowerShell - Show help
.\build-run.ps1 help
```

### Command Prompt Equivalents

```cmd
build-run.bat build
build-run.bat run 8080
build-run.bat build-run
build-run.bat dev
build-run.bat clean
build-run.bat dependencies
build-run.bat help
```

### Direct Maven Commands

```powershell
cd CarRentalSystem

# Clean build
mvn clean package

# Build with tests
mvn package

# Build without tests
mvn -DskipTests package

# Run tests
mvn test

# Run specific test
mvn test -Dtest=ClassName

# Dev mode with hot reload
mvn spring-boot:run

# Run on different port
mvn spring-boot:run -Dspring-boot.run.arguments="--server.port=9090"

# View dependency tree
mvn dependency:tree
```

---

## 🔧 Troubleshooting

### Problem: "Java not found"

**Solution:**
```powershell
# Check if Java is in PATH
java -version

# If not found, add Java to PATH:
# 1. Find Java installation (usually C:\Program Files\Java\jdk-xx)
# 2. Add to PATH in Environment Variables
# 3. Restart PowerShell/CMD
```

### Problem: "Maven not found"

**Solution:**
```powershell
mvn -v

# If not found:
# 1. Download Maven from apache.org
# 2. Extract to a folder
# 3. Add bin folder to PATH
# 4. Restart terminal
```

### Problem: "Port already in use"

**Solution:**
```powershell
# Run on different port
.\build-run.ps1 run -port 9090

# Or find and kill process:
netstat -ano | findstr :8080
taskkill /PID <PID> /F
```

### Problem: "Build fails with compilation error"

**Solution:**
```powershell
# Clean Maven cache
mvn clean

# Remove target folder
rm -r CarRentalSystem\target

# Rebuild
mvn clean package
```

### Problem: "H2 Console SQL errors"

**Solution:**
- Ensure table names don't conflict with SQL keywords
- User entity uses `@Table(name = "app_user")` to avoid "user" keyword
- Check database DDL auto mode: should be "update" for dev

---

## 👨‍💻 Development

### Adding New Features

1. **Create Model** (Entity):
```java
@Entity
@Table(name = "entity_name")
public class YourEntity {
    @Id
    private int id;
    // ... fields and methods
}
```

2. **Create Repository** (Database Access):
```java
@Repository
public interface YourRepository extends JpaRepository<YourEntity, Integer> {
    // Custom queries if needed
}
```

3. **Create Controller** (REST Endpoint):
```java
@RestController
@RequestMapping("/api/entities")
public class YourController {
    @Autowired
    private YourRepository repository;
    
    @GetMapping
    public List<YourEntity> getAll() {
        return repository.findAll();
    }
}
```

### Testing

```powershell
# Run all tests
mvn test

# Run specific test class
mvn test -Dtest=CarRentalControllerTest

# Run with coverage
mvn test jacoco:report
```

### Logging

Add logging to your application:

```java
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class MyClass {
    private static final Logger logger = LoggerFactory.getLogger(MyClass.class);
    
    public void myMethod() {
        logger.info("This is an info message");
        logger.debug("This is a debug message");
        logger.error("This is an error message");
    }
}
```

Configure log levels in `application-dev.properties`:
```properties
logging.level.com.ashutosh.carrental=DEBUG
```

---

## 📝 API Endpoints

### Available Endpoints

```
GET  /                           # Home page
GET  /cars                       # List available cars
GET  /rentals                    # View all rentals
GET  /add-car                    # Add car form
POST /add-car                    # Submit new car
GET  /add-user                   # Add user form
POST /add-user                   # Submit new user
GET  /rent                       # Rent car form
POST /rent                       # Submit rental
GET  /h2-console                 # H2 Database console (dev only)
```

---

## 📦 Building for Production

```powershell
# Build production JAR
mvn clean package -DskipTests

# JAR location: CarRentalSystem/target/carrental-0.0.1-SNAPSHOT.jar

# Run production build
java -jar target/carrental-0.0.1-SNAPSHOT.jar

# With production config
java -jar target/carrental-0.0.1-SNAPSHOT.jar --spring.profiles.active=prod
```

---

## 📞 Support

For issues or questions:
1. Check logs: `logs/` directory
2. Review [Spring Boot Documentation](https://spring.io/projects/spring-boot)
3. Check [Hibernate/JPA Docs](https://hibernate.org/)

---

## 📄 License

This project is provided as-is for educational and development purposes.

---

**Last Updated**: November 11, 2025  
**Spring Boot Version**: 3.3.4  
**Java Version**: 17+
