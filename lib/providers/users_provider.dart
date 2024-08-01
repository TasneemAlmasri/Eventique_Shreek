import 'package:flutter/material.dart';
import 'package:eventique_company_app/models/user_model.dart';

class UsersProvider with ChangeNotifier {
  List<OneUser> users = [
    OneUser(
      id: 0,
      name: 'taghreed',
      email: 'taghreedswidah9@gmail.com',
      imageUrl: '',
    ),
    OneUser(
      id: 1,
      name: 'tasneem',
      email: 'tasneem.masri@gmail.com',
      imageUrl: '',
    )
  ];

  List<OneUser> get usersList {
    return [...users];
  }

  OneUser findById(int id) {
    return users.firstWhere((vendor) => vendor.id == id);
  }
}
