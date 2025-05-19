const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

console.log('🚀 Setting up Proseby monorepo...\n');

function runCommand(command, description) {
  console.log(`📦 ${description}...`);
  try {
    execSync(command, { stdio: 'inherit' });
    console.log(`✅ ${description} completed\n`);
  } catch (error) {
    console.error(`❌ ${description} failed:`, error.message);
    process.exit(1);
  }
}

// Check Node.js version
const nodeVersion = process.version;
const requiredVersion = 18;
const currentVersion = parseInt(nodeVersion.slice(1));

if (currentVersion < requiredVersion) {
  console.error(`❌ Node.js ${requiredVersion}+ required. Current: ${nodeVersion}`);
  process.exit(1);
}
console.log(`✅ Node.js ${nodeVersion} detected\n`);

// Check/Install pnpm
try {
  const pnpmVersion = execSync('pnpm --version', { encoding: 'utf8' }).trim();
  console.log(`✅ pnpm ${pnpmVersion} detected\n`);
} catch {
  runCommand('npm install -g pnpm@8.15.1', 'Installing pnpm');
}

// Install dependencies
runCommand('pnpm install', 'Installing dependencies');

// Setup git hooks
runCommand('pnpm dlx husky install', 'Setting up git hooks');

// Setup pre-commit hook
if (!fs.existsSync('.husky/pre-commit')) {
  runCommand('pnpm dlx husky add .husky/pre-commit "pnpm lint-staged"', 'Adding pre-commit hook');
}

// Check environment
if (!fs.existsSync('.env.local')) {
  console.log('📝 Creating .env.local from template...');
  fs.copyFileSync('.env.example', '.env.local');
  console.log('✅ .env.local created\n');
  console.log('⚠️  Please update .env.local with your actual credentials\n');
} else {
  console.log('✅ .env.local already exists\n');
}

// Create initial package files if they don't exist
const packages = ['ui', 'auth', 'database', 'api', 'ai', 'shared', 'eslint-config', 'typescript-config'];

packages.forEach(pkg => {
  const packageDir = `packages/${pkg}`;
  const packageJsonPath = `${packageDir}/package.json`;
  const indexPath = `${packageDir}/src/index.ts`;
  
  if (!fs.existsSync(packageDir)) {
    fs.mkdirSync(packageDir, { recursive: true });
    fs.mkdirSync(`${packageDir}/src`, { recursive: true });
  }
  
  if (!fs.existsSync(packageJsonPath)) {
    const packageJson = {
      "name": `@proseby/${pkg}`,
      "version": "0.1.0",
      "private": true,
      "main": "./src/index.ts",
      "types": "./src/index.ts",
      "scripts": {
        "build": "tsc",
        "dev": "tsc --watch",
        "lint": "eslint src --max-warnings 0",
        "type-check": "tsc --noEmit",
        "test": "vitest run",
        "test:watch": "vitest",
        "clean": "rm -rf dist"
      }
    };
    
    fs.writeFileSync(packageJsonPath, JSON.stringify(packageJson, null, 2));
  }
  
  if (!fs.existsSync(indexPath)) {
    fs.writeFileSync(indexPath, `// TODO: Implement ${pkg} package\nexport {}\n`);
  }
});

console.log('🎉 Setup complete!\n');
console.log('📝 Next steps:');
console.log('1. Update .env.local with your API keys and database credentials');
console.log('2. Start the database: docker-compose up -d');
console.log('3. Start development: pnpm dev');
console.log('4. Open browser: http://localhost:3000\n');
console.log('📚 Useful commands:');
console.log('- pnpm dev                 # Start all dev servers');
console.log('- pnpm dev:web            # Start only web app');
console.log('- pnpm db:studio          # Open database studio');
console.log('- pnpm type-check         # Check TypeScript');
console.log('- pnpm test               # Run tests');
