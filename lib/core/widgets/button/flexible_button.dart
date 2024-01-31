import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gostar/core/widgets/button/platform_button.dart';

class FlexibleButton extends StatelessWidget {
  const FlexibleButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.width,
    this.bgColor,
    this.borderRadius = 8,
    this.hPadding = 16,
    this.vPadding = 12,
    this.isUpperCase = false,
    this.isDisabled = false,
    this.isLoading = false,
    this.isFilled = true,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final double? width;
  final Color? bgColor;
  final double borderRadius;
  final bool isFilled;
  final bool isDisabled;
  final bool isUpperCase;
  final bool isLoading;
  final double vPadding;
  final double hPadding;

  @override
  Widget build(BuildContext context) {
    return PlatformButton(
      width: width,
      height: isFilled ? (48.h) : null,
      isDisabled: isDisabled,
      onPressed: isLoading || isDisabled ? () {} : onPressed,
      backgroundColor:
          isFilled ? bgColor ?? Theme.of(context).primaryColor : null,
      borderRadius: BorderRadius.circular((borderRadius)),
      padding: EdgeInsets.symmetric(
        horizontal: (hPadding),
        vertical: isFilled ? (8).h : (vPadding).h,
      ),
      child: isLoading
          ? FittedBox(
              child: CircularProgressIndicator(
              color: isFilled ? Theme.of(context).colorScheme.onPrimary : null,
            ))
          : Text(
              isUpperCase ? text.toUpperCase() : text,
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              // ? Theme.of(context).textTheme.button
              // : Theme.of(context).textTheme.button!.copyWith(
              //       color: Theme.of(context).colorScheme.onSurface,
              //     ),
            ),
    );
  }
}
