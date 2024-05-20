import 'error_message_model.dart';

class ServerException implements Exception {
  final ErrorMessageModel errorMessageModel;
  const ServerException(this.errorMessageModel);
}
class LocalException implements Exception {
  final String errorMessage;
  const LocalException(this.errorMessage);
}

class NoInternetException implements Exception {
  final String message ='no internet';
  NoInternetException();
}
