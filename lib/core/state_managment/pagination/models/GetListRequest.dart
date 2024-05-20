

import 'package:QuickDo/core/core_model/base_params.dart';

class GetListRequest extends BaseParams {
  int? SkipCount;
  int? MaxResultCount;

  GetListRequest({this.SkipCount, this.MaxResultCount});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (SkipCount != null) data['skip'] = SkipCount;
    if (MaxResultCount != null) data['limit'] = MaxResultCount;

    return data;
  }
}
