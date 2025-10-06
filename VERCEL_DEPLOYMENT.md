# ▲ Vercel Deployment Guide

Complete guide for deploying the Biodiversity Dashboard on Vercel

## 📋 Prerequisites

- GitHub account
- Vercel account ([Free signup](https://vercel.com/signup))
- Project code on GitHub

## 🚀 Method 1: Quick Deploy (Recommended)

### Frontend on Vercel + Backend on Railway/Render

This method is simpler and more efficient.

#### Step 1: Deploy Backend

1. **Deploy your backend on Railway or Render**
   ```bash
   # You should have already done this
   # Your backend URL: https://your-backend.railway.app
   ```

2. **Note down your backend URL**

#### Step 2: Deploy Frontend on Vercel

1. **Go to [Vercel Dashboard](https://vercel.com/dashboard)**

2. **Click "Add New Project"**

3. **Connect GitHub Repository**
   - Select your GitHub repository
   - Authorize Vercel

4. **Project Configuration:**
   
   | Setting | Value |
   |---------|-------|
   | **Framework Preset** | Create React App |
   | **Root Directory** | `frontend` |
   | **Build Command** | `npm run build` |
   | **Output Directory** | `build` |

5. **Add Environment Variables:**
   
   Click "Environment Variables" and add:
   ```
   REACT_APP_API_URL=https://your-backend.railway.app
   ```

6. **Click "Deploy"** 🚀

7. **Wait** (2-3 minutes)

8. **Done!** Your app is live at `https://your-project.vercel.app` 🎉

## 🔧 Method 2: Full-Stack on Vercel

Complete Frontend + Backend deployment on Vercel (with Serverless Functions)

### Step 1: File Preparation

The following files have already been created:
- ✅ `vercel.json` - Vercel configuration
- ✅ `package.json` - Build scripts
- ✅ `api/index.py` - Serverless function wrapper
- ✅ `requirements.txt` - Python dependencies

### Step 2: Deploy

1. **Install Vercel CLI** (Optional)
   ```bash
   npm install -g vercel
   ```

2. **Login to Vercel**
   ```bash
   vercel login
   ```

3. **Deploy**
   ```bash
   vercel
   ```

4. **Or from Dashboard:**
   - Go to [Vercel Dashboard](https://vercel.com/dashboard)
   - "Add New Project"
   - Select repository
   - Vercel automatically detects `vercel.json`
   - Click "Deploy"

### ⚠️ Method 2 Limitations

Vercel Serverless Functions have limitations:
- Maximum 10 seconds execution (Hobby plan)
- Maximum 50MB memory
- Cold starts may be slow

For production, Method 1 (separate backend) is better.

## 🔐 CORS Configuration

If backend is on a different service, configure CORS:

In `backend/main.py`:
```python
cors_origins = [
    "https://your-project.vercel.app",  # Your Vercel domain
    "http://localhost:3000",
]
```

## 🌐 Custom Domain

### Adding a Custom Domain

1. Go to Project Settings in Vercel
2. Click "Domains"
3. Add domain: `yourdomain.com`
4. Add DNS records in your domain provider:

   ```
   Type: CNAME
   Name: @ (or www)
   Value: cname.vercel-dns.com
   ```

5. Free SSL automatically enabled! 🔒

## 📊 Monitoring & Logs

### View Logs

1. Go to Project Dashboard
2. Click "Deployments"
3. Select deployment
4. Click "View Function Logs"

### Analytics

Free Vercel Analytics:
1. Go to Project Settings
2. Click "Analytics"
3. Enable Analytics

## 🐛 Troubleshooting

### Issue: Build successful but blank page

**Solution:**
```bash
# Check ROOT DIRECTORY is correct
Root Directory: frontend
```

### Issue: API not working

**Solution:**
1. Check Environment Variables
2. Check CORS settings in backend
3. Verify backend URL is correct

### Issue: 404 on routes

**Solution:**
In `vercel.json`:
```json
{
  "rewrites": [
    { "source": "/(.*)", "destination": "/index.html" }
  ]
}
```

### Issue: Build timeout

**Solution:**
```bash
# Reduce dependencies
npm prune --production
```

## 💰 Pricing

### Hobby (Free)
- ✅ Unlimited deployments
- ✅ Free SSL
- ✅ 100GB bandwidth/month
- ✅ Analytics
- ❌ Serverless limit: 10s

### Pro ($20/month)
- ✅ Everything in Hobby
- ✅ Serverless: 60s
- ✅ More bandwidth
- ✅ Team collaboration
- ✅ Password protection

## 🔄 Auto-Deploy

Vercel automatically deploys:

```bash
# Every push to main branch
git push origin main
# ↓
# Vercel automatically rebuilds and deploys
```

### Branch Previews

Each Pull Request gets a preview URL:
```
https://your-project-git-branch-name.vercel.app
```

## ⚡ Performance Optimization

### 1. Image Optimization

Vercel automatically optimizes images.

### 2. Edge Caching

Static files are automatically cached.

### 3. Compression

Vercel automatically uses Gzip/Brotli.

### 4. CDN

Content served from nearest location.

## 📈 Comparison: Vercel vs Railway vs Render

| Feature | Vercel | Railway | Render |
|---------|--------|---------|--------|
| Frontend | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| Backend Python | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| Free Tier | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐ |
| Deploy Speed | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐ |
| Analytics | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐ |

**Recommendation:** 
- Frontend → Vercel ✅
- Backend → Railway/Render ✅

## 🚀 Quick Commands

```bash
# Method 1: Vercel CLI
npm install -g vercel
vercel login
vercel

# Method 2: GitHub Integration
# Push to GitHub → Vercel auto-deploys

# Environment Variables
vercel env add REACT_APP_API_URL

# View Logs
vercel logs

# Deploy to Production
vercel --prod
```

## 📝 Pre-Deploy Checklist

- [x] Code pushed to GitHub
- [x] Backend deployed (Railway/Render)
- [ ] Backend URL noted
- [ ] `vercel.json` created
- [ ] Environment Variables configured
- [ ] CORS configured in backend
- [ ] Local testing completed

## 🎯 Final Steps

```bash
# 1. Commit changes
git add .
git commit -m "Add Vercel configuration"
git push origin main

# 2. Go to vercel.com
# 3. New Project → Import GitHub
# 4. Select Repository
# 5. Configure:
#    - Root Directory: frontend
#    - Environment Variables: REACT_APP_API_URL
# 6. Deploy! 🚀

# 7. After deployment:
# Visit: https://your-project.vercel.app
```

## 🆘 Support

### Vercel Resources
- [Documentation](https://vercel.com/docs)
- [Community](https://github.com/vercel/vercel/discussions)
- [Twitter](https://twitter.com/vercel)
- Email: support@vercel.com

### Project Issues
Create an issue in the GitHub repository.

---

## ✅ Ready to Deploy!

Your project is ready for Vercel! 🎉

**Best Approach:**
1. ✅ Frontend → Vercel
2. ✅ Backend → Railway/Render (already deployed)
3. ✅ Connect with Environment Variables

**Good luck! 🚀**
