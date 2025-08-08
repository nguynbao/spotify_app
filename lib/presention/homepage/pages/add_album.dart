import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddAlbumScreen extends StatefulWidget {
  const AddAlbumScreen({super.key});

  @override
  State<AddAlbumScreen> createState() => _AddAlbumScreenState();
}

class _AddAlbumScreenState extends State<AddAlbumScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _albumNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _selectedImage; // <-- Thêm biến ảnh

  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _albumNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
    // Xin quyền
    var status = await Permission.photos.request(); // cho iOS
    var storageStatus = await Permission.storage.request(); // cho Android

    if (status.isGranted || storageStatus.isGranted) {
      final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
        print("Ảnh đã chọn: ${image.path}");
      } else {
        print("Không có ảnh nào được chọn.");
      }
    } else {
      print("Không có quyền truy cập thư viện ảnh.");
    }
  } catch (e) {
    print("Lỗi khi mở thư viện ảnh: $e");
  }
}
  Future<void> saveAlbumToFirestore(String albumName, String description, List<dynamic> imagePaths) async {
    try {
      await FirebaseFirestore.instance.collection('albums').add({
        'name': albumName,
        'description': description,
        'images': imagePaths,
        'created_at': FieldValue.serverTimestamp(),
      });
      print("Lưu album thành công!");
    } catch (e) {
      print("Lỗi khi lưu album: $e");
    }
  }

  void _createAlbum() async{
    if (_formKey.currentState!.validate()) {
      final name = _albumNameController.text.trim();
      final description = _descriptionController.text.trim();
      final imagePaths = _selectedImage != null ? [_selectedImage!.path] : [];

       await saveAlbumToFirestore(name, description, imagePaths);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Tạo album \"$name\" thành công!")),
      );
      _albumNameController.clear();
      _descriptionController.clear();
      setState(() {
        _selectedImage = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Tạo Album", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Khu vực chọn ảnh
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: _selectedImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.file(
                            _selectedImage!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        )
                      : const Center(
                          child: Icon(Icons.image_outlined, size: 60, color: Colors.grey),
                        ),
                ),
              ),
              const SizedBox(height: 24),

              // Tên album
              TextFormField(
                controller: _albumNameController,
                decoration: InputDecoration(
                  labelText: 'Tên Album',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) => value == null || value.isEmpty ? 'Vui lòng nhập tên album' : null,
              ),
              const SizedBox(height: 16),

              // Mô tả
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Mô tả',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 30),

              // Nút tạo album
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _createAlbum,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Tạo Album", style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
