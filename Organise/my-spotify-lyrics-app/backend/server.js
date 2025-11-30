// backend/server.js

const express = require('express');
const cors = require('cors');
const app = express();
const authRoutes = require('./routes/auth');
const lyricsRoutes = require('./routes/lyrics');

// Middleware to handle JSON requests and CORS
app.use(express.json());
app.use(cors());

// Define routes
app.use('/auth', authRoutes);
app.use('/lyrics', lyricsRoutes);

// Start the server
const PORT = process.env.PORT || 8888;
app.listen(PORT, () => console.log(`Server running on http://localhost:${PORT}`));
