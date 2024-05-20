part of 'create_model_cubit.dart';

@immutable
abstract class CreateModelState {}

class CreateModelInitial extends CreateModelState {}

class Loading extends CreateModelState  {}

class CreateModelSuccessfully extends CreateModelState  {
  final dynamic model;
  CreateModelSuccessfully({required this.model});
}

class Error extends CreateModelState {
  final String message;
  final BaseError? error;
  Error({required this.message, this.error});
}