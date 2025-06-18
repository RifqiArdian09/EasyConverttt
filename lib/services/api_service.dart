import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://192.168.1.3:8000"; // Sesuaikan dengan IP server
  
  static Future<Map<String, dynamic>> convertFileWeb(
    Uint8List fileBytes, 
    String fileName, 
    String format,
  ) async {
    try {
      final uri = Uri.parse("$baseUrl/convert/");
      var request = http.MultipartRequest("POST", uri)
        ..fields['format'] = format
        ..files.add(http.MultipartFile.fromBytes(
          'file', 
          fileBytes, 
          filename: fileName,
        ));

      final response = await request.send();
      final responseStr = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return jsonDecode(responseStr);
      } else {
        throw Exception("Gagal mengkonversi: ${response.statusCode}\n$responseStr");
      }
    } catch (e) {
      throw Exception("Error: ${e.toString()}");
    }
  }

  static Future<List<String>> getSupportedFormats() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/formats"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<String>.from(data['supported_formats']);
      }
      throw Exception("Gagal mendapatkan format yang didukung");
    } catch (e) {
      throw Exception("Error: ${e.toString()}");
    }
  }
}