library marquee_text;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MarqueeText extends StatefulWidget {
  final String text;
  final TextStyle textStyle;

  MarqueeText({
    Key key,
    @required this.text,
    this.textStyle,
  }) : super(key: key);

  @override
  _MarqueeTextState createState() => _MarqueeTextState();
}

class _MarqueeTextState extends State<MarqueeText>
    with SingleTickerProviderStateMixin {
  // Animation<double> _animation;
  // AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    var renderParagraph = RenderParagraph(
      TextSpan(
        text: widget.text,
        style: widget.textStyle,
      ),
      softWrap: false,
      maxLines: 1,
      textDirection: TextDirection.ltr,
      overflow: TextOverflow.visible,
    );
    renderParagraph.layout(BoxConstraints.tightForFinite());
    print(renderParagraph.textSize.width);
    print(renderParagraph.constraints.maxWidth);
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      child: Container(
        width: double.infinity,
        child: Text(
          widget.text,
          style: widget.textStyle,
          overflow: TextOverflow.visible,
          softWrap: false,
        ),
      ),
    );
  }
}
