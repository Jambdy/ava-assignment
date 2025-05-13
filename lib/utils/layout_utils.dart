import 'dart:math';

import 'package:flutter/material.dart';

import '../constants/constants.dart';

class LayoutUtils {
  /// Returns the min of the screen width and configured max height.
  static double constrainedWidth(BuildContext context) {
    final screen = MediaQuery.of(context).size.width;
    return min(screen, Constants.widthMax);
  }
}
