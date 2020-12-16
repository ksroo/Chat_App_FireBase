import 'package:chat_chat_chat/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, snapShot) {
        if (snapShot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        final docs = snapShot.data.docs;
        final user = FirebaseAuth.instance.currentUser;

        return ListView.builder(
          reverse: true,
          itemCount: docs.length,
          itemBuilder: (context, index) {
            return MessageBubble(
              docs[index]['text'],
              docs[index]['username'],
              docs[index]['userId'] == user.uid,
              key: ValueKey(docs[index].documentID),
            );
          },
        );
      },
    );
  }
}
