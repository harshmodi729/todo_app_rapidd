abstract class Failure {
  final String errorMessage;

  const Failure(this.errorMessage);

  List<Object> get props => [errorMessage];

  @override
  String toString() => '$runtimeType{errorMessage: $errorMessage}';
}

class ServerFailure extends Failure {
  const ServerFailure(super.errorMessage);
}