class TaskListPaginationConfig {
  const TaskListPaginationConfig._();

  static const int pageSize = 20;
  static const double prefetchExtent = 480;

  static bool shouldRequestNextPage({
    required double pixels,
    required double maxScrollExtent,
    required bool requestInFlight,
  }) {
    return !requestInFlight && maxScrollExtent - pixels <= prefetchExtent;
  }
}
