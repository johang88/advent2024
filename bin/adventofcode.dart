import 'dart:io';
import 'package:adventofcode/day1.dart';
import 'package:adventofcode/day2.dart';
import 'package:adventofcode/day3.dart' show day3;

void main(List<String> arguments) {
  const defaultDay = 'day3';
  final useSampleInput = arguments.length > 1 ? arguments[1] == '--sample' : false;
  final day = arguments.isNotEmpty ? arguments[0] : defaultDay;
  final inputFilePath = 'data/$day${useSampleInput ? '_sample' : ''}.txt';

  final inputFile = File(inputFilePath);
  final inputLines = inputFile.readAsLinesSync();

  ({
    'day1': day1,
    'day2': day2,
    'day3': day3,
  })[day]!(inputLines);
}
