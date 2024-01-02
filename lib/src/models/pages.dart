import 'package:flutter/material.dart';

import '../presentation/pages/home_page.dart';
import '../presentation/pages/login_page.dart';
import '../presentation/pages/settings_page.dart';
import '../presentation/pages/top_arts_page.dart';
import '../shared/auth.dart';

class Pages {
  static final PageModel homePage = PageModel(name: "home-page");
  static final PageModel topartsPage = PageModel(name: "top-arts-page");
  static final PageModel settingsPage = PageModel(name: "settings-page");
  static final PageModel loginPage = PageModel(name: "login-page");

  static String get initialRoute {
    return Auth.currentUser == null ? loginPage.name : homePage.name;
  }

  static Map<String, Widget Function(dynamic context)> routes = {
    homePage.name: (context) => const HomePage(),
    topartsPage.name: (context) => const TopArtsPage(),
    settingsPage.name: (context) => const SettingsPage(),
    loginPage.name: (context) => const LoginPage(),
  };
}

class PageModel {
  final String name;
  PageModel({required this.name});

  void pushMe(BuildContext context) {
    Navigator.pushNamed(context, name);
  }

  void pushReplacementMe(BuildContext context) {
    Navigator.pushReplacementNamed(context, name);
  }
}
