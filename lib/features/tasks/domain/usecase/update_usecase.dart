import 'package:fpdart/fpdart.dart' show Either;
import 'package:todo_app/core/errors/failure.dart';
import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/features/tasks/data/repositories/task_repository.dart';

class UpdateTaskUsecase implements UseCase<void, Map<String, dynamic>> {
  final TaskRepository _repo;

  UpdateTaskUsecase(this._repo);

  @override
  Future<Either<Failure, void>> call({
    required Map<String, dynamic> params,
  }) async {
    return _repo.updateTask(params['taskId'], params['data']);
  }
}
