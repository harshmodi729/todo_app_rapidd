import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/core/di/service_injector.dart';
import 'package:todo_app/features/tasks/data/models/task.dart';
import 'package:todo_app/features/tasks/presentation/viewmodels/task_view_model.dart';
import 'package:todo_app/shared/utils/extensions.dart';
import 'package:todo_app/shared/widgets/add_task_sheet.dart';
import 'package:todo_app/shared/widgets/confirm_dialog.dart';

import 'share_task_dialog.dart';

class TaskTile extends ConsumerWidget {
  final Task task;

  const TaskTile({super.key, required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TaskViewModel viewModel = ref.read(taskViewModelProvider.notifier);

    final tilePadding = ResponsiveValue<double>(
      context,
      defaultValue: 14,
      conditionalValues: [.largerThan(name: TABLET, value: 20)],
    ).value;

    final fontSize = ResponsiveValue<double>(
      context,
      defaultValue: 14,
      conditionalValues: [.largerThan(name: TABLET, value: 16)],
    ).value;

    final SharedPreferences prefs = si<SharedPreferences>();
    final String currentUser = prefs.getString("userEmail") ?? "";
    final bool isOwner = task.ownerEmail == currentUser;
    final int sharedCount = task.sharedWith.length - 1;

    return Material(
      color: context.theme.primaryColor.withAlpha(50),
      borderRadius: .circular(12),
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => AddTaskSheet(task: task),
          );
        },
        child: Container(
          padding: .all(tilePadding),
          decoration: BoxDecoration(
            borderRadius: .circular(12),
            border: .all(color: context.theme.primaryColor),
          ),
          child: Row(
            crossAxisAlignment: .start,
            children: [
              Checkbox(
                value: task.isDone,
                onChanged: (_) => viewModel.toggleDone(task),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      task.title,
                      style: TextStyle(
                        fontSize: fontSize + 2,
                        fontWeight: .bold,
                        decoration: task.isDone ? .lineThrough : null,
                      ),
                    ),
                    4.spaceHeight(),
                    Text(
                      task.description,
                      style: TextStyle(fontSize: fontSize),
                      maxLines: 3,
                      overflow: .ellipsis,
                    ),
                    4.spaceHeight(),
                    if (isOwner)
                      Text(
                        context.localizations.owner,
                        style: TextStyle(
                          fontSize: fontSize - 2,
                          fontWeight: FontWeight.w600,
                          color: context.theme.primaryColor,
                        ),
                      )
                    else if (sharedCount > 0)
                      Text(
                        context.localizations.sharedWithCount(sharedCount),
                        style: TextStyle(
                          fontSize: fontSize - 2,
                          color: Colors.grey.shade600,
                        ),
                      ),
                  ],
                ),
              ),
              if (isOwner)
                Row(
                  mainAxisSize: .min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.share, size: fontSize + 6),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => ShareTaskDialog(taskId: task.id),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: fontSize + 6,
                      ),
                      onPressed: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (_) => ConfirmDialog(
                            title: context.localizations.deleteTask,
                            message: context
                                .localizations
                                .areYouSureYouWantToDeleteThisTask,
                            confirmLabel: context.localizations.delete,
                            cancelLabel: context.localizations.cancel,
                          ),
                        );

                        if (confirm == true) {
                          await ref
                              .read(taskViewModelProvider.notifier)
                              .deleteTask(task.id);
                        }
                      },
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
