import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/config/routes/app_routes.dart';
import 'package:todo_app/core/di/service_injector.dart';
import 'package:todo_app/features/tasks/presentation/viewmodels/task_view_model.dart';
import 'package:todo_app/shared/utils/extensions.dart';

class EmailSetup extends ConsumerStatefulWidget {
  const EmailSetup({super.key});

  @override
  ConsumerState<EmailSetup> createState() => _EmailSetupState();
}

class _EmailSetupState extends ConsumerState<EmailSetup> {
  final TextEditingController controller = TextEditingController();
  bool isValid = false;

  @override
  Widget build(BuildContext context) {
    final fontSize = ResponsiveValue<double>(
      context,
      defaultValue: 14,
      conditionalValues: [.largerThan(name: TABLET, value: 16)],
    ).value;

    return Scaffold(
      appBar: AppBar(title: Text(context.localizations.setupEmail)),
      body: Column(
        children: [
          Text(
            context.localizations.enterEmailToContinue,
            style: TextStyle(fontSize: 18),
          ),
          20.spaceHeight(),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: context.localizations.email,
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                isValid = value.trim().validateEmail();
              });
            },
          ),
          20.spaceHeight(),
          ElevatedButton(
            onPressed: isValid
                ? () {
                    final prefs = si<SharedPreferences>();
                    prefs.setString("userEmail", controller.text.trim());
                    ref.invalidate(taskViewModelProvider);
                    context.goNamed(AppRoutes.taskList.name);
                  }
                : null,
            child: Text(
              context.localizations.submit,
              style: TextStyle(fontSize: fontSize),
            ).paddingSymmetric(horizontal: 20, vertical: 6),
          ),
        ],
      ).paddingAll(16.0),
    );
  }
}
