import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/ui_helper.dart';
import 'platform_button.dart';

class CIconButton extends StatelessWidget {
  const CIconButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.size,
    this.icon,
    this.iconPath,
    this.iconColor,
    this.bgColor,
    this.isDisabled = false,
    this.isLoading = false,
    this.isFilled = false,
    this.borderRadius = 8,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  final String label;
  final String? iconPath;
  final IconData? icon;
  final double? size;
  final Color? iconColor;
  final bool isFilled;
  final Color? bgColor;
  final VoidCallback onPressed;
  final bool isDisabled;
  final bool isLoading;
  final double borderRadius;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return PlatformButton(
      isDisabled: isDisabled,
      backgroundColor: bgColor,
      padding: padding,
      borderRadius: BorderRadius.circular((borderRadius)),
      onPressed: isLoading || isDisabled ? () {} : onPressed,
      child: isLoading
          ? const FittedBox(child: CircularProgressIndicator())
          : icon != null
              ? Icon(
                  icon,
                  size: size,
                  color: iconColor,
                  semanticLabel: label,
                )
              : iconPath == null
                  ? Container()
                  : SvgPicture.asset(
                      iconPath!,
                      width: size == null ? null : (size!),
                      height: size == null ? null : (size!),
                      color: iconColor,
                      semanticsLabel: label,
                    ),
    );
  }
}
