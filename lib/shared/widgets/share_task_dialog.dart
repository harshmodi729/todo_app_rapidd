import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:todo_app/features/tasks/presentation/viewmodels/task_view_model.dart';
import 'package:todo_app/shared/utils/extensions.dart';
import 'package:todo_app/shared/widgets/app_text_button.dart';

class ShareTaskDialog extends ConsumerStatefulWidget {
  final String taskId;

  const ShareTaskDialog({super.key, required this.taskId});

  @override
  ConsumerState<ShareTaskDialog> createState() => _ShareTaskDialogState();
}

class _ShareTaskDialogState extends ConsumerState<ShareTaskDialog> {
  final TextEditingController emailCtrl = TextEditingController();
  bool isEmailValid = false;

  @override
  Widget build(BuildContext context) {
    final TaskViewModel viewModel = ref.read(taskViewModelProvider.notifier);
    final fontSize = ResponsiveValue<double>(
      context,
      defaultValue: 14,
      conditionalValues: [.largerThan(name: TABLET, value: 16)],
    ).value;

    return AlertDialog(
      title: Text(
        context.localizations.shareTask,
        style: TextStyle(fontSize: fontSize + 2),
      ),
      content: TextField(
        controller: emailCtrl,
        decoration: InputDecoration(
          labelText: context.localizations.email,
          errorText: emailCtrl.text.isEmpty || isEmailValid
              ? null
              : context.localizations.enterAValidEmail,
        ),
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) {
          setState(() {
            isEmailValid = value.trim().validateEmail();
          });
        },
      ),
      actions: [
        AppTextButton(
          label: context.localizations.cancel,
          fontSize: fontSize,
          onPressed: () => context.pop(),
        ),
        AppTextButton(
          label: context.localizations.share,
          fontSize: fontSize,
          onPressed: isEmailValid
              ? () async {
                  await viewModel.shareTask(
                    widget.taskId,
                    emailCtrl.text.trim(),
                  );
                  if (context.canPop()) context.pop();
                }
              : null,
        ),
      ],
    );
  }
}
