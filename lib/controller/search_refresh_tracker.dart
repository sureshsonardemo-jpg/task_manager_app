class SearchRefreshTracker {
  int _revision = 0;

  int get revision => _revision;

  void taskChanged(String taskId) {
    if (taskId.trim().isNotEmpty) {
      _revision += 1;
    }
  }
}
