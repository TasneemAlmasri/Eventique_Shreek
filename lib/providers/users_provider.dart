import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventique_company_app/models/user_model.dart';
import 'package:flutter/foundation.dart';

class UsersProvider with ChangeNotifier {
  List<OneUser> _users = [];

  List<OneUser> get users => _users;

  OneUser findById(int id) {
    return _users.firstWhere((user) => user.id == id);
  }

  void fetchUsersForVendor(String vendorId) {
    // Set up a snapshot listener for the 'chats' collection
    FirebaseFirestore.instance.collection('chats').snapshots().listen(
      (chatsSnapshot) async {
        try {
          final List<OneUser> loadedUsers = [];
          final userSet = <String>{}; // To track unique user IDs

          // Log before processing data
          print('Processing chats from Firestore for vendorId: $vendorId');

          if (chatsSnapshot.docs.isEmpty) {
            print('No chat documents found.');
          } else {
            print('Fetched ${chatsSnapshot.docs.length} chat documents');
          }

          for (var chat in chatsSnapshot.docs) {
            print('Processing chat document with ID: ${chat.id}');

            // Extract userId and vendorId from document ID
            final parts = chat.id.split('_');
            if (parts.length != 2) {
              print('Invalid document ID format: ${chat.id}');
              continue;
            }

            final chatUserId = parts[0];
            final chatVendorId = parts[1];

            print(
                'Extracted chatUserId: $chatUserId, chatVendorId: $chatVendorId');

            // Check if the vendorId matches
            if (chatVendorId == vendorId) {
              print('Vendor ID matches! Fetching messages for this chat.');

              // Fetch messages for this chat document
              final messagesSnapshot =
                  await chat.reference.collection('messages').get();

              if (messagesSnapshot.docs.isEmpty) {
                print('No messages found in this chat.');
              } else {
                print('Fetched ${messagesSnapshot.docs.length} messages.');
              }

              for (var message in messagesSnapshot.docs) {
                final userId = message['userId'];
                final userName = message['userName'];
                final userImage = message['userImage'];

                print('Message from userId: $userId, userName: $userName');

                // Only add unique users
                if (!userSet.contains(userId)) {
                  userSet.add(userId);
                  loadedUsers.add(
                    OneUser(
                      id: int.tryParse(userId) ?? 0, // Ensure ID is an integer
                      name: userName,
                      imageUrl: userImage,
                    ),
                  );
                }
              }
            } else {
              print('Vendor ID does not match. Skipping chat.');
            }
          }

          // Update the list of loaded users and notify listeners
          _users = loadedUsers;
          print('Loaded users: ${_users.length}');
          notifyListeners();
        } catch (error) {
          print("Error processing users: $error");
          throw (error);
        }
      },
      onError: (error) {
        print("Error listening to chat documents: $error");
      },
    );
  }
}
