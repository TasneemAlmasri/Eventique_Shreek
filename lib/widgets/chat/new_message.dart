import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventique_company_app/widgets/chat/create_customized_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/color.dart';

class NewMessage extends StatefulWidget {
  final int userId;

  NewMessage(this.userId);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  var _enteredMessage = '';

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final vendor = FirebaseAuth.instance.currentUser;
    final vendorData = await FirebaseFirestore.instance
        .collection('vendors')
        .doc(vendor!.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add(
      {
        'text': _enteredMessage,
        'createdAt': Timestamp.now(),
        'vendorId': vendor.uid,
        'vendorName': vendorData['username'],
        'vendorImage': vendorData['image_url'],
        'userId': widget.userId, // Add vendorId to message
      },
    );
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(vertical: 18),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CreateCustomizedService(widget.userId);
                },
              );
            },
            icon: Icon(
              Icons.add_box_rounded,
              color: primary,
            ),
            iconSize: 36,
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Send a message ...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
            icon: Icon(
              Icons.send,
            ),
            color: primary,
            iconSize: 30,
          ),
        ],
      ),
    );
  }
}
