import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../extensions/plus_build_context.dart';
import '../../shared/auth.dart';
import '../../shared/svg_icon.dart';
import '../dialogs/signout_dialog.dart';
import '../dialogs/theme_switcher_dialog.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.surfaceVariant,
            ),
            child: Column(children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant
                                .withOpacity(0.4))),
                    child: Hero(
                      tag: "user-icon",
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          imageUrl: Auth.currentUser!.photoURL!,
                          errorWidget: (context, url, error) {
                            return const Center(
                              child: SvgIcon(name: "info"),
                            );
                          },
                          filterQuality: FilterQuality.high,
                          width: 80,
                          height: 80,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Auth.currentUser?.displayName ?? "no name",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant),
                      ),
                      Text(
                        Auth.currentUser?.email ?? "no email",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant
                                    .withOpacity(0.8)),
                      ),
                    ],
                  ),
                ],
              ),
            ]),
          ),
          const SizedBox(height: 10),
          SettingsListTile(
            title: "log out",
            iconName: "logout",
            onTap: () => SignoutDialog.show(context),
          ),
          const SizedBox(height: 15),
          Text(
            "App",
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 5),
          SettingsListTile(
            title: "App theme",
            iconName: ThemeSwitcherDialog.options
                .firstWhere(
                    (element) => context.rSettings.isMyTheme(element.last))
                .first
                .toString()
                .toLowerCase(),
            onTap: () => ThemeSwitcherDialog.show(context),
            end: context.wSettings.themeMode.name,
          ),
        ]),
      ),
    );
  }
}

class SettingsListTile extends StatelessWidget {
  const SettingsListTile({
    super.key,
    required this.title,
    this.subTitle,
    this.onTap,
    required this.iconName,
    this.end,
  });
  final String title;
  final String? subTitle;
  final void Function()? onTap;
  final String iconName;
  final String? end;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgIcon(name: iconName),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      tileColor: Theme.of(context).colorScheme.surfaceVariant,
      title: Text(title),
      subtitle: subTitle != null ? Text(subTitle!) : null,
      onTap: onTap,
      trailing: Text(end ?? ''),
      // splashColor: Colors.red,
    );
  }
}
