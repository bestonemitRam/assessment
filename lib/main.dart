import 'package:assessment/core/routes/routes.dart';
import 'package:assessment/logic/provider/auth_provider.dart';
import 'package:assessment/logic/provider/lost_found_item_provider.dart';
import 'package:assessment/logic/provider/theme_provider.dart';

import 'package:assessment/utils/AppHelper.dart';
import 'package:assessment/utils/extensions.dart';
import 'package:assessment/utils/theme/dark_theme.dart';
import 'package:assessment/utils/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import 'core/database/database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.initDatabase();
  runApp(LostAndFoundApp());
}

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
                  ChangeNotifierProvider<DarkThemeProvider>(
                      create: (_) => DarkThemeProvider()),
                  ChangeNotifierProvider(create: (_) => AuthProvider()),
                  ChangeNotifierProvider(create: (_) => LostAndFoundItem()),
                ],
                child: Consumer<DarkThemeProvider>(
                    builder: (context, value, child) {
                  AppHelper.themelight = !value.darkTheme;
                  return MaterialApp.router(
                    routerConfig: MyRoutes.router,
                    debugShowCheckedModeBanner: false,
                    theme: value.darkTheme ? lighttheme : darktheme,

                    // theme: ThemeData(
                    //   scaffoldBackgroundColor: Colors.white,
                    //   canvasColor: const Color.fromRGBO(255, 255, 255, 1),
                    //   fontFamily: 'GoogleSans',
                    //   primarySwatch: Colors.blue,
                    // ),
                    themeMode: ThemeMode.light,

                    title: "Assessment App",
                  );
                }))));
  }
}
