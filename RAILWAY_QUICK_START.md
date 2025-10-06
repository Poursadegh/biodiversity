# 🚂 Railway Quick Start

## Deploy in 3 Steps

### 1️⃣ Push to GitHub
```bash
git add .
git commit -m "Ready for Railway deployment"
git push origin main
```

### 2️⃣ Deploy on Railway
1. Go to [railway.app](https://railway.app)
2. Click **"Start a New Project"**
3. Select **"Deploy from GitHub repo"**
4. Choose your repository
5. Wait for build to complete ⏳

### 3️⃣ Get Your URL
1. Click **"Settings"** → **"Domains"**
2. Click **"Generate Domain"**
3. Done! 🎉 Your app is live at: `your-app.up.railway.app`

---

## 🧪 Test Locally with Docker

```bash
# Build the image
docker build -t biodiversity-dashboard .

# Run the container
docker run -p 8000:8000 biodiversity-dashboard

# Open browser to http://localhost:8000
```

---

## 🔧 Quick Fixes

### Build fails?
```bash
# Check logs
railway logs --build
```

### App not starting?
```bash
# View runtime logs
railway logs
```

### Need to redeploy?
```bash
git push origin main  # Auto-deploys
```

---

## 📊 Monitor Your App

- **Dashboard**: [railway.app/project/your-project](https://railway.app)
- **Logs**: Click "View Logs" in dashboard
- **Metrics**: Check CPU, Memory, Network usage
- **Health**: Visit `https://your-app.up.railway.app/health`

---

## 💡 Pro Tips

✅ Railway auto-detects Dockerfile  
✅ Free $5 credit monthly  
✅ Auto-deploys on git push  
✅ Free SSL certificates included  
✅ Rollback anytime in dashboard  

---

**Need help?** See [RAILWAY_DEPLOYMENT.md](./RAILWAY_DEPLOYMENT.md) for full guide

