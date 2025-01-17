import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:eventique_shreek/core/resources/color.dart';
import 'package:eventique_shreek/pages/chatScreen.dart';
import 'package:eventique_shreek/pages/orders_screen.dart';
import 'package:eventique_shreek/pages/statistics.dart';
import 'package:eventique_shreek/pages/vendors_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:typicons_flutter/typicons_flutter.dart';

class NavigationBarPage extends StatefulWidget {
  const NavigationBarPage({super.key});

  @override
  State<NavigationBarPage> createState() => _NavigationBarPageState();
}

class _NavigationBarPageState extends State<NavigationBarPage> {
  List Screen = [
    VendorsScreen(),
    Statistics(),
    OrdersScreen(),
    ChatScreen(),
  ];

  int _selctedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: beige,
        shadowColor: beige,
        backgroundColor: beige,
        actions: [
          //notifivation icon
          Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFFFFDF0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(
                Icons.notifications_none_rounded,
                color: Color(0xff662465),
              ),
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: ((context) => const NotificatioPage())));
              },
              padding: const EdgeInsets.only(bottom: 2),
            ),
          ),
        ],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              padding: const EdgeInsets.only(left: 30),
              icon: const Icon(
                Typicons.th_menu_outline,
                color: Color(0xffDD8CA1),
                size: 28,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      drawer: const Drawer(),
      backgroundColor: beige,
      bottomNavigationBar: CurvedNavigationBar(
        index: _selctedIndex,
        backgroundColor: beige,
        buttonBackgroundColor: primary,
        color: primary,
        animationDuration: Duration(milliseconds: 300),
        items: [
          CurvedNavigationBarItem(
              child: Icon(
                Icons.storefront,
                color: beige,
              ),
              label: 'Services',
              labelStyle: TextStyle(color: beige, fontSize: 12)),
          CurvedNavigationBarItem(
              child: Icon(
                Icons.show_chart,
                color: beige,
              ),
              label: 'Statistics',
              labelStyle: TextStyle(color: beige, fontSize: 12)),
          CurvedNavigationBarItem(
              child: Icon(
                Icons.list,
                color: beige,
              ),
              label: 'Orders',
              labelStyle: TextStyle(color: beige, fontSize: 12)),
          CurvedNavigationBarItem(
              child: FaIcon(
                FontAwesomeIcons.comment,
                color: beige,
              ),
              label: 'Chat',
              labelStyle: TextStyle(color: beige, fontSize: 12))
        ],
        onTap: (index) {
          setState(() {
            _selctedIndex = index;
          });
        },
      ),
      body: Screen[_selctedIndex],
    );
  }
}
