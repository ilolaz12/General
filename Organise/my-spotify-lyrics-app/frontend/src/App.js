// frontend/src/App.js

import React, { useEffect, useState } from 'react';
import SpotifyPlayer from 'react-spotify-web-playback';
import LyricsDisplay from './components/LyricsDisplay';

const App = () => {
    const [token, setToken] = useState('');
    const [lyrics, setLyrics] = useState('');

    useEffect(() => {
        // Get access token from URL hash
        const hash = window.location.hash.substring(1).split('&').reduce((initial, item) => {
            if (item) {
                const parts = item.split('=');
                initial[parts[0]] = decodeURIComponent(parts[1]);
            }
            return initial;
        }, {});

        setToken(hash.access_token);

        // Fetch and translate lyrics
        fetchLyricsAndTranslate('Shape of You', 'Ed Sheeran');
    }, []);

    // Function to fetch and translate lyrics
    const fetchLyricsAndTranslate = async (title, artist) => {
        const response = await fetch(`http://localhost:8888/lyrics?title=${title}&artist=${artist}&lang=es`);
        const data = await response.json();
        setLyrics(data.lyrics);
    };

    return (
        <div>
            {/* Spotify player component */}
            <SpotifyPlayer token={token} uris={['spotify:track:7qiZfU4dY1lWllzX7mPBI3']} />

            {/* Lyrics display component */}
            <LyricsDisplay lyrics={lyrics} />
        </div>
    );
};

export default App;
