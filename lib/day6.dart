List<int>? getDistinctPositions(List<String> input, int px, int py, int size, Function(int, int)? callback) {
  var positions = List<int>.generate(size * size, (_) => -1); // Keep track of hit positons

  int index(int x, int y) 
    => y * size + x;

  bool inbounds(int p)
    => p >= 0 && p < size;

  bool isPositionValid(int x, int y)
    => input[y][x] != '#' && input[y][x] != 'O';

  // Mark starting positopn
  positions[index(px, py)] = 0;

  // Direction always starts up
  var dx = 0;
  var dy = -1;
  var direction = 0;

  // Move guard until out of bounds
  while (inbounds(px + dx) && inbounds(py + dy)) {
    var nx = px + dx;
    var ny = py + dy;

    if (isPositionValid(nx, ny)) {
      px = nx;
      py = ny;

      if (positions[index(px, py)] == direction) {
        // Loop detected!
        return null;
      }

      if (callback != null) {
        callback(px, py);
      }

      positions[index(px, py)] = direction;
    } else {
      // Turn 90 degrees
      if (dx != 0) {
        dy = dx;
        dx = 0;
      } else {
        dx = -dy;
        dy = 0;
      }
      direction = (direction + 1) % 4;
    }
  }

  return positions;
}

void day6(List<String> input) {
  var size = input.length; // Grid is always square

  // Find starting position
  var px = 0;
  var py = 0;
  for (py = 0; py < size; py++) {
    var found = false;
    for (px = 0; px < size; px++) {
      if (input[py][px] == '^') {
        found = true;
        break;
      }
    }
    if (found) break;
  }

  bool checkIfLoopingWithObstacle(int ox, int oy) {
    String placeObstacle(int y) {
      if (y == oy) {
        return input[y].replaceRange(ox, ox + 1, 'O');
      } else {
        return input[y];
      }
    }

    final obstacleInput = List<String>.generate(size, (y) => placeObstacle(y));
    final positions = getDistinctPositions(obstacleInput, px, py, size, null);
    return positions == null;
  }

  var loops = <int>{};
  final distinctPositions = getDistinctPositions(input, px, py, size, (ox, oy) {
    final i = oy * size + ox;
    if (!loops.contains(i) && checkIfLoopingWithObstacle(ox, oy)) {
      loops.add(i);
    }
  });

  loops.remove(py * size + px); // can't place obstacle at start position
  
  print(distinctPositions!.where((x) => x >= 0).length);
  print(loops.length);
}