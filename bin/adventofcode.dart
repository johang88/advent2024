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

void main(List<String> arguments) {
  const defaultDay = 'day1';
  final day = arguments.length > 0 ? arguments[0] : defaultDay;
  final inputFilePath = 'bin/${day}.txt';

  final inputFile = File(inputFilePath);
  final inputLines = inputFile.readAsLinesSync();

  switch (day) {
    case 'day1':
      day1(inputLines);
    break;
  }
}
