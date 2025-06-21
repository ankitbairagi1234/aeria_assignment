import 'dart:async';
import 'package:flutter/material.dart';

class BoxController {
  List<Color> boxColors = [];
  List<int> tapOrder = [];
  bool isAnimatingBack = false;

  void initializeBoxes(int n) {
    boxColors = List.generate(n, (_) => Colors.red);
    tapOrder.clear();
    isAnimatingBack = false;
  }

  void handleTap(int index, VoidCallback updateState) {
    if (boxColors[index] == Colors.green || isAnimatingBack) return;
    boxColors[index] = Colors.green;
    tapOrder.add(index);

    if (tapOrder.length == boxColors.length) {
      _startReverseAnimation(updateState);
    }
  }

  void _startReverseAnimation(VoidCallback updateState) {
    isAnimatingBack = true;
    int i = tapOrder.length - 1;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (i < 0) {
        timer.cancel();
        tapOrder.clear();
        isAnimatingBack = false;
        updateState();
        return;
      }
      boxColors[tapOrder[i]] = Colors.red;
      i--;
      updateState();
    });
  }
}
