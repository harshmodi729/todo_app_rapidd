import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/core/di/service_injector.dart';
import 'package:todo_app/features/tasks/data/models/task.dart';
import 'package:todo_app/features/tasks/presentation/viewmodels/task_view_model.dart';
import 'package:todo_app/shared/utils/extensions.dart';
import 'package:todo_app/shared/widgets/app_text_button.dart';
import 'package:todo_app/shared/widgets/confirm_dialog.dart';
import 'package:uuid/uuid.dart';

class AddTaskSheet extends ConsumerStatefulWidget {
  final Task? task;

  const AddTaskSheet({super.key, this.task});

  @override
  ConsumerState<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends ConsumerState<AddTaskSheet> {
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController descCtrl = TextEditingController();
  bool isDone = false;
  bool isTitleValid = false;

  @override
  void initState() {
    super.initState();

    titleCtrl = TextEditingController(text: widget.task?.title ?? '');
    descCtrl = TextEditingController(text: widget.task?.description ?? '');
    isDone = widget.task?.isDone ?? false;
    isTitleValid = titleCtrl.text.trim().isNotEmpty;

    if (widget.task != null) {
      FirebaseFirestore.instance
          .collection('tasks')
          .doc(widget.task!.id)
          .snapshots()
          .listen((snapshot) {
            if (!snapshot.exists) {
              if (mounted) context.pop();
            }
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final SharedPreferences prefs = si<SharedPreferences>();
    final String currentUser = prefs.getString("userEmail") ?? "";
    final bool isEdit = widget.task != null;
    final bool isOwner = isEdit && widget.task!.ownerEmail == currentUser;
    final TaskViewModel viewModel = ref.read(taskViewModelProvider.notifier);
    final double bottom = MediaQuery.of(context).viewInsets.bottom;
    final double sheetWidth = ResponsiveValue<double>(
      context,
      defaultValue: .infinity,
      conditionalValues: [.largerThan(name: TABLET, value: 600)],
    ).value;

    final fontSize = ResponsiveValue<double>(
      context,
      defaultValue: 14,
      conditionalValues: [.largerThan(name: TABLET, value: 16)],
    ).value;

    return SizedBox(
      width: sheetWidth,
      child: Column(
        mainAxisSize: .min,
        children: [
          Text(
            isEdit
                ? context.localizations.editTask
                : context.localizations.addTask,
            style: TextStyle(fontSize: 20, fontWeight: .bold),
          ),
          20.spaceHeight(),
          TextField(
            controller: titleCtrl,
            decoration: InputDecoration(
              labelText: context.localizations.taskTitle,
            ),
            onChanged: (_) {
              setState(() {
                isTitleValid = titleCtrl.text.trim().isNotEmpty;
              });
            },
            keyboardType: TextInputType.text,
          ),
          12.spaceHeight(),
          TextField(
            controller: descCtrl,
            decoration: InputDecoration(
              labelText: context.localizations.taskDescription,
            ),
            keyboardType: TextInputType.multiline,
            maxLines: 5,
          ),
          20.spaceHeight(),
          Row(
            mainAxisSize: .min,
            children: [
              if (isOwner && isEdit)
                AppTextButton(
                  label: context.localizations.delete,
                  color: Colors.red,
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
                          .deleteTask(widget.task!.id);

                      if (context.mounted) {
                        context.pop();
                      }
                    }
                  },
                  buttonStyle: ButtonStyle(
                    padding: WidgetStatePropertyAll(
                      .symmetric(horizontal: 20, vertical: 20),
                    ),
                  ),
                ),
              ElevatedButton(
                onPressed: isTitleValid
                    ? () async {
                        if (isEdit) {
                          await viewModel.updateTask(widget.task!.id, {
                            "title": titleCtrl.text.trim(),
                            "description": descCtrl.text.trim(),
                            "isDone": isDone,
                            "updatedAt": DateTime.now(),
                          });
                        } else {
                          final prefs = si<SharedPreferences>();
                          final email = prefs.getString("userEmail") ?? "";

                          final Task task = Task(
                            id: const Uuid().v4(),
                            title: titleCtrl.text.trim(),
                            description: descCtrl.text.trim(),
                            isDone: false,
                            ownerEmail: email,
                            sharedWith: [email],
                            updatedAt: .now(),
                          );
                          await viewModel.addTask(task);
                        }
                        if (mounted) context.pop();
                      }
                    : null,
                child: Text(
                  isEdit
                      ? context.localizations.edit
                      : context.localizations.add,
                  style: TextStyle(fontSize: fontSize),
                ).paddingSymmetric(horizontal: 20, vertical: 6),
              ),
            ],
          ),
        ],
      ),
    ).paddingOnly(bottom: bottom + 20, top: 20, left: 20, right: 20);
  }
}
