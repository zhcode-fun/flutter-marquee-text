[中文介绍](https://www.zhcode.fun/note/Flutter/marquee_text包介绍.html)

# Screenshot

![Screenshot](https://www.zhcode.fun/images/marquee_text.gif)

# Usage
```dart
Container(
  width: 100,
  color: Colors.green
  child: MarqueeText(
    text: 'Don not worry when you are not recognized',
    style: TextStyle(
      fontSize: 24,
      color: Colors.white,
    ),
    speed: 30,
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
