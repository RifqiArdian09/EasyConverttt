# EasyConvert

EasyConvert is a cross-platform document conversion tool built with Flutter for the frontend and FastAPI (Python) for the backend. It leverages LibreOffice for robust document conversions, allowing users to convert various document types like PDF, DOCX, PPTX, and more.

## Features

* **File Upload:** Easily upload your documents from your device.
* **Multiple Target Formats:** Convert to and from various popular document formats (PDF, DOCX, PPTX, ODT, TXT).
* **Fast and Reliable Conversion:** Utilizes LibreOffice for efficient and accurate conversions.
* **User-Friendly Interface:** A clean and intuitive Flutter UI for a seamless experience.

## Project Structure
![sturucture](https://github.com/RifqiArdian09/EasyConverttt/blob/main/lib/images/image.png)

## Getting Started

Follow these instructions to set up and run EasyConvert on your local machine.

---

### Backend Setup (FastAPI)

The backend handles the file upload, conversion using LibreOffice, and serves the converted files.

#### Prerequisites

* **Python 3.7+**: Make sure you have Python installed.
* **LibreOffice**: LibreOffice is essential for document conversion. Download and install it from the official website: [https://www.libreoffice.org/download/](https://www.libreoffice.org/download/)
    * **Windows User**: Note the installation path for LibreOffice (e.g., `C:\Program Files\LibreOffice\program\soffice.exe`). You'll need to update the `LIBREOFFICE_PATH` variable in `backend/main.py` if it differs.

#### Installation

1.  **Navigate to the backend directory:**

    ```bash
    cd EasyConvert/backend
    ```

2.  **Create a virtual environment (recommended):**

    ```bash
    python -m venv venv
    ```

3.  **Activate the virtual environment:**

    * **Windows:**

        ```bash
        .\venv\Scripts\activate
        ```

    * **macOS/Linux:**

        ```bash
        source venv/bin/activate
        ```

4.  **Install the required Python packages:**

    ```bash
    pip install -r requirements.txt
    ```

    *If you don't have a `requirements.txt` file, create one in the `backend/` directory with the following content and then run `pip install -r requirements.txt`*:

    ```
    fastapi
    uvicorn[standard]
    python-multipart
    python-dotenv
    ```

#### Running the Backend Server

1.  **Ensure your virtual environment is active.**
2.  **Run the FastAPI application:**

    ```bash
    uvicorn main:app --host 0.0.0.0 --port 8000 --reload
    ```

    The backend server will typically run on `http://127.0.0.1:8000` (or `http://localhost:8000`). Make sure your firewall allows connections to this port.

    **Important:** If you are running the Flutter app on a different device or a mobile emulator, you might need to change `baseUrl` in `lib/services/api_service.dart` to your backend machine's actual IP address (e.g., `http://192.168.1.3:8000`).

---

### Frontend Setup (Flutter)

The frontend is a Flutter application that provides the user interface for interacting with the backend.

#### Prerequisites

* **Flutter SDK**: Ensure you have Flutter installed and configured. Follow the official Flutter installation guide: [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
* **IDE**: Android Studio, VS Code with Flutter and Dart plugins are recommended.

#### Installation

1.  **Navigate to the Flutter project directory:**

    ```bash
    cd EasyConvert
    ```

2.  **Get Flutter dependencies:**

    ```bash
    flutter pub get
    ```

#### Running the Frontend Application

1.  **Ensure your FastAPI backend server is running.**
2.  **Run the Flutter application:**

    * **For Web (recommended for quick testing):**

        ```bash
        flutter run -d chrome
        ```

    * **For Android Emulator/Device:**

        Make sure you have an Android emulator running or a physical device connected and configured for development.

        ```bash
        flutter run
        ```

    * **For Desktop (Windows, macOS, Linux):**

        Ensure you have desktop development enabled (`flutter config --enable-windows-desktop`, `flutter config --enable-macos-desktop`, or `flutter config --enable-linux-desktop`).

        ```bash
        flutter run -d windows # or -d macos, -d linux
        ```

The Flutter application should launch, and you can now pick a file and convert it using the running backend service.

---

## Usage

1.  **Start the Backend Server:** Follow the steps in "Running the Backend Server."
2.  **Run the Flutter Application:** Follow the steps in "Running the Frontend Application."
3.  **Select a File:** On the Flutter app, click the "Pilih File" (Select File) button to choose a document from your computer.
4.  **Choose Target Format:** Select the desired output format from the dropdown menu.
5.  **Convert:** Click the "CONVERT NOW" button to initiate the conversion.
6.  **Download/View Result:** Upon successful conversion, a success message will appear, indicating the converted filename. (Note: The current frontend only shows a success message; a download functionality would need to be implemented separately based on the `output_path` returned by the backend.)

## Troubleshooting

* **"Failed to load supported formats"**: Ensure your FastAPI backend is running and the `baseUrl` in `lib/services/api_service.dart` is correctly set to your backend's address (especially if running on a different machine or emulator).
* **"Konversi gagal" (Conversion failed)**:
    * Check the `LIBREOFFICE_PATH` in `backend/main.py` is correct for your LibreOffice installation.
    * Review the backend logs for more detailed error messages.
    * Ensure LibreOffice is not already running in the background.
* **CORS Issues**: The backend has `CORSMiddleware` configured to allow all origins (`allow_origins=["*"]`). If you encounter CORS errors, double-check that the middleware is correctly applied and no other network configurations are blocking requests.
* **File Permissions**: Ensure the `uploads/` and `converted/` directories in the backend have appropriate write permissions for the user running the FastAPI application.
