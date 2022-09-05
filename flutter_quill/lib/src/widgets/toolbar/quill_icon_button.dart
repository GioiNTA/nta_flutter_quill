// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';

class QuillIconButton extends StatelessWidget {
  const QuillIconButton({
    required this.onPressed,
    this.icon,
    this.size = 40,
    this.fillColor,
    this.borderColor,
    this.hoverElevation = 1,
    this.highlightElevation = 1,
    this.borderRadius = 2,
    Key? key,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget? icon;
  final double size;
  final Color? fillColor;
  final Color? borderColor;
  final double hoverElevation;
  final double highlightElevation;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: size, height: size),
      child: RawMaterialButton(
        visualDensity: VisualDensity.compact,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor ?? Colors.transparent),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        fillColor: fillColor,
        // splashColor: Colors.transparent,
        // highlightColor: Colors.transparent,
        elevation: 0,
        hoverElevation: hoverElevation,
        highlightElevation: hoverElevation,
        onPressed: onPressed,
        child: icon,
      ),
    );
  }
}
