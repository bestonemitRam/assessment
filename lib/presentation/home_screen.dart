import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:assessment/core/routes/routes.dart';
import 'package:assessment/logic/provider/lost_found_item_provider.dart';
import 'package:assessment/logic/provider/theme_provider.dart';
import 'package:assessment/utils/AppHelper.dart';
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
    final status = Provider.of<LostAndFoundItem>(context, listen: false);
    status.fetchItems();

    return Scaffold(
      appBar: AppBar(
        //    backgroundColor: Colors.white,

        iconTheme: IconThemeData(
          color: AppHelper.themelight
              ? Colors.white
              : Colors.black, // Set back button color
        ),

        title: Center(
          child: Text(
            "Lost & Found App",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppHelper.themelight ? Colors.white : Colors.black),
          ),
        ),
        actions: [
          Consumer<DarkThemeProvider>(
              builder: (context, darkThemeProvider, child) {
            return IconButton(
              icon: Icon(
                Theme.of(context).brightness == Brightness.dark
                    ? Icons.light_mode
                    : Icons.dark_mode,
                color: AppHelper.themelight ? Colors.white : Colors.black,
              ),
              onPressed: () {
                // Toggle the theme mode
                darkThemeProvider.darkThemessd(true);
              },
            );
          })
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
          if (lostAndFoundItem.isLoaded) {
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
                                        style: context.buttonTestStyle.copyWith(
                                            color: AppHelper.themelight
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                      Text(
                                        item.name!,
                                        style: context.buttonTestStyle.copyWith(
                                            color: AppHelper.themelight
                                                ? Colors.grey
                                                : Colors.black),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Contact Info : ",
                                        style: context.buttonTestStyle.copyWith(
                                            color: AppHelper.themelight
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                      Container(
                                        width: 100,
                                        child: Text(
                                          //  productsC[index]['subTitle'].toString(),

                                          item.contactInfo!,
                                          maxLines: 20,
                                          style: context.buttonTestStyle
                                              .copyWith(
                                                  color: AppHelper.themelight
                                                      ? Colors.grey
                                                      : Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Date : ",
                                        style: context.buttonTestStyle.copyWith(
                                            color: AppHelper.themelight
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                      Text(
                                        item.date!,
                                        style: context.buttonTestStyle.copyWith(
                                            color: AppHelper.themelight
                                                ? Colors.grey
                                                : Colors.black),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Descriptions : ",
                                        style: context.buttonTestStyle.copyWith(
                                            color: AppHelper.themelight
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                      Container(
                                        width: 120,
                                        child: Text(
                                          item.itemDescription!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: context.buttonTestStyle
                                              .copyWith(
                                                  color: AppHelper.themelight
                                                      ? Colors.grey
                                                      : Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Location : ",
                                        style: context.buttonTestStyle.copyWith(
                                            color: AppHelper.themelight
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                      Container(
                                        width: 120,
                                        child: Text(
                                          item.location!,
                                          overflow: TextOverflow.ellipsis,
                                          style: context.buttonTestStyle
                                              .copyWith(
                                                  color: AppHelper.themelight
                                                      ? Colors.grey
                                                      : Colors.black),
                                        ),
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
