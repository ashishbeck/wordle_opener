import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle_opener/code/constants.dart';
import 'package:wordle_opener/code/providers.dart';

class NotificationItem extends StatefulWidget {
  final String text;
  const NotificationItem({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  animate() async {
    controller.value = 1;
    await Future.delayed(Duration(milliseconds: notificationDisplay));
    if (mounted) controller.reverse();
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: notificationFade));
    animate();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    MaterialColor colors = themeProvider.darkMode ? darkColors : lightColors;
    return FadeTransition(
      opacity: controller,
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: colors[100],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          widget.text,
          style: TextStyle(
              color: colors[500], fontWeight: FontWeight.bold, fontSize: 21),
        ),
      ),
    );
  }
}
