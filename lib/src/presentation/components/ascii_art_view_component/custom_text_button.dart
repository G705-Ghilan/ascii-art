import 'package:flutter/material.dart';

import '../../../shared/svg_icon.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.label,
    required this.icon,
    this.isSelected = false,
    this.onTap,
    this.withSelect = true,
  });

  final String label;
  final String icon;
  final bool isSelected;
  final void Function()? onTap;
  final bool withSelect;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onTap,
      icon: SvgIcon(
        name: withSelect ? "$icon-${isSelected ? 'bold' : 'outline'}" : icon,
        color: isSelected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onSecondaryContainer,
      ),
      label: Text(
        label,
        style: TextStyle(
            color: isSelected
                ? null
                : Theme.of(context).colorScheme.onSecondaryContainer),
      ),
    );
  }
}
