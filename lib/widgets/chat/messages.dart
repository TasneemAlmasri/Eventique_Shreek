import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/widgets/chat/messageBubble.dart';

class Messages extends StatelessWidget {
  final int userId;

  Messages(this.userId);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (chatSnapshot.hasError) {
          return Center(
            child: Text('An error occurred, please try again later.'),
          );
        }
        if (!chatSnapshot.hasData || chatSnapshot.data == null) {
          return Center(
            child: Text('No messages yet.'),
          );
        }
        final chatDocs = chatSnapshot.data!.docs;
        if (chatDocs.isEmpty) {
          return Center(
            child: Text('Start a new chat.'),
          );
        }
        return ListView.builder(
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (ctx, i) {
            final message = chatDocs[i];
            if (message['type'] == 'service') {
              return ListTile(
                title: Text('Service: ${message['service']}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Description: ${message['description']}'),
                    Text('Price: \$${message['price']}'),
                  ],
                ),
              );
            } else {
              return MessageBubble(
                message['text'],
                message['vendorName'],
                message['vendorImage'],
                message['vendorId'] == FirebaseAuth.instance.currentUser!.uid,
                key: ValueKey(chatDocs[i].id),
              );
            }
          },
        );
      },
    );
  }
}
