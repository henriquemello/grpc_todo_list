abstract class BaseException implements Exception{
  Exception get exception;
  StackTrace? get stackTrace;
  String? get message;
  String? get reason;
}
class RepositoryException extends BaseException{
  @override
  final Exception exception;
  @override
  final String? message;
  @override
  final String? reason ;
  @override
  final StackTrace? stackTrace;

  RepositoryException({required this.exception, this.message, this.reason, this.stackTrace});
}