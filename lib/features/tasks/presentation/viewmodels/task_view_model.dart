import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart' show Either;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/core/di/service_injector.dart';
import 'package:todo_app/core/errors/failure.dart';
import 'package:todo_app/features/tasks/data/models/task.dart';
import 'package:todo_app/features/tasks/domain/usecase/add_task_usecase.dart';
import 'package:todo_app/features/tasks/domain/usecase/delete_task_usecase.dart';
import 'package:todo_app/features/tasks/domain/usecase/share_task_usecase.dart';
import 'package:todo_app/features/tasks/domain/usecase/stream_task_usecase.dart';
import 'package:todo_app/features/tasks/domain/usecase/update_usecase.dart';

class TaskViewModel extends AsyncNotifier<List<Task>> {
  @override
  FutureOr<List<Task>> build() async {
    final email = si<SharedPreferences>().getString("userEmail") ?? "";
    final streamTasks = si<StreamTasksUsecase>();

    _subscribeToStream(streamTasks(email));
    return [];
  }

  void _subscribeToStream(Stream<Either<Failure, List<Task>>> stream) {
    stream.listen((result) {
      result.fold(
        (failure) =>
            state = AsyncError(failure.errorMessage, StackTrace.current),
        (tasks) => state = AsyncData(tasks),
      );
    });
  }

  Future<void> addTask(Task task) async {
    final addUsecase = si<AddTaskUsecase>();
    final result = await addUsecase(params: task);

    result.fold(
      (failure) => state = AsyncError(failure.errorMessage, StackTrace.current),
      (_) => null,
    );
  }

  Future<void> updateTask(String id, Map<String, dynamic> data) async {
    final updateUsecase = si<UpdateTaskUsecase>();
    final result = await updateUsecase(params: {"taskId": id, "data": data});

    result.fold(
      (failure) => state = AsyncError(failure.errorMessage, StackTrace.current),
      (_) => null,
    );
  }

  Future<void> toggleDone(Task task) async {
    await updateTask(task.id, {"isDone": !task.isDone});
  }

  Future<void> shareTask(String id, String email) async {
    final result = await si<ShareTaskUsecase>()(
      params: {"taskId": id, "email": email},
    );

    result.fold(
      (failure) => state = AsyncError(failure.errorMessage, StackTrace.current),
      (_) => null,
    );
  }

  Future<void> deleteTask(String id) async {
    final result = await si<DeleteTaskUsecase>()(params: id);

    result.fold(
      (failure) => state = AsyncError(failure.errorMessage, StackTrace.current),
      (_) => null,
    );
  }
}

final taskViewModelProvider = AsyncNotifierProvider<TaskViewModel, List<Task>>(
  TaskViewModel.new,
);
