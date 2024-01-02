import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/pages.dart';

class DrawerProvider with ChangeNotifier {
  int selectedIndex = 0;

  void onDestinationSelected(BuildContext context, int index) {
    [
      () {
        if (selectedIndex != 0) {
          selectedIndex = index;
          Pages.homePage.pushReplacementMe(context);
          selectedIndex = 0;
        } else {
          Navigator.pop(context);
        }
      },
      () {
        // soon
        Pages.topartsPage.pushReplacementMe(context);
        selectedIndex = 1;
      },
      () {
        Navigator.pop(context);
        Pages.settingsPage.pushMe(context);
      },
      () {
        showAboutDialog(
          context: context,
          applicationName: "Ascii art",
          applicationIcon: Image.asset(
            "assets/icons/app_icon.png",
            width: 50,
            height: 50,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: child,
              );
            },
          ),
          applicationLegalese:
              "Discover the beauty of text-based art with our simple and intuitive ASCII Art application. ",
          applicationVersion: "1.0.0",
        );
      }
    ][index]();
  }

  static ChangeNotifierProvider<DrawerProvider> create() {
    return ChangeNotifierProvider(create: (context) => DrawerProvider());
  }
}
