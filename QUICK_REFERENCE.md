# Railway Deployment Quick Reference

## 🚀 Fast Track Deployment (5 minutes)

### 1. Run Setup Script
```bash
chmod +x setup_railway.sh
./setup_railway.sh
```

### 2. Commit & Push
```bash
git add .
git commit -m "Configure for Railway deployment"
git push
```

### 3. Deploy on Railway
1. Go to https://railway.app/new
2. "Deploy from GitHub repo" → Select your repo
3. Click "+ New" → "Database" → "PostgreSQL"
4. Click "Deploy"

### 4. Done! 🎉
Click "Open App" to view your deployed Transitmix

---

## 🔧 Manual Setup (if script doesn't work)

### Files to Update:
1. **Gemfile** - Change `gem 'debugger'` to `gem 'debug'`
2. **spec/rb/spec_helper.rb** - Change `require 'debugger'` to `require 'debug'`

### Files to Create:
3. **railway.toml** (copy from provided file)
4. **nixpacks.toml** (copy from provided file)

---

## 📋 Essential Environment Variables

Railway sets these automatically:
- ✅ `DATABASE_URL` (from PostgreSQL service)
- ✅ `PORT` (Railway sets this)

No additional env vars required for basic deployment!

---

## ⚠️ Known Issues & Quick Fixes

### Issue: "Could not find debugger"
**Fix:** Run `bundle install` after updating Gemfile

### Issue: Database connection error
**Fix:** Make sure you added PostgreSQL service in Railway

### Issue: Mapbox tiles don't load
**Fix:** The API key may be rate-limited. You'll need your own Mapbox token.
Get one at https://account.mapbox.com/

---

## 🔑 Optional: Update API Keys

The app uses hardcoded API keys that may stop working. Update these in:

**Mapbox:**
- `app/js/app.js` (line 10)
- `app/js/utils.js` (line 16)

**Google Maps:**
- `app/js/views/HomeView.js` (line 27)

---

## 🧪 Test Locally First

```bash
# Create database
createdb transitmix_development

# Run migrations
bundle exec rake db:migrate

# Start server
bundle exec rackup

# Open http://localhost:3000
```

---

## 📊 Monitor Deployment

In Railway dashboard:
- **Logs tab** - See real-time logs
- **Metrics tab** - CPU, memory, network
- **Variables tab** - Environment variables

---

## 🆘 Need Help?

- 📖 Detailed guide: `RAILWAY_DEPLOYMENT.md`
- ✅ Checklist: `DEPLOYMENT_CHECKLIST.md`
- 💬 Railway Discord: https://discord.gg/railway
- 📚 Railway Docs: https://docs.railway.app/

---

## ⏱️ Deployment Timeline

- **First deployment:** ~5-7 minutes
- **Subsequent deploys:** ~2-3 minutes
- **Migrations:** ~30 seconds

---

## 💰 Pricing

Railway provides:
- $5 free credit monthly
- Pay-as-you-go after that
- Estimated cost for this app: ~$1-3/month (light usage)

---

## 🎯 Success Checklist

After deployment, verify:
- [ ] Home page loads
- [ ] Can enter a city name
- [ ] Map displays correctly
- [ ] Can draw a transit line
- [ ] Line calculations work
- [ ] Can save and reload maps
