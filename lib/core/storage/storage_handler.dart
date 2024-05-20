import 'package:get_storage/get_storage.dart';

class StorageHandler {
  static String storageName = 'task_management';
  static String tokenKey = 'token';
  static String langKey = 'language';
  static String versionNumberKey = 'versionNumberKey';
  static String version = 'version';
  static String generalUserDataKey = 'generalUserDataKey';

  static GetStorage box = GetStorage(storageName);

  static Future<void> init() async {
    await GetStorage.init(storageName);
  }

  Future<void> setToken(String token) async => await box.write(tokenKey, token);

  Future<void> removeToken() async => await box.remove(tokenKey);

  bool get hasToken => box.hasData(tokenKey);

  String get token => hasToken ? box.read(tokenKey) : 'no token';

  ///////////////////////////////////////////////////////////////////////////////

  static getLanguage() {
    return box.read(langKey) ?? "en";
  }

  static writeLanguage(value) {
    box.write(langKey, value);
  }
  static getVersionNumber() {
    return box.read(versionNumberKey);
  }

  static writeVersionNumber(value) {
    box.write(versionNumberKey, value);
  }
  static getVersion() {
    return box.read(version);
  }

  static writeVersion(value) {
    box.write(version, value);
  }
  static Future<void> writeUserData(value) async {
    box.remove(generalUserDataKey);
    box.write(generalUserDataKey,value);
  }
  static getUserData() {
    return box.read(generalUserDataKey);
  }
}
