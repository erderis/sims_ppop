class DataState<T> {
  final bool isLoading;
  final bool isSuccess;
  final bool isError;
  final T? data;
  final String? error;

  DataState({
    this.isLoading = false,
    this.isSuccess = false,
    this.isError = false,
    this.data,
    this.error,
  });
}
