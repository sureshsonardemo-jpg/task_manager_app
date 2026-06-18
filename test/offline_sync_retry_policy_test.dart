import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager_app/services/offline_sync_retry_policy.dart';

void main() {
  test('offline retries use capped exponential backoff', () {
    const policy = OfflineSyncRetryPolicy(maxAttempts: 4);

    expect(policy.delayForAttempt(1), const Duration(seconds: 1));
    expect(policy.delayForAttempt(4), const Duration(seconds: 8));
    expect(policy.delayForAttempt(8), const Duration(seconds: 8));
  });
}
