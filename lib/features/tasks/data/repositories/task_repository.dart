import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart' show Either, Left, Right;
import 'package:todo_app/core/errors/failure.dart';
import 'package:todo_app/features/tasks/data/datasource/task_remote_source.dart';
import 'package:todo_app/features/tasks/data/models/task.dart';

class TaskRepository {
  final TaskRemoteSource _remote;

  TaskRepository(this._remote);

  Stream<Either<Failure, List<Task>>> streamTasks(String email) {
    try {
      return _remote.streamTasks(email).map((snapshot) {
        final tasks = snapshot.docs
            .map(
              (doc) => Task.fromJson({
                ...doc.data(),
                'id': doc.id,
                'updatedAt': (doc.data()['updatedAt'] as Timestamp).toDate(),
              }),
            )
            .toList();

        return Right(tasks);
      });
    } catch (e) {
      return Stream.value(Left(ServerFailure(e.toString())));
    }
  }

  Future<Either<Failure, void>> addTask(Task task) async {
    try {
      await _remote.addTask(task.id, {
        ...task.toJson(),
        'updatedAt': Timestamp.fromDate(task.updatedAt),
      });
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> updateTask(
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      await _remote.updateTask(id, data);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> shareTask(String id, String email) async {
    try {
      await _remote.shareTask(id, email);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> deleteTask(String id) async {
    try {
      return Right(await _remote.deleteTask(id));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
