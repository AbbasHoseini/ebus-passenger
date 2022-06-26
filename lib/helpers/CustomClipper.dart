import 'package:flutter/material.dart';

@immutable
class ClipShadowPath extends StatelessWidget {
  final Shadow ?shadow;
  final CustomClipper<Path>? clipper;
  final Widget? child;

  ClipShadowPath({
    @required this.shadow,
    @required this.clipper,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ClipShadowShadowPainter(
        clipper: this.clipper!,
        shadow: this.shadow!,
      ),
      child: ClipPath(child: child, clipper: this.clipper),
    );
  }
}

class _ClipShadowShadowPainter extends CustomPainter {
  final Shadow? shadow;
  final CustomClipper<Path>? clipper;

  _ClipShadowShadowPainter({@required this.shadow, @required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow!.toPaint();
    var clipPath = clipper!.getClip(size).shift(shadow!.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class TransactionItemClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    double cs = 10;
    double cl = 10;
    double nh = size.height / 2.3;
    double nw = 15;
    double a = 20;

    int count = 31;
    double sw = size.width / count;
    double sh = 10;

    path.moveTo(0.0 + cl, 0.0);
    path.lineTo(size.width - cs, 0.0);
    path.lineTo(size.width, 0.0 + cs);
    // path.lineTo(size.width, size.height - nh);
    // path.lineTo(size.width - nw, size.height - nh + (a / 2));
    // path.lineTo(size.width, size.height - nh + (a));

    path.lineTo(size.width, size.height);

    for (var i = 0; i <= count; i++) {
      path.lineTo(size.width - (sw * i), size.height - (sh * (i % 2)));
    }

    path.lineTo(0.0 + cs, size.height);

    path.lineTo(0.0, size.height - cs);
    // path.lineTo(0.0, size.height - nh + (a));
    // path.lineTo(0.0 + nw, size.height - nh + (a / 2));
    // path.lineTo(0.0, size.height - nh);
    path.lineTo(0.0, 0.0 + cl);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}
