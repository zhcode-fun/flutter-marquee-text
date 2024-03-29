[![pub package](https://img.shields.io/pub/v/marquee_text.svg)](https://pub.dev/packages/marquee_text)

# Screenshot

![Screenshot](https://github.com/zhcode-fun/zhcode-fun/raw/master/marquee_text.gif)

# Usage

1. Add marquee_text as a dependency in your pubspec.yaml file.
    ```yaml
    dependencies:
      marquee_text: ^2.5.0+1
    ```

2. Now in your flutter project, you can use:
    ```dart
    Container(
      width: 100,
      color: Colors.green
      child: Column(
        children: [
          /// horizontal marquee
          MarqueeText(
            text: TextSpan(
              text: 'This is long long long text...',
            ),
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
            speed: 30,
          ),

          /// vertical marquee
          VerticalMarqueeText(
            text: TextSpan(
              children: <InlineSpan>[
                TextSpan(
                  text: '''
                  This is long long long text...
                  This is long long long text...
                  This is long long long text...
                  ''',
                ),
              ],
            ),
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
            speed: 30,
          ),
        ],
      ),
    )
    ```

# Properties

|Property|Type|Required|Default|
|:--:|:-:|:-:|:-:|
text|String|true|/
style|TextStyle|false|/
speed|double|false|50
alwaysScroll|bool|false|false
textDirection|TextDirection|false|TextDirection.ltr
marqueeDirection|MarqueeDirection|false|MarqueeDirection.rtl
textAlign|TextAlign|false|TextAlign.start
