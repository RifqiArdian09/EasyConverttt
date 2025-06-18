import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FilePickerWidget extends StatelessWidget {
  final void Function(Uint8List fileBytes, String fileName) onFilePicked;
  final List<String> allowedExtensions;

  const FilePickerWidget({
    super.key,
    required this.onFilePicked,
    this.allowedExtensions = const ['pdf', 'doc', 'docx', 'ppt', 'pptx', 'odt', 'txt'],
  });

  Future<void> _pickFile(BuildContext context) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedExtensions,
        withData: true,
      );

      if (result == null || result.files.single.bytes == null) return;

      final file = result.files.single;
      onFilePicked(file.bytes!, file.name);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Icon(Icons.cloud_upload, size: 50, color: Color(0xFFFF7B00)),
            const SizedBox(height: 10),
            const Text(
              "Pilih File Dokumen",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              "Format yang didukung: ${allowedExtensions.join(', ')}",
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => _pickFile(context),
              child: const Text("Pilih File"),
            ),
          ],
        ),
      ),
    );
  }
}