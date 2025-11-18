// Car image database - Maps car make/model to image URLs
// These are free, publicly available car images

export const CAR_IMAGES = {
  'Toyota-Corolla': 'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=400&h=300&fit=crop',
  'Toyota-Camry': 'https://images.unsplash.com/photo-1605559424843-9e4c3ca4b7f1?w=400&h=300&fit=crop',
  'Honda-Civic': 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&h=300&fit=crop',
  'Honda-Accord': 'https://images.unsplash.com/photo-1552608944-4cb28e81ecc3?w=400&h=300&fit=crop',
  'BMW-X5': 'https://images.unsplash.com/photo-1552608944-4cb28e81ecc3?w=400&h=300&fit=crop',
  'BMW-Series': 'https://images.unsplash.com/photo-1605559424843-9e4c3ca4b7f1?w=400&h=300&fit=crop',
  'Mercedes-Benz': 'https://images.unsplash.com/photo-1506157786151-b8491531f063?w=400&h=300&fit=crop',
  'Ford-Mustang': 'https://images.unsplash.com/photo-1494976866556-6812c9d1c72e?w=400&h=300&fit=crop',
  'Audi-A4': 'https://images.unsplash.com/photo-1605559424843-9e4c3ca4b7f1?w=400&h=300&fit=crop',
  'Volkswagen-Golf': 'https://images.unsplash.com/photo-1585010589290-04a97a18e16b?w=400&h=300&fit=crop'
};

// Fallback image for cars without specific images
export const DEFAULT_CAR_IMAGE = 'https://images.unsplash.com/photo-1552608944-4cb28e81ecc3?w=400&h=300&fit=crop';

// Get car image by make and model
export const getCarImage = (make, model) => {
  const key = `${make}-${model}`;
  return CAR_IMAGES[key] || DEFAULT_CAR_IMAGE;
};

// Car icon emoji
export const CAR_EMOJI = '🚗';

// Fallback emoji when image fails to load
export const FALLBACK_EMOJI = '🏎️';
