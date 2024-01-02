import 'package:flutter/material.dart';

class OopsDialog extends StatelessWidget {
  const OopsDialog({super.key, required this.details});
  final String details;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text("Oops!")),
      content: const Text(
        "Something went wrong. Please try again later ...",
        textAlign: TextAlign.center,
      ),
      actions: [
        ExpansionTile(
          title: const Text("Details"),
          backgroundColor: Theme.of(context).colorScheme.surface,
          collapsedBackgroundColor: Theme.of(context).colorScheme.surface,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          collapsedShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          expandedAlignment: Alignment.topLeft,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(details),
            ),
          ],
        ),
      ],
    );
  }

  static show(BuildContext context, String details) {
    showDialog(
      context: context,
      builder: (context) {
        return OopsDialog(details: details);
      },
    );
  }
}
