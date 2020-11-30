import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformIcon extends StatelessWidget {
  final IconData cupertinoIcon;
  final IconData materialIcon;
  final double size;
  final Color color;

  const PlatformIcon(
      {Key key,
      @required this.cupertinoIcon,
      @required this.materialIcon,
      this.size,
      this.color = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return Icon(
        cupertinoIcon,
        size: size,
        color: color,
      );
    } else {
      return Icon(
        materialIcon,
        size: size,
        color: color,
      );
    }
  }
}
