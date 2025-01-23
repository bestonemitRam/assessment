import 'dart:io';

import 'package:assessment/logic/provider/auth_provider.dart';
import 'package:assessment/logic/provider/lost_found_item_provider.dart';
import 'package:assessment/main.dart';
import 'package:assessment/utils/AppHelper.dart';
import 'package:assessment/utils/extensions.dart';
import 'package:assessment/widgets/custom_text_field.dart';
import 'package:assessment/widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  Future<void> pickShopImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _images.add(pickedFile);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LostAndFoundItem>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(
            color: AppHelper.themelight ? Colors.white : Colors.black,
          ),
          title: Text(
            "Report Lost/Found Item",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppHelper.themelight ? Colors.white : Colors.black),
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
                // CustomTextField(
                //   controller: _dateController,
                //   validator: (val) {
                //     if (val!.isEmpty) {
                //       return "Please enter description ";
                //     }
                //     return null;
                //   },
                //   maxLength: 64,
                //   counterWidget: const Offstage(),
                //   hintText: 'Select Date',
                //   fillColor: context.appColor.greyColor100,
                //   suffix: Icon(
                //     Icons.calendar_today,
                //   ),
                //   onTap: () async {
                //     FocusScope.of(context).requestFocus(FocusNode());
                //     DateTime? date = await showDatePicker(
                //       context: context,
                //       initialDate: DateTime.now(),
                //       firstDate: DateTime(2000),
                //       lastDate: DateTime(2100),
                //     );
                //     if (date != null) {
                //       _dateController.text = date.toString().split(' ')[0];
                //     }
                //   },
                // ),

                CustomTextField(
                  controller: _dateController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please enter a date";
                    }
                    // Add validation for valid date format if needed
                    return null;
                  },
                  maxLength: 64,
                  counterWidget: const Offstage(),
                  hintText: 'Select Date',
                  fillColor: context.appColor.greyColor100,
                  suffix: Icon(Icons.calendar_today,
                      color:
                          AppHelper.themelight ? Colors.white : Colors.black),
                  onTap: () async {
                    // No need to unfocus before showing the date picker in most cases
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
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          AppHelper.themelight ? Colors.white : Colors.black)),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: Container(
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        color: AppHelper.themelight
                                            ? Colors.white
                                            : Colors.black,
                                        child: InkWell(
                                          onTap: () {
                                            _pickImages();
                                            Navigator.pop(context);
                                          },
                                          child: Icon(
                                            Icons.file_present_sharp,
                                            size: 50,
                                            color: AppHelper.themelight
                                                ? Colors.black
                                                : Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 50,
                                      ),
                                      Container(
                                        child: InkWell(
                                          onTap: () {
                                            pickShopImage();
                                            Navigator.pop(context);
                                          },
                                          child: Icon(
                                            Icons.camera,
                                            size: 70,
                                            color: AppHelper.themelight
                                                ? Colors.black
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15),
                                          child: Text(
                                            "Close",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        )),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Text(
                    "Upload Images",
                    style: TextStyle(
                        color:
                            AppHelper.themelight ? Colors.black : Colors.white),
                  ),
                ),
                SizedBox(height: 10),
                _images.isNotEmpty
                    ? Wrap(
                        spacing: 10,
                        children: _images
                            .map((img) => Stack(
                                  children: [
                                    Container(
                                        height: 100,
                                        width: 100,
                                        child: Image.file(File(img.path),
                                            width: 100)),
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: IconButton(
                                        icon: Icon(Icons.close,
                                            color: AppHelper.themelight
                                                ? Colors.white
                                                : Colors.black),
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

  // Widget openpoppup() {
  //   return AlertDialog(
  //     title: Text(
  //      "efsfeff",

  //     ),
  //     actions: this.actions,
  //     content: Text(
  //       this.content,
  //       style: Theme.of(context).textTheme.body1,
  //     ),
  //   );
  // }
}
