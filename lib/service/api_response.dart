class ApiResponse<T> {
  Status status;
  T data;
  Exception e;

  ApiResponse.loading() : status = Status.LOADING;
  ApiResponse.success(this.data) : status = Status.SUCCESS;
  ApiResponse.error(this.e) : status = Status.ERROR;
  
}

enum Status {
  LOADING,
  SUCCESS,
  ERROR,
}
