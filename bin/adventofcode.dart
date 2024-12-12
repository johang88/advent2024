import 'dart:io';
import 'package:adventofcode/day1.dart' show day1;
import 'package:adventofcode/day2.dart' show day2;
import 'package:adventofcode/day3.dart' show day3;
import 'package:adventofcode/day4.dart' show day4;
import 'package:adventofcode/day5.dart' show day5;
import 'package:adventofcode/day6.dart' show day6;
import 'package:adventofcode/day7.dart' show day7;
import 'package:adventofcode/day8.dart' show day8;
import 'package:adventofcode/day9.dart' show day9;
import 'package:adventofcode/day10.dart' show day10;
import 'package:adventofcode/day11.dart' show day11;
import 'package:adventofcode/day12.dart' show day12;

void main(List<String> arguments) {
  const defaultDay = 'day12';
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
    'day6': day6,
    'day7': day7,
    'day8': day8,
    'day9': day9,
    'day10': day10,
    'day11': day11,
    'day12': day12,
  })[day]!(inputLines); 
}
