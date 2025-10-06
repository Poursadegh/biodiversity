# Test Docker Build and Deployment Script (PowerShell)
# This script helps verify the Docker configuration works correctly

$ErrorActionPreference = "Stop"

Write-Host "🐳 Testing Docker Build for Railway Deployment" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

$IMAGE_NAME = "biodiversity-dashboard"
$CONTAINER_NAME = "bio-test"
$PORT = 8000

# Step 1: Build
Write-Host "Step 1: Building Docker image..." -ForegroundColor Blue
try {
    docker build -t $IMAGE_NAME .
    Write-Host "✅ Build successful!" -ForegroundColor Green
} catch {
    Write-Host "❌ Build failed!" -ForegroundColor Red
    exit 1
}
Write-Host ""

# Step 2: Run
Write-Host "Step 2: Starting container..." -ForegroundColor Blue
try {
    docker run -d `
        --name $CONTAINER_NAME `
        -p "${PORT}:${PORT}" `
        -e "PORT=$PORT" `
        $IMAGE_NAME | Out-Null
    Write-Host "✅ Container started!" -ForegroundColor Green
} catch {
    Write-Host "❌ Container failed to start!" -ForegroundColor Red
    exit 1
}
Write-Host ""

# Step 3: Wait for startup
Write-Host "Step 3: Waiting for app to start (10 seconds)..." -ForegroundColor Blue
Start-Sleep -Seconds 10

# Step 4: Test health endpoint
Write-Host "Step 4: Testing health endpoint..." -ForegroundColor Blue
try {
    $healthResponse = Invoke-WebRequest -Uri "http://localhost:${PORT}/health" -UseBasicParsing -TimeoutSec 5
    if ($healthResponse.Content -match "healthy") {
        Write-Host "✅ Health check passed!" -ForegroundColor Green
        Write-Host "Response: $($healthResponse.Content)" -ForegroundColor Gray
    } else {
        Write-Host "❌ Health check failed!" -ForegroundColor Red
        Write-Host "Response: $($healthResponse.Content)" -ForegroundColor Gray
    }
} catch {
    Write-Host "❌ Health check failed!" -ForegroundColor Red
    Write-Host "Error: $_" -ForegroundColor Red
}
Write-Host ""

# Step 5: Test API endpoint
Write-Host "Step 5: Testing API endpoint..." -ForegroundColor Blue
try {
    $apiResponse = Invoke-WebRequest -Uri "http://localhost:${PORT}/api" -UseBasicParsing -TimeoutSec 5
    if ($apiResponse.Content -match "Biodiversity") {
        Write-Host "✅ API check passed!" -ForegroundColor Green
        Write-Host "Response: $($apiResponse.Content)" -ForegroundColor Gray
    } else {
        Write-Host "❌ API check failed!" -ForegroundColor Red
        Write-Host "Response: $($apiResponse.Content)" -ForegroundColor Gray
    }
} catch {
    Write-Host "❌ API check failed!" -ForegroundColor Red
    Write-Host "Error: $_" -ForegroundColor Red
}
Write-Host ""

# Step 6: Test dashboard stats
Write-Host "Step 6: Testing dashboard stats endpoint..." -ForegroundColor Blue
try {
    $statsResponse = Invoke-WebRequest -Uri "http://localhost:${PORT}/api/dashboard/stats" -UseBasicParsing -TimeoutSec 5
    if ($statsResponse.Content -match "totalSpecies") {
        Write-Host "✅ Dashboard stats check passed!" -ForegroundColor Green
        Write-Host "Response: $($statsResponse.Content)" -ForegroundColor Gray
    } else {
        Write-Host "❌ Dashboard stats check failed!" -ForegroundColor Red
        Write-Host "Response: $($statsResponse.Content)" -ForegroundColor Gray
    }
} catch {
    Write-Host "❌ Dashboard stats check failed!" -ForegroundColor Red
    Write-Host "Error: $_" -ForegroundColor Red
}
Write-Host ""

# Step 7: Test frontend
Write-Host "Step 7: Testing frontend..." -ForegroundColor Blue
try {
    $frontendResponse = Invoke-WebRequest -Uri "http://localhost:${PORT}/" -UseBasicParsing -TimeoutSec 5
    if ($frontendResponse.StatusCode -eq 200) {
        Write-Host "✅ Frontend check passed!" -ForegroundColor Green
        Write-Host "HTTP Status: $($frontendResponse.StatusCode)" -ForegroundColor Gray
    } else {
        Write-Host "❌ Frontend check failed!" -ForegroundColor Red
        Write-Host "HTTP Status: $($frontendResponse.StatusCode)" -ForegroundColor Gray
    }
} catch {
    Write-Host "❌ Frontend check failed!" -ForegroundColor Red
    Write-Host "Error: $_" -ForegroundColor Red
}
Write-Host ""

# Summary
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "🎉 All tests completed!" -ForegroundColor Green
Write-Host ""
Write-Host "📊 Container info:" -ForegroundColor Cyan
docker ps --filter "name=$CONTAINER_NAME" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
Write-Host ""
Write-Host "🌐 Access your app at: http://localhost:${PORT}" -ForegroundColor Yellow
Write-Host ""
Write-Host "📝 View logs with: docker logs $CONTAINER_NAME" -ForegroundColor Gray
Write-Host "🛑 Stop container with: docker stop $CONTAINER_NAME" -ForegroundColor Gray
Write-Host "🗑️  Remove container with: docker rm $CONTAINER_NAME" -ForegroundColor Gray
Write-Host ""
Write-Host "Tip: Leave the container running to test the app in your browser!" -ForegroundColor Blue
Write-Host "================================================" -ForegroundColor Cyan

