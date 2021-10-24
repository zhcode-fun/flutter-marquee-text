import 'package:flutter/material.dart';
import 'package:marquee_text/marquee_direction.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:marquee_text/vertical_marquee_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _textList = [
    'Short text.',
    'Long text Long text Long text Long text Long text'
  ];

  var firstTextIndex = 0;
  var secondTextIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MarqueeTextDemo'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              /// FirstText
              /// 固定宽度的Container
              Container(
                color: Colors.green,
                width: 160,
                child: MarqueeText(
                  text: TextSpan(
                    text: _textList[firstTextIndex],
                  ),
                  speed: 90,
                  textDirection: TextDirection.rtl,
                  marqueeDirection: MarqueeDirection.ltr,
                ),
              ),

              const SizedBox(width: 12),

              /// SecondText
              /// 包含在Expanded中
              Expanded(
                child: Container(
                  color: Colors.pink,
                  child: MarqueeText(
                    text: TextSpan(
                      text: _textList[secondTextIndex],
                    ),
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                    marqueeDirection: MarqueeDirection.ltr,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: MaterialButton(
                  color: Colors.green,
                  child: const Text(
                    'ChangeFirstText',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      firstTextIndex = 1 - firstTextIndex;
                    });
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: MaterialButton(
                  color: Colors.pink,
                  child: const Text(
                    'ChangeSecondText',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      secondTextIndex = 1 - secondTextIndex;
                    });
                  },
                ),
              ),
            ],
          ),
          Container(
            color: Colors.green,
            width: 160,
            height: 100,
            // height: 400,
            child: const VerticalMarqueeText(
              marqueeDirection: MarqueeDirection.btt,
              textAlign: TextAlign.center,
              // alwaysScroll: true,
              text: TextSpan(
                children: <InlineSpan>[
                  TextSpan(
                    text: '''Hello,Flutter!
Hello,Flutter!
Hello,Flutter!
Hello,Flutter!
Hello,Flutter!
Hello,Flutter!
Hello,Flutter!
Hello,Flutter!
''',
                  ),
                  TextSpan(
                    text: '''Hello,Flutter!
Hello,Flutter!
Hello,Flutter!
Hello,Flutter!
Hello,Flutter!
Hello,Flutter!
Hello,Flutter!
Hello,Flutter!''',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              speed: 30,
            ),
          ),
        ],
      ),
    );
  }
}
