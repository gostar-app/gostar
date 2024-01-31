import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget([
    this.text,
    this.style,
  ]);

  final String? text;

  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text ?? 'Not Found',
        style: style,
      ),
    );
  }
}
