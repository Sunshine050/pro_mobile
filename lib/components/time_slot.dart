import 'package:flutter/material.dart';

class TimeSlot extends StatelessWidget {
  final String time, status;

  const TimeSlot({super.key, required this.time, required this.status});

  Color slotColor() {
    Color slotColor;
    if (status == "free") {
      slotColor = Color.fromRGBO(16, 80, 176, 1);
    } else if (status == "reserved") {
      slotColor = Color.fromRGBO(219, 34, 20, 1);
    } else if (status == "pending") {
      slotColor = Color.fromRGBO(255, 193, 7, 1);
    } else {
      slotColor = Color.fromRGBO(202, 196, 208, 1);
    }
    return slotColor;
  }

  String slotIcon() {
    String iconPath;
    if (status == "free") {
      iconPath = 'assets/icon2/check_white.png';
    } else if (status == "reserved") {
      iconPath = 'assets/icon2/user-profile_white.png';
    } else if (status == "pending") {
      iconPath = 'assets/icon2/hour-white.png';
    } else {
      iconPath = 'assets/icon2/close2_white.png';
    }
    return iconPath;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
      decoration: BoxDecoration(
          color: slotColor(), borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            time,
            style: const TextStyle(color: Colors.white),
          ),
          Flexible(
              child: Image.asset(
            slotIcon(),
            fit: BoxFit.contain,
            width: 16,
          ))
        ],
      ),
    );
  }
}
