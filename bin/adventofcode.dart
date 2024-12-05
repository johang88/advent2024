import 'dart:io';
import 'package:adventofcode/day1.dart' show day1;
import 'package:adventofcode/day2.dart' show day2;
import 'package:adventofcode/day3.dart' show day3;
import 'package:adventofcode/day4.dart' show day4;
import 'package:adventofcode/day5.dart' show day5;

void main(List<String> arguments) {
  const defaultDay = 'day5';
  final useSampleInput = arguments.length > 1 ? arguments[1] == '--sample' : false;
  final day = arguments.isNotEmpty ? arguments[0] : defaultDay;
  final inputFilePath = 'data/$day${useSampleInput ? '_sample' : ''}.txt';

  final inputFile = File(inputFilePath);
  final inputLines = inputFile.readAsLinesSync();

  ({
    'day1': day1,
    'day2': day2,
    'day3': day3,
    'day4': day4,
    'day5': day5,
  })[day]!(inputLines);
}
