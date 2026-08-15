from  pathlib import Path
import yt_dlp as yt

def download_video(url):
    downloads_dir = Path.home() / "Downloads"
    downloads_dir.mkdir(parents=True, exist_ok=True)

    try:
        ydl_opts = {
            'format': 'best[ext=mp4]/best',
            'outtmpl': str(downloads_dir / '%(title)s.%(ext)s'),
        }
        with yt.YoutubeDL(ydl_opts) as ydl:
            ydl.download([url])
    except Exception as e:
        print(f"Error downloading video: {e}")