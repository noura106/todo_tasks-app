import 'package:QuickDo/core/errors/base_error.dart';
import 'package:QuickDo/core/newtwork/result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:meta/meta.dart';
part 'create_model_state.dart';

typedef UsecaseCallBack = Future<Result>? Function(dynamic data);

class CreateModelCubit<Model> extends Cubit<CreateModelState> {
  final UsecaseCallBack? getData;

  CreateModelCubit(this.getData) : super(CreateModelInitial());

  createModel({dynamic requestData}) async {
    emit(Loading());
    try {
      Result? response = await getData!(requestData);
      if (response != null) {
        if (response.hasDataOnly) {
          emit(CreateModelSuccessfully(model: response.data));
          return true;
        } else if (response.hasErrorOnly) {
          emit(Error(message: response.error!.message!, error: response.error));
          return false;
        } else {
          emit(Error(message: 'some thing went wrong'));
          return false;
        }
      } else {
        emit(CreateModelInitial());
        return false;
      }
    } catch (e) {
      emit(Error(message: e.toString()));
      return false;
    }
  }
}
