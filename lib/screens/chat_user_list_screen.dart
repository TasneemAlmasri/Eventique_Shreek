//taghreed
import '/color.dart';
import '/providers/theme_provider.dart';
import 'package:eventique_company_app/providers/users_provider.dart';
import '/widgets/chat/chat_list_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatUsersListScreen extends StatefulWidget {
  static const routeName = '/users-list';

  @override
  State<ChatUsersListScreen> createState() => _ChatUsersListScreenState();
}

class _ChatUsersListScreenState extends State<ChatUsersListScreen> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    var sysBrightness = MediaQuery.of(context).platformBrightness;
    ThemeMode? themeMode = themeProvider.getThemeMode();
    bool isLight = themeMode == ThemeMode.light ||
        (sysBrightness == Brightness.light && themeMode != ThemeMode.dark);
    final userData = Provider.of<UsersProvider>(context, listen: false).users;
    return Scaffold(
        backgroundColor: isLight ? white : darkBackground,
        body: ListView.builder(
          itemBuilder: (ctx, i) => ChatListItem(
            name: userData[i].name!,
            userId: userData[i].id!,
            imageUrl: userData[i].imageUrl!,
          ),
          itemCount: userData.length,
        ));
  }
}
