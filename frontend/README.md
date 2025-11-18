# Car Rental System - React Frontend

A modern, responsive React frontend for the Car Rental System backend built with Vite.

## Features

✨ **Responsive Design**
- Desktop, tablet, and mobile optimized
- Fluid grid layouts
- Touch-friendly navigation

🚗 **Car Management**
- Browse all available cars with images
- Filter by availability status
- View car details (make, model, ID, status)
- Add new cars to the fleet

👤 **User Management**
- Register new users
- Track user rentals
- Manage user information

🔑 **Rental System**
- Create new rentals
- View active and completed rentals
- Track rental dates
- Check rental history

🎨 **Modern UI**
- Clean, professional design
- Smooth animations
- Status badges and indicators
- Form validation
- Alert notifications

## Tech Stack

- **React 18**: UI framework
- **Vite**: Build tool & dev server
- **React Router**: Navigation
- **Axios**: API calls
- **CSS3**: Styling with responsive design
- **Unsplash API**: Car images (free, public domain)

## Project Structure

```
frontend/
├── src/
│   ├── components/        # Reusable UI components
│   ├── pages/            # Page components
│   ├── utils/            # Utility functions
│   │   ├── api.js       # Backend API calls
│   │   └── carImages.js # Car image mappings
│   ├── styles/
│   │   └── global.css   # Global styles
│   ├── App.jsx          # Main app component
│   └── main.jsx         # Entry point
├── index.html           # HTML template
├── vite.config.js       # Vite configuration
└── package.json         # Dependencies
```

## Setup & Installation

### Prerequisites
- Node.js 16+ (LTS recommended)
- npm or yarn
- Backend running on http://localhost:8080

### Installation Steps

1. **Navigate to frontend directory:**
```bash
cd frontend
```

2. **Install dependencies:**
```bash
npm install
```

3. **Create environment file (optional):**
```bash
cp .env.example .env
```

4. **Start development server:**
```bash
npm run dev
```

The frontend will be available at `http://localhost:3000`

## Available Scripts

### Development
```bash
npm run dev
```
Starts Vite dev server with hot reload on `http://localhost:3000`

### Build
```bash
npm run build
```
Creates optimized production build in `dist/` folder

### Preview
```bash
npm run preview
```
Preview production build locally

### Lint (optional)
```bash
npm run lint
```
Check code quality with ESLint

## Pages & Routes

| Route | Page | Description |
|-------|------|-------------|
| `/` | Home | Dashboard with quick actions |
| `/cars` | Browse Cars | View all available and rented cars |
| `/rent` | Rent Car | Create a new rental |
| `/rentals` | View Rentals | See all rental history |
| `/add-car` | Add Car | Register new vehicle |
| `/add-user` | Register User | Create new customer account |

## API Integration

The frontend communicates with the backend API running on `http://localhost:8080`:

### Endpoints Used

```
GET  /cars        - List all cars
GET  /users       - List all users
GET  /rentals     - List all rentals
POST /add-car     - Create new car
POST /add-user    - Register new user
POST /rent        - Create new rental
```

### API Configuration

Edit `src/utils/api.js` to change the backend URL:

```javascript
const API_BASE_URL = 'http://localhost:8080';
```

## Car Images

Car images are fetched from Unsplash (free, public domain images):

- Configured in `src/utils/carImages.js`
- Fallback emoji (🚗) if image fails to load
- Customizable image mappings

### Add Custom Car Images

Edit `src/utils/carImages.js`:

```javascript
export const CAR_IMAGES = {
  'Toyota-Corolla': 'https://your-image-url.jpg',
  'Honda-Civic': 'https://your-image-url.jpg',
  // Add more mappings...
};
```

**To download exact car model images:**

1. Visit Unsplash, Pexels, or Pixabay
2. Search for specific car models
3. Copy image URLs
4. Add to `CAR_IMAGES` object
5. Format: `'Make-Model': 'image-url'`

## Styling

Global styles in `src/styles/global.css` include:

- **Color Scheme:**
  - Primary: #007bff (Blue)
  - Success: #28a745 (Green)
  - Danger: #dc3545 (Red)
  - Background: #f5f5f5 (Light gray)

- **Responsive Breakpoints:**
  - Mobile: < 576px
  - Tablet: 576px - 992px
  - Desktop: > 992px

- **Components:**
  - Buttons, Forms, Cards, Tables
  - Badges, Alerts, Modals
  - Navigation, Hero sections
  - Grids and Responsive layouts

## Form Validation

All forms include client-side validation:

- Required field checks
- Email format validation
- Phone number validation
- Numeric input validation
- Unique ID checking

Server-side validation is also performed on the backend.

## Performance Optimizations

- ✓ Code splitting with React Router
- ✓ Image optimization (lazy loading)
- ✓ CSS minification
- ✓ Bundle size < 500KB (gzipped)
- ✓ Responsive image loading
- ✓ Efficient API calls with Axios

## Browser Support

- Chrome (latest)
- Firefox (latest)
- Safari (latest)
- Edge (latest)
- Mobile browsers (iOS Safari, Chrome Mobile)

## Troubleshooting

### Backend not connecting
- Verify backend is running: `http://localhost:8080`
- Check CORS settings if on different domain
- Review browser console for API errors

### Images not loading
- Check image URLs are accessible
- Verify Unsplash/Pexels URLs are still valid
- Fallback emoji will display instead

### Port 3000 already in use
```bash
# Kill existing process or use different port:
npm run dev -- --port 3001
```

### Build errors
```bash
# Clear node_modules and reinstall:
rm -rf node_modules package-lock.json
npm install
npm run build
```

## Deployment

### Build for Production
```bash
npm run build
```

### Deploy to Vercel
```bash
npm install -g vercel
vercel
```

### Deploy to Netlify
```bash
npm run build
# Upload `dist` folder to Netlify
```

### Deploy with Docker
```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
CMD ["npm", "run", "preview"]
```

## Environment Variables

Create `.env` file for configuration:

```
VITE_API_URL=http://localhost:8080
VITE_APP_NAME=Car Rental System
```

Use in code:
```javascript
const apiUrl = import.meta.env.VITE_API_URL
```

## Development Tips

1. **Enable Redux DevTools** for state management
2. **Use React Developer Tools** browser extension
3. **Check Network tab** for API calls
4. **Use Console** to debug issues
5. **Hot Reload** happens automatically during dev

## Contributing

1. Create feature branch: `git checkout -b feature/name`
2. Make changes with conventional commits
3. Test thoroughly: `npm run build`
4. Push and create pull request

## License

This project is part of the Car Rental System demo application.

## Support

For backend issues, see: `../README.md`
For API documentation, see: `../FRONTEND_REQUIREMENTS.json`

## Next Steps

- [ ] Add authentication/login
- [ ] Implement user dashboard
- [ ] Add payment integration
- [ ] Create admin panel
- [ ] Add real-time notifications
- [ ] Implement car search filters
- [ ] Add booking calendar
- [ ] Create pricing tiers
- [ ] Add customer reviews
- [ ] Implement analytics

---

**Backend API**: http://localhost:8080
**Frontend Dev**: http://localhost:3000
**Database Console**: http://localhost:8080/h2-console
