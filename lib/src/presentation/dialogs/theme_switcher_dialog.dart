import 'package:flutter/material.dart';

import '../../extensions/plus_build_context.dart';
import '../../shared/svg_icon.dart';

class ThemeSwitcherDialog extends StatelessWidget {
  const ThemeSwitcherDialog({super.key});

  static const List<List<dynamic>> options = [
    ["Dark", 2],
    ["Light", 1],
    ["System", 0],
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Wrap(
        children: options
            .map((e) => dialogTile(context, title: e.first, index: e.last))
            .toList(),
      ),
    );
  }

  ListTile dialogTile(BuildContext context,
      {required String title, required int index}) {
    return ListTile(
      leading: SvgIcon(
        name: title.toLowerCase(),
      ),
      title: Text(title),
      selected: context.wSettings.isMyTheme(index),
      selectedColor: Theme.of(context).colorScheme.onSecondaryContainer,
      selectedTileColor: Theme.of(context).colorScheme.secondaryContainer,
      onTap: () => context.rSettings.themeIndex = index,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
    );
  }

  static show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const ThemeSwitcherDialog();
      },
    );
  }
}

