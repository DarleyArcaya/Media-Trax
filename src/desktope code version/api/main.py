import sys
import os


if getattr(sys, 'frozen', False):
    # En modo --onedir, sys.executable apunta a la ubicación real de tu main.exe
    base_dir = os.path.dirname(sys.executable)
else:
    # En desarrollo normal con Python
    base_dir = os.path.dirname(os.path.abspath(__file__))

# Agrega la carpeta base al PATH de Python
if base_dir not in sys.path:
    sys.path.insert(0, base_dir)


import fastapi
import uvicorn
from core.downloader_audio import download_audio
from core.downloader_video import download_video

app = fastapi.FastAPI()


@app.get("/download")
async def download_audio_endpoint():
    return {"message": "Downloading audio from YouTube"}

@app.get("/download_audio")
async def download_audio_return(url: str):
    try: 
        result = download_audio(url)
        return {"message": "Audio downloaded successfully", "result": result}
    except Exception as e:
        return {"error": str(e)}


@app.get("/download_video")
async def download_video_return(url: str):
    try:
        result = download_video(url)
        return {"message": "Video downloaded successfully", "result": result}
    except Exception as e:
        return {"error": str(e)}


LOGGING_CONFIG = {
    "version": 1,
    "disable_existing_loggers": False,
    "formatters": {},
    "handlers": {},
    "loggers": {}
}

if __name__ == "__main__":
    uvicorn.run(app, host="127.0.0.1", port=8000, reload=False, log_config=LOGGING_CONFIG) 

# Command for create executtable: pyinstaller --onedir --noconsole --paths . --collect-all core --collect-all yt_dlp --collect-all pydantic_core --collect-all pydantic --collect-all fastapi main.py