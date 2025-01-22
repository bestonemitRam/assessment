import 'package:assessment/utils/extensions.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  Future<bool> login(BuildContext context) async {
    // Show loader

    print("djkfhgkjdgh");
    context.showLoader(show: true);

    // Wait for 2 seconds
    await Future.delayed(const Duration(seconds: 2));

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Login successfully!"),
        backgroundColor: Colors.green,
      ),
    );

    // Hide loader
    context.showLoader(show: false);

    // Return true
    return true;
  }
}
