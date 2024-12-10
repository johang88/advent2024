import 'dart:io';

void printMap(List<int> map, int h, int w) {
  for (var y = 0;  y < h; y++) {
    for (var x = 0; x < w; x++) {
      stdout.write(map[y * w + x]);
    }
    stdout.write('\n');
  }
  stdout.write('\n');
}

List<List<int>> getTrails(List<int> map, int h, int w, int index) {
  // Check all neighbors
  final currentValue = map[index];
  if (currentValue == 9) {
    return [[index]];
  }

  final trails = List<List<int>>.generate(0, (i) => <int>[]);

  void check(int x, int y) {
    if (x < 0 || x >= w || y < 0 || y >= h) return;

    var checkIndex = y * w + x;
    if (map[checkIndex] == currentValue + 1) {
      for (var trail in getTrails(map, h, w, checkIndex)) {
        trail.insert(0, currentValue);
        trails.add(trail);
      }
    }
  }

  final ox = index % w;
  final oy = index ~/ w;

  check(ox - 1, oy);
  check(ox + 1, oy);
  check(ox, oy - 1);
  check(ox, oy + 1);

  return trails;
}

void day10(List<String> input) {
  final w = input.length;
  final h = input.length;
  final map = List<int>.generate(w * h, (i) => int.parse(input[i ~/ w][i % w]));

  var score = 0;
  var rating = 0;
  for (var i = 0; i < map.length; i++) {
    if (map[i] == 0) {
      var trails = getTrails(map, h, w, i);
      var countedTrails = <int>{};
      for (var trail in trails) {
        var s = trail.fold(0, (a, b) => a + b);
        if (!countedTrails.contains(s)) {
          countedTrails.add(s);
          score++;
        }
        rating++;
      }
    }
  }

  print(score);
  print(rating);
  // printMap(map, h, w);
}