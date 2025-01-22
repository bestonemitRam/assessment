import 'package:assessment/core/routes/routes.dart';
import 'package:assessment/utils/extensions.dart';
import 'package:assessment/widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lost & Found App")),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 20.h, right: 20.h, top: 100.h),
          child: Column(
            children: [
              Image.asset(
                'assets/images/MMEPL_Logo.jpg',
                fit: BoxFit.fill,
                width: 250.w,
                height: 100.h,
              ),
              SizedBox(height: 100.h),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonElevated(
                      backgroundColor: context.appColor.primarycolor,
                      text: "Report Lost/Found Item",
                      onPressed: () async {
                        context.push(MyRoutes.FORMSCREEN);
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
