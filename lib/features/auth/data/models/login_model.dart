


import 'package:QuickDo/core/core_model/base_model.dart';
import 'package:QuickDo/core/newtwork/api_response.dart';

class LoginResponseModel extends ApiResponse<LoginModel> {
  LoginResponseModel(
      {required LoginModel data})
      : super( data: data,);

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      data: LoginModel.fromJson(json),
    );
  }
}
class LoginModel extends BaseModel {
  final int? id;
  final String? userName;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? image;
  final String? token;

  LoginModel(
      {this.gender,
      this.userName,
      this.id,
      this.image,
      this.email,
      this.firstName,
      this.lastName,
      this.token});
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
        id: json['id'] as int?,
        image: json['image'] != null ? json['image'] as String : null,
        userName: json['username'] as String?,
        email: json['email'] as String?,
        firstName: json['firstName'] as String?,
        lastName: json['lastName'] as String?,
        gender: json['gender'] as String?,
        token: json['token'] as String?,);
  }
  toJson(){
    return{
      'id':id,
      'image':image,
      'username':userName,
      'email':email,
      'firstName':firstName,
      'lastName':lastName,
      'gender':gender,
      'token':token
    };
  }
}
