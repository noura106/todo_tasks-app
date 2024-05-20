abstract class ApiResponse<T> {
  ApiResponse({
    required this.data,
  });
  final T data;
}
