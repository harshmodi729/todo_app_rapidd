import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final ButtonStyle? buttonStyle;

  const AppTextButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.buttonStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: buttonStyle,
      child: Text(
        label,
        style: TextStyle(
          fontSize: fontSize ?? 14,
          color: color,
          fontWeight: fontWeight ?? FontWeight.normal,
        ),
      ),
    );
  }
}
