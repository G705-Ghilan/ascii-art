import 'package:flutter/material.dart';

import '../../models/pages.dart';
import '../../shared/auth.dart';

class SignoutDialog extends StatelessWidget {
  const SignoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text(
        "are you sure you want to sign out ?",
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
        TextButton(
            onPressed: () {
              Auth.signout().then((value) {
                Navigator.of(context).popUntil((route) => route.isFirst);
                Pages.loginPage.pushReplacementMe(context);
              });
            },
            child: const Text("Sign out"))
      ],
    );
  }

  static show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const SignoutDialog();
      },
    );
  }
}
