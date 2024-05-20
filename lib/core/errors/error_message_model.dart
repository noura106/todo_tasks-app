import 'package:equatable/equatable.dart';

class ErrorMessageModel extends Equatable {
  final String statusMessage;
  final bool success;
  final int status;
  const ErrorMessageModel(
      {required this.statusMessage,
        required this.status,
        required this.success});

  factory ErrorMessageModel.fromJson(Map<String, dynamic> json) {
    return ErrorMessageModel(
        statusMessage: json['message'] ?? json['message'],
        status: json['statusCode'],
        success: json['success']);
  }

  factory ErrorMessageModel.notValid([String? message]) {
    return ErrorMessageModel(
      statusMessage: message ?? 'error',
      status: 422,
      success: false,
    );
  }

  @override
  List<Object?> get props => [statusMessage];
}
