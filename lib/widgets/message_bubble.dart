import 'package:flutter/material.dart';

class MessageBubbles extends StatelessWidget {
  MessageBubbles({Key? key, required this.message, required this.isMe})
      : super(key: key);

  final String message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isMe ? Colors.grey : Theme.of(context).accentColor,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(10),
              topRight: const Radius.circular(10),
              bottomLeft:
                  isMe ? const Radius.circular(10) : const Radius.circular(0),
              bottomRight:
                  !isMe ? const Radius.circular(10) : const Radius.circular(0),
            ),
          ),
          width: 140,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Text(
            message,
            style: TextStyle(
              color: isMe ? Colors.black : Color.fromARGB(255, 255, 239, 239),
            ),
          ),
        ),
      ],
    );
  }
}
