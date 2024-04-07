import 'package:avto_baraka/style/colors.dart';
import 'package:flutter/material.dart';

class Grabber extends StatelessWidget {
  const Grabber({
    super.key,
    required this.onVerticalDragUpdate,
    required this.isOnDesktopAndWeb,
  });

  final ValueChanged<DragUpdateDetails> onVerticalDragUpdate;
  final bool isOnDesktopAndWeb;

  @override
  Widget build(BuildContext context) {
    if (!isOnDesktopAndWeb) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onVerticalDragUpdate: onVerticalDragUpdate,
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            width: 38.0,
            height: 6.0,
            decoration: BoxDecoration(
              color: iconSelectedColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ),
    );
  }
}




// Grabber(
//                         onVerticalDragUpdate: (DragUpdateDetails details) {
//                           setState(() {
//                             _sheetPosition -=
//                                 details.delta.dy / _dragSensitivity;
//                             if (_sheetPosition < 0.67) {
//                               _sheetPosition = 0.67;
//                             }
//                             if (_sheetPosition > 0.96) {
//                               _sheetPosition = 0.96;
//                             }
//                           });
//                         },
//                         isOnDesktopAndWeb: _isOnDesktopAndWeb,
//                       ),



  // double _sheetPosition = 0.75;
  // final double _dragSensitivity = 900;