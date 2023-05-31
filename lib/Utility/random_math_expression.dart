import 'dart:math';

import 'package:math_expressions/math_expressions.dart';

class RandomMathExpression {
  static final Random _random = Random();
  static late int maxOperators;
  static late int maxOperand;

  static void assignParams(int difficulty) {
    if (difficulty == 0) {
      maxOperators = 1;
      maxOperand = 15;
    }
    else if (difficulty == 1) {
      maxOperators = 2;
      maxOperand = 20;
    }
    else {
      maxOperators = 3;
      maxOperand = 25;
    }
  }

  static String generateExpression(int difficulty) {
    assignParams(difficulty);
    final numOperands = _random.nextInt(maxOperators) + 2;
    final operands = List.generate(numOperands, (_) => _random.nextInt(maxOperand) + 1);
    final operators = List.generate(numOperands - 1, (_) => _randomOperator());
    final expression = StringBuffer();
    for (var i = 0; i < numOperands; i++) {
      expression.write(operands[i]);
      if (i < numOperands - 1) {
        expression.write(' ${operators[i]} ');
      }
    }
    return expression.toString();
  }

  static int evaluateExpression(String expression) {
    final parser = Parser();
    final parsedExpression = parser.parse(expression);
    final context = ContextModel();
    double ans = parsedExpression.evaluate(EvaluationType.REAL, context);
    return ans.toInt();
  }

  static String _randomOperator() {
    final operators = ['+', '-', '*', '%'];
    return operators[_random.nextInt(operators.length)];
  }

  static List<int> generateOptions(int resultExpression, int difficulty) {
    List<int> res = [];
    int cnt = -1;
    for (int i = 0; i < 3; i++) {
      late int _op;
      while (true) {
        _op = _random.nextInt(maxOperand * maxOperand);
        if (_op < resultExpression - 20 || _op > resultExpression + 20 || _op == resultExpression) continue;
        if (cnt >= difficulty + 1 || _op % 10 == resultExpression % 10) {
          break;
        }
        cnt++;
      }
      res.add(_op);
    }
    res.add(resultExpression);
    res.shuffle();
    return res;
  }
}