# 🎨 Render.com Deployment Guide

Complete guide for deploying the Biodiversity Dashboard on Render.com.

## 📋 Prerequisites

- GitHub account
- Render.com account (sign up at [render.com](https://render.com))
- Git repository with your code

## 🚀 Quick Deploy

### Step 1: Push to GitHub

```bash
git add .
git commit -m "Deploy to Render"
git push origin main
```

### Step 2: Create Web Service on Render

1. **Go to Render Dashboard**
   - Visit [dashboard.render.com](https://dashboard.render.com)
   - Click **"New +"** → **"Web Service"**

2. **Connect Your Repository**
   - Click **"Connect a repository"**
   - Authorize Render to access your GitHub
   - Select your repository

3. **Configure the Service**

   Fill in the following settings:

   | Setting | Value |
   |---------|-------|
   | **Name** | `biodiversity-dashboard` (or your choice) |
   | **Region** | Choose closest to your users |
   | **Branch** | `main` |
   | **Runtime** | **Docker** |
   | **Plan** | Free (or paid for more resources) |

4. **Environment Variables** (Optional)

   Click **"Advanced"** and add:
   ```
   CORS_ORIGINS=https://yourdomain.com
   ```

5. **Deploy!**
   - Click **"Create Web Service"**
   - Render will automatically build and deploy
   - Build takes ~5-10 minutes for first deployment

### Step 3: Access Your App

Once deployed, your app will be available at:
```
https://biodiversity-dashboard.onrender.com
```

(Or your custom name if you chose differently)

## ⚙️ Render Configuration

### Dockerfile Detection

Render automatically detects the Dockerfile and uses it for deployment. No additional configuration needed!

### Port Configuration

Render automatically provides the `PORT` environment variable. Our Dockerfile is already configured to use it:
```dockerfile
ENV PORT=8000
CMD uvicorn main:app --host 0.0.0.0 --port ${PORT} --workers 2
```

### Health Check

Render monitors your app using the health check endpoint at `/health`.

## 🔍 Monitoring & Logs

### View Logs

1. Go to your service dashboard
2. Click on **"Logs"** tab
3. See real-time logs

### Metrics

Render provides:
- Request count
- Response time
- Memory usage
- CPU usage

Access via: Service Dashboard → **"Metrics"** tab

## 🐛 Troubleshooting

### Build Issues

**Problem: Frontend build fails with "react-scripts: not found"**
```
Solution: Fixed in latest Dockerfile - npm ci now installs all dependencies
```

**Problem: Build times out**
```
Solution: 
1. Check Dockerfile for efficiency
2. Upgrade to paid plan for faster builds
3. Optimize dependencies
```

**Problem: Out of memory during build**
```
Solution:
1. Free tier has limited resources
2. Upgrade to Starter plan ($7/month)
3. Or optimize build process
```

### Runtime Issues

**Problem: App crashes after deployment**
```bash
# Check logs in Render dashboard
# Common causes:
# 1. Missing dependencies
# 2. Port configuration (should use Render's PORT)
# 3. Data files not found
```

**Problem: 502 Bad Gateway**
```
Solutions:
1. Check health check endpoint works
2. Ensure app listens on 0.0.0.0 (not localhost)
3. Wait longer - cold starts can take 30s on free tier
4. Check logs for errors
```

**Problem: Static files (images, CSS) not loading**
```
Solution: 
1. Verify build process completed
2. Check static files are in correct directory
3. FastAPI is serving static files properly
```

### Performance Issues

**Problem: Slow cold starts**
```
Free tier spins down after 15 minutes of inactivity
Solutions:
1. Upgrade to paid plan (always running)
2. Use a keep-alive service (cron-job.org)
3. Accept the cold start delay
```

**Problem: Slow responses**
```
Solutions:
1. Upgrade to larger instance
2. Optimize database queries
3. Add caching layer
4. Use CDN for static assets
```

## 💰 Pricing

### Free Tier
- **Cost**: $0/month
- **Limits**: 
  - 750 hours/month (spins down after inactivity)
  - 512 MB RAM
  - 0.1 CPU
  - Shared bandwidth
- **Good for**: Testing, personal projects

### Starter Plan
- **Cost**: $7/month
- **Features**:
  - Always running
  - 512 MB RAM
  - 0.5 CPU
  - Better bandwidth
- **Good for**: Small production apps

### Standard Plan
- **Cost**: $25/month
- **Features**:
  - Always running
  - 2 GB RAM
  - 1 CPU
  - High bandwidth
- **Good for**: Production applications

## 🔄 Updates & Redeployment

### Automatic Deployments

Render automatically redeploys when you push to your connected branch:

```bash
git add .
git commit -m "Update feature"
git push origin main
# Render automatically rebuilds and redeploys
```

### Manual Deployment

1. Go to your service dashboard
2. Click **"Manual Deploy"** → **"Deploy latest commit"**
3. Or click **"Clear build cache & deploy"** for fresh build

### Rollback

1. Go to **"Events"** tab
2. Find previous successful deployment
3. Click **"Rollback to this version"**

## 🌐 Custom Domain

### Add Custom Domain

1. Go to service **"Settings"**
2. Scroll to **"Custom Domain"**
3. Click **"Add Custom Domain"**
4. Enter your domain: `app.yourdomain.com`
5. Add DNS records to your domain provider:

   **For subdomain (app.yourdomain.com):**
   ```
   Type: CNAME
   Name: app
   Value: your-service.onrender.com
   ```

   **For root domain (yourdomain.com):**
   ```
   Type: A
   Name: @
   Value: [Render's IP - shown in dashboard]
   ```

6. Wait for DNS propagation (5-30 minutes)
7. Render automatically provides free SSL certificate! 🔒

## 🔐 Environment Variables

### Add Environment Variables

1. Go to **"Environment"** tab
2. Click **"Add Environment Variable"**
3. Add your variables:

```bash
# Optional custom CORS origins
CORS_ORIGINS=https://yourdomain.com,https://www.yourdomain.com

# Optional log level
LOG_LEVEL=info
```

4. Click **"Save Changes"**
5. App automatically redeploys with new variables

## 📊 Scaling

### Vertical Scaling (Increase Resources)

1. Go to **"Settings"**
2. Under **"Instance Type"**, select larger plan
3. Click **"Save Changes"**
4. App restarts with more resources

### Horizontal Scaling (Multiple Instances)

Available on Pro plans and above:
- Multiple instances for high availability
- Load balancing included
- Zero-downtime deployments

## 🔧 Advanced Configuration

### Background Workers

If you need background tasks:
1. Create new **"Background Worker"** service
2. Use same repository
3. Different start command

### Databases

Render offers managed databases:
- **PostgreSQL**: $7/month (free tier available)
- **Redis**: $10/month

To add:
1. Create database in Render
2. Get connection URL
3. Add as environment variable
4. Update your app to use it

### Cron Jobs

For scheduled tasks:
1. Create **"Cron Job"** service
2. Set schedule (e.g., `0 0 * * *` for daily)
3. Define command to run

## 🆘 Support

### Render Support

- [Render Docs](https://render.com/docs)
- [Render Community](https://community.render.com)
- Email: support@render.com
- [Status Page](https://status.render.com)

### Project Issues

Create an issue in your GitHub repository

## ✅ Deployment Checklist

Before deploying, ensure:

- [x] Code is pushed to GitHub
- [x] Dockerfile is working (test with `.\test-docker.ps1`)
- [x] Data files are included
- [x] Dependencies are correct
- [x] Environment variables are set
- [x] Health check works
- [x] Frontend builds successfully

## 📈 Optimization Tips

### 1. Build Caching
Render caches Docker layers. Optimize Dockerfile to maximize cache hits.

### 2. Image Size
Our optimized Dockerfile creates ~800MB image. Consider:
- Multi-stage builds (already done ✅)
- Minimal base images (already done ✅)
- Clean up in same layer

### 3. Startup Time
- Pre-load data at build time (already done ✅)
- Use lightweight dependencies
- Optimize initialization code

### 4. Keep-Alive (Free Tier)
To prevent cold starts, use a service to ping your app:
```bash
# Use cron-job.org or similar
# Ping https://your-app.onrender.com/health
# Every 10 minutes
```

## 🎯 Comparison: Render vs Railway

| Feature | Render | Railway |
|---------|--------|---------|
| Free Tier | 750h/month | $5 credit/month |
| Cold Starts | Yes (free tier) | No |
| Build Speed | Good | Faster |
| UI | More detailed | Simpler |
| Database | Built-in | Built-in |
| Custom Domain | Free SSL | Free SSL |
| Best For | Traditional apps | Modern apps |

Both are excellent! Choose based on your preference.

## 🚀 Quick Start Commands

```bash
# 1. Commit your code
git add .
git commit -m "Deploy to Render"
git push origin main

# 2. Go to render.com
# 3. New Web Service → Connect GitHub
# 4. Select Docker runtime
# 5. Deploy!

# 6. Your app will be live at:
# https://your-app-name.onrender.com
```

## 📝 Common Error Solutions

### Error: "Port already in use"
```
Solution: Don't set PORT in environment variables.
Render provides it automatically.
```

### Error: "Application failed to respond"
```
Solutions:
1. Check app listens on 0.0.0.0 (not 127.0.0.1)
2. Verify PORT environment variable is used
3. Check health endpoint returns 200
4. Review startup logs
```

### Error: "Build exceeded maximum time"
```
Solutions:
1. Optimize Dockerfile
2. Reduce dependencies
3. Upgrade to paid plan
```

---

## 🎉 Ready to Deploy!

Your Dockerfile is now fixed and optimized for Render deployment!

**Now try deploying again on Render - it should work!** ✅

---

**Questions?** Check the [Render documentation](https://render.com/docs) or ask in the community!

