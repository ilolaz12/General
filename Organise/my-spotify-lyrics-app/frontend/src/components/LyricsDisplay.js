// frontend/src/components/LyricsDisplay.js

import React from 'react';

const LyricsDisplay = ({ lyrics }) => {
    return (
        <div>
            <h2>Translated Lyrics</h2>
            <p>{lyrics}</p>
        </div>
    );
};

export default LyricsDisplay;
