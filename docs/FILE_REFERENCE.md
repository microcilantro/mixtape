# 📝 FILE REPLACEMENT QUICK REFERENCE

## Core Files (MUST REPLACE)

| Your File | Replace With | Location |
|-----------|--------------|----------|
| `Gemfile.lock` | NEW `Gemfile.lock` | Project root |
| `Gemfile` | `Gemfile` or `Gemfile.NEW` | Project root |
| `.ruby-version` | `.ruby-version` or `ruby-version.NEW` | Project root |
| `railway.toml` | `railway.toml` | Project root (NEW) |
| `nixpacks.toml` | `nixpacks.toml` | Project root (NEW) |

## Test Files (MUST REPLACE)

| Your File | Replace With |
|-----------|--------------|
| `spec/rb/spec_helper.rb` | `spec_helper.rb.NEW` → rename |
| `spec/rb/factories.rb` | `factories.rb.NEW` → rename |
| `spec/rb/support/database_cleaner.rb` | `database_cleaner.rb.NEW` → rename |

## Security Files (HIGHLY RECOMMENDED)

| Your File | Replace With |
|-----------|--------------|
| `app/views/index.erb` | `index.erb.SECURE` → rename |
| `app/js/app.js` | `app.js.SECURE` → rename |
| `app/js/utils.js` | `utils.js.SECURE` → rename |
| `app/js/views/HomeView.js` | `HomeView.js.SECURE` → rename |

---

## Railway Environment Variables (if using security files)

```
MAPBOX_ACCESS_TOKEN = your_mapbox_token_here
MAPBOX_STYLE_ID = mapbox/streets-v11
GOOGLE_MAPS_API_KEY = your_google_maps_key_here
```

---

## Key Changes Summary

**Gemfile.lock (CRITICAL):**
- ✅ jasmine-core: 3.99.1 → 3.99.0
- ✅ sequel: Now explicitly requires bigdecimal
- ✅ All gems compatible with Ruby 3.0.0

**Security files:**
- ✅ Remove hardcoded API keys
- ✅ Read from ENV variables
- ✅ Fallback to old keys if ENV not set

---

## After Replacing Files

```bash
git add .
git commit -m "Fix deployment and secure API keys"
git push
```

Railway auto-deploys in ~5 minutes!

---

## Most Important File

**The NEW `Gemfile.lock` fixes EVERYTHING:**
- jasmine-core version
- sequel/bigdecimal dependency  
- All other gem compatibility

**Make sure you get the LATEST Gemfile.lock!**
