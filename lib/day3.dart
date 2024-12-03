import 'dart:math';

class ParseResult
{
  final int i;
  final int? n;

  ParseResult(this.i, this.n);
}

bool isDigit(String s, int idx) 
  => (s.codeUnitAt(idx) ^ 0x30) <= 9;

ParseResult parseInt(String input, int i) {
  final start = i;
  while (i < input.length) {
    if (!isDigit(input, i)) {
      break;
    }
    i++;
  }

  final len = i - start;
  if (len == 0) {
    return ParseResult(i, null);
  }

  final n = int.parse(input.substring(start, i));
  return ParseResult(i, n);
}

ParseResult parseExact(String input, int i, String expected) {
  return ParseResult(i + expected.length, input.startsWith(expected, i) ? 0 : null);
}

ParseResult parseEither(String input, int i, List<String> choices) {
  for (var n = 0; n < choices.length; n++) {
    final result = parseExact(input, i, choices[n]);
    if (result.n != null) {
      return ParseResult(result.i, n);
    }
  }

  return ParseResult(i + 1, null);
}

void day3(List<String> input) {
  var sum = 0;
  var part2Sum = 0;
  var enabled = true;

  // Puzzle input seems to be fine per line ... 
  for (final line in input) {
    var i = 0; 
    while (i < line.length && i >= 0) {
      while (i < line.length) {
        final op = parseEither(line, i, ['mul(', 'do()', 'don\'t()']);
        i = op.i;

        // No match.
        if (op.n == null) {
          break;
        }

        // do()
        if (op.n == 1) {
          enabled = true;
          break;
        }

        // don't()
        if (op.n == 2) {
          enabled = false;
          break;
        }

        // Parse full mul(,)

        // First number.
        final n1 = parseInt(line, i);
        i = n1.i;
        if (n1.n == null) {
          break;
        }
        
        // ,
        if (line[i] != ',') {
          break;
        }

        i++;

        // Second number
        final n2 = parseInt(line, i);
        i = n2.i;
        if (n2.n == null) {
          break;
        }
        i = n2.i;

        // )
        if (line[i] != ')') {
          break;
        }

        i++;
        var result = n1.n! * n2.n!;
        sum += result;
        if (enabled) {
          part2Sum += result;
        }
      }
    }
  }
  print(sum);
  print(part2Sum);
}