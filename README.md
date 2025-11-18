# Car Rental System - Full Stack

A modern **full-stack Car Rental Management System** built with:
- **Backend**: Java 17, Spring Boot 3.3.4, Spring Data JPA, H2 Database
- **Frontend**: React 18, Vite, React Router, Axios

This is a **production-ready application** with React UI, REST APIs, responsive design, and complete setup automation.

---

## ✨ Features

### Core Functionality
- 🚗 **Manage Cars**: Browse, add, and track car availability with images
- 👥 **Manage Users**: Register users and manage customer information
- 🎫 **Rent Cars**: Create and manage car rental transactions
- 📊 **View Rentals**: Complete rental history with statistics
- ✅ **Real-time Tracking**: Track rental dates and status

### Frontend Features
- 🎨 **Modern React UI**: 6 responsive pages with React Router
- 📱 **Fully Responsive**: Mobile, tablet, and desktop optimized
- 🖼️ **Car Images**: Unsplash integration with fallback emojis
- ✔️ **Form Validation**: Client-side validation with error messages
- ⚡ **Hot Reload**: Vite development server with instant updates
- 🎯 **Professional Design**: Clean, modern UI with smooth animations

### Backend Features
- 🌐 **Spring Boot REST API**: Complete CRUD endpoints
- 🗄️ **H2 Database**: Development-ready, in-memory database
- 🔄 **JPA/Hibernate**: Object-relational mapping
- ✔️ **Server Validation**: Input validation and business logic
- 🛠️ **Maven Build**: Automated build and dependency management
- � **H2 Console**: Database inspection and management

---

## 🛠️ Technologies Used

### Backend
| Component | Version | Purpose |
|-----------|---------|---------|
| **Java** | 17+ | Core language |
| **Spring Boot** | 3.3.4 | Framework |
| **Spring Data JPA** | 3.3.4 | ORM & Database |
| **Hibernate** | 6.5.3 | JPA Implementation |
| **H2 Database** | 2.2.224 | Development/Testing |
| **Thymeleaf** | 3.3.4 | Template Engine |
| **Maven** | 3.9+ | Build Tool |
| **Tomcat** | 10.1.30 | Application Server |

### Frontend
| Component | Version | Purpose |
|-----------|---------|---------|
| **React** | 18.3.1 | UI Framework |
| **Vite** | 5.4.21 | Build Tool & Dev Server |
| **React Router** | 6.30.1 | Navigation |
| **Axios** | 1.13.2 | HTTP Client |
| **CSS3** | Latest | Styling & Responsive Design |
| **Node.js** | 18+ LTS | JavaScript Runtime |

---

## 📋 Prerequisites

### Required
- ✅ **Java JDK 17 or higher** ([Download](https://www.oracle.com/java/technologies/downloads/))
- ✅ **Maven 3.9+** ([Download](https://maven.apache.org/download.cgi))
- ✅ **Git** (optional, for cloning)

### Verify Installation
```powershell
java -version      # Should show Java 17+
mvn -v            # Should show Maven 3.9+
```

---

## 🚀 Quick Start

## ⚡ Quick Start (Easiest!)

### Option 1: Full Stack (Recommended)
```powershell
cd d:\PROJECTS\car_manager\carRENTALsystem

# Terminal 1: Start Backend
.\startup.ps1 backend

# Terminal 2: Start Frontend
.\startup.ps1 frontend

# Open in browser:
# Frontend: http://localhost:3000
# Backend:  http://localhost:8080
```

### Option 2: Backend Only
```powershell
cd d:\PROJECTS\car_manager\carRENTALsystem
.\startup.ps1 backend

# Application starts on http://localhost:8080
```

### Option 3: Frontend Only (requires backend running)
```powershell
cd d:\PROJECTS\car_manager\carRENTALsystem\frontend
npm run dev

# Application starts on http://localhost:3000
```

### Option 4: Manual Build & Run
```powershell
cd CarRentalSystem
mvn clean package
java -jar target/carrental-0.0.1-SNAPSHOT.jar
```

---

## 📚 Complete Documentation

For detailed setup and management:

### 📖 [SETUP_GUIDE.md](./SETUP_GUIDE.md)
- ✅ Complete installation instructions
- 🏃 How to run the application
- 🔧 Configuration and environment setup
- 🐛 Troubleshooting guide
- 👨‍💻 Development guidelines

### 📦 [DEPENDENCY_MANAGEMENT.md](./DEPENDENCY_MANAGEMENT.md)
- 📚 Current dependencies explained
- ➕ How to add new dependencies
- 🔍 View and manage dependencies
- 🔄 Update and upgrade procedures
- 📊 Dependency security

---

## 🎯 Build & Run Commands

### PowerShell

```powershell
# Show help
.\build-run.ps1 help

# Build only
.\build-run.ps1 build

# Run only (must build first)
.\build-run.ps1 run -port 8080

# Build and run
.\build-run.ps1 build-run

# Development mode (hot reload)
.\build-run.ps1 dev -port 8080

# Clean build artifacts
.\build-run.ps1 clean

# Show dependencies
.\build-run.ps1 dependencies
```

### Command Prompt

```cmd
build-run.bat help
build-run.bat build
build-run.bat run 8080
build-run.bat build-run
build-run.bat dev
build-run.bat clean
build-run.bat dependencies
```

### Direct Maven

```powershell
cd CarRentalSystem

# Build with tests
mvn clean package

# Build without tests (faster)
mvn -DskipTests package

# Dev mode
mvn spring-boot:run

# Run on different port
mvn spring-boot:run -Dspring-boot.run.arguments="--server.port=9090"

# View dependencies
mvn dependency:tree
```

---

## 🌐 Access Application

Once running, access the application:

- **Web UI**: [http://localhost:8080/](http://localhost:8080/)
- **H2 Console** (dev only): [http://localhost:8080/h2-console](http://localhost:8080/h2-console)
  - JDBC URL: `jdbc:h2:mem:carrental`
  - Username: `sa`
  - Password: (leave empty)

---

## 📁 Project Structure

```
carRENTALsystem/
├── CarRentalSystem/                    # Spring Boot application source
│   ├── src/main/java/
│   │   └── com/ashutosh/carrental/
│   │       ├── CarRentalApplication.java      # Main @SpringBootApplication
│   │       ├── controller/
│   │       │   └── CarRentalController.java   # REST endpoints & routes
│   │       ├── model/
│   │       │   ├── Car.java                   # Car entity
│   │       │   ├── User.java                  # User entity (@Table name fix)
│   │       │   └── Rental.java                # Rental entity
│   │       └── repository/
│   │           ├── CarRepository.java         # Car CRUD
│   │           ├── UserRepository.java        # User CRUD
│   │           └── RentalRepository.java      # Rental CRUD
│   ├── src/main/resources/
│   │   ├── application.properties             # Default config
│   │   ├── application-dev.properties         # Development config
│   │   ├── application-prod.properties        # Production config
│   │   ├── static/
│   │   │   └── index.html                     # Home page
│   │   └── templates/                         # Thymeleaf templates
│   │       ├── add-car.html
│   │       ├── add-user.html
│   │       ├── cars.html
│   │       ├── rent.html
│   │       └── rentals.html
│   ├── target/                                # Build output (auto-generated)
│   └── pom.xml                                # Maven dependencies & config
├── build-run.ps1                      # PowerShell build automation script
├── build-run.bat                      # Batch build automation script
├── .env.example                       # Environment template
├── SETUP_GUIDE.md                     # Complete setup documentation
├── DEPENDENCY_MANAGEMENT.md           # Dependency management guide
└── README.md                          # This file
```

---

## 📊 API Endpoints

### Pages
- `GET /` — Home page
- `GET /cars` — List available cars
- `GET /add-car` — Add car form
- `GET /add-user` — Add user form
- `GET /rent` — Rent car form
- `GET /rentals` — View all rentals

### API Operations
- `POST /add-car` — Add new car
- `POST /add-user` — Register new user
- `POST /rent` — Create rental
- `GET /h2-console` — Database console (dev only)

---

## 🗄️ Database

### Development (Default)
- **Type**: H2 (In-memory)
- **Lifecycle**: Auto-created, loses data on restart
- **Console**: http://localhost:8080/h2-console
- **Perfect for**: Development and testing

### Production
- Switch to MySQL or PostgreSQL
- Edit `application-prod.properties`
- Update `pom.xml` with appropriate driver
- See [DEPENDENCY_MANAGEMENT.md](./DEPENDENCY_MANAGEMENT.md)

---

## ✅ Fixed Issues

### Compilation Errors (Fixed ✓)
- ✓ Parameter shadowing in `CarRentalController.addCar()` method
- ✓ H2 SQL reserved word error in `User` table (`user` → `app_user`)

### Configuration (Added ✓)
- ✓ Development profile with debug logging
- ✓ Production profile with optimized settings
- ✓ Environment variable templates

---

## 🛠️ Environment Setup

### Development Environment

```properties
SERVER_PORT=8080
SPRING_PROFILES_ACTIVE=dev
SPRING_JPA_HIBERNATE_DDL_AUTO=update
LOGGING_LEVEL_COM_ASHUTOSH_CARRENTAL=DEBUG
```

### Production Environment

```properties
SERVER_PORT=8080
SPRING_PROFILES_ACTIVE=prod
SPRING_JPA_HIBERNATE_DDL_AUTO=validate
LOGGING_LEVEL_COM_ASHUTOSH_CARRENTAL=INFO
spring.h2.console.enabled=false
```

---

## 📖 Step-by-Step Setup

1. **Install Prerequisites**
   ```powershell
   java -version  # Verify Java 17+
   mvn -v        # Verify Maven 3.9+
   ```

2. **Navigate to Project**
   ```powershell
   cd d:\PROJECTS\car_manager\carRENTALsystem
   ```

3. **Build Application**
   ```powershell
   .\build-run.ps1 build
   ```

4. **Run Application**
   ```powershell
   .\build-run.ps1 run
   ```

5. **Access Web UI**
   ```
   http://localhost:8080
   ```

---

## 🐛 Troubleshooting

| Issue | Solution |
|-------|----------|
| "Java not found" | Install JDK 17+, add to PATH |
| "Maven not found" | Install Maven 3.9+, add to PATH |
| "Port 8080 in use" | Run on different port: `.\build-run.ps1 run -port 9090` |
| "Build fails" | Clean cache: `mvn clean install` |
| "H2 console errors" | Check entity names (avoid SQL keywords) |

See [SETUP_GUIDE.md](./SETUP_GUIDE.md) for more troubleshooting.

---

## 📦 Dependencies at a Glance

```
Spring Boot 3.3.4
├── spring-boot-starter-web (REST & web)
├── spring-boot-starter-data-jpa (Database)
├── spring-boot-starter-thymeleaf (Templates)
├── h2database (Dev database)
└── spring-boot-starter-test (Testing)
```

View full dependency tree:
```powershell
mvn dependency:tree
```

---

## 👨‍💻 Contributing

1. Create a feature branch
2. Make your changes
3. Test locally: `.\build-run.ps1 dev`
4. Build and verify: `.\build-run.ps1 build`
5. Commit and push

---

## 📝 Notes

- This is a **professional Spring Boot application**, not a simple console app
- Uses **Hibernate ORM** for database operations
- Fully **automated build & run scripts**
- Production-ready with dev/prod configurations
- **H2 Console** available for database inspection during development

---

## 📞 Support

- Check [SETUP_GUIDE.md](./SETUP_GUIDE.md) for detailed documentation
- Check [DEPENDENCY_MANAGEMENT.md](./DEPENDENCY_MANAGEMENT.md) for dependency help
- Review application logs in console output

---

## 📄 Project Info

- **Application Name**: Car Rental System
- **Version**: 0.0.1-SNAPSHOT
- **Spring Boot**: 3.3.4
- **Java Version**: 17+
- **Last Updated**: November 11, 2025

---

**Ready to build? Run: `.\build-run.ps1 build-run`** 🚀
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
