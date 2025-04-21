class ApiResponse<T> {
  final int? statusCode;
  final String status;
  final String message;
  final T? data;

  ApiResponse({
    required this.statusCode,
    required this.status,
    required this.message,
    this.data,
  });
}
