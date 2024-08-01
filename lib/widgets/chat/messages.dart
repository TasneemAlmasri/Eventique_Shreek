import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/widgets/chat/messageBubble.dart';

class Messages extends StatelessWidget {
  final int userId;

  Messages(this.userId);
  void _addToCart(DocumentSnapshot doc) {
    // Logic to add the service to the cart
  }
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
            if (chatDocs[i]['type'] == 'service') {
              return ListTile(
                title: Text('Service: ${chatDocs[i]['service']}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Description: ${chatDocs[i]['description']}'),
                    Text('Price: \$${chatDocs[i]['price']}'),
                    ElevatedButton(
                      onPressed: () {
                        _addToCart(chatDocs[i]);
                      },
                      child: Text('Add to Cart'),
                    ),
                  ],
                ),
              );
            } else {
              return MessageBubble(
                chatDocs[i]['text'],
                chatDocs[i]['vendorName'],
                chatDocs[i]['vendorImage'],
                chatDocs[i]['vendorId'] ==
                    FirebaseAuth.instance.currentUser!.uid,
                key: ValueKey(chatDocs[i].id),
              );
            }
          },
        );
      },
    );
  }
}
