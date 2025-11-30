# powershell/create_structure.ps1

# Define the base directory
$baseDir = "G:\My Drive\Code\Organise\my-spotify-lyrics-app"

# Create the folder structure
New-Item -ItemType Directory -Path "$baseDir\backend\routes"
New-Item -ItemType Directory -Path "$baseDir\frontend\public"
New-Item -ItemType Directory -Path "$baseDir\frontend\src\components"

# Create empty files
New-Item -ItemType File -Path "$baseDir\backend\server.js"
New-Item -ItemType File -Path "$baseDir\backend\.env"
New-Item -ItemType File -Path "$baseDir\backend\routes\auth.js"
New-Item -ItemType File -Path "$baseDir\backend\routes\lyrics.js"
New-Item -ItemType File -Path "$baseDir\frontend\src\App.js"
New-Item -ItemType File -Path "$baseDir\frontend\src\index.js"
New-Item -ItemType File -Path "$baseDir\frontend\src\components\LyricsDisplay.js"
New-Item -ItemType File -Path "$baseDir\frontend\package.json"
New-Item -ItemType File -Path "$baseDir\backend\package.json"
