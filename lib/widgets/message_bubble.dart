import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubbles extends StatelessWidget {
  MessageBubbles(
      {Key? key,
      required this.message,
      required this.isMe,
      required this.userIds})
      : super(key: key);

  final String message;
  final bool isMe;
  final String userIds;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isMe
                ? Color.fromARGB(255, 60, 212, 250)
                : Theme.of(context).accentColor,
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
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(userIds)
                      .get(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError || snapshot.data == null) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return Text(
                      snapshot.data['username'],
                      style: TextStyle(
                          color: isMe
                              ? Colors.black
                              : Color.fromARGB(255, 255, 239, 239),
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    );
                  }),
              Text(
                message,
                style: TextStyle(
                  fontSize: 18,
                  color:
                      isMe ? Colors.black : Color.fromARGB(255, 255, 239, 239),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
