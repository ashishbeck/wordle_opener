import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:wordle_opener/code/constants.dart';
import 'package:wordle_opener/code/providers.dart';

class TextTile extends StatefulWidget {
  final String? value;
  final bool reveal;
  final int index;
  final bool isUsed;
  const TextTile({
    Key? key,
    this.value,
    this.reveal = false,
    required this.index,
    this.isUsed = false,
  }) : super(key: key);

  @override
  State<TextTile> createState() => _TextTileState();
}

class _TextTileState extends State<TextTile> with TickerProviderStateMixin {
  late AnimationController appearController;
  late AnimationController flipController;
  bool newColor = false;

  makeAppear() {
    appearController.reverse(from: 1.1);
  }

  makeFlip() async {
    await Future.delayed(Duration(milliseconds: 100 * widget.index));
    flipController.forward(from: 0).then((value) {
      setState(() {
        newColor = true;
      });
      flipController.reverse();
    });
  }

  resetFlip() {
    flipController.forward(from: 0).then((value) {
      setState(() {
        newColor = false;
      });
      flipController.reverse();
    });
  }

  @override
  void initState() {
    super.initState();
    appearController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 1,
      upperBound: 1.1,
    );
    flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0,
      upperBound: 1.4,
    );
  }

  @override
  void dispose() {
    appearController.dispose();
    flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? value = widget.value;
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    MaterialColor colors = themeProvider.darkMode ? darkColors : lightColors;
    return AnimatedBuilder(
        animation: flipController,
        builder: (context, child) {
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0)
              ..rotateX(flipController.value),
            origin: Offset(62 / 2, 62 / 2),
            child: ScaleTransition(
              scale: appearController,
              child: Container(
                margin: const EdgeInsets.all(2),
                constraints: const BoxConstraints(
                  maxWidth: 62,
                  maxHeight: 62,
                ),
                decoration: BoxDecoration(
                  color: newColor
                      ? widget.isUsed
                          ? yellow(themeProvider.darkMode)
                          : green(themeProvider.darkMode)
                      : Colors.transparent,
                  border: Border.all(
                      color: newColor
                          ? Colors.transparent
                          : value == null
                              ? colors[400]!
                              : colors[200]!,
                      width: 2),
                ),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: FittedBox(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.value ?? "",
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontWeight: FontWeight.bold,
                          // fontSize: 12,
                          color: newColor ? white : colors[100]!),
                    ),
                  )),
                ),
              ),
            ),
          );
        });
  }

  @override
  void didUpdateWidget(covariant TextTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != null && oldWidget.value == null) {
      makeAppear();
    }
    if (widget.reveal && !oldWidget.reveal) {
      makeFlip();
    }
    if (!widget.reveal && oldWidget.reveal) {
      resetFlip();
    }
  }
}
