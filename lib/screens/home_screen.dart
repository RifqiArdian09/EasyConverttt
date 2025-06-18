import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';
import '../widgets/file_picker_widget.dart';
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  Uint8List? selectedFileBytes;
  String? selectedFileName;
  String? selectedFormat;
  String resultMessage = '';
  bool isLoading = false;
  List<String> supportedFormats = [];
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _loadSupportedFormats();
    
    // Initialize animations
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutQuart,
      ),
    );
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadSupportedFormats() async {
    try {
      final formats = await ApiService.getSupportedFormats();
      setState(() {
        supportedFormats = formats;
        if (formats.isNotEmpty) selectedFormat = formats.first;
      });
    } catch (e) {
      setState(() => resultMessage = "Failed to load formats: ${e.toString()}");
      _showErrorSnackbar("Failed to load supported formats");
    }
  }

  Future<void> _convertFile() async {
    if (selectedFileBytes == null || selectedFileName == null || selectedFormat == null) {
      _showErrorSnackbar("Please select a file and target format");
      return;
    }

    setState(() {
      isLoading = true;
      resultMessage = '';
    });

    try {
      final result = await ApiService.convertFileWeb(
        selectedFileBytes!,
        selectedFileName!,
        selectedFormat!,
      );

      _showSuccessDialog(result['filename']);
    } catch (e) {
      _showErrorSnackbar("Conversion failed: ${e.toString()}");
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _showSuccessDialog(String filename) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Conversion Successful"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 60),
            const SizedBox(height: 16),
            Text("File saved as: $filename"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
        ),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFF7B00),
                Color(0xFFFF9D42),
                Colors.white,
              ],
              stops: [0.0, 0.3, 0.7],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // AI Illustration and Title
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          Text(
                            'Document Converter',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  blurRadius: 4,
                                  color: Colors.black.withOpacity(0.2),
                                ), // Added closing parenthesis for Shadow
                              ], // Added closing square bracket for shadows list
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Convert your documents easily',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // File Upload Card
                  SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Card(
                        elevation: 8,
                        shadowColor: Colors.black.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              
                              const SizedBox(height: 8),
                            
                            
                              const SizedBox(height: 20),
                              FilePickerWidget(
                                onFilePicked: (bytes, name) {
                                  setState(() {
                                    selectedFileBytes = bytes;
                                    selectedFileName = name;
                                    resultMessage = '';
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Conversion Options Card
                  SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Card(
                        elevation: 8,
                        shadowColor: Colors.black.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.settings_outlined,
                                    color: Colors.orange[700],
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    "Conversion Options",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              DropdownButtonFormField<String>(
                                value: selectedFormat,
                                decoration: InputDecoration(
                                  labelText: 'Target Format',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[100],
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 14),
                                ),
                                items: supportedFormats
                                    .map((f) => DropdownMenuItem(
                                          value: f,
                                          child: Text(
                                            f.toUpperCase(),
                                            style: const TextStyle(fontSize: 14),
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (val) =>
                                    setState(() => selectedFormat = val),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: isLoading ? null : _convertFile,
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    backgroundColor: Colors.orange[700],
                                    foregroundColor: Colors.white,
                                    elevation: 2,
                                    shadowColor: Colors.orange.withOpacity(0.4),
                                  ),
                                  child: isLoading
                                      ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white,
                                          ),
                                        )
                                      : const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.autorenew, size: 20),
                                            SizedBox(width: 8),
                                            Text(
                                              "CONVERT NOW",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Results Section
                  if (resultMessage.isNotEmpty)
                    SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: resultMessage.contains("Berhasil")
                                ? Colors.green[50]
                                : Colors.red[50],
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: resultMessage.contains("Berhasil")
                                  ? Colors.green[100]!
                                  : Colors.red[100]!,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    resultMessage.contains("Berhasil")
                                        ? Icons.check_circle
                                        : Icons.error,
                                    color: resultMessage.contains("Berhasil")
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    resultMessage.contains("Berhasil")
                                        ? "Conversion Successful"
                                        : "Error Occurred",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: resultMessage.contains("Berhasil")
                                          ? Colors.green[800]
                                          : Colors.red[800],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                resultMessage,
                                style: TextStyle(
                                  color: resultMessage.contains("Berhasil")
                                      ? Colors.green[800]
                                      : Colors.red[800],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}