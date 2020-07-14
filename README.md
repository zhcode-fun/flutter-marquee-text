[中文介绍](https://www.zhcode.fun/note/Flutter/marquee_text包介绍.html)

# Screenshot

![Demo](https://imgkr.cn-bj.ufileos.com/8fd2277e-f665-41a2-995c-f07def1af729.gif)

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
