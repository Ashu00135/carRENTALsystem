# Frontend Development Guide - Car Rental System

## Quick Overview

This document explains what the frontend needs to implement for the Car Rental System backend that's running on `http://localhost:8080`

## System Architecture

```
Browser/Frontend (HTML/CSS/JS or React/Vue/Angular)
        ↓ HTTP Requests (JSON/Form Data)
        ↓
Spring Boot Backend (http://localhost:8080)
        ↓
H2 Database
```

## Pages & Features Required

### 1. **Home Page** (`/`)
- Welcome message
- 6 main action buttons in a grid:
  - List Available Cars
  - Rent a Car
  - View Rentals
  - Add New Car
  - Register New User
  - H2 Database Console

### 2. **Cars List Page** (`/cars`)
- Display all available cars in a table/grid
- Columns: ID, Make, Model, Status (Available/Rented)
- Search/Filter by make
- Filter by availability status
- Action buttons: View Details, Rent Now

### 3. **Rent Car Page** (`/rent`)
- Form with 2 required dropdowns:
  - **User Selection**: Choose from list of registered users
  - **Car Selection**: Choose from available cars only
- Optional fields:
  - Rental start date
  - Estimated return date
- Submit button: "Complete Rental"

### 4. **View Rentals Page** (`/rentals`)
- Table showing all rental records
- Columns: Rental ID, Customer Name, Car (Make/Model), Rental Date, Return Date, Status
- Filters:
  - By user
  - By status (Active/Completed)
  - By date range
- Sortable columns
- Pagination (15 items per page)

### 5. **Add Car Page** (`/add-car`)
- Form fields:
  - **Car ID** (required, unique number)
  - **Make** (required, e.g., "Toyota")
  - **Model** (required, e.g., "Corolla")
  - Year (optional)
  - Color (optional)
  - License Plate (optional)
  - Daily Rate (optional)
  - Status (Available/Maintenance)
- Submit button: "Add Car"

### 6. **Register User Page** (`/add-user`)
- Form fields:
  - **User ID** (required, unique number)
  - **Full Name** (required)
  - Email (optional)
  - Phone (optional)
  - Driver's License Number (optional)
  - Address (optional)
- Submit button: "Register Customer"

### 7. **H2 Database Console** (`/h2-console`)
- Link to backend's database console
- Allow direct SQL queries (development only)

## API Endpoints to Call

```
GET  /              → Home page (HTML)
GET  /cars          → List cars page (HTML)
GET  /rent          → Rent form page (HTML)
POST /rent          → Submit rental (redirect on success)
GET  /rentals       → View rentals page (HTML)
GET  /add-car       → Add car form page (HTML)
POST /add-car       → Submit new car (redirect on success)
GET  /add-user      → Register user form page (HTML)
POST /add-user      → Submit user registration (redirect on success)
GET  /h2-console    → Database console
```

### Important Form Parameters

**For `/rent` (POST):**
```
userId: integer (which user is renting)
carId:  integer (which car to rent)
```

**For `/add-car` (POST):**
```
id:    integer (unique)
make:  string (e.g., "Toyota")
model: string (e.g., "Corolla")
```

**For `/add-user` (POST):**
```
id:   integer (unique)
name: string (full name)
```

## Design Requirements

### Color Scheme
- **Primary**: #007bff (Blue) - Buttons, links
- **Success**: #28a745 (Green) - Success messages
- **Danger**: #dc3545 (Red) - Errors, delete buttons
- **Background**: #f5f5f5 (Light gray)
- **Text**: #333333 (Dark gray)

### Layout
- **Max width**: 1200px
- **Responsive**: Mobile (< 576px), Tablet (576-992px), Desktop (> 992px)
- **Font**: Arial/Helvetica, 16px body text, 24px headings
- **Padding**: 20px desktop, 10px mobile

### Essential Components
- Navigation bar (with links to all pages)
- Responsive forms with validation
- Tables with sorting and pagination
- Status badges (Available/Rented, Active/Completed)
- Error/success message displays
- Loading spinners
- Responsive buttons

## Form Validation

### Client-Side (Frontend) - MUST implement:
- Required field validation
- Unique ID validation (show error if trying to add duplicate)
- Email format validation
- Phone number format validation
- Number range validation (year 2000-2025, etc.)

### Server-Side (Backend) - Already implemented

## Recommended Tech Stack Options

### Option 1: Vanilla HTML/CSS/JavaScript
```
Pros: Lightweight, no build process
Cons: Limited scalability, more code
```

### Option 2: React + React Router + Axios
```
Pros: Component-based, scalable, large ecosystem
Cons: Build process, steeper learning curve
```

### Option 3: Vue.js + Vue Router + Axios
```
Pros: Easy to learn, great documentation
Cons: Smaller ecosystem than React
```

### Option 4: Angular + TypeScript
```
Pros: Full-featured, enterprise-ready
Cons: Heavy, steep learning curve
```

## Project Setup (if using React)

```bash
# Create project
npm create vite@latest car-rental-frontend -- --template react
cd car-rental-frontend

# Install dependencies
npm install
npm install react-router-dom axios

# Start development server
npm run dev

# Build for production
npm run build
```

## Testing Checklist

- [ ] All forms submit correctly to backend
- [ ] Error messages display on validation failure
- [ ] Success messages display on form submission
- [ ] Dropdown data loads from backend
- [ ] Tables display data correctly
- [ ] Pagination works
- [ ] Search/filter functionality works
- [ ] Responsive design works on mobile/tablet/desktop
- [ ] Loading states show during API calls
- [ ] Form fields reset after successful submission

## Performance Goals

- Page load time: < 3 seconds
- Time to interactive: < 5 seconds
- Bundle size: < 500KB (gzipped)

## Deployment Options

- **Vercel** (for Next.js)
- **Netlify** (for React/Vue)
- **AWS S3 + CloudFront**
- **GitHub Pages**
- **Docker** (for containerization)

## Development Workflow

```
1. Set up project structure
2. Create page components/templates
3. Create reusable UI components
4. Implement form handling
5. Integrate with backend API
6. Add validation and error handling
7. Style with CSS (use color scheme above)
8. Make responsive
9. Test all features
10. Deploy
```

## Important Notes

- **Backend is running on**: `http://localhost:8080`
- **Database**: H2 (in-memory, development only)
- **CORS**: Configure if running frontend on different port/domain
- **Session**: Backend uses server-side sessions (likely)
- **Forms**: Use POST method for creating/updating data

## Quick Links

- 📖 [Full Requirements JSON](./FRONTEND_REQUIREMENTS.json)
- 🔧 [Backend README](./README.md)
- 📊 [API Endpoints](./FRONTEND_REQUIREMENTS.json#api_endpoints)
- 🎨 [UI Components Spec](./FRONTEND_REQUIREMENTS.json#ui_components)

## Questions?

Refer to the detailed `FRONTEND_REQUIREMENTS.json` file for:
- Complete page layouts
- Exact API parameter specifications
- Component details
- Styling specifications
- Testing recommendations
