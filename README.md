🔮 Advanced File Converter
Aplikasi berbasis Flask + LibreOffice yang dirancang untuk mengonversi berbagai format file, seperti DOCX, PDF, PPTX, XLSX, TXT, dan CSV, melalui antarmuka web modern dan intuitif.

Aplikasi ini bertujuan untuk menyederhanakan proses konversi file dengan fitur-fitur canggih seperti drag and drop, progress bar animasi, dan download otomatis.

🚀 Fitur Utama
🌙 Antarmuka Pengguna Modern: Tampilan tema gelap (dark theme) dengan fitur drag and drop untuk mengunggah file.

📂 Dukungan Format Luas: Mampu mengonversi berbagai format file, termasuk:

Dokumen: DOC, DOCX, ODT, RTF, TXT, HTML, PDF

Spreadsheet: XLS, XLSX, ODS, CSV

Presentasi: PPT, PPTX, ODP

⚡ Pengalaman Pengguna Interaktif: Menampilkan progress bar animasi yang informatif saat proses konversi berlangsung.

📥 Kemudahan Penggunaan: File hasil akan secara otomatis diunduh ke perangkat Anda setelah konversi selesai.

🛡️ Validasi File Aman: Memiliki validasi untuk membatasi ukuran file maksimum hingga 100MB guna menjaga stabilitas dan performa aplikasi.

📦 Instalasi dan Penggunaan
Ikuti langkah-langkah di bawah ini untuk menginstal dan menjalankan aplikasi.

1. Kloning Repositori
git clone https://github.com/RifqiArdian09/FileConverter.git
cd FileConverter

2. Buat dan Aktifkan Virtual Environment
Virtual environment direkomendasikan untuk mengisolasi dependensi proyek.

# Membuat virtual environment
python -m venv venv

# Mengaktifkan virtual environment
source venv/bin/activate    # Linux / macOS
venv\Scripts\activate       # Windows

3. Instal Dependensi Python
Pasang semua pustaka Python yang diperlukan dari file requirements.txt.

pip install -r requirements.txt

4. Instalasi LibreOffice
Pastikan LibreOffice terinstal di sistem Anda, karena aplikasi ini menggunakannya sebagai engine konversi.

Windows:

Unduh dan instal LibreOffice dari situs resminya: https://www.libreoffice.org/download/

Secara default, path soffice.exe biasanya berada di C:\Program Files\LibreOffice\program\soffice.exe. Jika tidak, pastikan untuk menambahkannya ke variabel PATH sistem Anda.

Linux / macOS:

Ubuntu / Debian:

sudo apt install libreoffice

macOS (menggunakan Homebrew):

brew install --cask libreoffice

5. Menjalankan Aplikasi
Jalankan server aplikasi Flask dengan perintah berikut:

python app.py

Setelah server berjalan, buka browser Anda dan akses http://127.0.0.1:5000 untuk mulai menggunakan aplikasi.

Butuh bantuan atau memiliki pertanyaan? Jangan ragu untuk membuka issue di repositori ini.
