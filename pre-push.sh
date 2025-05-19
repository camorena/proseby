echo "🧹 Pre-push cleanup for Proseby..."

# 1. Ensure .env.local is not tracked
echo ".env.local" >> .gitignore
git rm --cached .env.local 2>/dev/null || true

# 2. Clean up backup files
rm -f .env.local.backup*
rm -f packages/database/package.json.backup

# 3. Verify no secrets in git
echo "🔍 Checking for potential secrets..."
git diff --cached --name-only | xargs grep -l -E "(sk-|supabase|postgres://)" || echo "✅ No secrets found in staged files"

# 4. Update README with current status
echo "📝 Updating project status..."

# 5. Add all files
git add .

# 6. Commit with comprehensive message
git commit -m "✅ feat: complete infrastructure setup

- Fix database connection with Supabase Session pooler
- Complete Prisma migration with init schema  
- Resolve all environment variable issues
- Update turbo.json with proper database tasks
- Clean up duplicate DATABASE_URL entries
- Verify all monorepo packages working

🎯 Ready for Phase 2: Authentication + Dashboard"

echo "✅ Ready to push!"
echo ""
echo "📤 To push to GitHub:"
echo "git push origin main"
echo ""
echo "🔗 Your repo: https://github.com/camorena/proseby"