class TaskDeleteGuard {
  const TaskDeleteGuard();

  bool canDelete({
    required bool taskHasPendingSync,
    required bool syncIsApplyingChanges,
  }) {
    return !taskHasPendingSync && !syncIsApplyingChanges;
  }
}
