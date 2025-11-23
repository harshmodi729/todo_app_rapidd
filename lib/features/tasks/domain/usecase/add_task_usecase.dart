import 'package:fpdart/fpdart.dart' show Either;
import 'package:todo_app/core/errors/failure.dart';
import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/features/tasks/data/models/task.dart';
import 'package:todo_app/features/tasks/data/repositories/task_repository.dart';

class AddTaskUsecase implements UseCase<void, Task> {
  final TaskRepository _repo;

  AddTaskUsecase(this._repo);

  @override
  Future<Either<Failure, void>> call({required Task params}) async {
    return _repo.addTask(params);
  }
}
