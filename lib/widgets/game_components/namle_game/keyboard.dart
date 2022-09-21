import 'package:flutter/material.dart';

class Keyboard extends StatelessWidget {
  final String row1 = "QWERTYUIOPÅ";
  final String row2 = "ASDFGHJKLØÆ";
  final String row3 = "*ZXCVBNM+"; // * = backspace, + = Enter
  final Function(String) callback;
  final Map<String, Color> colorOfLetter;

  const Keyboard(this.callback, this.colorOfLetter, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget keyboardButton(String c) {
      if (c == "*") {
        return Container(
          width: 50,
          height: 50,
          child: IconButton(
            icon: const Icon(Icons.backspace, color: Colors.white),
            onPressed: () {
              callback(c);
            },
          ),
        );
      } else if (c == "+") {
        return Container(
          width: 50,
          height: 50,
          child: IconButton(
            icon: const Icon(Icons.keyboard_return, color: Colors.white),
            onPressed: () {
              callback(c);
            },
          ),
        );
      }

      // Coloring of the letters
      Color backgroundColor = Color.fromARGB(255, 90, 90, 90);
      if (colorOfLetter.containsKey(c)) {
        backgroundColor = colorOfLetter[c]!;
      }
      return InkWell(
        onTap: () {
          callback(c);
        },
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(5),
          ),
          width: 30,
          height: 40,
          child: Center(
            child: Text(
              c,
              style: TextStyle(
                  fontSize: 28,
                  color: backgroundColor == Color.fromARGB(255, 90, 90, 90)
                      ? Colors.white
                      : Colors.black),
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: row1.characters.map((c) => keyboardButton(c)).toList(),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: row2.characters.map((c) => keyboardButton(c)).toList(),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: row3.characters.map((c) => keyboardButton(c)).toList(),
        )
      ],
    );
  }
}
