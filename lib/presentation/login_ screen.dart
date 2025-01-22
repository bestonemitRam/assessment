import 'package:assessment/core/routes/routes.dart';
import 'package:assessment/logic/provider/auth_provider.dart';
import 'package:assessment/utils/extensions.dart';
import 'package:assessment/widgets/custom_text_field.dart';
import 'package:assessment/widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool isValidEmail(String email) {
    // Regular expression for validating an email address
    final emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    // final pageNotifier = Provider.of<LoginProvider>(context, listen: false);
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(100),
              Image.asset(
                'assets/images/MMEPL_Logo.jpg',
                height: 100,
                width: 200,
              ),
              Gap(50.h),
              Text(
                'Welcome back,',
                style: TextStyle(),
              ),
              Gap(20.h),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: email,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please enter your E-mail ID";
                        } else if (!isValidEmail(val)) {
                          return "Please enter a valid E-mail ID";
                        }
                        return null; // Return null if the validation passes
                      },
                      maxLength: 64,
                      counterWidget: const Offstage(),
                      hintText: 'Enter E-mail ID',
                      fillColor: context.appColor.greyColor100,
                    ),
                    Gap(10.h),
                    CustomTextField(
                      controller: password,
                      obscureText: !_isPasswordVisible,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please enter a password";
                        } else if (val.length < 6) {
                          return "Password must be at least 6 characters long";
                        }
                        return null;
                      },
                      maxLength: 64,
                      counterWidget: const Offstage(),
                      hintText: "Enter password",
                      fillColor: context.appColor.greyColor100,
                      suffix: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(5),
              Gap(50.h),
              SizedBox(
                width: double.infinity,
                child: ButtonElevated(
                    backgroundColor: context.appColor.primarycolor,
                    text: "Continue",
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        final status = await Provider.of<AuthProvider>(context,
                                listen: false)
                            .login(
                          context,
                        );
                        if (status) {
                          context.push(MyRoutes.DASHBOARD);
                        }
                      }
                    }),
              ),
              Gap(25.h),
              Gap(10.h),
              Gap(30.h),
            ],
          ),
        ),
      ),
    );
  }
}
