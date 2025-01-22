import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:assessment/core/routes/routes.dart';
import 'package:assessment/logic/provider/lost_found_item_provider.dart';
import 'package:assessment/utils/extensions.dart';
import 'package:assessment/widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Lost & Found App",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          actions: [
         IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
              color: Colors.black,
            ),
            onPressed: () {
              // Toggle the theme mode
              final themeNotifier =
                  context.read<ValueNotifier<ThemeMode>>();
              themeNotifier.value = themeNotifier.value == ThemeMode.dark
                  ? ThemeMode.light
                  : ThemeMode.dark;
            },
          ),
        ],
          
          ),
      floatingActionButton: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ButtonElevated(
              padding: EdgeInsets.all(10.0),
              backgroundColor: context.appColor.primarycolor,
              text: "Report Lost/Found Item",
              onPressed: () async {
                context.push(MyRoutes.FORMSCREEN);
              }),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Consumer<LostAndFoundItem>(
        builder: (context, lostAndFoundItem, child) {
          // Fetch items if the list is empty
          if (lostAndFoundItem.items.isEmpty) {
            lostAndFoundItem.fetchItems();
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(), // Show loading while fetching data
                  SizedBox(height: 10),
                  Text("Loading items..."), // Loading message
                ],
              ),
            );
          }

          // Display a message if no items are available
          if (lostAndFoundItem.items.isEmpty) {
            return Center(
              child: Text(
                'Welcome to the App!', // The welcome message
                style: TextStyle(
                  fontSize: 24, // Font size
                  fontWeight: FontWeight.bold, // Font weight
                  color: Colors.blue, // Text color
                ),
              ),
            );
          }

          // Show list of items if data is available
          return ListView.builder(
            itemCount: lostAndFoundItem.items.length,
            itemBuilder: (context, index) {
              final item = lostAndFoundItem.items[index];

              print("dfgjgjj  ${item.images.first}");
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Row(
                          children: [
                            if (item.images.first.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Image.file(File(item.images.first),
                                        width: 100)),
                              ),
                            Gap(5.w),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Name : ",
                                        // productsC[index]['title'].toString(),
                                        style:
                                            context.buttonTestStyle.copyWith(),
                                      ),
                                      Text(
                                        item.name!,
                                        // productsC[index]['title'].toString(),
                                        style:
                                            context.buttonTestStyle.copyWith(),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Contact Info : ",
                                        style: context.buttonTestStyle.copyWith(
                                            color: context.appColor.greyColor),
                                      ),
                                      Text(
                                        //  productsC[index]['subTitle'].toString(),

                                        item.contactInfo!,
                                        style: context.buttonTestStyle.copyWith(
                                            color: context.appColor.greyColor),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Descriptions : ",
                                        // productsC[index]['title'].toString(),
                                        style:
                                            context.buttonTestStyle.copyWith(),
                                      ),
                                      Text(
                                        item.itemDescription!,
                                        // productsC[index]['title'].toString(),
                                        style:
                                            context.buttonTestStyle.copyWith(),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Location : ",
                                        // productsC[index]['title'].toString(),
                                        style:
                                            context.buttonTestStyle.copyWith(),
                                      ),
                                      Text(
                                        item.location!,
                                        // productsC[index]['title'].toString(),
                                        style:
                                            context.buttonTestStyle.copyWith(),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Date : ",
                                        // productsC[index]['title'].toString(),
                                        style:
                                            context.buttonTestStyle.copyWith(),
                                      ),
                                      Text(
                                        item.date!,
                                        // productsC[index]['title'].toString(),
                                        style:
                                            context.buttonTestStyle.copyWith(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        //color: context.appColor.greyColor ,
                        thickness: 0.2,
                      )
                    ],
                  ),
                ),
              );

              // ListTile(
              //   title: Text(item.name),
              //   subtitle: Text(item.itemDescription),
              //   trailing: Text(item.date),
              //   onTap: () {
              //     // You can add item details navigation here if needed
              //   },
              // );
            },
          );
        },
      ),
    );
  }
}
