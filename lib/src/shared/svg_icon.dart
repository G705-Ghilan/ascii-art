
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  const SvgIcon({super.key, required this.name, this.color});
  final String name;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/icons/$name.svg",
      colorFilter: ColorFilter.mode(
          color ?? Theme.of(context).colorScheme.onSurfaceVariant,
          BlendMode.srcATop),
    );
  }
}