import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String _expression = '';
  String _result = '';

  void logicOnPressedButtom(String value) {
    setState(() {
      if (value == 'C') {
        _expression = '';
        _result = '';
      } else if (value == '=') {
        try {
          // استبدال الرموز الغير مدعومة
          String finalExpression = _expression
              .replaceAll('×', '*')
              .replaceAll('÷', '/');
          Parser p = Parser();
          Expression exp = p.parse(finalExpression);
          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);
          if (eval % 1 == 0) {
            _result = eval.toInt().toString(); // لو صحيح شيله العلامات العشرية
          } else {
            _result = eval.toString(); // لو عشري سيبه زي ما هو
          }
        } catch (e) {
          _result = 'Error';
        }
      } else {
        _expression += value;
      }
    });
  }

  //
  Widget _buildButton(String text, {Color color = Colors.blue}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          onPressed: () => logicOnPressedButtom(text),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(15),
            ),
            backgroundColor: color,
            padding: EdgeInsets.symmetric(vertical: 22),
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: 26, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff161516),
        appBar: AppBar(
          backgroundColor: Color(0xff161516),
          centerTitle: true,
          title: Text(
            "Ziad Calculator",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
        //
        body: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(24),
                alignment: Alignment.centerRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      _expression,
                      style: TextStyle(fontSize: 32, color: Colors.white),
                    ),
                    SizedBox(height: 12),
                    Text(
                      _result,
                      style: TextStyle(fontSize: 40, color: Colors.greenAccent),
                    ),
                  ],
                ),
              ),
            ),
            Divider(color: Colors.grey, endIndent: 20, indent: 20),
            Column(
              children: [
                Row(
                  children: [
                    _buildButton('7', color: Color(0xff2d2b28)),
                    _buildButton('8', color: Color(0xff2d2b28)),
                    _buildButton('9', color: Color(0xff2d2b28)),
                    _buildButton('÷', color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('4', color: Color(0xff2d2b28)),
                    _buildButton('5', color: Color(0xff2d2b28)),
                    _buildButton('6', color: Color(0xff2d2b28)),
                    _buildButton('×', color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('1', color: Color(0xff2d2b28)),
                    _buildButton('2', color: Color(0xff2d2b28)),
                    _buildButton('3', color: Color(0xff2d2b28)),
                    _buildButton('-', color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _buildButton(
                      'C',
                      color: const Color.fromARGB(255, 180, 35, 24),
                    ),
                    _buildButton('0', color: Color(0xff2d2b28)),
                    _buildButton('.', color: Color(0xff2d2b28)),
                    _buildButton('+', color: Colors.orange),
                  ],
                ),
                Row(children: [_buildButton('=', color: Colors.green)]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
