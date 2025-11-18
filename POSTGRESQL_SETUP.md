# 🗄️ PostgreSQL Database Setup Guide

## Issue Identified
The application was configured for **H2 in-memory database** but you're using **PostgreSQL with DBeaver**.

## ✅ Fixes Applied

1. ✅ Added PostgreSQL dependency to `pom.xml`
2. ✅ Created PostgreSQL configuration in `application-postgres.properties`
3. ✅ Updated main `application.properties` to use PostgreSQL
4. ✅ Created `database-setup.sql` script for DBeaver
5. ✅ Fixed API routing issues (from previous fix)

---

## 📋 Step-by-Step Setup Instructions

### Step 1: Setup PostgreSQL Database in DBeaver

1. **Open DBeaver**

2. **Create a new PostgreSQL connection** (if not already connected):
   - Host: `localhost`
   - Port: `5432`
   - Database: `postgres` (initially)
   - Username: `postgres`
   - Password: `postgres` (or your PostgreSQL password)

3. **Create the `carrental` database**:
   - Right-click on your PostgreSQL connection
   - Select **SQL Editor** → **New SQL Script**
   - Copy and paste this:
   ```sql
   CREATE DATABASE carrental
       WITH 
       OWNER = postgres
       ENCODING = 'UTF8';
   ```
   - Click **Execute** (Ctrl+Enter)

4. **Connect to the `carrental` database**:
   - Refresh your connection
   - You should see `carrental` database in the list
   - Right-click → **Set Active Database**

5. **Run the setup script**:
   - Open `CarRentalSystem/database-setup.sql` in DBeaver
   - **Skip the first CREATE DATABASE command** (you already did it)
   - Execute the rest of the script to create tables and sample data
   - Or let Spring Boot auto-create tables (recommended)

---

### Step 2: Update Database Credentials (if needed)

If your PostgreSQL username/password is different, update these files:

**File: `CarRentalSystem/src/main/resources/application.properties`**
```properties
spring.datasource.username=YOUR_USERNAME
spring.datasource.password=YOUR_PASSWORD
```

**File: `CarRentalSystem/src/main/resources/application-postgres.properties`**
```properties
spring.datasource.username=YOUR_USERNAME
spring.datasource.password=YOUR_PASSWORD
```

---

### Step 3: Rebuild and Restart the Application

1. **Stop all running processes**:
   ```powershell
   Get-Process java,node -ErrorAction SilentlyContinue | Stop-Process -Force
   ```

2. **Navigate to backend directory**:
   ```powershell
   cd d:\PROJECTS\car_manager\carRENTALsystem\CarRentalSystem
   ```

3. **Clean and rebuild**:
   ```powershell
   mvn clean package -DskipTests
   ```

4. **Start the backend**:
   ```powershell
   java -jar target\carrental-0.0.1-SNAPSHOT.jar
   ```

   You should see logs like:
   ```
   Hibernate: create table car ...
   Hibernate: create table app_user ...
   Hibernate: create table rental ...
   ```

5. **In a new terminal, start frontend**:
   ```powershell
   cd d:\PROJECTS\car_manager\carRENTALsystem\frontend
   npm run dev
   ```

---

### Step 4: Verify in DBeaver

1. **Refresh the `carrental` database** in DBeaver
2. You should now see these tables in the **public** schema:
   - `car`
   - `app_user` (or `user_table`)
   - `rental`

3. **Query the tables**:
   ```sql
   SELECT * FROM car;
   SELECT * FROM app_user;
   SELECT * FROM rental;
   ```

---

### Step 5: Test the Application

1. **Open**: http://localhost:3000

2. **Add a User**:
   - Click "Register User"
   - Add: Name="Test User", Email="test@test.com"
   - Check DBeaver: `SELECT * FROM app_user;`

3. **Add a Car**:
   - Click "Add Car"
   - Add: ID=10, Make="Tesla", Model="Model 3"
   - Check DBeaver: `SELECT * FROM car;`

4. **Create a Rental**:
   - Click "Rent a Car"
   - Select user and car
   - Click "Complete Rental"
   - Check DBeaver: `SELECT * FROM rental;`

---

## 🔍 Troubleshooting

### Problem: "Connection refused" or "Database does not exist"

**Solution**:
1. Verify PostgreSQL is running:
   ```powershell
   Get-Service postgresql*
   ```
2. Check if database exists in DBeaver
3. Verify connection string in `application.properties`:
   ```properties
   spring.datasource.url=jdbc:postgresql://localhost:5432/carrental
   ```

---

### Problem: "Password authentication failed"

**Solution**:
Update username/password in `application.properties`:
```properties
spring.datasource.username=YOUR_USERNAME
spring.datasource.password=YOUR_PASSWORD
```

---

### Problem: "No schema found in DBeaver"

**Solution**:
1. The schema is `public` (default PostgreSQL schema)
2. In DBeaver, expand: `carrental` → `Schemas` → `public` → `Tables`
3. If still not visible, let Spring Boot create tables:
   - Start the backend
   - Check logs for "Hibernate: create table..."
   - Refresh DBeaver (F5)

---

### Problem: Tables not created automatically

**Solution**:
1. Check application logs for errors
2. Verify `application.properties` has:
   ```properties
   spring.jpa.hibernate.ddl-auto=update
   ```
3. Manually create tables using `database-setup.sql`

---

### Problem: Frontend shows "Network Error"

**Solution**:
1. Verify backend is running: http://localhost:8080/api/health
2. Check CORS settings in `ApiController.java`:
   ```java
   @CrossOrigin(origins = "http://localhost:3000")
   ```
3. Clear browser cache and refresh

---

## 📊 Database Schema

```
┌─────────────────┐         ┌─────────────────┐
│      CAR        │         │    APP_USER     │
├─────────────────┤         ├─────────────────┤
│ id (PK)         │         │ id (PK)         │
│ make            │         │ name            │
│ model           │         │ email           │
│ available       │         │ phone           │
└─────────────────┘         └─────────────────┘
         ▲                           ▲
         │                           │
         │      ┌─────────────────┐  │
         │      │     RENTAL      │  │
         │      ├─────────────────┤  │
         └──────│ id (PK)         │  │
                │ car_id (FK)     │──┘
                │ user_id (FK)    │
                │ rental_date     │
                └─────────────────┘
```

---

## 🎯 Configuration Summary

| Setting | H2 (Old) | PostgreSQL (New) |
|---------|----------|------------------|
| Database | In-memory | Persistent |
| Driver | `org.h2.Driver` | `org.postgresql.Driver` |
| URL | `jdbc:h2:mem:carrental` | `jdbc:postgresql://localhost:5432/carrental` |
| Dialect | `H2Dialect` | `PostgreSQLDialect` |
| Data Persistence | Lost on restart | Saved permanently |
| DBeaver Support | Limited | Full support ✅ |

---

## 📝 Next Steps

1. ✅ Create database in DBeaver
2. ✅ Update credentials if needed
3. ✅ Rebuild application
4. ✅ Start backend and frontend
5. ✅ Verify tables appear in DBeaver
6. ✅ Test CRUD operations
7. ✅ Monitor database in real-time with DBeaver

---

## 🚀 Quick Start Command

Run this all-in-one script:

```powershell
# Stop processes
Get-Process java,node -ErrorAction SilentlyContinue | Stop-Process -Force

# Rebuild
cd d:\PROJECTS\car_manager\carRENTALsystem\CarRentalSystem
mvn clean package -DskipTests

# Start backend (in new window)
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd d:\PROJECTS\car_manager\carRENTALsystem\CarRentalSystem; java -jar target\carrental-0.0.1-SNAPSHOT.jar"

# Wait for backend
Start-Sleep -Seconds 20

# Start frontend (in new window)
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd d:\PROJECTS\car_manager\carRENTALsystem\frontend; npm run dev"

Write-Host "✓ Services started!" -ForegroundColor Green
Write-Host "Backend:  http://localhost:8080" -ForegroundColor Cyan
Write-Host "Frontend: http://localhost:3000" -ForegroundColor Cyan
```

---

## ✅ Success Indicators

You'll know it's working when:
- ✅ Backend logs show: `Started CarRentalSystemApplication`
- ✅ DBeaver shows tables: `car`, `app_user`, `rental`
- ✅ Frontend loads at http://localhost:3000
- ✅ You can create rentals without "Network Error"
- ✅ Data persists in PostgreSQL (survives restart)
