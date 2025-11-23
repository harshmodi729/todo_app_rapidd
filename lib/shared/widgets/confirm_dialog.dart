import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/shared/widgets/app_text_button.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
  final bool showCancel;
  final Color confirmColor;

  const ConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    required this.confirmLabel,
    required this.cancelLabel,
    this.showCancel = true,
    this.confirmColor = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        if (showCancel)
          AppTextButton(
            label: cancelLabel,
            onPressed: () => context.pop(false),
          ),
        AppTextButton(
          label: confirmLabel,
          color: confirmColor,
          onPressed: () => context.pop(true),
        ),
      ],
    );
  }
}
