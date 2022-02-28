import 'package:chat_app/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  Messages({Key? key}) : super(key: key);
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    var userId = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      stream: _store
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.data!.docs.isEmpty || snapshot.hasError) {
          return const Center(
            child: Text('No data found'),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          reverse: true,
          itemBuilder: (context, index) {
            return MessageBubbles(
              message: snapshot.data!.docs[index]['message'],
              isMe: userId!.uid == snapshot.data!.docs[index]['userId'],
              userIds: snapshot.data!.docs[index]['userId'],
            );
          },
        );
      },
    );
  }
}
