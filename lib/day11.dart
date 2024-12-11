import 'dart:math';

int countDigits(int n) {
  var count = 0;
  while (n != 0) {
    n = n ~/ 10;
    ++count;
  }

  return count;
}

List<int> iterate(List<int> stones) {
  var output = List<int>.empty(growable: true);

  for (var stone in stones) {
    if (stone == 0) {
      output.add(stone + 1);
    } else {
      var digits = countDigits(stone);
      if (digits % 2 == 0) {
        digits = digits ~/ 2;

        final stone1 = stone ~/ pow(10, digits).floor();
        final stone2 = (stone % pow(10, digits).floor());
        output.add(stone1);
        output.add(stone2);
      } else {
        output.add(stone * 2024);
      }
    }
  }

  return output;
}

class Key
{
  final int i;
  final int s;

  Key(this.i, this.s);
}

int countStones(Map<Key, int> lookup, int stone, int i, int iterations) {
  if (i == iterations) return 1; // All done

  final key = Key(stone, stone);
  if (lookup.containsKey(key)) return lookup[key]!;

  var count = 0;
  if (stone == 0) {
    stone = stone + 1;
    count = countStones(lookup, stone, i + 1, iterations);
  } else {
    var digits = countDigits(stone);
      if (digits % 2 == 0) {
        digits = digits ~/ 2;

        final stone1 = stone ~/ pow(10, digits).floor();
        final stone2 = (stone % pow(10, digits).floor());

        count = countStones(lookup, stone1, i + 1, iterations) + countStones(lookup, stone2, i + 1, iterations);
      } else {
        count = countStones(lookup, stone * 2024, i + 1, iterations);
      }
  }

  lookup[key] = count;
  return count;
}

void day11(List<String> input) {
  final stones = input[0].split(' ').map((s) => int.parse(s)).toList();

  var part1 = 0;
  var lookup = <Key, int>{};
  for (var stone in stones) {
    part1 += countStones(lookup, stone, 0, 25);
  }
  print(part1);
}