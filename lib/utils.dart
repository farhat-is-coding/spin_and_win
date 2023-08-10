import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

final items = [
  'https://upload.wikimedia.org/wikipedia/commons/5/59/Empty.png?20091205084734',
  'https://clipart-library.com/img1/1241297.png',
  'https://static.vecteezy.com/system/resources/previews/016/765/289/original/french-fries-fast-food-cartoon-png.png',
  'https://clipart-library.com/img1/1241297.png',
  'https://cdn-icons-png.flaticon.com/512/3075/3075627.png',
  'https://clipart-library.com/img1/1241297.png',
  'https://static.vecteezy.com/system/resources/previews/016/765/289/original/french-fries-fast-food-cartoon-png.png',
  'https://clipart-library.com/img1/1241297.png',
];

List<FortuneItem> getWheelData() {
  List<FortuneItem> fortuneItems = [];
  for (var index = 0; index < items.length; index++) {
    Color fillColor;
    if (index % 2 == 0) {
      fillColor = const Color(0xff6CA082);
    } else {
      fillColor = const Color(0xffA3C4A0);
    }

    var fortuneItem = FortuneItem(
      style: FortuneItemStyle(
        color: fillColor,
        borderColor: const Color(0xff426651),
        borderWidth: 12,
      ),
      child: Transform.rotate(
        origin: const Offset(12, 12),
        angle: 90 * (3.14159265359 / 180), // 90 degrees in radians
        child: Image.network(
          items[index],
          width: 80,
          fit: BoxFit.cover,
        ),
      ),
    );

    fortuneItems.add(fortuneItem);
  }
  return fortuneItems;
}

String getItem(idx) {
  if (idx == 0) {
    return 'Nothing';
  }
  if (idx == 1) {
    return 'Burger';
  }
  if (idx == 2) {
    return 'French Fries';
  }
  if (idx == 3) {
    return 'Burger';
  }
  if (idx == 4) {
    return 'Soda';
  }
  if (idx == 5) {
    return 'Burger';
  }
  if (idx == 6) {
    return 'French Fries';
  }
  if (idx == 7) {
    return 'Burger';
  }
  return '';
}

/// A custom Path to paint stars.
Path drawStar(Size size) {
  // Method to convert degree to radians
  double degToRad(double deg) => deg * (pi / 180.0);

  const numberOfPoints = 5;
  final halfWidth = size.width / 2;
  final externalRadius = halfWidth;
  final internalRadius = halfWidth / 2.5;
  final degreesPerStep = degToRad(360 / numberOfPoints);
  final halfDegreesPerStep = degreesPerStep / 2;
  final path = Path();
  final fullAngle = degToRad(360);
  path.moveTo(size.width, halfWidth);

  for (double step = 0; step < fullAngle; step += degreesPerStep) {
    path.lineTo(halfWidth + externalRadius * cos(step),
        halfWidth + externalRadius * sin(step));
    path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
        halfWidth + internalRadius * sin(step + halfDegreesPerStep));
  }
  path.close();
  return path;
}
