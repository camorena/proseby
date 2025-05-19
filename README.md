Proseby - AI-Powered Business Automation Platform
🎯 Project Overview
Proseby is a modern AI-powered business automation platform built with a cutting-edge monorepo architecture. The platform provides chatbot creation, content generation, invoice management, and analytics capabilities.
🏗️ Architecture Overview
Proseby Monorepo (Turborepo + pnpm)
├── Frontend: Next.js 14 + React 19 + TypeScript
├── API: tRPC + Prisma + PostgreSQL
├── AI: OpenAI + Anthropic with fallback
├── Auth: Supabase Authentication
├── UI: Tailwind CSS + Shadcn/ui + Radix
├── State: Zustand + TanStack Query
└── Deploy: Vercel + GitHub Actions
📁 Project Structure
proseby/
├── apps/
│ ├── web/ # Next.js main application
│ └── docs/ # Documentation site
├── packages/
│ ├── ui/ # Shared UI components (@proseby/ui)
│ ├── auth/ # Authentication (@proseby/auth)
│ ├── database/ # Prisma schema (@proseby/database)
│ ├── api/ # tRPC procedures (@proseby/api)
│ ├── ai/ # AI services (@proseby/ai)
│ ├── shared/ # Common utilities (@proseby/shared)
│ ├── eslint-config/ # ESLint configuration
│ └── typescript-config/ # TypeScript configuration
├── scripts/ # Setup and utility scripts
├── .github/workflows/ # CI/CD pipelines
├── docker-compose.yml # Local development services
├── turbo.json # Turborepo configuration
├── pnpm-workspace.yaml # pnpm workspace configuration
└── package.json # Root package configuration
🚀 Current Status
✅ Completed

Monorepo setup with Turborepo + pnpm
Basic Next.js application running
Package structure created
Development environment configured
Git hooks setup (Husky + lint-staged)
TypeScript configuration
ESLint & Prettier setup

🔄 In Progress

Environment configuration (Supabase, OpenAI)
Database schema design
Authentication setup

📋 Todo

UI component library
tRPC API implementation
AI service integration
Authentication flows
Dashboard interface
Chatbot management
Content generation
Analytics dashboard
Billing system

⚙️ Environment Setup
Required Services

Supabase (Database + Auth)

Create project at supabase.com
Get: Project URL, Anon Key, Service Role Key, Database URL

OpenAI (Primary AI Provider)

Get API key from platform.openai.com
Recommended: Add payment method for usage

Optional Services

Anthropic API (AI fallback)
Upstash Redis (Caching)
Stripe (Billing)
Resend (Email)

Environment Variables
Create .env.local with:
bash# Database
DATABASE_URL="postgresql://postgres:password@db.xxxxx.supabase.co:5432/postgres"

# Supabase

SUPABASE_URL="https://xxxxx.supabase.co"
SUPABASE_SERVICE_ROLE_KEY="eyJhbGciOiJIUzI1NiIs..."
NEXT_PUBLIC_SUPABASE_URL="https://xxxxx.supabase.co"
NEXT_PUBLIC_SUPABASE_ANON_KEY="eyJhbGciOiJIUzI1NiIs..."

# AI Services

OPENAI_API_KEY="sk-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
ANTHROPIC_API_KEY="sk-ant-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

# Optional

UPSTASH_REDIS_REST_URL="https://xxxxx.upstash.io"
UPSTASH_REDIS_REST_TOKEN="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
STRIPE_SECRET_KEY="sk_test_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
RESEND_API_KEY="re_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

# Development

NODE_ENV="development"
NEXT_PUBLIC_APP_URL="http://localhost:3000"
🛠️ Development Commands
Setup
bash# Install dependencies
pnpm install

# Run initial setup

pnpm setup

# Start local services (database, redis)

docker-compose up -d
Development
bash# Start all development servers
pnpm dev

# Start specific app

pnpm dev:web

# Type checking

pnpm type-check

# Linting

pnpm lint
pnpm lint:fix

# Testing

pnpm test
pnpm test:watch

# Code formatting

pnpm format
Database
bash# Generate Prisma client
pnpm db:generate

# Run migrations

pnpm db:migrate

# Open Prisma Studio

pnpm db:studio

# Seed database

pnpm db:seed

# Reset database

pnpm db:reset
Building
bash# Build all packages
pnpm build

# Clean build artifacts

pnpm clean
📦 Package Details
@proseby/ui

Shared React component library
Tailwind CSS + Shadcn/ui + Radix UI
Theme support (light/dark)
Storybook for component docs

@proseby/auth

Supabase authentication integration
Role-based access control
Protected route components
User profile management

@proseby/database

Prisma ORM setup
PostgreSQL schema
Database migrations
Seed data scripts

@proseby/api

tRPC router definitions
Type-safe API procedures
Authentication middleware
Input validation with Zod

@proseby/ai

Multi-provider AI integration (OpenAI, Anthropic)
Automatic fallback between providers
Cost tracking and monitoring
Rate limiting

@proseby/shared

Common utilities and helpers
Type definitions
Constants and configuration
React hooks
Formatters and validators

🎯 Implementation Roadmap
Phase 1: Core Infrastructure (Week 1)

Complete environment setup
Design database schema
Implement authentication
Set up UI component library

Phase 2: API & Services (Week 2)

Build tRPC API layer
Integrate AI services
Create shared utilities
Set up testing framework

Phase 3: Core Features (Week 3-4)

Chatbot management interface
AI chat functionality
Content generation system
User dashboard

Phase 4: Advanced Features (Week 5-6)

Analytics and reporting
Billing and subscriptions
Multi-user organizations
API for third-party integrations

🚧 Known Issues

Husky setup: Pre-commit hooks creation may fail on first run

Fix: Manually create .husky/pre-commit file

pnpm workspace warnings: Convert from package.json workspaces

Fix: Use pnpm-workspace.yaml instead

Turbo dev loop: Root package calling turbo may create infinite loop

Fix: Ensure proper turbo.json configuration

🔧 Quick Start After Break
If you're continuing development:

Check environment:
bashnode -e "console.log('DB:', !!process.env.DATABASE_URL); console.log('OpenAI:', !!process.env.OPENAI_API_KEY)" -r dotenv/config dotenv_config_path=.env.local

Start services:
bashdocker-compose up -d
pnpm dev

Verify everything works:
bashcurl http://localhost:3000

📝 Key Decisions Made

Monorepo: Turborepo + pnpm for better DX and shared code
Database: PostgreSQL via Supabase for managed hosting
Auth: Supabase Auth for built-in social providers
AI: OpenAI as primary, Anthropic as fallback
Styling: Tailwind CSS + Shadcn/ui for rapid development
Type Safety: End-to-end with tRPC + Prisma + TypeScript

🐛 Common Troubleshooting
Dev server won't start:

Check pnpm-workspace.yaml exists
Verify no circular dependencies in turbo.json
Ensure .env.local is properly formatted

Database connection issues:

Verify DATABASE_URL format
Check Supabase project isn't paused
Ensure IP is whitelisted in Supabase

AI API failures:

Check API key validity
Verify billing setup for OpenAI
Test with curl to confirm API access

📞 Contact & Resources

Repository: https://github.com/camorena/proseby
Tech Stack: Next.js, React, TypeScript, Prisma, tRPC, Tailwind
Deployment: Vercel (planned)
Documentation: /apps/docs (planned)

🎯 For AI Assistants
Context for continuation:

This is a modern full-stack monorepo
Currently in early development phase
Environment setup is the next critical step
Architecture is designed for scale and maintainability
All major technology decisions have been made
Focus should be on implementation over architecture

Immediate next steps:

Complete environment configuration
Implement database schema
Set up authentication flows
Build core UI components

Current blocker: Environment setup (Supabase + OpenAI configuration)
