// import 'package:flutter/material.dart';
// import 'package:simple_animations/simple_animations.dart';

// class AnimationHandler {
//   Widget popUp(Widget child, Curve curve, double delay, {int duration}) {
//     int d = 1000;
//     if (duration != null) {
//       d = duration;
//     }
//     final tween = MultiTween([
//       Track("scale").add(Duration(milliseconds: d), Tween(begin: 0.0, end: 1.0),
//           curve: curve),
//       Track("opacity")
//           .add(Duration(milliseconds: d), Tween(begin: 0.5, end: 1.0))
//     ]);

//     return ControlledAnimation(
//       delay: Duration(milliseconds: (delay).round()),
//       duration: tween.duration,
//       tween: tween,
//       child: child,
//       builderWithChild: (context, child, animation) => Opacity(
//         opacity: animation["opacity"],
//         child: Transform.scale(scale: animation["scale"], child: child),
//       ),
//     );
//   }

//   Widget scalePop(Widget child, Curve curve, double delay, {int duration}) {
//     int d = 1000;
//     if (duration != null) {
//       d = duration;
//     }
//     final tween = MultiTrackTween([
//       Track("scale").add(Duration(milliseconds: d), Tween(begin: 0.0, end: 1.0),
//           curve: curve),
//     ]);

//     return ControlledAnimation(
//       delay: Duration(milliseconds: (delay).round()),
//       duration: tween.duration,
//       tween: tween,
//       child: child,
//       builderWithChild: (context, child, animation) =>
//           Transform.scale(scale: animation["scale"], child: child),
//     );
//   }

//   Widget translateFromLeft(Widget child, Curve curve, double delay) {
//     final tween = MultiTrackTween([
//       Track("translateX").add(
//           Duration(milliseconds: 250), Tween(begin: 230.0, end: 0.0),
//           curve: curve),
//       Track("opacity")
//           .add(Duration(milliseconds: 250), Tween(begin: 0.5, end: 1.0))
//     ]);

//     return ControlledAnimation(
//       delay: Duration(milliseconds: (300 * delay).round()),
//       duration: tween.duration,
//       tween: tween,
//       child: child,
//       builderWithChild: (context, child, animation) => Opacity(
//         opacity: animation["opacity"],
//         child: Transform.translate(
//             offset: Offset(-animation["translateX"], 0.0), child: child),
//       ),
//     );
//   }

//   Widget translateToLeft(Widget child, Curve curve, double delay) {
//     final tween = MultiTrackTween([
//       Track("translateX").add(
//           Duration(milliseconds: 500), Tween(begin: 0.0, end: 130.0),
//           curve: curve),
//       Track("opacity")
//           .add(Duration(milliseconds: 500), Tween(begin: 1.0, end: 0.5))
//     ]);

//     return ControlledAnimation(
//       delay: Duration(milliseconds: (300 * delay).round()),
//       duration: tween.duration,
//       tween: tween,
//       child: child,
//       builderWithChild: (context, child, animation) => Opacity(
//         opacity: animation["opacity"],
//         child: Transform.translate(
//             offset: Offset(-animation["translateX"], 0.0), child: child),
//       ),
//     );
//   }

//   Widget translateFromRight(Widget child, Curve curve, double delay,
//       {int duration}) {
//     int durationTranslate = 1000;
//     int durationOpacity = 500;
//     if (duration != null) {
//       durationTranslate = duration;
//       durationOpacity = duration ~/ 2;
//     }
//     final tween = MultiTrackTween([
//       Track("translateX").add(Duration(milliseconds: durationTranslate),
//           Tween(begin: -430.0, end: 0.0),
//           curve: curve),
//       Track("opacity").add(
//           Duration(milliseconds: durationOpacity), Tween(begin: 0.5, end: 1.0))
//     ]);

//     return ControlledAnimation(
//       delay: Duration(milliseconds: (delay).round()),
//       duration: tween.duration,
//       tween: tween,
//       child: child,
//       builderWithChild: (context, child, animation) => Opacity(
//         opacity: animation["opacity"],
//         child: Transform.translate(
//             offset: Offset(-animation["translateX"], 0.0), child: child),
//       ),
//     );
//   }

//   Widget translateFromBottom(Widget child, Curve curve, double delay,
//       {int duration, bool withOpacity, double fromDownUnder}) {
//     withOpacity = withOpacity == null ? true : withOpacity;
//     fromDownUnder = fromDownUnder == null ? -430 : fromDownUnder;
//     int durationTranslate = 1000;
//     int durationOpacity = 500;
//     if (duration != null) {
//       durationTranslate = duration;
//       durationOpacity = duration ~/ 2;
//     }
//     final tween = MultiTrackTween([
//       Track("translateY").add(Duration(milliseconds: durationTranslate),
//           Tween(begin: fromDownUnder, end: 0.0),
//           curve: curve),
//       Track("opacity").add(Duration(milliseconds: durationOpacity),
//           Tween(begin: withOpacity ? 0.5 : 1.0, end: 1.0))
//     ]);

//     return ControlledAnimation(
//       delay: Duration(milliseconds: (delay).round()),
//       duration: tween.duration,
//       tween: tween,
//       child: child,
//       builderWithChild: (context, child, animation) => Opacity(
//         opacity: animation["opacity"],
//         child: Transform.translate(
//             offset: Offset(0.0, -animation["translateY"]), child: child),
//       ),
//     );
//   }

//   Widget scaleFromRight(Widget child, Curve curve, double delay,
//       {int duration}) {
//     int durationScale = 1000;
//     if (duration != null) {
//       durationScale = duration;
//     }
//     final tween = MultiTrackTween([
//       Track("scaleX").add(
//           Duration(milliseconds: durationScale), Tween(begin: 0.0, end: 1.0),
//           curve: curve),
//     ]);

//     return ControlledAnimation(
//       delay: Duration(milliseconds: (delay).round()),
//       duration: tween.duration,
//       tween: tween,
//       child: child,
//       builderWithChild: (context, child, animation) => Transform.scale(
//         child: child,
//         scale: animation["scaleX"],
//         alignment: Alignment.centerRight,
//       ),
//     );
//   }
// }
