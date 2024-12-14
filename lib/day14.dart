import 'point.dart';
import 'dart:io';

class Robot {
  Point p;
  Point v;

  Robot(this.p, this.v);

  @override
  String toString() => "p$p v$v";
}

class State {
  List<Point> robots;
  int safetyScore;
  int iterations;

  State(this.robots, this.safetyScore, this.iterations);
}

void day14(List<String> input) {
  final w = input.length > 12 ? 101 : 11;
  final h = input.length > 12 ? 103 : 7;

  final regex = RegExp(r"p\=([0-9]+),([0-9]+) v\=([0-9\-]+),([0-9\-]+)");

  final robots = <Robot>[]; 
  for (var line in input) {
    final matches = regex.allMatches(line);
    final px = matches.elementAt(0)[1]!;
    final py = matches.elementAt(0)[2]!;
    final dx = matches.elementAt(0)[3]!;
    final dy = matches.elementAt(0)[4]!;
    robots.add(Robot(Point(int.parse(px), int.parse(py)), Point(int.parse(dx), int.parse(dy))));
  }

  final qw = (w - 1) ~/ 2;
  final qh = (h - 1) ~/ 2;

  final quadrants = [
    [0, 0, qw, qh],
    [qw + 1, 0, w, qh],
    [0, qh + 1, qw, h],
    [qw + 1, qh + 1, w, h],
    ];

  final states = <State>[];

  // Calculate all possible iterations
  final iterations = w * h;
  for (var i = 0; i < iterations; i++) {
    for (var robot in robots) {
      robot.p.x = (robot.p.x + robot.v.x) % w;
      robot.p.y = (robot.p.y + robot.v.y) % h;
    }

    var safetyFactory = 1;
    for (var quadrant in quadrants) {
      final robotCount = robots.where((r) => r.p.x >= quadrant[0] && r.p.y >= quadrant[1] && r.p.x < quadrant[2] && r.p.y < quadrant[3]).length;
      safetyFactory *= robotCount;
    }

    states.add(State(robots.map((r) => Point(r.p.x, r.p.y)).toList(), safetyFactory, i + 1));
  }

  // Part 1 is iteration 100 zero indexed
  print(states[99].safetyScore);

  // Sort by safety score, if one quadrant contains the tree then it "should"
  // result in a lower safety score.
  // Try printing until tree shows in console :D 
  // Got it on first try ... 
  states.sort((a, b) => a.safetyScore.compareTo(b.safetyScore));

  void printState(State state) {
    var grid = List<int>.generate(w * h, (i) => 0);
    for (var robot in state.robots) {
      grid[robot.y * w + robot.x]++;
    }

    for (var y = 0; y < h; y++) {
      stdout.write('\n');
      for (var x = 0; x < w; x++) {
        stdout.write(grid[y * w + x]);
      }
    }
  }

  printState(states[0]);
  stdout.write('\n');
  print(states[0].iterations);
}