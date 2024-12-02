import 'dart:io';

void day1(List<String> input) {
  var listA = <int>[];
  var listB = <int>[];

  for (final i in input) {
    final split = i.split('   ');
    listA.add(int.parse(split[0]));
    listB.add(int.parse(split[1]));
  }

  listA.sort();
  listB.sort();

  // Calculate distance and count occurances in secondary list.
  var counts = <int, int>{};
  var distance = 0;
  for (var i = 0; i < listA.length; i++) {
    distance += (listA[i] - listB[i]).abs();
    counts.update(listB[i], (i) => i + 1, ifAbsent: () => 1);
  }

  print(distance);

  // Much functional.
  final similarity = listA
    .map((v) => v * (counts[v] ?? 0))
    .fold(0, (a, b) => a + b);

  print(similarity);
}

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

void main(List<String> arguments) {
  const defaultDay = 'day2';
  final useSampleInput = arguments.length > 1 ? arguments[1] == '--sample' : false;
  final day = arguments.isNotEmpty ? arguments[0] : defaultDay;
  final inputFilePath = 'bin/$day${useSampleInput ? '_sample' : ''}.txt';

  final inputFile = File(inputFilePath);
  final inputLines = inputFile.readAsLinesSync();

  switch (day) {
    case 'day1':
      day1(inputLines);
    break;
    case 'day2':
      day2(inputLines);
    break;
  }
}
