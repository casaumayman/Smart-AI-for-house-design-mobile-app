import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyStep extends StatelessWidget {
  final String stepLabel;
  final int stepNum;
  final Widget child;

  const MyStep(
      {super.key,
      required this.stepLabel,
      required this.stepNum,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          Text(
            // "Step $stepNum.",
            "step_dynamic".trParams({"step": stepNum.toString()}),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(stepLabel),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      child,
      const SizedBox(
        height: 20,
      )
    ]);
  }
}
