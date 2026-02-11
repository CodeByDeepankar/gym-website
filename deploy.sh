#!/bin/bash

# FitZone Gym Website - Deployment Script
# This script helps deploy the website to GitHub Pages

echo "🏋️ FitZone Gym Website Deployment"
echo "=================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if GitHub CLI is installed
if ! command -v gh &> /dev/null; then
    echo -e "${RED}❌ GitHub CLI is not installed.${NC}"
    echo "Please install it from: https://cli.github.com/"
    exit 1
fi

# Check if user is authenticated
if ! gh auth status &> /dev/null; then
    echo -e "${RED}❌ Not authenticated with GitHub.${NC}"
    echo "Please run: gh auth login"
    exit 1
fi

echo -e "${GREEN}✅ GitHub CLI is ready!${NC}"
echo ""

# Get repository information
REPO_NAME="gym-website"
FULL_REPO="CodeByDeepankar/$REPO_NAME"
REPO_URL="https://github.com/$FULL_REPO"

echo "Repository: $REPO_URL"
echo ""

# Instructions for enabling GitHub Pages
echo -e "${YELLOW}📋 To enable GitHub Pages deployment:${NC}"
echo "----------------------------------------"
echo ""
echo "1. Go to: $REPO_URL/settings/pages"
echo ""
echo "2. Under 'Source', select:"
echo "   - Branch: 'main'"
echo "   - Folder: '/ (root)'"
echo ""
echo "3. Click 'Save'"
echo ""
echo "4. Wait 1-2 minutes for deployment"
echo ""
echo -e "${GREEN}🌐 Your website will be available at:${NC}"
echo "   https://codebydeepankar.github.io/gym-website/"
echo ""
echo -e "${YELLOW}⏳ Checking deployment status...${NC}"

# Try to enable Pages via API
echo ""
echo "Attempting to enable GitHub Pages via API..."

# Create a temporary JSON file
cat > /tmp/pages-config.json << 'EOF'
{
  "source": {
    "branch": "main"
  }
}
EOF

# Try the API call with the JSON file
gh api repos/$FULL_REPO/pages -X PUT --input /tmp/pages-config.json 2>&1 || {
    echo ""
    echo -e "${YELLOW}⚠️  API method didn't work, but don't worry!${NC}"
    echo ""
    echo "Please enable Pages manually:"
    echo "1. Go to: $REPO_URL/settings/pages"
    echo "2. Select 'main' branch and root folder"
    echo "3. Click Save"
}

# Cleanup
rm -f /tmp/pages-config.json

echo ""
echo "=================================="
echo -e "${GREEN}🎉 Deployment setup complete!${NC}"
echo ""
echo "Next steps:"
echo "1. Enable GitHub Pages (instructions above)"
echo "2. Wait 1-2 minutes for your site to deploy"
echo "3. Visit: https://codebydeepankar.github.io/gym-website/"
echo ""
echo -e "${YELLOW}💡 Tip: Enable Pages via GitHub UI for best results${NC}"
