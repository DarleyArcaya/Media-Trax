from pathlib import Path
import yt_dlp as yt

def download_audio(url):
    downloads_dir = Path.home() / "Downloads"
    downloads_dir.mkdir(parents=True, exist_ok=True)

    try:
        ydl_opts = {
            'format': 'bestaudio[ext=m4a]/ba[ext=mp3]',
            'outtmpl': str(downloads_dir / '%(title)s.%(ext)s'),
        }
        with yt.YoutubeDL(ydl_opts) as ydl:
            ydl.download([url])
    except Exception as e:
        print(f"Error downloading audio: {e}")