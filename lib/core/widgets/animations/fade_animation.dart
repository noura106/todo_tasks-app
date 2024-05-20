import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget? child;
  final FadeDirection fadeDirection;

  const FadeAnimation(
      {Key? key,
        this.delay = 1,
        this.child,
        this.fadeDirection = FadeDirection.right})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tween = MovieTween()
      ..tween(AniProps.opacity, Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 500))
      ..tween(AniProps.translateY, Tween(begin: -30.0, end: 0.0),
          duration:   const Duration(milliseconds: 500), curve:Curves.easeOut);

    return PlayAnimationBuilder<Movie>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, value, _) => Opacity(
        opacity: value.get(AniProps.opacity),
        child: Transform.translate(
            offset: Offset(
              (fadeDirection == FadeDirection.top ||
                  fadeDirection == FadeDirection.bottom)
                  ? 0
                  : value.get(AniProps.translateY) *
                  (fadeDirection == FadeDirection.left ? -1 : 1),
              (fadeDirection == FadeDirection.left ||
                  fadeDirection == FadeDirection.right)
                  ? 0
                  : value.get(AniProps.translateY) *
                  (fadeDirection == FadeDirection.top ? -1 : 1),
            ),
            child: child),
      ),
    );
  }
}

enum FadeDirection { top, bottom, right, left }

enum AniProps { opacity, translateY }
