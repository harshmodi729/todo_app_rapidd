import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/config/routes/app_routes.dart';
import 'package:todo_app/core/di/service_injector.dart';
import 'package:todo_app/features/tasks/presentation/viewmodels/task_view_model.dart';
import 'package:todo_app/shared/utils/extensions.dart';
import 'package:todo_app/shared/widgets/add_task_sheet.dart';
import 'package:todo_app/shared/widgets/confirm_dialog.dart';
import 'package:todo_app/shared/widgets/task_tile.dart';

class TaskList extends ConsumerWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(taskViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.localizations.yourTasks),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final shouldLogout = await showDialog(
                context: context,
                builder: (_) => ConfirmDialog(
                  title: context.localizations.logout,
                  message: context.localizations.doYouReallyWantToLogout,
                  confirmLabel: context.localizations.logout,
                  cancelLabel: context.localizations.cancel,
                ),
              );

              if (shouldLogout == true) {
                final SharedPreferences prefs = si<SharedPreferences>();
                await prefs.remove("userEmail");

                ref.invalidate(taskViewModelProvider);
                if (context.mounted) {
                  context.goNamed(AppRoutes.emailSetup.name);
                }
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => const AddTaskSheet(),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: state.when(
          data: (tasks) {
            if (tasks.isEmpty) {
              return Center(child: Text(context.localizations.noTasks));
            }

            final maxWidth = ResponsiveValue<double>(
              context,
              defaultValue: .infinity,
              conditionalValues: [
                Condition.largerThan(name: TABLET, value: 600),
              ],
            ).value;

            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: ListView.separated(
                  padding: .all(16),
                  itemCount: tasks.length,
                  separatorBuilder: (_, _) => 12.spaceHeight(),
                  itemBuilder: (_, index) => TaskTile(task: tasks[index]),
                ),
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => Center(child: Text(err.toString())),
        ),
      ),
    );
  }
}
