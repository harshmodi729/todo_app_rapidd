import 'package:fpdart/fpdart.dart' show Either;
import 'package:todo_app/core/errors/failure.dart';
import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/features/tasks/data/repositories/task_repository.dart';

class DeleteTaskUsecase implements UseCase<void, String> {
  final TaskRepository _repo;

  DeleteTaskUsecase(this._repo);

  @override
  Future<Either<Failure, void>> call({required String params}) async {
    return _repo.deleteTask(params);
  }
}
