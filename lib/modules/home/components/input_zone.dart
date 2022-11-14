import 'package:flutter/material.dart';

class InputZone extends StatelessWidget {
  const InputZone({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          DropdownButton(items: [], onChanged: (value) {}),
          ElevatedButton(onPressed: () {}, child: const Text("Send")),
        ],
      ),
    );
  }
}
