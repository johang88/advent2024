void day2(List<String> input) {
  bool areLevelsSafe(List<int> levels) {
    var increasing = levels[1] > levels[0];
    var isAllSafe = true;
    for (var i = 1; i < levels.length; i++) {
      final diff = levels[i] - levels[i - 1];
      final diffAbs = diff.abs();
      isAllSafe &= (diffAbs >= 1 && diffAbs <= 3) && ((increasing && diff > 0) || (!increasing && diff < 0));
    }

    return isAllSafe;
  }

  var safeReports = 0;
  var safeIfProblemDampenerIsEnabled = 0;
  for (final line in input) {
    final levels = line.split(' ').map(int.parse).toList();

    if (areLevelsSafe(levels)) {
      safeReports++;
    }

    // Validate with the problem dampener enabled!
    for (var i = 0; i < levels.length; i++) {
      var levelsWithOneRemoved = List<int>.from(levels);
      levelsWithOneRemoved.removeAt(i);
      if (areLevelsSafe(levelsWithOneRemoved)) {
        safeIfProblemDampenerIsEnabled++;
        break;
      }
    }
  }

  print(safeReports);
  print(safeIfProblemDampenerIsEnabled);
}