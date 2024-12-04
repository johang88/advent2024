
bool check(List<String> input, int x, int y, String s) {
  if (x >= 0 && x < input.length && y >= 0 && y < input.length) {
    return input[y][x] == s;
  } else {
    return false;
  }
}

int countMatches(List<String> input, int x, int y) {
  var totalMatches = 0;

  // Count rows
  if (x + 3 < input.length && input[y][x + 1] == 'M' && input[y][x + 2] == 'A' && input[y][x + 3] == 'S') {
    totalMatches++;
  }

  if (x - 3 >= 0 && input[y][x - 1] == 'M' && input[y][x - 2] == 'A' && input[y][x - 3] == 'S') {
    totalMatches++;
  }

  // Count columns
  if (y + 3 < input.length && input[y + 1][x] == 'M' && input[y + 2][x] == 'A' && input[y + 3][x] == 'S') {
    totalMatches++;
  }

  if (y - 3 >= 0 && input[y - 1][x] == 'M' && input[y - 2][x] == 'A' && input[y - 3][x] == 'S') {
    totalMatches++;
  }

  // Count diagonals
  if (check(input, x + 1, y + 1, 'M') && check(input, x + 2, y + 2, 'A') && check(input, x + 3, y + 3, 'S')) {
    totalMatches++;
  }

  if (check(input, x - 1, y - 1, 'M') && check(input, x - 2, y - 2, 'A') && check(input, x - 3, y - 3, 'S')) {
    totalMatches++;
  }

  if (check(input, x + 1, y - 1, 'M') && check(input, x + 2, y - 2, 'A') && check(input, x + 3, y - 3, 'S')) {
    totalMatches++;
  }

  if (check(input, x - 1, y + 1, 'M') && check(input, x - 2, y + 2, 'A') && check(input, x - 3, y + 3, 'S')) {
    totalMatches++;
  }

  return totalMatches;
}

void day4(List<String> input) {
  var totalMatches = 0;

  for (var y = 0; y < input.length; y++) {
    for (var x = 0; x < input.length; x++) {
      if (input[y][x] == 'X') {
        totalMatches += countMatches(input, x, y);
      }
    }
  }

  var totalXmas = 0;
    for (var y = 0; y < input.length; y++) {
    for (var x = 0; x < input.length; x++) {
      if (input[y][x] == 'A') {

        if (((check(input, x - 1, y - 1, 'M') && check(input, x + 1, y + 1, 'S')) || (check(input, x - 1, y - 1, 'S') && check(input, x + 1, y + 1, 'M')))
          && ((check(input, x - 1, y + 1, 'M') && check(input, x + 1, y - 1, 'S')) || (check(input, x - 1, y + 1, 'S') && check(input, x + 1, y - 1, 'M')))) {
            totalXmas++;
        }
      }
    }
  }

  print(totalMatches);
  print(totalXmas);
}