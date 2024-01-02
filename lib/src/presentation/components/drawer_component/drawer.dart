import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../extensions/plus_build_context.dart';

class DrawerComponent extends StatelessWidget {
  const DrawerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: context.wDrawer.selectedIndex,
      onDestinationSelected: (value) =>
          context.rDrawer.onDestinationSelected(context, value),
      children: [
        const SizedBox(height: 10),
        headline(context, "Tools"),
        listTile(context, icon: "ascii-icon", title: "Ascii arts"),
        listTile(context, icon: "top", title: "Top arts", end: "15    "),
        divider(),
        headline(context, "App"),
        listTile(context, icon: "settings", title: "Settings"),
        listTile(context, icon: "info", title: "About"),
      ],
    );
  }

  Padding divider() => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Divider(),
      );

  Widget headline(BuildContext context, String text) => Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
      );

  NavigationDrawerDestination listTile(BuildContext context,
      {required String icon,
      required String title,
      String? end,
      void Function()? onTap}) {
    return NavigationDrawerDestination(
      icon: SvgPicture.asset("assets/icons/$icon.svg",
          colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.onSecondaryContainer,
              BlendMode.srcATop)),
      label: end == null
          ? Text(title)
          : Expanded(
              child: Row(
                children: [
                  Text(title),
                  const Spacer(),
                  Text(end),
                  const SizedBox(width: 10)
                ],
              ),
            ),
    );
  }
}
