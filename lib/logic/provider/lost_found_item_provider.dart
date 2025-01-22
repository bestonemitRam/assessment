import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class LostAndFoundItem with ChangeNotifier 
{

    final List<XFile> _images = [];
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _dateController = TextEditingController();

  void _pickImages() async {
    final List<XFile>? pickedImages = await _picker.pickMultiImage();
    if (pickedImages != null) {
  
        _images.addAll(pickedImages);
    
    }
  }


}
