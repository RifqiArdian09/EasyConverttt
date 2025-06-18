# EasyConvert

**EasyConvert** adalah aplikasi berbasis Flutter Web yang memungkinkan pengguna untuk mengonversi dokumen antar format populer seperti PDF, DOCX, dan PPTX. Aplikasi ini terdiri dari frontend (Flutter) dan backend (FastAPI) yang terintegrasi melalui API.

---

## ✨ Fitur Utama

- Upload file (PDF, DOCX, PPTX)
- Pilih format tujuan
- File hasil konversi bisa langsung diunduh

---

## 📁 Struktur Proyek

EasyConvert/
├── lib/
│   ├── main.dart
│   ├── screens/
│   │   └── home_screen.dart
│   ├── widgets/
│   │   └── file_picker_widget.dart
│   └── services/
│       └── api_service.dart
├── backend/
│   ├── main.py
│   ├── uploads/
│   └── converted/


---

## 🚀 Cara Menjalankan

### 1. Clone Repository

```bash
git clone https://github.com/RifqiArdian09/EasyConverttt.git
cd EasyConverttt
```

### 2. Menjalankan Backend (FastAPI)

## ✅ Persyaratan:
- Python 3.10 atau lebih
- LibreOffice sudah terinstal (bisa diakses via command line)

```bash
cd backend
python -m venv venv
venv\Scripts\activate        # Untuk Windows
# source venv/bin/activate   # Untuk macOS/Linux

pip install fastapi uvicorn python-multipart
uvicorn main:app --reload

```

📂 Folder Penting:
- uploads/ = tempat file yang diunggah
- converted/ = hasil file yang sudah dikonversi



