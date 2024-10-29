import 'package:flutter/material.dart';

enum MessageType { ok, danger, warning, failed }

class MessageDialog extends StatelessWidget {
  final String content;
  final String messageType;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  const MessageDialog({
    super.key,
    required this.content,
    required this.messageType,
    this.onConfirm,
    this.onCancel,
  });

  Color setConfirmBtnColor() {
    if (messageType == "danger") {
      return Colors.red;
    } else {
      return const Color.fromRGBO(16, 80, 176, 1.0);
    }
  }

  String messageIcon() {
    String iconPath = "assets/icon2/";
    switch (messageType) {
      case "ok":
        iconPath += "correct.png";
        break;
      case "danger":
        iconPath += "error.png";
        break;
      case "warning":
        iconPath += "warning.png";
        break;
      default:
        iconPath += "remove.png";
    }
    return iconPath;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.info_rounded),
          SizedBox(
            width: 8,
          ),
          Text("Notification")
        ],
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
              child: Image.asset(
            messageIcon(),
            fit: BoxFit.contain,
            width: 80,
          )),
          const SizedBox(
            height: 16,
          ),
          Flexible(
            child: Text(
              content,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          )
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (onCancel != null)
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red)),
                onPressed: onCancel,
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(
              width: 12,
            ),
            if (onConfirm != null)
              FilledButton(
                style: FilledButton.styleFrom(
                    backgroundColor: setConfirmBtnColor()),
                onPressed: onConfirm,
                child: const Text('Confirm'),
              ),
          ],
        )
      ],
    );
  }
}
