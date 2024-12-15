import 'point.dart';
import 'dart:io';

void day15(List<String> input) {
  final map = <String>[];
  var robot = Point(0, 0);

  final moves = input[input.length - 1].split('');

  var h = input.length - 2;
  var w = input[h - 1].length;

  for (var y = 0; y < h; y++) {
    for (var x = 0; x < w; x++) {
      final tile = input[y][x];

      map.add(tile);
      if (tile == '@') {
        robot = Point(x * 2, y);
        map.add('.');
      } else {
        map.add(tile);
      }
    }
  }

  w *= 2;

  for (final move in moves) {
    if (move == '<') {
      var x = robot.x - 1;
      var empty = false;
      for (; x > 0; x--) {
        if (map[robot.y * w + x] == '#') break;
        if (map[robot.y * w + x] == '.') {
          empty = true;
          break;
        }
      }

      if (empty) {
        for (; x < robot.x; x++) {
          map[robot.y * w + x] = map[robot.y * w + (x + 1)];
          map[robot.y * w + (x + 1)] = '.';
          if (map[robot.y * w + x] == '@') {
            robot.x = x;
          }
        }
      }
    } else if (move == '>') {
      var x = robot.x + 1;
      var empty = false;
      for (; x < w; x++) {
        if (map[robot.y * w + x] == '#') break;
        if (map[robot.y * w + x] == '.') {
          empty = true;
          break;
        }
      }

      if (empty) {
        for (; x > robot.x; x--) {
          map[robot.y * w + x] = map[robot.y * w + (x - 1)];
          map[robot.y * w + (x - 1)] = '.';
          if (map[robot.y * w + x] == '@') {
            robot.x = x;
          }
        }
      }
    } if (move == '^') {
      var y = robot.y - 1;
      var empty = false;
      for (; y > 0; y--) {
        if (map[y * w + robot.x] == '#') break;
        if (map[y * w + robot.x] == '.') {
          empty = true;
          break;
        }
      }

      if (empty) {
        for (; y < robot.y; y++) {
          map[y * w + robot.x] = map[(y + 1) * w + robot.x];
          map[(y + 1) * w + robot.x] = '.';
          if (map[y * w + robot.x] == '@') {
            robot.y = y;
          }
        }
      }
    } else if (move == 'v') {
      var y = robot.y + 1;
      var empty = false;
      for (; y < h; y++) {
        if (map[y * w + robot.x] == '#') break;
        if (map[y * w + robot.x] == '.') {
          empty = true;
          break;
        }
      }

      if (empty) {
        for (; y > robot.y; y--) {
          map[y * w + robot.x] = map[(y - 1) * w + robot.x];
          map[(y - 1) * w + robot.x] = '.';
          if (map[y * w + robot.x] == '@') {
            robot.y = y;
          }
        }
      }
    }
  }

  stdout.write('\n');
  for (var y = 0; y < h; y++) {
    for (var x = 0; x < w; x++) {
      if (robot.x == x && robot.y == y) {
        stdout.write('@');
      } else {
        stdout.write(map[y * w + x]);
      }
    }
    stdout.write('\n');
  }

  var gps = 0;
  for (var y = 0; y < h; y++) {
    for (var x = 0; x < w; x++) {
      if (map[y * w + x] == 'O') {
        gps += 100 * y + x;
      }
    }
  }
  print(gps);
}