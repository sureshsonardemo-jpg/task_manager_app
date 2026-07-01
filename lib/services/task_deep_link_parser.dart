class TaskDeepLinkParser {
  const TaskDeepLinkParser();

  String? taskIdFrom(Uri uri) {
    if (uri.host != 'tasks' || uri.pathSegments.length != 1) {
      return null;
    }

    final taskId = uri.pathSegments.single.trim();
    return taskId.isEmpty ? null : taskId;
  }
}
