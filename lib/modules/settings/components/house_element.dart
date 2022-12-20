import 'package:flutter/material.dart';

class HouseElement extends StatelessWidget {
  const HouseElement(
      {super.key, required this.elementName, required this.color, this.onTap});
  final String elementName;
  final Color color;
  final Function()? onTap;

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
          InkWell(
            onTap: onTap,
            child: Container(
              width: 50,
              height: 50,
              color: color,
            ),
          )
        ],
      ),
    );
  }
}
