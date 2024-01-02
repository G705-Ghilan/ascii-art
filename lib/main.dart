import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'src/extensions/plus_build_context.dart';
import 'src/models/pages.dart';
import 'src/presentation/dialogs/ascii_category_dialog.dart';
import 'src/providers/drawer_provider.dart';
import 'src/providers/home_page_provider.dart';
import 'src/providers/settings_provider.dart';
import 'src/providers/top_arts_provider.dart';
import 'src/shared/shared_prefernces.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Preferences.getInstance();
  
  AsciiCategoryDialog.data = const JsonDecoder()
      .convert(await rootBundle.loadString("assets/category.json"));

  await Firebase.initializeApp(
    name: "firebase-app",
    options: DefaultFirebaseOptions.currentPlatform,
  );

    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };


  runApp(MultiProvider(
    providers: [
      HomePageProvider.create(),
      DrawerProvider.create(),
      Settingsprovider.create(),
      TopArtsProvider.create(),
    ],
    child: const AsciiArt(),
  ));
}

class AsciiArt extends StatelessWidget {
  const AsciiArt({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      themeMode: context.wSettings.themeMode,
      initialRoute: Pages.initialRoute,
      routes: Pages.routes,
    );
  }
}
