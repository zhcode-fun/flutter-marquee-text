import 'package:flutter/material.dart';
import 'package:marquee_text/marquee_text.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _textList = [
    'Short text.',
    'Long text Long text Long text Long text Long text'
  ];

  var firstTextIndex = 0;
  var secondTextIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MarqueeTextDemo'),
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
                  text: _textList[firstTextIndex],
                  speed: 90,
                ),
              ),

              SizedBox(width: 12),

              /// SecondText
              /// 包含在Expanded中
              Expanded(
                child: Container(
                  color: Colors.pink,
                  child: MarqueeText(
                    text: _textList[secondTextIndex],
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
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
                  child: Text(
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
              SizedBox(width: 12),
              Expanded(
                child: MaterialButton(
                  color: Colors.pink,
                  child: Text(
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
        ],
      ),
    );
  }
}
