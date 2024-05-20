import 'package:equatable/equatable.dart';

abstract class BaseModel extends Equatable {
  int? id;
  BaseModel({this.id});
  @override
  // TODO: implement props
  List<Object?> get props => [id];
}