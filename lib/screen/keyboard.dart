import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:wordle_opener/code/constants.dart';
import 'package:wordle_opener/code/providers.dart';

class Keyboard extends StatefulWidget {
  final Function(String) onPressed;
  const Keyboard({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<Keyboard> createState() => _KeyboardState();
}

class _KeyboardState extends State<Keyboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 200),
      child: Column(
        children: keys
            .map((e) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: e
                      .split("")
                      .map((e) => Flexible(
                          flex: e == "[" || e == "]" ? 2 : 1,
                          child: KeyTile(
                            value: e,
                            onPressed: widget.onPressed,
                          )))
                      .toList(),
                ))
            .toList(),
      ),
    );
  }
}

class KeyTile extends StatefulWidget {
  final String value;
  final Function(String) onPressed;
  const KeyTile({
    Key? key,
    required this.value,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<KeyTile> createState() => _KeyTileState();
}

class _KeyTileState extends State<KeyTile> {
  @override
  Widget build(BuildContext context) {
    String value = widget.value;
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    MaterialColor colors = themeProvider.darkMode ? darkColors : lightColors;
    Widget child() {
      if (value == "]") {
        return Icon(
          Icons.backspace_outlined,
          color: colors[100],
          size: 16,
        );
      }
      return FittedBox(
        child: Text(
          value == "[" ? "ENTER" : value.toUpperCase(),
          style: TextStyle(
              fontWeight: FontWeight.w700,
              color: themeProvider.darkMode ? white : black),
          textAlign: TextAlign.center,
        ),
      );
    }

    return value == " "
        ? Container()
        : MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => widget.onPressed(value),
              child: Container(
                margin: const EdgeInsets.all(3),
                constraints: BoxConstraints(
                  maxWidth: value == "[" || value == "]" ? 70 : 43,
                  maxHeight: 58,
                ),
                decoration: BoxDecoration(
                  color: themeProvider.darkMode ? colors[200] : colors[400],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(child: child()),
              ),
            ),
          );
  }
}
