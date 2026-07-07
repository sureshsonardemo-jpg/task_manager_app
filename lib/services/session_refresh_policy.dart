class SessionRefreshPolicy {
  const SessionRefreshPolicy({this.refreshBefore = const Duration(minutes: 5)});

  final Duration refreshBefore;

  bool shouldRefresh({
    required DateTime now,
    required DateTime expiresAt,
  }) {
    return !now.isBefore(expiresAt.subtract(refreshBefore));
  }
}
