import 'dart:io';

class Point {
  final int x;
  final int y;

  Point(this.x, this.y);
}

class Pair {
  final Point a;
  final Point b;

  Pair(this.a, this.b);
}

// Finds all distinct pairs
List<Pair> getAllPairs(List<Point> points) {
  final pairs = <Pair>[];
  for (var i = 0; i < points.length; i++) {
    for (var j = i + 1; j < points.length; j++) {
      pairs.add(Pair(points[i], points[j]));
    }
  }

  return pairs;
}

void day8(List<String> input) {
  final h = input.length;
  final w = input[0].length;

  var antennasByType = <String, List<Point>>{};
  for (var y = 0; y < h; y++) {
    for (var x = 0; x < w; x++) {
      final c = input[y][x];
      if (c != '.') {
        if (!antennasByType.containsKey(c)) antennasByType[c] = [];
        antennasByType[c]!.add(Point(x, y));
      }
    }
  }

  bool inbounds(int x, int y) => x >= 0 && x < w && y >= 0 && y < h;

  final antinodes = <int>{};
  for (final antennas in antennasByType.entries) {
    final pairs = getAllPairs(antennas.value);
    for (final pair in pairs) {
      var dx = pair.b.x - pair.a.x;
      var dy = pair.b.y - pair.a.y;

      var a1x = pair.a.x;
      var a1y = pair.a.y;
      while (inbounds(a1x, a1y)) {
        antinodes.add(a1y * w + a1x);

        a1x -= dx;
        a1y -= dy;
      }

      var a2x = pair.b.x;
      var a2y = pair.b.y;
      while (inbounds(a2x, a2y)) {
        antinodes.add(a2y * w + a2x);

        a2x += dx;
        a2y += dy;
      }
    }
  }

  /*for (var y = 0; y < h; y++) {
    for (var x = 0; x < w; x++) {
      final i = y * w + x;
      stdout.write(antinodes.contains(i) ? '#' : input[y][x]);
    }
    stdout.write('\n');
  }*/

  print(antinodes.length);
}