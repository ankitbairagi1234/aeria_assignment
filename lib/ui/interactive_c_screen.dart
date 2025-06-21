import 'package:flutter/material.dart';
import '../logic/box_controller.dart';
import '../widgets/color_box.dart';

class InteractiveCScreen extends StatefulWidget {
  const InteractiveCScreen({super.key});

  @override
  State<InteractiveCScreen> createState() => _InteractiveCScreenState();
}

class _InteractiveCScreenState extends State<InteractiveCScreen> {
  final TextEditingController _controller = TextEditingController();
  final BoxController _boxController = BoxController();

  void _generateBoxes() {
    final n = int.tryParse(_controller.text);
    if (n == null || n < 5 || n > 25) return;
    setState(() => _boxController.initializeBoxes(n));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Interactive C Box Layout')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: 'Enter N (5-25)'),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _generateBoxes,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 4,
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildCShape(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCShape(BuildContext context) {
    final total = _boxController.boxColors.length;
    if (total == 0) return [];

    int topCount = (total / 4).ceil().clamp(1, total);         // top row
    int bottomCount = topCount;                                // bottom row
    int sideCount = total - topCount - bottomCount;            // vertical side

    List<Widget> top = List.generate(topCount,
            (i) => ColorBox(index: i, controller: _boxController, onChange: _refresh));
    List<Widget> side = List.generate(sideCount,
            (i) => ColorBox(index: i + topCount, controller: _boxController, onChange: _refresh));
    List<Widget> bottom = List.generate(bottomCount,
            (i) => ColorBox(index: i + topCount + sideCount, controller: _boxController, onChange: _refresh));

    return [
      SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: top)),
      Column(children: side.map((box) => Row(children: [box])).toList()),
      SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: bottom)),
    ];
  }


  void _refresh() => setState(() {});
}
