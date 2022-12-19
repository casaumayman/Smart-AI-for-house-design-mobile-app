import 'package:flutter/material.dart';

class HouseElement extends StatelessWidget {
  const HouseElement({super.key, required this.elementName});
  final String elementName;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black)),
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(elementName),
          const SizedBox(
            width: 5,
          ),
          const Placeholder(
            fallbackWidth: 50,
            fallbackHeight: 50,
          )
        ],
      ),
    );
  }
}
