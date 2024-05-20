import 'package:equatable/equatable.dart';
class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  final int? statusCode;
  const ServerFailure(super.message, {this.statusCode});
}

class LocalFailure extends Failure {
  const LocalFailure(super.message);
}

class NoInternetFailure extends Failure {
  NoInternetFailure() : super('no internet');
}
