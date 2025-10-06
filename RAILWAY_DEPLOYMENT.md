# 🚂 Railway Deployment Guide

Complete guide for deploying the Biodiversity Dashboard on Railway.

## 📋 Prerequisites

- GitHub account
- Railway account (sign up at [railway.app](https://railway.app))
- Git repository with your code

## 🚀 Quick Deploy

### Option 1: Deploy from GitHub (Recommended)

1. **Push your code to GitHub**
   ```bash
   git add .
   git commit -m "Prepare for Railway deployment"
   git push origin main
   ```

2. **Connect to Railway**
   - Go to [railway.app](https://railway.app)
   - Click "Start a New Project"
   - Select "Deploy from GitHub repo"
   - Authorize Railway to access your GitHub
   - Select your repository

3. **Configure the deployment**
   - Railway will automatically detect the Dockerfile
   - The app will start building immediately

4. **Generate a domain**
   - Click on your project
   - Go to "Settings" tab
   - Under "Domains", click "Generate Domain"
   - Your app will be available at `your-app-name.up.railway.app`

### Option 2: Deploy with Railway CLI

1. **Install Railway CLI**
   ```bash
   # macOS/Linux
   curl -fsSL https://railway.app/install.sh | sh
   
   # Windows (PowerShell)
   iwr https://railway.app/install.ps1 | iex
   
   # Or via npm
   npm install -g @railway/cli
   ```

2. **Login to Railway**
   ```bash
   railway login
   ```

3. **Initialize and deploy**
   ```bash
   railway init
   railway up
   ```

4. **Open your app**
   ```bash
   railway open
   ```

## ⚙️ Configuration

### Environment Variables

Railway automatically provides the `PORT` environment variable. You can add additional variables:

1. Go to your project dashboard
2. Click on "Variables" tab
3. Add the following (optional):

```bash
# Optional: Custom CORS origins (comma-separated)
CORS_ORIGINS=https://yourdomain.com,https://www.yourdomain.com

# Optional: Set log level
LOG_LEVEL=info
```

### Custom Domain

1. Go to your project settings
2. Navigate to "Domains"
3. Click "Add Domain"
4. Enter your custom domain
5. Add the CNAME record to your DNS provider:
   ```
   CNAME @ your-app-name.up.railway.app
   ```

## 🏗️ Build Process

The Dockerfile performs the following steps:

1. **Frontend Build** (Multi-stage)
   - Installs Node.js dependencies
   - Builds React application
   - Creates optimized production bundle

2. **Backend Setup**
   - Installs Python dependencies
   - Copies backend code
   - Copies data files
   - Integrates frontend build

3. **Production Server**
   - Runs with Uvicorn (ASGI server)
   - 2 workers for concurrent requests
   - Health check endpoint at `/health`

## 🔍 Monitoring & Logs

### View Logs
```bash
# Via CLI
railway logs

# Or in the web dashboard
# Go to your project → Click "View Logs"
```

### Health Check
The app includes a health check endpoint:
```bash
curl https://your-app-name.up.railway.app/health
```

Response:
```json
{
  "status": "healthy",
  "timestamp": "2024-01-01T00:00:00.000000"
}
```

### Metrics
Railway provides built-in metrics:
- CPU usage
- Memory usage
- Network traffic
- Request count

Access via: Project Dashboard → "Metrics" tab

## 🐛 Troubleshooting

### Build Failures

**Problem**: Frontend build fails
```
Solution: Check that all dependencies in frontend/package.json are correct
railway logs --build
```

**Problem**: Backend dependencies fail
```
Solution: Verify requirements.txt has all necessary packages
```

### Runtime Issues

**Problem**: App crashes after deployment
```bash
# Check logs
railway logs

# Common causes:
# 1. Missing data files
# 2. Port configuration (Railway sets PORT automatically)
# 3. Memory limits exceeded
```

**Problem**: 502 Bad Gateway
```
Possible causes:
1. App not listening on correct PORT
2. Health check failing
3. App takes too long to start

Check: Railway automatically provides PORT environment variable
The Dockerfile is configured to use it: --port ${PORT}
```

**Problem**: Static files not loading
```
Solution: Verify the build process completed successfully
Check: frontend/build directory should be copied to backend/static
```

### Performance Issues

**Problem**: Slow response times
```
Solutions:
1. Upgrade Railway plan for more resources
2. Optimize data queries in backend
3. Enable caching
4. Use CDN for static assets
```

**Problem**: Out of memory
```
Solutions:
1. Reduce dataset size
2. Implement pagination
3. Upgrade to larger plan
4. Optimize pandas operations
```

## 📊 Scaling

### Vertical Scaling
Upgrade your Railway plan for:
- More CPU
- More memory
- Higher bandwidth

### Optimization Tips

1. **Enable Caching**
   - Add Redis for API response caching
   - Use Railway's Redis plugin

2. **Database Optimization**
   - Consider moving data to PostgreSQL
   - Use Railway's PostgreSQL plugin

3. **CDN Integration**
   - Use Cloudflare for static assets
   - Reduce server load

## 🔄 Updates & Redeployment

### Automatic Deployments
Railway automatically redeploys when you push to your connected branch:
```bash
git add .
git commit -m "Update feature"
git push origin main
# Railway automatically rebuilds and deploys
```

### Manual Deployment
```bash
# Via CLI
railway up

# Via web dashboard
# Go to Deployments → Click "Deploy"
```

### Rollback
1. Go to "Deployments" tab
2. Find previous successful deployment
3. Click "Rollback to this version"

## 💰 Costs

Railway offers:
- **Free Tier**: $5 free credit per month
- **Developer Plan**: $10/month (includes $10 credit)
- **Pro Plan**: $20/month (includes $20 credit)

Cost factors:
- CPU usage
- Memory usage
- Network egress
- Build minutes

**Tip**: Railway shows cost estimates in real-time on your dashboard

## 🔐 Security Best Practices

1. **Environment Variables**
   - Never commit sensitive data
   - Use Railway's environment variables

2. **HTTPS**
   - Railway provides free SSL certificates
   - All domains use HTTPS by default

3. **Network Security**
   - Configure CORS properly
   - Use Railway's private networking for services

## 📚 Additional Resources

- [Railway Documentation](https://docs.railway.app/)
- [Railway Community](https://discord.gg/railway)
- [Railway Blog](https://blog.railway.app/)
- [FastAPI Deployment Best Practices](https://fastapi.tiangolo.com/deployment/)

## 🆘 Support

### Railway Support
- [Railway Discord](https://discord.gg/railway)
- [Railway Twitter](https://twitter.com/railway_app)
- Email: team@railway.app

### Project Issues
Create an issue in the GitHub repository

---

## ✅ Deployment Checklist

Before deploying, ensure:

- [ ] All code is committed to GitHub
- [ ] Data files are included in repository
- [ ] Dependencies are correctly specified
- [ ] Environment variables are configured
- [ ] Health check endpoint works
- [ ] Frontend builds successfully
- [ ] Backend tests pass
- [ ] CORS origins are configured
- [ ] Documentation is updated

---

**Happy Deploying! 🎉**

