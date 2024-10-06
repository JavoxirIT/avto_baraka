import 'package:flutter/material.dart';

class BottomLoader extends StatelessWidget {
  const BottomLoader({required this.children, super.key});

  final dynamic children;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 25,
        width: 25,
        child: children,
      ),
    );
  }
}
