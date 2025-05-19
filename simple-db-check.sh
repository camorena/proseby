echo "🔍 Simple Database Diagnosis..."

# Check if .env.local exists and show its contents (masked)
if [ -f ".env.local" ]; then
    echo "✅ .env.local file found"
    echo "📝 Environment variables (masked):"
    cat .env.local | grep -E '^[A-Z]' | sed 's/=.*/=***MASKED***/'
    echo ""
else
    echo "❌ .env.local file NOT found!"
    echo "📝 Please create .env.local with your Supabase credentials"
    exit 1
fi

# Test if we can connect to Supabase at all
echo "🌐 Testing Supabase connection..."
SUPABASE_URL=$(grep "NEXT_PUBLIC_SUPABASE_URL" .env.local | cut -d '=' -f2 | tr -d '"')

if [ -n "$SUPABASE_URL" ]; then
    echo "🔗 Testing: $SUPABASE_URL"
    if curl -s --max-time 5 "$SUPABASE_URL/rest/v1/" > /dev/null; then
        echo "✅ Supabase API is reachable"
    else
        echo "❌ Cannot reach Supabase API - project might be paused"
    fi
else
    echo "⚠️  SUPABASE_URL not found in .env.local"
fi

# Test database connection with Docker
echo ""
echo "🐳 Testing database with Docker (safer approach)..."
DATABASE_URL=$(grep "DATABASE_URL" .env.local | cut -d '=' -f2 | tr -d '"')

if [ -n "$DATABASE_URL" ]; then
    # Extract connection details
    DB_HOST=$(echo $DATABASE_URL | sed -n 's/.*@\([^:]*\):.*/\1/p')
    DB_PORT=$(echo $DATABASE_URL | sed -n 's/.*:\([0-9]*\)\/.*/\1/p')
    
    echo "🔗 Host: $DB_HOST"
    echo "🔗 Port: $DB_PORT"
    
    # Test connection with telnet
    if command -v nc >/dev/null 2>&1; then
        echo "🧪 Testing port connectivity..."
        if nc -z "$DB_HOST" "$DB_PORT" 2>/dev/null; then
            echo "✅ Database port is reachable"
        else
            echo "❌ Cannot reach database port - likely project is PAUSED"
            echo "🚨 Go to https://supabase.com/dashboard and RESUME your project"
        fi
    fi
else
    echo "❌ DATABASE_URL not found"
fi

echo ""
echo "🛠️  QUICK FIXES:"
echo "1. Go to https://supabase.com/dashboard"
echo "2. Find your Proseby project"
echo "3. If it shows 'PAUSED', click 'Resume Project'"
echo "4. If still failing, regenerate the DATABASE_URL from Settings > Database"
echo ""
echo "📋 Next steps after fixing:"
echo "   pnpm db:generate"
echo "   pnpm db:migrate"
echo "   pnpm dev"