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
├── lib/                      # Kode sumber aplikasi Flutter (Frontend)
│   ├── main.dart             # Titik masuk utama aplikasi Flutter
│   ├── screens/              # Layar/halaman UI aplikasi
│   │   └── home_screen.dart  # Layar utama untuk pemilihan dan konversi file
│   ├── widgets/              # Widget UI yang dapat digunakan kembali
│   │   └── file_picker_widget.dart # Widget untuk memilih file
│   └── services/             # Layanan untuk berinteraksi dengan API backend
│       └── api_service.dart  # Logika untuk panggilan API ke backend
├── backend/                  # Kode sumber aplikasi Python (Backend)
│   ├── main.py               # Logika utama server backend
│   ├── uploads/              # Direktori untuk menyimpan file yang diunggah sementara
│   └── converted/            # Direktori untuk menyimpan file hasil konversi
├── .gitignore                # File yang diabaikan oleh Git
└── README.md                 # Deskripsi proyek ini
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



