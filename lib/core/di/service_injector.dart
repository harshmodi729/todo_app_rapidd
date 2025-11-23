import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/features/tasks/data/datasource/task_remote_source.dart';
import 'package:todo_app/features/tasks/data/repositories/task_repository.dart';
import 'package:todo_app/features/tasks/domain/usecase/add_task_usecase.dart';
import 'package:todo_app/features/tasks/domain/usecase/delete_task_usecase.dart';
import 'package:todo_app/features/tasks/domain/usecase/share_task_usecase.dart';
import 'package:todo_app/features/tasks/domain/usecase/stream_task_usecase.dart';
import 'package:todo_app/features/tasks/domain/usecase/update_usecase.dart';

final si = GetIt.instance;

Future<void> initDependencies() async {
  // SharedPrefs
  final prefs = await SharedPreferences.getInstance();
  si.registerSingleton<SharedPreferences>(prefs);

  // Firestore
  si.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  // Remote Source
  si.registerLazySingleton<TaskRemoteSource>(() => TaskRemoteSource(si()));

  // Repository
  si.registerLazySingleton<TaskRepository>(() => TaskRepository(si()));

  // UseCases
  si.registerLazySingleton<AddTaskUsecase>(() => AddTaskUsecase(si()));
  si.registerLazySingleton<UpdateTaskUsecase>(() => UpdateTaskUsecase(si()));
  si.registerLazySingleton<ShareTaskUsecase>(() => ShareTaskUsecase(si()));
  si.registerLazySingleton<StreamTasksUsecase>(() => StreamTasksUsecase(si()));
  si.registerLazySingleton<DeleteTaskUsecase>(() => DeleteTaskUsecase(si()));
}
