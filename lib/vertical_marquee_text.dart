library marquee_text;

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:marquee_text/marquee_direction.dart';

class VerticalMarqueeText extends StatelessWidget {
  final InlineSpan text;
  final TextStyle? style;

  /// default 50
  /// Must be greater than 0.
  final double speed;

  /// Always scroll and ignore text length.
  final bool alwaysScroll;

  final TextDirection textDirection;

  /// default btt
  final MarqueeDirection marqueeDirection;

  final TextAlign? textAlign;

  const VerticalMarqueeText({
    Key? key,
    required this.text,
    this.style,
    this.speed = 50,
    this.alwaysScroll = false,
    this.textDirection = TextDirection.ltr,
    this.marqueeDirection = MarqueeDirection.rtl,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      /// Remove color will cause parent widget's onTap to not work
      color: Colors.transparent,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) => ClipPath(
          child: _MarqueeContainer(
            text: text,
            textStyle: style,
            constraints: constraints,
            speed: speed,
            alwaysScroll: alwaysScroll,
            textDirection: textDirection,
            marqueeDirection: marqueeDirection,
            textAlign: textAlign ?? TextAlign.start,
          ),
        ),
      ),
    );
  }
}

class _MarqueeContainer extends StatefulWidget {
  final InlineSpan text;
  final TextStyle? textStyle;
  final double speed;
  final BoxConstraints constraints;
  final bool alwaysScroll;
  final TextDirection textDirection;
  final MarqueeDirection marqueeDirection;
  final TextAlign textAlign;

  const _MarqueeContainer({
    Key? key,
    required this.text,
    this.textStyle,
    required this.constraints,
    required this.speed,
    required this.alwaysScroll,
    required this.textDirection,
    required this.marqueeDirection,
    required this.textAlign,
  }) : super(key: key);

  @override
  _MarqueeContainerState createState() => _MarqueeContainerState();
}

class _MarqueeContainerState extends State<_MarqueeContainer>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;
  bool _showMarquee = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final renderParagraph = RenderParagraph(
      widget.text,
      softWrap: true,
      textDirection: widget.textDirection,
      textAlign: widget.textAlign,
    );
    renderParagraph.layout(widget.constraints);
    var textHeight = renderParagraph.textSize.height;
    var constraintsHeight = renderParagraph.constraints.maxHeight;
    _showMarquee = textHeight > constraintsHeight || widget.alwaysScroll;
    var tweenList = [constraintsHeight, -textHeight];
    if (_showMarquee) {
      if (widget.speed <= 0) {
        throw 'marquee_text speed value must be greater than 0';
      }
      var duration = ((textHeight / (widget.speed * 1.72)) * 1000).floor();
      _showMarquee = true;
      _animationController.duration = Duration(milliseconds: duration);
      _animation = Tween(
        begin: tweenList[widget.marqueeDirection.index - 2],
        end: tweenList[3 - widget.marqueeDirection.index],
      ).animate(_animationController)
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            _animationController.repeat();
          }
        });
      _animationController.forward();
    }

    final textWidget = Text.rich(
      widget.text,
      style: widget.textStyle,
      overflow: TextOverflow.visible,
      softWrap: false,
      textDirection: widget.textDirection,
      textAlign: widget.textAlign,
    );
    return _showMarquee
        ? AnimatedBuilder(
            builder: (context, myWidget) => Container(
              width: double.infinity,
              transform: Matrix4.translationValues(
                0.0,
                _animation.value,
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
