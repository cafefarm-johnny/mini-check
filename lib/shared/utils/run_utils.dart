import 'package:flutter/material.dart';
import 'package:mini_check/shared/utils/snack_bar_utils.dart';

class RunUtils {
  const RunUtils._internal();

  static Future<RunResult<T>> run<T>(
    Future<T> Function() action, {
    required BuildContext context,
    required String failMessage,
  }) async {
    try {
      final value = await action();
      return RunResult.success(value);
    } catch (e, st) {
      debugPrint('run failed. $e\n$st');

      if (context.mounted) {
        SnackBarUtils.show(
          context: context,
          message: failMessage,
        );
      }

      return RunResult.failure();
    }
  }
}

class RunResult<T> {
  RunResult({
    required this.value,
    required this.status,
  });

  final T? value;
  final RunResultStatus status;

  factory RunResult.success(T value) {
    return RunResult(value: value, status: RunResultStatus.success);
  }

  factory RunResult.failure() {
    return RunResult(value: null, status: RunResultStatus.failure);
  }
}

enum RunResultStatus {
  success,
  failure
  ;

  bool get isSuccess => this == RunResultStatus.success;
  bool get isFailure => this == RunResultStatus.failure;
}
