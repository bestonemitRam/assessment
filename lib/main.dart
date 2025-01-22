import 'package:assessment/core/routes/routes.dart';
import 'package:assessment/logic/provider/auth_provider.dart';
import 'package:assessment/logic/provider/lost_found_item_provider.dart';
import 'package:assessment/presentation/confirmation_screen.dart';
import 'package:assessment/presentation/form_screen.dart';
import 'package:assessment/presentation/home_screen.dart';
import 'package:assessment/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

void main() => runApp(LostAndFoundApp());

class LostAndFoundApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => GlobalLoaderOverlay(
            overlayColor: context.appColor.whiteColor.withOpacity(0.5),
            child: MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => AuthProvider()),
                     ChangeNotifierProvider(create: (_) => LostAndFoundItem()),
             
             
              ],
              child: MaterialApp.router(
                routerConfig: MyRoutes.router,
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  scaffoldBackgroundColor: Colors.white,
                  canvasColor: const Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: 'GoogleSans',
                  primarySwatch: Colors.blue,
                ),
                themeMode: ThemeMode.light,
                title: "Assessment App",
                //   initialRoute: '/',
                // routes: {
                //   '/': (context) => HomeScreen(),
                //   '/form': (context) => FormScreen(),
                //   '/confirmation': (context) => ConfirmationScreen(),
                // },
              ),
            )));
  }
}
