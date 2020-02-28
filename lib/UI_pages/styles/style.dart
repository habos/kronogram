import 'package:flutter/material.dart';
import 'package:kronogram/UI_pages/values/values.dart';

// Style Font
//const double _fontSize = Fonts.font2Color;
const FontWeight _fontWeight = Fonts.font2Weight;
const String _fontFamily = Fonts.font2Family;
const FontStyle _fontStyle = Fonts.font2Style;

class StyleTextStyle extends TextStyle {
  const StyleTextStyle({
    Color color,
    //double fontSize = _fontSize,
    FontWeight fontWeight = _fontWeight,
    String fontFamily = _fontFamily,
    FontStyle fontStyle = _fontStyle,
    double height,
    double letterSpacing,
  }) : super(
          color: color,
          //fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: fontFamily,
        );
}

class Style extends StatelessWidget {
  const Style({
    Key key,
    this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const StyleTextStyle(),
      child: this.child,
    );
  }
}

class StyleButton extends StatelessWidget {
  const StyleButton({
    Key key,
    this.color,
    this.border = const BorderSide(),
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
    this.padding,
    @required this.onPressed,
    @required this.child,
  }) : super(key: key);

  final Color color;
  final BorderSide border;
  final BorderRadiusGeometry borderRadius;
  final EdgeInsets padding;
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: this.color,
      shape: RoundedRectangleBorder(
        side: this.border,
        borderRadius: this.borderRadius,
      ),
      onPressed: this.onPressed,
      child: DefaultTextStyle(
        style: const StyleTextStyle(),
        child: this.child,
      ),
    );
  }
}

class StyleSwitch extends StatelessWidget {
  const StyleSwitch({
    Key key,
    @required this.value,
    @required this.onChanged,
    this.activeColor,
  }) : super(key: key);
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(
      value: this.value,
      onChanged: this.onChanged,
      activeColor: this.activeColor,
    );
  }
}

class StyleSlider extends StatelessWidget {
  const StyleSlider({
    Key key,
    @required this.value,
    @required this.onChanged,
    this.inactiveColor,
    this.activeColor,
    this.min,
    this.max,
  }) : super(key: key);
  final double value;
  final ValueChanged<double> onChanged;
  final Color inactiveColor;
  final Color activeColor;
  final double min;
  final double max;

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: this.value,
      onChanged: this.onChanged,
      activeColor: this.activeColor,
    );
  }
}

class StyleCircularProgressIndicator extends StatelessWidget {
  const StyleCircularProgressIndicator({
    Key key,
    this.color,
  }) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(this.color),
    );
  }
}

class StyleLinearProgressIndicator extends StatelessWidget {
  const StyleLinearProgressIndicator({
    Key key,
    this.color,
  }) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(this.color),
    );
  }
}
