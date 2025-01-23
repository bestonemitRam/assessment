import 'package:assessment/core/database/database.dart';
import 'package:assessment/data/LostItem.dart';
import 'package:assessment/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class LostAndFoundItem with ChangeNotifier {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  String _message = '';
  String get message => _message;
  Future<bool> storedatainDatabase(
      BuildContext context, String date, List<String> imagePaths) async {
    context.showLoader(show: true);
    final newItem = LostItem(
      name: nameController.text,
      contactInfo: contactController.text,
      itemDescription: descriptionController.text,
      date: date,
      location: locationController.text,
      images: imagePaths,
    );

    try {
      await DatabaseHelper.instance.insertItem(newItem);
      await Future.delayed(const Duration(seconds: 1));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Item added successfully!"),
          backgroundColor: Colors.green,
        ),
      );

      fetchItems();
      nameController.clear();
      contactController.clear();
      descriptionController.clear();
      locationController.clear();
      context.showLoader(show: false);
      return true;
    } catch (e) {
      print("kdsfgkjh  ${e}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to add lost item. Please try again."),
          backgroundColor: Colors.red,
        ),
      );

      return false;
    }
  }

  List<LostItem> _items = [];

  List<LostItem> get items => _items;

  bool isLoading = false;

  bool get isLoaded => isLoading;

  setLoading(value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> fetchItems() async {
    setLoading(true);
    _items = await DatabaseHelper.instance.fetchItems();
    setLoading(false);
    notifyListeners();
  }

  Future<void> addItem(LostItem item) async {
    await DatabaseHelper.instance.insertItem(item);
    await fetchItems();
  }

  Future<void> deleteItem(int id) async {
    await DatabaseHelper.instance.deleteItem(id);
    await fetchItems();
  }
}
