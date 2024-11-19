class Result<T> {
  final T? data;
  final String? error;
  bool get isSuccess => error == null && data != null;
  Result({this.data, this.error});
}
