import 'package:flutter/material.dart';

import '../../../extensions/plus_build_context.dart';
import '../../../shared/user_icon.dart';

class SearchBarComponent extends StatelessWidget {
  const SearchBarComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return ConstrainedBox(
      constraints: const BoxConstraints(
          minWidth: 360.0, maxWidth: 800.0, minHeight: 56.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: context.rHome.openDrawer,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  controller: context.rHome.searchBarController,
                  focusNode: context.rHome.focusNode,
                  onChanged: (value) {
                    context.rHome.onChange();
                  },
                  onSubmitted: (value) async {
                    await context.rHome.search(context, true);
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search for ascii ...",
                    hintStyle: hintStyle(context, colorScheme),
                  ),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: colorScheme.onSurface),
                ),
              ),
            ),
            IconButton(
              onPressed: () async => await context.rHome.search(context, true),
              icon: const Icon(Icons.search),
            ),
            const UserIcon(),
          ],
        ),
      ),
    );
  }

  TextStyle? hintStyle(BuildContext context, ColorScheme colorScheme) =>
      Theme.of(context)
          .textTheme
          .bodyLarge
          ?.copyWith(color: colorScheme.onSurfaceVariant);
}
