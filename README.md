# EasyConvert

**EasyConvert** adalah aplikasi berbasis Flutter Web yang memungkinkan pengguna untuk mengonversi dokumen antar format populer seperti PDF, DOCX, dan PPTX. Aplikasi ini terdiri dari frontend (Flutter) dan backend (FastAPI) yang terintegrasi melalui API.

---

## ✅ Format Dokumen yang Didukung

Aplikasi ini mendukung konversi antar format berikut:

| Format | Deskripsi                 |
|--------|---------------------------|
| PDF    | Portable Document Format |
| DOC    | Microsoft Word 97–2003   |
| DOCX   | Microsoft Word modern    |
| PPT    | PowerPoint 97–2003       |
| PPTX   | PowerPoint modern        |
| ODT    | OpenDocument Text        |
| TXT    | Plain Text File          |

---

## 📁 Struktur Proyek
EasyConvert/
├── lib/
│ ├── main.dart
│ ├── screens/
│ │ └── home_screen.dart
│ ├── widgets/
│ │ └── file_picker_widget.dart
│ └── services/
│ └── api_service.dart
├── backend/
│ ├── main.py
│ ├── uploads/
│ └── converted/
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

### 3. Menjalankan Frontend (Flutter Web)

## ✅ Persyaratan:
- Flutter SDK (disarankan versi terbaru)

```bash
flutter pub get
flutter run -d chrome
```



