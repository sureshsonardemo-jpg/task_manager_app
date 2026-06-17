class OfflineSyncRetryPolicy {
  const OfflineSyncRetryPolicy({this.maxAttempts = 4});

  final int maxAttempts;

  Duration delayForAttempt(int attempt) {
    final safeAttempt = attempt.clamp(1, maxAttempts);
    return Duration(seconds: 1 << (safeAttempt - 1));
  }

  bool shouldRetry({required int attempt, required bool isNetworkError}) {
    return isNetworkError && attempt < maxAttempts;
  }
}
