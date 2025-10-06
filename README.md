# Biodiversity Dashboard

A web application for visualizing species observations from the Global Biodiversity Information Facility (GBIF) data, specifically focused on Poland. The application allows users to search for species, view their observations on an interactive map, and analyze temporal patterns through timeline visualizations.

## Features

### Core Features
- **Species Search**: Search for species by scientific name or vernacular name with real-time suggestions
- **Interactive Map**: Visualize species observations on an interactive map with custom markers
- **Timeline Visualization**: View temporal distribution of observations using interactive charts
- **Dashboard Statistics**: Overview of the dataset with key metrics and top observed species
- **Responsive Design**: Modern, mobile-friendly interface built with React and Tailwind CSS

### Technical Features
- **FastAPI Backend**: High-performance Python API with automatic documentation
- **React Frontend**: Modern React application with hooks and functional components
- **Real-time Search**: Debounced search with loading states and error handling
- **Data Optimization**: Efficient data processing and caching for large datasets
- **Unit Tests**: Comprehensive test coverage for backend API endpoints

## Technology Stack

### Backend
- **FastAPI**: Modern, fast web framework for building APIs
- **Pandas**: Data manipulation and analysis
- **NumPy**: Numerical computing
- **Pytest**: Testing framework
- **Uvicorn**: ASGI server

### Frontend
- **React 18**: Modern React with hooks
- **Tailwind CSS**: Utility-first CSS framework
- **React Leaflet**: Interactive maps
- **Recharts**: Data visualization
- **Axios**: HTTP client
- **Lucide React**: Icon library

## Project Structure

```
biodiversity-dashboard/
├── backend/
│   ├── main.py                 # FastAPI application
│   ├── tests/
│   │   └── test_api.py        # Unit tests
│   └── requirements.txt       # Python dependencies
├── frontend/
│   ├── public/
│   │   ├── index.html
│   │   └── manifest.json
│   ├── src/
│   │   ├── components/        # React components
│   │   │   ├── Header.js
│   │   │   ├── SearchBar.js
│   │   │   ├── MapVisualization.js
│   │   │   ├── TimelineChart.js
│   │   │   ├── SpeciesInfo.js
│   │   │   └── DashboardStats.js
│   │   ├── services/
│   │   │   └── api.js         # API service layer
│   │   ├── App.js
│   │   ├── index.js
│   │   └── index.css
│   ├── package.json
│   └── tailwind.config.js
├── scripts/
│   └── download_data.py       # Data download script
├── data/                      # Data files
└── README.md
```

## Installation and Setup

### Prerequisites
- Python 3.8+
- Node.js 16+
- npm or yarn

### Backend Setup

1. **Create virtual environment**:
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

2. **Install dependencies**:
   ```bash
   cd backend
   pip install -r requirements.txt
   ```

3. **Download data**:
   ```bash
   cd ../scripts
   python download_data.py
   ```

4. **Run the backend**:
   ```bash
   cd ../backend
   python main.py
   ```

The API will be available at `http://localhost:8000`

### Frontend Setup

1. **Install dependencies**:
   ```bash
   cd frontend
   npm install
   ```

2. **Start development server**:
   ```bash
   npm start
   ```

The application will be available at `http://localhost:3000`

## API Documentation

The FastAPI backend provides automatic interactive documentation at:
- Swagger UI: `http://localhost:8000/docs`
- ReDoc: `http://localhost:8000/redoc`

### Endpoints

- `GET /health` - Health check
- `GET /api/species/search?query={query}&limit={limit}` - Search species
- `GET /api/species/{species_key}/observations` - Get species observations
- `GET /api/species/{species_key}/timeline` - Get species timeline data
- `GET /api/dashboard/stats` - Get dashboard statistics

## Data Source

The application uses data from the Global Biodiversity Information Facility (GBIF):
- **Dataset**: GBIF occurrence data
- **Geographic Scope**: Poland (country code: PL)
- **Time Range**: 2000-2023
- **Data Types**: Human observations, machine observations
- **Quality Filters**: Only records with valid coordinates and no geospatial issues

## Performance Optimizations

### Backend Optimizations
- **Data Preprocessing**: Species and observations data are preprocessed and stored as CSV files
- **Efficient Queries**: Pandas operations optimized for large datasets
- **Memory Management**: Data loaded once at startup to avoid repeated I/O
- **Response Caching**: API responses are optimized for minimal data transfer

### Frontend Optimizations
- **Debounced Search**: Search requests are debounced to reduce API calls
- **Component Memoization**: React components optimized to prevent unnecessary re-renders
- **Lazy Loading**: Map and chart components load only when needed
- **Efficient State Management**: Minimal state updates and proper dependency arrays

### Data Optimizations
- **Geographic Filtering**: Data filtered to Poland boundaries to reduce dataset size
- **Coordinate Validation**: Only records with valid coordinates are included
- **Temporal Filtering**: Focus on recent data (2000-2023) for better performance
- **Species Deduplication**: Unique species list created to avoid redundant data

## Testing

### Backend Tests
Run the test suite:
```bash
cd backend
pytest tests/test_api.py -v
```

### Frontend Tests
Run the test suite:
```bash
cd frontend
npm test
```

## Deployment

### 🚂 Railway (Recommended)

**Quick Deploy in 3 steps:**

1. Push to GitHub
   ```bash
   git push origin main
   ```

2. Deploy on Railway
   - Go to [railway.app](https://railway.app)
   - Click "Deploy from GitHub repo"
   - Select your repository

3. Get your URL
   - Generate domain in settings
   - Your app is live! 🎉

📖 **Full Guide**: [RAILWAY_DEPLOYMENT.md](./RAILWAY_DEPLOYMENT.md)  
⚡ **Quick Start**: [RAILWAY_QUICK_START.md](./RAILWAY_QUICK_START.md)

### 🐳 Docker (Local Testing)

```bash
# Build and run locally
docker build -t biodiversity-dashboard .
docker run -p 8000:8000 biodiversity-dashboard

# Open http://localhost:8000
```

### Other Platforms

#### Render.com
1. Go to [render.com](https://render.com)
2. Create Web Service from GitHub
3. Select **Docker** as runtime
4. Deploy! (takes ~5-10 minutes)

📖 **Full Guide**: [RENDER_DEPLOYMENT.md](./RENDER_DEPLOYMENT.md)

#### Vercel
**Best for Frontend**
1. Go to [vercel.com](https://vercel.com)
2. Import GitHub repository
3. Set Root Directory: `frontend`
4. Add Environment Variable: `REACT_APP_API_URL`
5. Deploy!

📖 **Full Guide**: [VERCEL_DEPLOYMENT.md](./VERCEL_DEPLOYMENT.md)

#### Fly.io
```bash
fly auth login
fly launch
fly deploy
```

### Environment Variables
Railway automatically provides `PORT`. Optional variables:
```bash
CORS_ORIGINS=https://yourdomain.com
LOG_LEVEL=info
```

## Usage

1. **Search for Species**: Use the search bar to find species by name
2. **View Observations**: Click on a species to see its observations on the map
3. **Analyze Timeline**: View the temporal distribution of observations
4. **Explore Data**: Use the dashboard statistics to understand the dataset

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## License

This project is licensed under the MIT License.

## Acknowledgments

- **GBIF**: Global Biodiversity Information Facility for providing the data
- **OpenStreetMap**: Map tiles and geographic data
- **React Community**: For the excellent ecosystem and tools
- **FastAPI**: For the modern Python web framework

## Future Enhancements

- **Advanced Filtering**: Filter by date range, location, or observation type
- **Species Comparison**: Compare multiple species side by side
- **Export Functionality**: Export data and visualizations
- **Mobile App**: Native mobile application
- **Real-time Updates**: Live data updates from GBIF
- **Machine Learning**: Species prediction and classification
- **Social Features**: User accounts and saved searches

## Troubleshooting

### Common Issues

1. **Data not loading**: Ensure the data download script has run successfully
2. **CORS errors**: Check that the backend CORS settings include your frontend URL
3. **Map not displaying**: Verify that Leaflet CSS is properly imported
4. **Search not working**: Check the API connection and network requests

### Performance Issues

1. **Slow search**: Reduce the dataset size or implement server-side pagination
2. **Map lag**: Limit the number of markers displayed at once
3. **Memory usage**: Monitor data loading and implement data pagination

## Support

For questions or issues, please:
1. Check the troubleshooting section
2. Review the API documentation
3. Create an issue in the repository
4. Contact the development team

---

**Made with ❤️ for Biodiversity Research**
#   b i o d i v e r s i t y  
 