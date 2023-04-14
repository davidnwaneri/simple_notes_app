part of 'app_reusable_text_field.dart';

// Cc: {https://stackoverflow.com/questions/71621132/how-to-make-the-floating-label-stay-within-the-border}

class CustomOutlineInputBorder extends InputBorder {
  /// Creates an underline border for an [InputDecorator].
  ///
  /// The [borderSide] parameter defaults to [BorderSide.none] (it must not be
  /// null). Applications typically do not specify a [borderSide] parameter
  /// because the input decorator substitutes its own, using [copyWith], based
  /// on the current theme and [InputDecorator.isFocused].
  ///
  /// The [borderRadius] parameter defaults to a value where the top left
  /// and right corners have a circular radius of 4.0. The [borderRadius]
  /// parameter must not be null.
  const CustomOutlineInputBorder({
    super.borderSide = const BorderSide(),
    this.borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(4),
      topRight: Radius.circular(4),
      bottomLeft: Radius.circular(4),
      bottomRight: Radius.circular(4),
    ),
  });

  /// The radii of the border's rounded rectangle corners.
  ///
  /// When this border is used with a filled input decorator, see
  /// [InputDecoration.filled], the border radius defines the shape
  /// of the background fill as well as the bottom left and right
  /// edges of the underline itself.
  ///
  /// By default the top right and top left corners have a circular radius
  /// of 4.0.
  final BorderRadius borderRadius;

  @override
  bool get isOutline => false;

  @override
  CustomOutlineInputBorder copyWith({
    BorderSide? borderSide,
    BorderRadius? borderRadius,
  }) {
    return CustomOutlineInputBorder(
      borderSide: borderSide ?? this.borderSide,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.only(bottom: borderSide.width);
  }

  @override
  CustomOutlineInputBorder scale(double t) {
    return CustomOutlineInputBorder(borderSide: borderSide.scale(t));
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRect(
        Rect.fromLTWH(
          rect.left,
          rect.top,
          rect.width,
          math.max(0, rect.height - borderSide.width),
        ),
      );
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRRect(borderRadius.resolve(textDirection).toRRect(rect));
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is CustomOutlineInputBorder) {
      return CustomOutlineInputBorder(
        borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
        borderRadius: BorderRadius.lerp(a.borderRadius, borderRadius, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is CustomOutlineInputBorder) {
      return CustomOutlineInputBorder(
        borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
        borderRadius: BorderRadius.lerp(borderRadius, b.borderRadius, t)!,
      );
    }
    return super.lerpTo(b, t);
  }

  /// Draw a horizontal line at the bottom of [rect].
  ///
  /// The [borderSide] defines the line's color and weight. The `textDirection`
  /// `gap` and `textDirection` parameters are ignored.
  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double? gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection? textDirection,
  }) {
    final paint = borderSide.toPaint();
    final outer = borderRadius.toRRect(rect);
    final center = outer.deflate(borderSide.width / 2.0);
    canvas.drawRRect(center, paint);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is InputBorder && other.borderSide == borderSide;
  }

  @override
  int get hashCode => borderSide.hashCode;
}
