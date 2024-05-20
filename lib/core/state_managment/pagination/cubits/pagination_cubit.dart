import 'package:QuickDo/core/newtwork/result.dart';
import 'package:QuickDo/core/state_managment/pagination/models/GetListRequest.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'pagination_state.dart';

typedef RepositoryCallBack = Future<Result>? Function(dynamic data);

class PaginationCubit<ListModel> extends Cubit<PaginationState> {
  final RepositoryCallBack getData;

  PaginationCubit(this.getData) : super(PaginationInitial());
  List<ListModel> list = [];
  Map<String, dynamic> params = {};
  int MaxResultCount = 10;
  int SkipCount = 0;

  getList({bool loadMore = false}) async {
    if (!loadMore) {
      SkipCount = 0;
      emit(Loading());
    } else {
      SkipCount += 10;
    }

    var requestData = GetListRequest(
      MaxResultCount: MaxResultCount,
      SkipCount: SkipCount,
    );

    var response = await getData(requestData);

    if (response == null) {
      emit(PaginationInitial());
    } else {
      if (response.hasDataOnly) {
        //print(response.data);
        if (loadMore) {
          list.addAll(response.data as List<ListModel>);
        } else {
          list = response.data as List<ListModel>;
        }

        emit(GetListSuccessfully(
            list: list.toSet().toList(), noMoreData: (response.data.toList() as List<ListModel>).isEmpty && loadMore));
        //print("${list.toSet().toList()}");
      } else if (response.hasErrorOnly) {
        if (response.error?.message != null) {
          emit(Error(response.error!.message!));
        }else{
          emit(Error('Some Thing went wrong'));

        }
      }  else {
        emit(PaginationInitial());
      }
    }
  }
}
