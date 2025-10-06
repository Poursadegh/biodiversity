#!/bin/bash

# Test Docker Build and Deployment Script
# This script helps verify the Docker configuration works correctly

set -e  # Exit on error

echo "🐳 Testing Docker Build for Railway Deployment"
echo "================================================"
echo ""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

IMAGE_NAME="biodiversity-dashboard"
CONTAINER_NAME="bio-test"
PORT=8000

# Step 1: Build
echo -e "${BLUE}Step 1: Building Docker image...${NC}"
docker build -t $IMAGE_NAME . || {
    echo -e "${RED}❌ Build failed!${NC}"
    exit 1
}
echo -e "${GREEN}✅ Build successful!${NC}"
echo ""

# Step 2: Run
echo -e "${BLUE}Step 2: Starting container...${NC}"
docker run -d \
    --name $CONTAINER_NAME \
    -p $PORT:$PORT \
    -e PORT=$PORT \
    $IMAGE_NAME || {
    echo -e "${RED}❌ Container failed to start!${NC}"
    exit 1
}
echo -e "${GREEN}✅ Container started!${NC}"
echo ""

# Step 3: Wait for startup
echo -e "${BLUE}Step 3: Waiting for app to start (10 seconds)...${NC}"
sleep 10

# Step 4: Test health endpoint
echo -e "${BLUE}Step 4: Testing health endpoint...${NC}"
HEALTH_RESPONSE=$(curl -s http://localhost:$PORT/health || echo "failed")

if [[ $HEALTH_RESPONSE == *"healthy"* ]]; then
    echo -e "${GREEN}✅ Health check passed!${NC}"
    echo "Response: $HEALTH_RESPONSE"
else
    echo -e "${RED}❌ Health check failed!${NC}"
    echo "Response: $HEALTH_RESPONSE"
fi
echo ""

# Step 5: Test API endpoint
echo -e "${BLUE}Step 5: Testing API endpoint...${NC}"
API_RESPONSE=$(curl -s http://localhost:$PORT/api || echo "failed")

if [[ $API_RESPONSE == *"Biodiversity"* ]]; then
    echo -e "${GREEN}✅ API check passed!${NC}"
    echo "Response: $API_RESPONSE"
else
    echo -e "${RED}❌ API check failed!${NC}"
    echo "Response: $API_RESPONSE"
fi
echo ""

# Step 6: Test dashboard stats
echo -e "${BLUE}Step 6: Testing dashboard stats endpoint...${NC}"
STATS_RESPONSE=$(curl -s http://localhost:$PORT/api/dashboard/stats || echo "failed")

if [[ $STATS_RESPONSE == *"totalSpecies"* ]]; then
    echo -e "${GREEN}✅ Dashboard stats check passed!${NC}"
    echo "Response: $STATS_RESPONSE"
else
    echo -e "${RED}❌ Dashboard stats check failed!${NC}"
    echo "Response: $STATS_RESPONSE"
fi
echo ""

# Step 7: Test frontend
echo -e "${BLUE}Step 7: Testing frontend...${NC}"
FRONTEND_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:$PORT/ || echo "failed")

if [[ $FRONTEND_RESPONSE == "200" ]]; then
    echo -e "${GREEN}✅ Frontend check passed!${NC}"
    echo "HTTP Status: $FRONTEND_RESPONSE"
else
    echo -e "${RED}❌ Frontend check failed!${NC}"
    echo "HTTP Status: $FRONTEND_RESPONSE"
fi
echo ""

# Summary
echo "================================================"
echo -e "${GREEN}🎉 All tests completed!${NC}"
echo ""
echo "📊 Container info:"
docker ps --filter name=$CONTAINER_NAME --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
echo ""
echo "🌐 Access your app at: http://localhost:$PORT"
echo ""
echo "📝 View logs with: docker logs $CONTAINER_NAME"
echo "🛑 Stop container with: docker stop $CONTAINER_NAME"
echo "🗑️  Remove container with: docker rm $CONTAINER_NAME"
echo ""
echo -e "${BLUE}Tip: Leave the container running to test the app in your browser!${NC}"
echo "================================================"

