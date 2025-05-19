const { Client } = require('pg')

const client = new Client({
  connectionString: process.env.DATABASE_URL
})

client.connect()
  .then(() => {
    console.log('✅ Database connected!')
    client.end()
  })
  .catch(err => {
    console.log('❌ Database connection failed:', err.message)
  })
