# 🚀 راهنمای Deploy - Biodiversity Dashboard

## گزینه‌های Cloud رایگان

### 1. Railway (توصیه می‌شود) ⭐

#### مزایا:
- ✅ 500 ساعت رایگان در ماه
- ✅ پشتیبانی کامل از Docker
- ✅ PostgreSQL رایگان
- ✅ Auto Deploy از GitHub
- ✅ Custom Domain رایگان

#### مراحل Deploy:

1. **ثبت‌نام و اتصال GitHub:**
   ```bash
   # 1. برو به railway.app
   # 2. Sign up with GitHub
   # 3. Connect your repository
   ```

2. **تنظیمات پروژه:**
   - انتخاب `Dockerfile` به عنوان builder
   - تنظیم Environment Variables:
     ```
     API_HOST=0.0.0.0
     API_PORT=8000
     CORS_ORIGINS=https://your-app-name.railway.app
     ```

3. **Deploy:**
   - Railway خودکار از GitHub pull می‌کند
   - Docker image build می‌شود
   - App deploy می‌شود

#### URL نهایی:
```
https://your-app-name.railway.app
```

---

### 2. Render

#### مزایا:
- ✅ 750 ساعت رایگان در ماه
- ✅ Docker Support
- ✅ PostgreSQL رایگان

#### مراحل Deploy:

1. **ثبت‌نام:**
   ```bash
   # برو به render.com
   # Sign up with GitHub
   ```

2. **ایجاد Web Service:**
   - Connect Repository
   - Build Command: `docker build -t biodiversity-dashboard .`
   - Start Command: `python main.py`
   - Environment: `Docker`

3. **Environment Variables:**
   ```
   API_HOST=0.0.0.0
   API_PORT=8000
   CORS_ORIGINS=https://your-app-name.onrender.com
   ```

---

### 3. Fly.io

#### مزایا:
- ✅ 3 app رایگان
- ✅ Global CDN
- ✅ Docker Support

#### مراحل Deploy:

1. **نصب Fly CLI:**
   ```bash
   # Windows
   iwr https://fly.io/install.ps1 -useb | iex
   
   # Mac/Linux
   curl -L https://fly.io/install.sh | sh
   ```

2. **Login و Deploy:**
   ```bash
   fly auth login
   fly launch
   fly deploy
   ```

---

### 4. Heroku (محدودیت‌های جدید)

#### مزایا:
- ✅ 550 ساعت رایگان در ماه
- ✅ Docker Support

#### مراحل Deploy:

1. **نصب Heroku CLI:**
   ```bash
   # Windows
   # Download from heroku.com
   
   # Mac
   brew install heroku/brew/heroku
   ```

2. **Deploy:**
   ```bash
   heroku login
   heroku create your-app-name
   heroku container:push web
   heroku container:release web
   ```

---

## 🔧 تنظیمات پیش از Deploy

### 1. Environment Variables

برای هر platform، این متغیرها را تنظیم کنید:

```env
API_HOST=0.0.0.0
API_PORT=8000
CORS_ORIGINS=https://your-domain.com,http://localhost:3000
NODE_ENV=production
```

### 2. CORS Configuration

در `backend/main.py`، CORS را برای production تنظیم کنید:

```python
app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "http://localhost:3000",
        "http://127.0.0.1:3000",
        "https://your-app-name.railway.app",  # Railway
        "https://your-app-name.onrender.com",  # Render
        "https://your-app-name.fly.dev",      # Fly.io
    ],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
```

### 3. Health Check

Health check endpoint در `/health` موجود است:

```bash
curl https://your-app-name.railway.app/health
```

---

## 📊 Monitoring

### 1. Logs
- Railway: Dashboard → Logs
- Render: Dashboard → Logs
- Fly.io: `fly logs`

### 2. Metrics
- CPU Usage
- Memory Usage
- Response Time
- Error Rate

---

## 🔄 Auto Deploy

### GitHub Actions (اختیاری)

```yaml
# .github/workflows/deploy.yml
name: Deploy to Railway
on:
  push:
    branches: [main]
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Deploy to Railway
        run: |
          # Railway auto-deploys from GitHub
```

---

## 🚨 Troubleshooting

### مشکلات رایج:

1. **Port Issues:**
   ```python
   # در main.py
   port = int(os.environ.get("PORT", 8000))
   uvicorn.run(app, host="0.0.0.0", port=port)
   ```

2. **CORS Errors:**
   - Domain را به CORS_ORIGINS اضافه کنید
   - HTTPS استفاده کنید

3. **Build Failures:**
   - Dockerfile را بررسی کنید
   - Dependencies را چک کنید

4. **Memory Issues:**
   - Dataset size را کاهش دهید
   - Caching اضافه کنید

---

## 💡 Tips

1. **Performance:**
   - از CDN استفاده کنید
   - Images را optimize کنید
   - Caching اضافه کنید

2. **Security:**
   - HTTPS استفاده کنید
   - Environment variables را secure کنید
   - Rate limiting اضافه کنید

3. **Monitoring:**
   - Health checks را monitor کنید
   - Error tracking اضافه کنید
   - Performance metrics را track کنید

---

## 🎯 نتیجه

پس از deploy، اپلیکیشن شما در دسترس خواهد بود:

- **Frontend**: `https://your-app-name.railway.app`
- **API**: `https://your-app-name.railway.app/api/`
- **Health Check**: `https://your-app-name.railway.app/health`

**توصیه نهایی**: Railway بهترین گزینه برای این پروژه است!
