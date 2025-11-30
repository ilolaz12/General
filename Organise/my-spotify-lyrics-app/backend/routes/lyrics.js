// backend/routes/lyrics.js

const express = require('express');
const axios = require('axios');
const translate = require('@vitalets/google-translate-api');
const router = express.Router();

// Function to fetch lyrics from Genius API
const fetchLyrics = async (songTitle, artistName) => {
    const baseUrl = 'https://api.genius.com';
    const headers = { 'Authorization': 'Bearer YOUR_GENIUS_ACCESS_TOKEN' };
    const searchUrl = `${baseUrl}/search?q=${encodeURIComponent(songTitle)} ${encodeURIComponent(artistName)}`;

    const response = await axios.get(searchUrl, { headers });
    const songInfo = response.data.response.hits[0].result;
    const lyricsUrl = songInfo.url;

    // Scrape lyrics from the URL (not shown here)
    const lyricsText = await scrapeLyrics(lyricsUrl);
    
    return lyricsText;
};

// Function to translate lyrics using Google Translate API
const translateLyrics = async (lyrics, targetLanguage) => {
    const translation = await translate(lyrics, { to: targetLanguage });
    return translation.text;
};

// Route to fetch and translate lyrics
router.get('/', async (req, res) => {
    const songTitle = req.query.title;
    const artistName = req.query.artist;
    const targetLanguage = req.query.lang || 'es'; // Default to Spanish if not provided

    try {
        const lyrics = await fetchLyrics(songTitle, artistName);
        const translatedLyrics = await translateLyrics(lyrics, targetLanguage);
        res.json({ lyrics: translatedLyrics });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

module.exports = router;
