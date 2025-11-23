import 'package:fpdart/fpdart.dart' show Either;
import 'package:todo_app/core/errors/failure.dart';
import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/features/tasks/data/models/task.dart';
import 'package:todo_app/features/tasks/data/repositories/task_repository.dart';

class StreamTasksUsecase implements StreamUseCase<List<Task>, String> {
  final TaskRepository _repo;

  StreamTasksUsecase(this._repo);

  @override
  Stream<Either<Failure, List<Task>>> call(String params) {
    return _repo.streamTasks(params);
  }
}
