import 'point.dart';
import 'package:equations/equations.dart';

void day13(List<String> input) {
  final regex = RegExp(r'X[\+\=]([0-9]+), Y[\+\=]([0-9]+)');

  Point parsePoint(String s) {
    final matches = regex.allMatches(s);
    var x = matches.elementAt(0)[1]!;
    var y = matches.elementAt(0)[2]!;
    return Point(int.parse(x), int.parse(y));
  }

  var cost = 0;
  for (var i = 0; i < input.length; i += 4) {
    var buttonA = parsePoint(input[i + 0]);
    var buttonB = parsePoint(input[i + 1]);
    var prize = parsePoint(input[i + 2]);
    prize.x += 10000000000000;
    prize.y += 10000000000000;

    final matrix = RealMatrix.fromData(rows: 2, columns: 2, data: [
      [buttonA.x.toDouble(), buttonB.x.toDouble()],
      [buttonA.y.toDouble(), buttonB.y.toDouble()]
    ]);

    final knownValues = [prize.x.toDouble(), prize.y.toDouble()];

    final solver = LUSolver(matrix: matrix, knownValues: knownValues);
    final solutions = solver.solve();

    final a = solutions[0].round();
    final b = solutions[1].round();

    if (buttonA.x * a + buttonB.x * b == prize.x && buttonA.y * a + buttonB.y * b == prize.y) {
      cost += a * 3 + b * 1;
    }
  }

  print(cost);
}