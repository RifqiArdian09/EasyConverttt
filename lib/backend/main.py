from fastapi import FastAPI, UploadFile, File, Form, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
import os
import shutil
import subprocess
import logging
from typing import List

app = FastAPI()

# Setup logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# CORS Configuration
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Configuration
UPLOAD_DIR = "uploads"
OUTPUT_DIR = "converted"
ALLOWED_FORMATS = ["pdf", "docx", "pptx", "odt", "txt"]
LIBREOFFICE_PATH = r"C:\Program Files\LibreOffice\program\soffice.exe"

# Ensure directories exist
os.makedirs(UPLOAD_DIR, exist_ok=True)
os.makedirs(OUTPUT_DIR, exist_ok=True)

def validate_file_extension(filename: str) -> bool:
    """Validate file extension"""
    allowed_extensions = ['.pdf', '.doc', '.docx', '.ppt', '.pptx', '.odt', '.txt']
    return any(filename.lower().endswith(ext) for ext in allowed_extensions)

@app.post("/convert/")
async def convert_file(
    file: UploadFile = File(...),
    format: str = Form(...),
):
    try:
        # Validate input
        if format.lower() not in ALLOWED_FORMATS:
            raise HTTPException(400, detail=f"Format {format} tidak didukung")
        
        if not validate_file_extension(file.filename):
            raise HTTPException(400, detail="Tipe file tidak didukung")

        # Save uploaded file
        input_path = os.path.join(UPLOAD_DIR, file.filename)
        with open(input_path, "wb") as buffer:
            shutil.copyfileobj(file.file, buffer)
        logger.info(f"File disimpan di: {input_path}")

        # Prepare conversion command
        cmd = [
            LIBREOFFICE_PATH,
            "--headless",
            "--convert-to",
            format,
            "--outdir",
            OUTPUT_DIR,
            input_path
        ]

        # Run conversion
        logger.info(f"Menjalankan perintah: {' '.join(cmd)}")
        result = subprocess.run(
            cmd,
            capture_output=True,
            text=True,
            timeout=30
        )

        # Check results
        if result.returncode != 0:
            error_msg = f"Konversi gagal: {result.stderr}"
            logger.error(error_msg)
            raise HTTPException(500, detail=error_msg)

        # Verify output file
        output_filename = f"{os.path.splitext(file.filename)[0]}.{format}"
        output_path = os.path.join(OUTPUT_DIR, output_filename)
        
        if not os.path.exists(output_path):
            error_msg = "File output tidak ditemukan setelah konversi"
            logger.error(error_msg)
            raise HTTPException(500, detail=error_msg)

        logger.info(f"Konversi berhasil: {output_path}")
        return {
            "status": "success",
            "filename": output_filename,
            "path": output_path
        }

    except subprocess.TimeoutExpired:
        error_msg = "Proses konversi timeout (lebih dari 30 detik)"
        logger.error(error_msg)
        raise HTTPException(500, detail=error_msg)
    except Exception as e:
        logger.error(f"Error: {str(e)}")
        raise HTTPException(500, detail=str(e))

@app.get("/formats")
async def get_supported_formats():
    return {"supported_formats": ALLOWED_FORMATS}