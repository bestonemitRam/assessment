import 'package:assessment/core/database/logindb.dart';
import 'package:assessment/utils/extensions.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  Future<bool> login(BuildContext context, String email, password) async {
    context.showLoader(show: true);

    final user = {
      'email': email,
      'password': password,
    };

    await LoginDb.instance.insertUser(user);

    await Future.delayed(const Duration(seconds: 2));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Login successfully!"),
        backgroundColor: Colors.green,
      ),
    );

    context.showLoader(show: false);

    return true;
  }
}
