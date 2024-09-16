abstract class Failure {
  final String errorMessage;
  const Failure({required this.errorMessage});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errorMessage});
}

class CacheFailure extends Failure {
  CacheFailure({required super.errorMessage});
}

class ConnectionFailure extends Failure {
  ConnectionFailure({required super.errorMessage});
}

class UnKnownFaliure extends Failure {
  UnKnownFaliure({required super.errorMessage});
}

class InputNoImageFailure extends Failure {
  InputNoImageFailure({required super.errorMessage});
}
