// failures.dart
abstract class Failure {
  final String message;
  const Failure(this.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

// exceptions.dart
class CacheException implements Exception {
  final String message;
  const CacheException(this.message);
}

class ServerException implements Exception {
  final String message;
  const ServerException(this.message);
}