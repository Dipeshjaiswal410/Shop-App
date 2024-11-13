// Screen Clipper Part

import 'package:flutter/material.dart';

class MountainCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Start at the top left corner
    path.lineTo(0, 0);

    // Go down to the bottom left corner
    path.lineTo(0, size.height - 150);

    // First curve - slight curve upwards
    path.quadraticBezierTo(
      size.width * 0.25, size.height - 50, // Lower control point
      size.width * 0.5, size.height - 100, // Midpoint for smoother rise
    );

    // Adjusted curve to make it less steep
    path.quadraticBezierTo(
      size.width * 0.7, size.height - 140, // Lower control point to flatten
      size.width - 150, size.height - 40, // End of curve on the bottom right
    );

    // Final curve with a gentle slope
    path.quadraticBezierTo(
      size.width * 0.95, size.height - 220, // Final control point
      size.width, size.height - 150, // Final endpoint
    );

    // Go up to the top right corner
    path.lineTo(size.width, 0);

    // Close the path
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
