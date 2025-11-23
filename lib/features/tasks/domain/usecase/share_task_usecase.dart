import 'package:fpdart/fpdart.dart' show Either;
import 'package:todo_app/core/errors/failure.dart';
import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/features/tasks/data/repositories/task_repository.dart';

class ShareTaskUsecase implements UseCase<void, Map<String, String>> {
  final TaskRepository _repo;

  ShareTaskUsecase(this._repo);

  @override
  Future<Either<Failure, void>> call({required Map<String, String> params}) {
    return _repo.shareTask(params['taskId']!, params['email']!);
  }
}
