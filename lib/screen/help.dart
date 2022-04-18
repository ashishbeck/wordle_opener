import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wordle_opener/code/constants.dart';
import 'package:wordle_opener/code/providers.dart';
import 'package:wordle_opener/screen/tile.dart';

class HelpInfo extends StatefulWidget {
  const HelpInfo({Key? key}) : super(key: key);

  @override
  State<HelpInfo> createState() => _HelpInfoState();
}

class _HelpInfoState extends State<HelpInfo> {
  String first = "CIGAR";
  String last = "FANNY";
  bool shouldReveal = false;
  bool isHovering = false;

  initReveal() async {
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      shouldReveal = true;
    });
  }

  _launch(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunch(uri.toString())) {
      launch(uri.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    initReveal();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    MaterialColor colors = themeProvider.darkMode ? darkColors : lightColors;

    List<TextTile> example1 = first
        .split("")
        .map((e) => TextTile(
              index: 0,
              value: e,
              reveal: shouldReveal,
              isUsed: true,
            ))
        .toList();
    List<TextTile> example2 = last
        .split("")
        .map((e) => TextTile(
              index: 0,
              value: e,
              reveal: shouldReveal,
              isUsed: false,
            ))
        .toList();

    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          padding: const EdgeInsets.only(top: 8, bottom: 8, left: 0, right: 0),
          constraints: const BoxConstraints(maxWidth: 500),
          // decoration: BoxDecoration(
          //     border: Border.all(
          //         // color: Colors.red,
          //         )),
          child: Scrollbar(
            child: SingleChildScrollView(
              child: DefaultTextStyle(
                style: TextStyle(
                  fontSize: 16,
                  color: themeProvider.darkMode ? white : black,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.left,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                "WHAT IS THIS?",
                                style: Theme.of(context).textTheme.headline5,
                              )),
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.close),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        '• This is a simple utility that should assist you in making '
                        'decisions about choosing a fortune word for Wordle.',
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        '• "Fortune word" here refers to a word that has not been a '
                        'previous Wordle solution. The purpose of this utility is to go '
                        'for a single or 2 attempt wins.\nYou would want to open'
                        ' with a specific word every day so that there will be a moment '
                        'when this word would be the solution and you hit it in the first '
                        '(or second) attempt. You need to know if that word has appeared in the game '
                        'before.',
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        '• This tool will help you figure exactly that out.',
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Divider(),
                      Text(
                        "Examples",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: example1
                            .map(
                              (e) => Flexible(
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  child: e,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      Text(
                          "The word has already been used in a previous Wordle"),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: example2
                            .map(
                              (e) => Flexible(
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  child: e,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      Text("The word has not appeared in a previous Wordle"),
                      Divider(),
                      const SizedBox(
                        height: 32,
                      ),
                      Center(
                          child: Text(
                        "WHAT THIS ISN\'T!",
                        style: Theme.of(context).textTheme.headline5,
                      )),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        '• This will NOT tell you if the word you entered is a valid '
                        'dictionary word.',
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        '• This will NOT tell you anything about the future words.',
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        '• Just like the official game, this is also prone to abuse'
                        ' and is not trying to be immune to those. Because if one wants, they'
                        ' can anyway cheat easily without any external assistance.',
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text.rich(
                        TextSpan(
                            text:
                                '• One is expected to use this tool maybe once every few weeks'
                                ' when they want to change their ',
                            children: [
                              TextSpan(
                                  text: 'opening',
                                  style: TextStyle(
                                      color: green(themeProvider.darkMode))),
                              const TextSpan(text: ' words.'),
                            ]),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(color: colors[400]!)),
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "Go back",
                          style: TextStyle(
                            fontSize: 16,
                            color: themeProvider.darkMode ? white : black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        // icon: Icon(
                        //   Icons.keyboard_arrow_left,
                        //   color: themeProvider.darkMode ? white : black,
                        // ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Text.rich(TextSpan(text: "A project by ", children: [
                        WidgetSpan(
                          child: MouseRegion(
                            onEnter: (event) =>
                                setState(() => isHovering = true),
                            onExit: (event) =>
                                setState(() => isHovering = false),
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () =>
                                  _launch('https://linktr.ee/ashishbeck'),
                              child: Text(
                                "ASHISH BECK",
                                style: TextStyle(
                                    color: isHovering
                                        ? null
                                        : green(themeProvider.darkMode)),
                              ),
                            ),
                          ),
                        )
                      ])),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
