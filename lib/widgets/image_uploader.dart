// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

class ImageUploader extends StatefulWidget {
  const ImageUploader({super.key});

  @override
  _ImageUploaderState createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  final List<dynamic> _selectedImages = [];

  Future<void> _pickImage(int index) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      if (kIsWeb) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          if (index >= 0 && index < _selectedImages.length) {
            _selectedImages[index] = bytes;
          } else {
            _selectedImages.add(bytes);
          }
        });
      } else {
        setState(() {
          if (index >= 0 && index < _selectedImages.length) {
            _selectedImages[index] = File(pickedFile.path);
          } else {
            _selectedImages.add(File(pickedFile.path));
          }
        });
      }
    }
  }

  void _viewImage(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              kIsWeb
                  ? Image.memory(_selectedImages[index],
                      width: 200, height: 200)
                  : Image.file(_selectedImages[index], width: 200, height: 200),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _pickImage(index);
                  Navigator.of(ctx).pop();
                },
                child: const Text('Change Image'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Images',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 5),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: _selectedImages.length < 3
              ? _selectedImages.length + 1
              : _selectedImages.length,
          itemBuilder: (context, index) {
            if (index == _selectedImages.length && _selectedImages.length < 3) {
              return _buildAddImageButton();
            } else {
              return _buildImagePreview(index);
            }
          },
        ),
      ],
    );
  }

  Widget _buildAddImageButton() {
    return GestureDetector(
      onTap: () => _pickImage(-1),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey),
        ),
        child: Center(
          child: Icon(Icons.add, size: 40, color: Colors.grey.shade600),
        ),
      ),
    );
  }

  Widget _buildImagePreview(int index) {
    return GestureDetector(
      onTap: () => _viewImage(context, index),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: kIsWeb
            ? Image.memory(
                _selectedImages[index],
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              )
            : Image.file(
                _selectedImages[index],
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
