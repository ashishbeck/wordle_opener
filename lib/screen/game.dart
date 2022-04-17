import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wordle_opener/code/constants.dart';
import 'package:wordle_opener/code/providers.dart';
import 'package:wordle_opener/code/words.dart';
import 'package:wordle_opener/screen/help.dart';
import 'package:wordle_opener/screen/keyboard.dart';
import 'package:wordle_opener/screen/notification.dart';
import 'package:wordle_opener/screen/tile.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  FocusNode focusNode = FocusNode();
  late String todayWord;
  String myWord = "";
  int today = DateTime.now().difference(startDate).inDays + 1;
  List<String> completedWords = [];
  List<TextTile> tiles = List.generate(5, ((index) => TextTile(index: index)));
  String allKeys =
      keys.map((e) => e.toUpperCase()).join("").replaceAll(" ", "");
  int currentIndex = 0;
  int total = 5;
  bool hasRevealed = false;
  int? usedIndex;
  List<NotificationItem> notifications = [];

  getTodayWord() {
    todayWord = wordList[today].toString();
  }

  getCompletedWordList() {
    completedWords = wordList.sublist(0, today);
  }

  resetBoxes() {
    for (var i = 0; i < 5; i++) {
      tiles[i] = TextTile(
        value: myWord.split("")[i],
        reveal: false,
        index: i,
        isUsed: usedIndex != null,
      );
    }
    setState(() {
      hasRevealed = false;
    });
  }

  onTyped(String value) {
    if (value == "Enter" || value == "[") {
      if (myWord.length == 5) {
        usedIndex = check();
        for (var i = 0; i < 5; i++) {
          tiles[i] = TextTile(
            value: myWord.split("")[i],
            reveal: true,
            index: i,
            isUsed: usedIndex != null,
          );
        }
        setState(() {
          hasRevealed = true;
        });
      }
    } else if (value == "Backspace" || value == "]") {
      if (hasRevealed) resetBoxes();
      if (currentIndex != 0) {
        tiles[currentIndex - 1] = TextTile(
          value: null,
          index: currentIndex - 1,
          isUsed: usedIndex != null,
        );
        currentIndex--;
        myWord = myWord.substring(0, myWord.length - 1);
        setState(() {});
      }
    } else if (allKeys.contains(value)) {
      if (currentIndex < total) {
        tiles[currentIndex] = TextTile(
          value: value,
          index: currentIndex,
        );
        currentIndex++;
        myWord += value;
        setState(() {});
      }
    }
  }

  int? check() {
    if (completedWords.contains(myWord.toLowerCase())) {
      int index = completedWords.indexOf(myWord.toLowerCase());
      setState(() => notifications
          .add(NotificationItem(text: "Solution in Wordle $index")));
      Future.delayed(
              Duration(milliseconds: notificationFade + notificationDisplay))
          .then((value) => setState(() => notifications.removeAt(0)));
      return index;
      // print("Sorry, the word was used in Wordle #$index");
    } else {
      return null;
      // print("It has potential");
    }
  }

  @override
  void initState() {
    super.initState();
    getTodayWord();
    getCompletedWordList();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    AppBar appBar = AppBar(
      title: Text(
        "Wordle Opener",
        style: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(fontFamily: 'RobotoSlab'),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () => themeProvider.toggleDarkMode(),
          icon:
              Icon(themeProvider.darkMode ? Icons.light_mode : Icons.dark_mode),
          color: themeProvider.darkMode ? white : black,
        ),
      ],
      leading: IconButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => HelpInfo())),
        icon: const Icon(Icons.help_outline),
        color: themeProvider.darkMode ? white : black,
      ),
    );

    return RawKeyboardListener(
      focusNode: focusNode,
      autofocus: true,
      onKey: ((event) {
        if (event.runtimeType == RawKeyDownEvent &&
            event.logicalKey != LogicalKeyboardKey.bracketLeft &&
            event.logicalKey != LogicalKeyboardKey.bracketRight) {
          onTyped(event.logicalKey.keyLabel);
        }
      }),
      child: Scaffold(
        appBar: appBar,
        floatingActionButton: kDebugMode
            ? FloatingActionButton(
                onPressed: () => themeProvider.toggleDarkMode(),
                child: const Icon(Icons.favorite),
              )
            : Container(),
        body: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: tiles.map((e) => Flexible(child: e)).toList(),
                ),
                const Spacer(),
                Keyboard(
                  onPressed: (val) {
                    onTyped(val.toUpperCase());
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: notifications,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
