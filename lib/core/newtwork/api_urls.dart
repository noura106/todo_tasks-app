class ApiURLs {

  ///BASE_URL dev
  static const String baseUrl = 'https://dummyjson.com/';

  /// **********auth apis ***********////////////
  static const String login = '${baseUrl}auth/login';
  static const String refreshToken = '${baseUrl}auth/refresh';
  static const String getMe = '${baseUrl}auth/me';
/// **********todos apis ***********////////////
  static getMyTasks(int userId)  => '${baseUrl}todos/user/${userId}';
  static const String getAllTasks = '${baseUrl}todos';
  static  deleteTaskById(int taskId) => '${baseUrl}todos/${taskId}';
  static  updateTask(int taskId) => '${baseUrl}todos/${taskId}';




}