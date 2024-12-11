import 'dart:math';

int countDigits(int n) {
  var count = 0;
  while (n != 0) {
    n = n ~/ 10;
    ++count;
  }

  return count;
}

class Key
{
  int s;
  int i;

  Key(this.s, this.i);

  @override
  bool operator==(Object other) =>
      other is Key && s == other.s && i == other.i;

  @override
  int get hashCode => Object.hash(s, i);
}

int countStones(Map<Key, int> cache, int stone, int i) {
  if (i == 0) return 1; // All done

  final key = Key(stone, i);
  if (cache.containsKey(key)) {
    return cache[key]!;
  }

  var count = 0;
  if (stone == 0) {
    count = countStones(cache, stone + 1, i - 1);
  } else {
    var digits = countDigits(stone);
      if (digits % 2 == 0) {
        digits = digits ~/ 2;

        final stone1 = stone ~/ pow(10, digits).floor();
        final stone2 = (stone % pow(10, digits).floor());

        count = countStones(cache, stone1, i - 1) + countStones(cache, stone2, i - 1);
      } else {
        count = countStones(cache, stone * 2024, i - 1);
      }
  }

  cache[key] = count;

  return count;
}

void day11(List<String> input) {
  final stones = input[0].split(' ').map((s) => int.parse(s)).toList();

  var part1 = 0;
  var cache = <Key, int>{};
  for (var stone in stones) {
    part1 += countStones(cache, stone, 25);
  }
  print(part1);

  var part2 = 0;
  for (var stone in stones) {
    part2 += countStones(cache, stone, 75);
  }
  print(part2);
}