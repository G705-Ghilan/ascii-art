import 'package:flutter/material.dart';

import '../../extensions/plus_build_context.dart';

class AsciiCategoryDialog extends StatelessWidget {
  const AsciiCategoryDialog({super.key});

  static late Map data;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        scrollable: true,
        title: const Text("Category"),
        content: FutureBuilder(
          future: () async {
            await Future.delayed(const Duration(milliseconds: 300));
            final List<Widget> children = [];
            for (String key in data.keys) {
              List<List<String>> tile = [];
              for (var a in data[key]) {
                tile.add([a.first, a.last]);
              }
              children.add(CustomExpansionTile(title: key, list: tile));
            }
            return Column(children: children);
          }(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? snapshot.data as Widget
                : const Text("loading ...");
          },
        ));
  }

  static show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const AsciiCategoryDialog();
      },
    );
  }
}

class CustomExpansionTile extends StatelessWidget {
  const CustomExpansionTile({
    super.key,
    required this.title,
    required this.list,
  });
  final String title;
  final List<List<String>> list;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          borderRadius: BorderRadius.circular(10),
          child: ExpansionTile(
            maintainState: true,
            title: Text(title),
            backgroundColor: Theme.of(context).colorScheme.surface,
            collapsedBackgroundColor: Theme.of(context).colorScheme.surface,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            collapsedShape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            children: [
              for (List<String> tile in list)
                Material(
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    // splashColor: Colors.red,
                    title: Text(tile.first),
                    subtitle: Text(tile.last),
                    onTap: () {
                      context.rHome.setText(tile.last);
                      Navigator.pop(context);
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
