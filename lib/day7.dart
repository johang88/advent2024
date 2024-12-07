List<List<String>> getOperators(int n, List<String> operators) {
  if (n == 0) {
    return [[]];
  }

  List<List<String>> result = [];

  for (var operator in operators) {
    var subCombinations = getOperators(n - 1, operators);

    for (var combination in subCombinations) {
      result.add([operator, ...combination]);
    }
  }

  return result;
}

int evaluate(int a, int b, String op) {
  switch (op) {
    case '*': return a * b;
    case '+': return a + b;
    case '|': return int.parse(a.toString() + b.toString()); // this is not nice.
    default: 
      print('error');
      return 0;
  }
}

void day7(List<String> input) {
  var calibrationResult = 0;
  final availableOperators = ['*', '+', '|'];

  for (final line in input) {
    final equation = line.split(':');
    final testValue = int.parse(equation[0]);
    final values = equation[1].trim().split(' ').map(int.parse).toList();
    final numberOfOperators = values.length - 1;
    final allOperators = getOperators(numberOfOperators, availableOperators);

    for (final operators in allOperators) {
      var sum = values[0];
      for (var i = 1; i < values.length; i++) {
        sum = evaluate(sum, values[i], operators[i - 1]);
      }

      if (sum == testValue) {
        calibrationResult += testValue;
        break;
      }
    }
  }

  print(calibrationResult);
}