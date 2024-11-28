import 'dart:io';
import 'package:flutter/material.dart';
import 'package:projek_mobile/helpers/helper.dart';


class CameraAccessScreen extends StatefulWidget {
  const CameraAccessScreen({super.key});

  @override
  State<CameraAccessScreen> createState() => _CameraAccessScreenState();
}

class _CameraAccessScreenState extends State<CameraAccessScreen> {
  String _imagePath = "";
  final ImagePickerHelper _imagePickerHelper = ImagePickerHelper();

  void _pickImageFromGallery() {
    _imagePickerHelper.getImageFromGallery((String? path) {
      if (path != null) {
        setState(() {
          _imagePath = path;
        });
      }
    });
  }

  void _pickImageFromCamera() {
    _imagePickerHelper.getImageFromCamera((String? path) {
      if (path != null) {
        setState(() {
          _imagePath = path;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Access'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: _pickImageFromGallery,
              icon: const Icon(Icons.insert_drive_file),
            ),
            const SizedBox(height: 20),
            IconButton(
              onPressed: _pickImageFromCamera,
              icon: const Icon(Icons.camera_alt),
            ),
            if (_imagePath.isNotEmpty)
              Image.file(
                File(_imagePath),
                width: 200,
                height: 200,
              ),
          ],
        ),
      ),
    );
  }
}