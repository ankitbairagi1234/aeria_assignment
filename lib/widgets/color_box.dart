import 'package:flutter/material.dart';
import '../logic/box_controller.dart';

class ColorBox extends StatelessWidget {
  final int index;
  final BoxController controller;
  final VoidCallback onChange;

  const ColorBox({
    super.key,
    required this.index,
    required this.controller,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.handleTap(index, onChange);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.all(4),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: controller.boxColors[index],
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
