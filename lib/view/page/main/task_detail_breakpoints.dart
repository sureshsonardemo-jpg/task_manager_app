class TaskDetailBreakpoints {
  const TaskDetailBreakpoints._();

  static const double compactWidth = 360;

  static bool usesCompactLayout(double availableWidth) {
    return availableWidth <= compactWidth;
  }

  static double horizontalPadding(double availableWidth) {
    return usesCompactLayout(availableWidth) ? 12 : 24;
  }
}
