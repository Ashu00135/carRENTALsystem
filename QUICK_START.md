# Quick Reference - Car Rental System Spring Boot

## 🚀 Start Here

### 1. Verify Installation (PowerShell)
```powershell
java -version     # Should be Java 17+
mvn -v           # Should be Maven 3.9+
```

### 2. Navigate to Project
```powershell
cd d:\PROJECTS\car_manager\carRENTALsystem
```

### 3. Build & Run
```powershell
# PowerShell - Fastest
.\build-run.ps1 build-run

# Command Prompt
build-run.bat build-run

# Or manual
cd CarRentalSystem
mvn clean package
java -jar target/carrental-0.0.1-SNAPSHOT.jar
```

### 4. Access Application
Open browser: **http://localhost:8080**

---

## 📚 Documentation Files

| File | Purpose |
|------|---------|
| **README.md** | Main overview (you are here) |
| **SETUP_GUIDE.md** | Complete installation & troubleshooting |
| **DEPENDENCY_MANAGEMENT.md** | How to manage Maven dependencies |

---

## ⚡ Common Commands

### Build
```powershell
# Using script
.\build-run.ps1 build

# Using Maven directly
cd CarRentalSystem
mvn clean package

# Skip tests (faster)
mvn -DskipTests package
```

### Run
```powershell
# Using script on default port (8080)
.\build-run.ps1 run

# Using script on custom port
.\build-run.ps1 run -port 9090

# Dev mode (hot reload)
.\build-run.ps1 dev

# Direct
java -jar CarRentalSystem/target/carrental-0.0.1-SNAPSHOT.jar
```

### Clean
```powershell
.\build-run.ps1 clean
# or
mvn clean
```

### View Dependencies
```powershell
.\build-run.ps1 dependencies
# or
mvn dependency:tree
```

---

## 🌐 Important URLs

- **Web UI**: http://localhost:8080
- **H2 Console** (dev): http://localhost:8080/h2-console
- **Database JDBC URL**: `jdbc:h2:mem:carrental`
- **DB User**: `sa`
- **DB Password**: (empty)

---

## 🔧 Configuration

### Change Server Port
```powershell
# Run on different port
.\build-run.ps1 run -port 9090

# Or pass as argument
java -jar target/carrental-0.0.1-SNAPSHOT.jar --server.port=9090
```

### Change Environment
- **Development**: Uses H2 in-memory database
- **Production**: Edit `application-prod.properties` for MySQL/PostgreSQL

---

## 🐛 Quick Troubleshooting

| Problem | Solution |
|---------|----------|
| Java not found | Install JDK 17+ from oracle.com |
| Maven not found | Install Maven from maven.apache.org |
| Port in use | Use different port: `.\build-run.ps1 run -port 9090` |
| Build fails | Run `mvn clean install` |
| Hot reload not working | Use dev mode: `.\build-run.ps1 dev` |

---

## 📂 Project Structure

```
carRENTALsystem/
├── CarRentalSystem/          # Main source code
│   ├── src/main/java/        # Java source
│   ├── src/main/resources/   # Config & templates
│   ├── target/               # Build output (auto)
│   └── pom.xml               # Dependencies
├── build-run.ps1             # PowerShell script
├── build-run.bat             # Batch script
├── README.md                 # This file
├── SETUP_GUIDE.md            # Detailed guide
└── DEPENDENCY_MANAGEMENT.md  # Dependencies
```

---

## 📖 Get Help

1. **Quick issues**: See Quick Troubleshooting above
2. **Setup issues**: Read [SETUP_GUIDE.md](./SETUP_GUIDE.md)
3. **Dependency issues**: Read [DEPENDENCY_MANAGEMENT.md](./DEPENDENCY_MANAGEMENT.md)
4. **Need help?**: Check the logs in console output

---

## ✨ What's Included

✅ **Spring Boot 3.3.4** - Modern framework
✅ **Maven** - Dependency management
✅ **H2 Database** - Development database
✅ **Hibernate ORM** - Database mapping
✅ **Thymeleaf** - HTML templates
✅ **Build Scripts** - Automation
✅ **Complete Docs** - Setup guides
✅ **Dev & Prod Configs** - Environment profiles

---

## 🎯 Next Steps

1. **Build**: `.\build-run.ps1 build`
2. **Run**: `.\build-run.ps1 run`
3. **Visit**: http://localhost:8080
4. **Explore**: Add cars, users, manage rentals
5. **Develop**: Add features using Spring Boot

---

## 💡 Pro Tips

- Use `.\build-run.ps1 dev` for hot reload development
- Access H2 console at http://localhost:8080/h2-console
- View dependencies: `mvn dependency:tree`
- Run tests: `mvn test`
- Build faster: `mvn -DskipTests package`

---

**Last Updated**: November 11, 2025
**Version**: Spring Boot 3.3.4 | Java 17+
