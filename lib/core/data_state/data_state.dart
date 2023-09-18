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

class ProfileState<T> extends DataState {
  final bool isLoadingImage;
  final bool isLoadingUpdate;
  final bool isErrorImage;
  final bool isErrorUpdate;
  final bool isSuccessUpdate;

  ProfileState(
      {super.isLoading,
      super.isSuccess,
      super.isError,
      super.data,
      super.error,
      this.isLoadingImage = false,
      this.isLoadingUpdate = false,
      this.isErrorImage = false,
      this.isErrorUpdate = false,
      this.isSuccessUpdate = false});
}
