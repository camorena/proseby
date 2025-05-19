echo "🔍 Diagnosing Supabase Database Connection..."

# Check if .env.local exists
if [ ! -f ".env.local" ]; then
    echo "❌ .env.local file not found!"
    echo "📝 Create .env.local with your Supabase credentials"
    exit 1
fi

# Load environment variables
source .env.local

# Check if DATABASE_URL is set
if [ -z "$DATABASE_URL" ]; then
    echo "❌ DATABASE_URL not found in .env.local"
    echo "📝 Add: DATABASE_URL='postgresql://postgres:[password]@db.[project-id].supabase.co:5432/postgres'"
    exit 1
fi

echo "✅ DATABASE_URL found"

# Extract project ID from URL for Supabase dashboard check
PROJECT_ID=$(echo $DATABASE_URL | grep -oP 'db\.\K[^.]+')
echo "🔗 Project ID: $PROJECT_ID"
echo "🌐 Supabase Dashboard: https://supabase.com/dashboard/project/$PROJECT_ID"

# Test database connection
echo "🧪 Testing database connection..."
pnpm --filter @proseby/database db:generate 2>/dev/null || echo "⚠️  Prisma generate failed"

# Try to connect directly
echo "🔌 Testing direct connection..."
npx prisma db pull --schema=packages/database/prisma/schema.prisma 2>&1 | head -5

echo ""
echo "📋 TROUBLESHOOTING CHECKLIST:"
echo "1. ✅ Check if your Supabase project is ACTIVE (not paused)"
echo "2. ✅ Verify DATABASE_URL has correct format:"
echo "   postgresql://postgres:[YOUR_PASSWORD]@db.[PROJECT_ID].supabase.co:5432/postgres"
echo "3. ✅ Ensure your IP is whitelisted in Supabase > Settings > Database > Network Restrictions"
echo "4. ✅ Confirm database password is correct (check Supabase > Settings > Database > Connection Info)"
echo ""
echo "🚨 MOST COMMON ISSUE: Supabase project is PAUSED due to inactivity"
echo "🔄 Solution: Log into Supabase dashboard and click 'Resume Project'"