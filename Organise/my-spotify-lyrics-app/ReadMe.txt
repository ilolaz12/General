my-spotify-lyrics-app/
│
├── backend/
│   ├── node_modules/
│   ├── package.json
│   ├── server.js
│   ├── .env
│   └── routes/
│       ├── auth.js
│       └── lyrics.js
│
├── frontend/
│   ├── node_modules/
│   ├── public/
│   ├── src/
│       ├── components/
│       │   └── LyricsDisplay.js
│       ├── App.js
│       ├── index.js
│   ├── package.json
│
└── powershell/
    └── create_structure.ps1


Instructions to Run the Project
Set Up Backend:

Navigate to the backend directory.

Install dependencies: npm install.

Create a .env file with your Spotify and Genius API credentials:

makefile
Copy code
SPOTIFY_CLIENT_ID=your_spotify_client_id
SPOTIFY_CLIENT_SECRET=your_spotify_client_secret
SPOTIFY_REDIRECT_URI=http://localhost:8888/callback
Start the backend server: node server.js.

Set Up Frontend:

Navigate to the frontend directory.
Install dependencies: npm install.
Start the frontend development server: npm start.
Access the App:

Open your browser and navigate to http://localhost:3000.
Log in to Spotify and authorize the app.
Play a song and see the translated lyrics displayed alongside the Spotify player.
This setup ensures that your app fetches lyrics from the Genius API, translates them using the Google Translate API, and displays them in sync with the Spotify player.