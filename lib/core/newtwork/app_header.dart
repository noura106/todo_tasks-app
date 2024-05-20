
import 'package:QuickDo/core/storage/storage_handler.dart';

class AppHeaders {
  static const Map<String, dynamic> headerWithoutToken = {
    'Content-Type': 'application/json',
  };

  static Map<String, dynamic> get header {
    final header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (StorageHandler().hasToken) {
      header.addAll({
        'Authorization': 'Bearer ${StorageHandler().token}',
      });
    }

    return header;
  }

  static Map<String, dynamic> get headerWithFile {
    final header = {
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
    };

    if (StorageHandler().hasToken) {
      header.addAll({
        'Authorization': 'Bearer ${StorageHandler().token}',
      });
    }

    return header;
  }

  static Map<String, dynamic> get headerOnlyAuth => {
    'Authorization': StorageHandler().token,
  };
  static Map<String, dynamic> get headerWithRefreshToken {
    return {
      'Authorization': 'Bearer ${StorageHandler().token}',
    };
  }
}
