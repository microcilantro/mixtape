# Railway Deployment Checklist

## Before Deploying

- [ ] Replace `Gemfile` with the updated version (removes debugger gem)
- [ ] Replace `spec/rb/spec_helper.rb` with updated version
- [ ] Add `railway.toml` to project root
- [ ] Add `nixpacks.toml` to project root (optional but recommended)
- [ ] Commit all changes to Git
- [ ] Push to GitHub (or your Git provider)

## On Railway

- [ ] Create new project from GitHub repo
- [ ] Add PostgreSQL database service
- [ ] Verify DATABASE_URL is automatically set
- [ ] Set PORT environment variable (optional, Railway sets automatically)
- [ ] Deploy and watch logs

## After First Deployment

- [ ] Open the app URL
- [ ] Test creating a new map
- [ ] Check if Mapbox tiles load correctly
- [ ] Verify database is working (maps are saved)

## API Keys to Update

The app has hardcoded API keys that may not work long-term:

1. **Mapbox** (2 locations):
   - `app/js/app.js` line 10: `L.mapbox.map('map', 'codeforamerica.h6mlbj75', options)`
   - `app/js/utils.js` line 16: URL includes `codeforamerica.h6mlbj75`
   
   Get your own at: https://account.mapbox.com/

2. **Google Maps Geocoding**:
   - `app/js/views/HomeView.js` line 27: `AIzaSyCcgZLlBTM4GY0RhkUjy4MDD9RaZ0zIoiY`
   
   Get your own at: https://console.cloud.google.com/

## Files Changed

1. `Gemfile` - Updated debugger to debug
2. `spec/rb/spec_helper.rb` - Updated require statement
3. `railway.toml` - Added (NEW)
4. `nixpacks.toml` - Added (NEW)

## Deployment Command

Railway will run this automatically:
```bash
bundle exec rake db:migrate && bundle exec unicorn -c ./config/unicorn.rb
```

## Testing Locally Before Deploy

```bash
# Install dependencies
bundle install

# Set up database
createdb transitmix_development
bundle exec rake db:migrate

# Start server
bundle exec unicorn -c ./config/unicorn.rb

# Open browser to localhost:3000
```

## Common Errors

### "Could not find debugger gem"
- Solution: Use the updated Gemfile

### "Database does not exist"
- Solution: Make sure PostgreSQL service is added in Railway

### "Port already in use"
- Solution: Railway handles port automatically via $PORT

### "Asset precompilation failed"
- Solution: All assets are compiled at runtime via Sinatra AssetPack

## Monitoring

After deployment, monitor:
- Railway logs tab
- Database connections in PostgreSQL service
- Error rates
- Response times

## Need Help?

- Check Railway docs: https://docs.railway.app/
- Check deployment guide: RAILWAY_DEPLOYMENT.md
- Railway Discord: https://discord.gg/railway
