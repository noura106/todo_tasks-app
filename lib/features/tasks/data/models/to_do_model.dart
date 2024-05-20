import 'package:QuickDo/core/core_model/base_model.dart';
import 'package:QuickDo/core/newtwork/api_response.dart';
class DeleteToDoResponse extends ApiResponse<ToDoModel> {
  DeleteToDoResponse(
      {
        required ToDoModel data})
      : super(data: data);

  factory DeleteToDoResponse.fromJson(Map<String, dynamic> json) {
    return DeleteToDoResponse(
        data: ToDoModel.fromJson(json));
  }
}
class ToDoResponse extends ApiResponse<ToDoListModel> {
  ToDoResponse(
      {
        required ToDoListModel data})
      : super(data: data);

  factory ToDoResponse.fromJson(Map<String, dynamic> json) {
    return ToDoResponse(
        data: ToDoListModel.fromJson(json));
  }
}
class ToDoListModel extends BaseModel {
  List<ToDoModel>? items;

  ToDoListModel({ this.items});

  ToDoListModel.fromJson(Map<String, dynamic> json) {
    if (json['todos'] != null) {
      items = <ToDoModel>[];
      json['todos'].forEach((v) {
        items!.add(ToDoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['todos'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class ToDoModel extends BaseModel {
  final int? id;
  final String? name;
   bool? isCompleted;
  final int? userId;
   bool? isDeleted;

  ToDoModel({this.id, this.name, this.userId, this.isCompleted,this.isDeleted});
  factory ToDoModel.fromJson(Map<String, dynamic> json) {
    return ToDoModel(
      id: json['id'] as int?,
      name: json['todo'] != null ? json['todo'] as String : null,
      isCompleted: json['completed'] as bool?,
      isDeleted: json['isDeleted'] as bool?,
      userId: json['userId'] as int?,);
  }
  toJson(){
    return{
      'id':id,
      'todo':name,
      'completed':isCompleted,
      'userId':userId,
      'isDeleted':isDeleted
    };
  }
}
