#!/bin/bash

# Transitmix Railway Deployment Setup Script
# This script prepares your Transitmix app for deployment on Railway

set -e  # Exit on error

echo "🚂 Transitmix Railway Deployment Setup"
echo "========================================"
echo ""

# Check if we're in the right directory
if [ ! -f "Gemfile" ]; then
    echo "❌ Error: Gemfile not found. Are you in the Transitmix project directory?"
    exit 1
fi

echo "✅ Found Gemfile"

# Backup original files
echo ""
echo "📦 Backing up original files..."
cp Gemfile Gemfile.backup
if [ -f "spec/rb/spec_helper.rb" ]; then
    cp spec/rb/spec_helper.rb spec/rb/spec_helper.rb.backup
fi

echo "✅ Backups created"

# Update Gemfile
echo ""
echo "📝 Updating Gemfile (replacing debugger with debug)..."
cat > Gemfile << 'EOF'
source 'https://rubygems.org'

ruby '3.2.0'

gem 'dedent'
gem 'dotenv'
gem 'grape'
gem 'pg'
gem 'rake'
gem 'sass'
gem 'sequel'
gem 'sinatra-assetpack', :require => 'sinatra/assetpack'
gem 'sinatra'
gem 'uglifier'
gem 'unicorn'

group :test do
  gem 'database_cleaner'
  gem 'debug'  # Replaced 'debugger' for Ruby 3.2.0 compatibility
  gem 'factory_girl'
  gem 'ffaker'
  gem 'rack-test'
  gem 'rspec'
  gem 'jasmine'
end
EOF

echo "✅ Gemfile updated"

# Update spec_helper.rb
echo ""
echo "📝 Updating spec/rb/spec_helper.rb..."
cat > spec/rb/spec_helper.rb << 'EOF'
require 'debug'  # Changed from 'debugger'
require 'factory_girl'
require 'ffaker'
require 'rspec'
require 'rack/test'

require './app'
require './spec/rb/factories'

Dir['./spec/rb/support/**/*.rb'].each { |f| require(f) }

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.order = "random"
end
EOF

echo "✅ spec_helper.rb updated"

# Create railway.toml
echo ""
echo "📝 Creating railway.toml..."
cat > railway.toml << 'EOF'
[build]
builder = "NIXPACKS"

[deploy]
startCommand = "bundle exec rake db:migrate && bundle exec unicorn -c ./config/unicorn.rb"
restartPolicyType = "ON_FAILURE"
restartPolicyMaxRetries = 10
EOF

echo "✅ railway.toml created"

# Create nixpacks.toml
echo ""
echo "📝 Creating nixpacks.toml..."
cat > nixpacks.toml << 'EOF'
[phases.setup]
nixPkgs = ["...", "postgresql"]

[phases.install]
cmds = ["bundle install"]

[start]
cmd = "bundle exec rake db:migrate && bundle exec unicorn -c ./config/unicorn.rb"
EOF

echo "✅ nixpacks.toml created"

# Create .railwayignore (optional)
echo ""
echo "📝 Creating .railwayignore..."
cat > .railwayignore << 'EOF'
*.gem
*.rbc
/coverage/
/InstalledFiles
/pkg/
/spec/reports/
/test/tmp/
/test/version_tmp/
/tmp/
.dat*
.repl_history
build/
/.yardoc/
/_yardoc/
/doc/
/rdoc/
/.bundle/
.rvmrc
.DS_Store
.sass-cache/
*.backup
EOF

echo "✅ .railwayignore created"

# Run bundle install
echo ""
echo "📦 Running bundle install..."
if bundle install; then
    echo "✅ Dependencies installed successfully"
else
    echo "⚠️  Bundle install had issues. You may need to run 'bundle update' or fix gem compatibility issues."
fi

# Git status
echo ""
echo "📋 Changes made:"
echo "  - Gemfile (debugger → debug)"
echo "  - spec/rb/spec_helper.rb (debugger → debug)"
echo "  - railway.toml (NEW)"
echo "  - nixpacks.toml (NEW)"
echo "  - .railwayignore (NEW)"
echo ""
echo "  Backups saved as:"
echo "  - Gemfile.backup"
echo "  - spec/rb/spec_helper.rb.backup"

echo ""
echo "✅ Setup complete!"
echo ""
echo "📝 Next steps:"
echo "1. Review the changes with: git diff"
echo "2. Test locally: bundle exec rackup"
echo "3. Commit changes: git add . && git commit -m 'Prepare for Railway deployment'"
echo "4. Push to GitHub: git push"
echo "5. Go to railway.app and deploy from your GitHub repo"
echo ""
echo "📚 See RAILWAY_DEPLOYMENT.md for detailed deployment instructions"
echo "📋 See DEPLOYMENT_CHECKLIST.md for a deployment checklist"
echo ""
echo "⚠️  Important: Update API keys for Mapbox and Google Maps"
echo "   Check RAILWAY_DEPLOYMENT.md for details on where to update them"
