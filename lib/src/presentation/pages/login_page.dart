import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/pages.dart';
import '../../shared/auth.dart';
import '../dialogs/oops_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final double width = 40;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: Center(
            child: SvgPicture.asset(
              "assets/icons/welcome.svg",
              // colorFilter: ColorFilter.mode(Colors.red, BlendMode.values[23]),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Material(
            borderRadius: BorderRadius.circular(100),
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () async {
                switchLoading();
                try {
                  await Auth.signInWithGoogle();
                  // ignore: use_build_context_synchronously
                  Pages.homePage.pushReplacementMe(context);
                } catch (e) {
                  log(e.toString());
                  OopsDialog.show(context, e.toString());
                }
                switchLoading();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: isLoading
                    ? const CircularProgressIndicator()
                    : Row(children: [
                        SvgPicture.asset(
                          "assets/icons/google.svg",
                          width: width,
                          height: width,
                        ),
                        const Spacer(),
                        Text(
                          isLoading ? "Loging in ..." : "Continue with google",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondaryContainer),
                        ),
                        const Spacer(),
                        SizedBox(width: width)
                      ]),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  switchLoading() => setState(() => isLoading = !isLoading);
}
