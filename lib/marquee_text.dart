library marquee_text;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MarqueeText extends StatelessWidget {
  final String text;
  final TextStyle style;

  /// default 50
  /// Must be greater than 0.
  final double speed;

  /// Always scroll and ignore text length.
  final bool alwaysScroll;

  const MarqueeText({
    Key key,
    @required this.text,
    this.style,
    this.speed = 50,
    this.alwaysScroll = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) => ClipPath(
        child: _MarqueeContainer(
          text: text,
          textStyle: style,
          constraints: constraints,
          speed: speed,
          alwaysScroll: alwaysScroll,
        ),
      ),
    );
  }
}

class _MarqueeContainer extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  final double speed;
  final BoxConstraints constraints;
  final bool alwaysScroll;

  _MarqueeContainer(
      {Key key,
      @required this.text,
      this.textStyle,
      @required this.constraints,
      this.speed,
      this.alwaysScroll})
      : super(key: key);

  @override
  _MarqueeContainerState createState() => _MarqueeContainerState();
}

class _MarqueeContainerState extends State<_MarqueeContainer>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;
  bool _showMarquee = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
    renderParagraph.layout(widget.constraints);
    var textWidth = renderParagraph.textSize.width;
    var constraintsWidth = renderParagraph.constraints.maxWidth;
    _showMarquee = textWidth > constraintsWidth || widget.alwaysScroll;
    if (_showMarquee) {
      if (widget.speed <= 0) {
        throw 'marquee_text speed value must be greater than 0';
      }
      var duration = ((textWidth / (widget.speed * 1.72)) * 1000).floor();
      _showMarquee = true;
      _animationController.duration = Duration(milliseconds: duration);
      _animation = Tween(begin: constraintsWidth, end: -textWidth)
          .animate(_animationController)
            ..addStatusListener((status) {
              if (status == AnimationStatus.completed) {
                _animationController.repeat();
              }
            });
      _animationController.forward();
    }

    final textWidget = Text(
      widget.text,
      style: widget.textStyle,
      overflow: TextOverflow.visible,
      softWrap: false,
    );
    return _showMarquee
        ? AnimatedBuilder(
            builder: (context, myWidget) => Container(
              width: double.infinity,
              transform: Matrix4.translationValues(
                _animation.value,
                0.0,
                0.0,
              ),
              child: myWidget,
            ),
            animation: _animation,
            child: textWidget,
          )
        : textWidget;
  }
}
