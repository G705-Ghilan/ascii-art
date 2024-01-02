
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'auth.dart';
import 'svg_icon.dart';

class UserIcon extends StatelessWidget {
  const UserIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "user-icon",
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
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
          ),
        ),
      ),
    );
  }
}
