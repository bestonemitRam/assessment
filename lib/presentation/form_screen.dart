import 'dart:io';

import 'package:assessment/logic/provider/auth_provider.dart';
import 'package:assessment/logic/provider/lost_found_item_provider.dart';
import 'package:assessment/utils/extensions.dart';
import 'package:assessment/widgets/custom_text_field.dart';
import 'package:assessment/widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<XFile> _images = [];
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _dateController = TextEditingController();

  void _pickImages() async {
    final List<XFile>? pickedImages = await _picker.pickMultiImage();
    if (pickedImages != null) {
      setState(() {
        _images.addAll(pickedImages);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Navigate to Confirmation Screen
      Navigator.pushNamed(context, '/confirmation');
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LostAndFoundItem>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Report Lost/Found Item",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          )),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 50),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextField(
                  controller: provider.nameController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please enter name ";
                    }
                    return null;
                  },
                  maxLength: 64,
                  counterWidget: const Offstage(),
                  hintText: 'Enter Name',
                  fillColor: context.appColor.greyColor100,
                ),
                Gap(10.h),
                CustomTextField(
                  controller: provider.contactController,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Please enter contact info";
                    }

                    final emailRegex = RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

                    final phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');

                    if (!emailRegex.hasMatch(val) &&
                        (!phoneRegex.hasMatch(val) || val.length > 11)) {
                      return "Please enter a valid email or phone number";
                    }

                    return null;
                  },
                  maxLength: 64,
                  counterWidget: const Offstage(),
                  hintText: 'Enter Contact Info',
                  fillColor: context.appColor.greyColor100,
                ),
                Gap(10.h),
                CustomTextField(
                  controller: provider.descriptionController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please enter description ";
                    }
                    return null;
                  },
                  maxLength: 64,
                  counterWidget: const Offstage(),
                  hintText: 'Enter Description',
                  fillColor: context.appColor.greyColor100,
                ),
                Gap(10.h),
                CustomTextField(
                  controller: _dateController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please enter description ";
                    }
                    return null;
                  },
                  maxLength: 64,
                  counterWidget: const Offstage(),
                  hintText: 'Select Date',
                  fillColor: context.appColor.greyColor100,
                  suffix: Icon(Icons.calendar_today),
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) {
                      _dateController.text = date.toString().split(' ')[0];
                    }
                  },
                ),
                Gap(10.h),
                CustomTextField(
                  controller: provider.locationController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please enter location ";
                    }
                    return null;
                  },
                  maxLength: 64,
                  counterWidget: const Offstage(),
                  hintText: 'Enter Location',
                  fillColor: context.appColor.greyColor100,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _pickImages,
                  child: Text("Upload Images"),
                ),
                SizedBox(height: 10),
                _images.isNotEmpty
                    ? Wrap(
                        spacing: 10,
                        children: _images
                            .map((img) => Stack(
                                  children: [
                                    Image.file(File(img.path), width: 100),
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: IconButton(
                                        icon: Icon(Icons.close),
                                        onPressed: () {
                                          setState(() {
                                            _images.remove(img);
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                ))
                            .toList(),
                      )
                    : Text("No images uploaded."),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ButtonElevated(
                      backgroundColor: context.appColor.primarycolor,
                      text: "Continue",
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          List<String> imagePaths =
                              _images.map((image) => image.path).toList();
                          final status = await Provider.of<LostAndFoundItem>(
                                  context,
                                  listen: false)
                              .storedatainDatabase(
                                  context, _dateController.text, imagePaths);
                          if (status) {
                            Navigator.pop(context);
                            //context.push(MyRoutes.DASHBOARD);
                          }
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
