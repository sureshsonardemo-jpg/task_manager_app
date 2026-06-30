class AttachmentRetryPolicy {
  const AttachmentRetryPolicy({this.maximumAttempts = 3});

  final int maximumAttempts;

  bool canRetry({required int attempts, required int statusCode}) {
    final transientFailure = statusCode == 408 || statusCode >= 500;
    return transientFailure && attempts < maximumAttempts;
  }
}
