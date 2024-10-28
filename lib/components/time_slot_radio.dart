import 'package:flutter/material.dart';

class TimeSlotRadio extends StatelessWidget {
  final String time, status;

  const TimeSlotRadio({super.key, required this.time, required this.status});

  Color slotBorderColor() {
    if (status == "free") {
      return const Color.fromRGBO(16, 80, 176, 1);
    } else {
      return const Color.fromRGBO(202, 196, 208, 1);
    }
  }

  Color textColor() {
    if (status == "free") {
      return Colors.black;
    } else {
      return const Color.fromRGBO(202, 196, 208, 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: slotBorderColor(), width: 1.5),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(time,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: textColor())),
        ],
      ),
    );
  }
}
