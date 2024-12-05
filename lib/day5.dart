

void day5(List<String> input) {
  // Parse input
  var orderings = <int, Set<int>>{}; // Key -> Depends On
  List<List<int>> printings = List.empty(growable: true);
  var addPrintings = false;
  for (final line in input) {
    if (line == '') {
      addPrintings = true;
    } else if (!addPrintings) {
      final split = line.split('|');
      final key = int.parse(split[0]);
      final value = int.parse(split[1]);
      if (!orderings.containsKey(key)) {
        orderings[key] = <int>{};
      }

      orderings[key]!.add(value);
    } else {
      printings.add(line.split(',').map((n) => int.parse(n)).toList());
    }
  }

  // Validate printings
  int validateItem(List<int> printing, int i) {
    final value = printing[i];
    if (!orderings.containsKey(value)) return -1;
    final dependencies = orderings[value]!;

    for (var k = i - 1; k >= 0; k--) {
      if (dependencies.contains(printing[k])) { // i must come before k so not valid
        return k;
      }
    }
    return -1;
  }

  bool validate(List<int> printing) {
    for (var i = 1; i < printing.length; i++) {
      if (validateItem(printing, i) != -1) return false;
    }

    return true;
  }

  void fixup(List<int> printing) {
    // This is not very nice. much algorithm.
    while (!validate(printing)) {
      for (var i = 1; i < printing.length; i++) {
        final k = validateItem(printing, i);
        if (k != -1) {
          // swap k,i
          final tmp = printing[k];
          printing[k] = printing[i];
          printing[i] = tmp;
          break;
        }
      }
    }
  }

  var sum = 0;
  var fixedSum = 0;
  for (final printing in printings) {
    if (validate(printing)) {
      sum += printing[printing.length ~/ 2];
    } else {
      fixup(printing);
      fixedSum += printing[printing.length ~/ 2];
    }
  }

  print(sum);
  print(fixedSum);
}