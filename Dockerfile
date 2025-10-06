# ==================================
# Stage 1: Build Frontend
# ==================================
FROM node:18-alpine AS frontend-build

WORKDIR /app/frontend

# Copy package files for better caching
COPY frontend/package*.json ./

# Install ALL dependencies (including devDependencies needed for build)
RUN npm ci && npm cache clean --force

# Copy frontend source
COPY frontend/ ./

# Build the React application
RUN npm run build

# ==================================
# Stage 2: Python Backend
# ==================================
FROM python:3.11-slim

WORKDIR /app

# Install system dependencies (gcc needed for some Python packages)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy and install Python dependencies first (better caching)
COPY backend/requirements.txt ./requirements.txt
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy backend application code
COPY backend/ ./

# Copy pre-existing data files (faster than generating)
COPY data/ ./data/

# Copy built frontend static files
COPY --from=frontend-build /app/frontend/build ./static

# Create non-root user for security
RUN useradd -m -u 1000 appuser && \
    chown -R appuser:appuser /app
USER appuser

# Railway automatically provides PORT env variable
# Default to 8000 if not set
ENV PORT=8000

# Expose the port (Railway will override this)
EXPOSE $PORT

# Health check for Railway
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD curl -f http://localhost:${PORT}/health || exit 1

# Run with uvicorn for production
# Railway sets PORT dynamically
CMD uvicorn main:app --host 0.0.0.0 --port ${PORT} --workers 2 --log-level info
