// import 'package:flutter/material.dart';
// import 'package:eventique_company_app/models/user_model.dart';

// class UsersProvider with ChangeNotifier {
//   List<OneUser> users = [
//     OneUser(
//       id: 0,
//       name: 'taghreed',
//       email: 'taghreedswidah9@gmail.com',
//       imageUrl: '',
//     ),
//     OneUser(
//       id: 1,
//       name: 'tasneem',
//       email: 'tasneem.masri@gmail.com',
//       imageUrl: '',
//     )
//   ];

//   List<OneUser> get usersList {
//     return [...users];
//   }

//   OneUser findById(int id) {
//     return users.firstWhere((vendor) => vendor.id == id);
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventique_company_app/models/user_model.dart';
import 'package:flutter/foundation.dart';

class UsersProvider with ChangeNotifier {
  List<OneUser> _users = [];

  List<OneUser> get users => _users;

  OneUser findById(int id) {
    return _users.firstWhere((user) => user.id == id);
  }

  Future<void> fetchUsersForVendor(String vendorId) async {
    try {
      // Fetch all chat messages where the receiverId is the current vendor
      final chatSnapshot = await FirebaseFirestore.instance
          .collection('chats')
          .where('receiverId', isEqualTo: vendorId)
          .get();

      // Extract unique sender IDs from chat messages
      final senderIds = chatSnapshot.docs.map((doc) => doc['senderId']).toSet();

      // Fetch user details for those sender IDs
      final userSnapshots = await Future.wait(senderIds.map((id) =>
          FirebaseFirestore.instance.collection('users').doc(id).get()));

      _users = userSnapshots
          .where((doc) => doc.exists)
          .map((doc) => OneUser.fromFirestore(doc))
          .toList();

      notifyListeners();
    } catch (error) {
      print("Error fetching users: $error");
    }
  }
}
