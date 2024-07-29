import 'package:eventique_shreek/core/resources/color.dart';
import 'package:flutter/material.dart';

class CreateService extends StatefulWidget {
  const CreateService({super.key});

  @override
  State<CreateService> createState() => _CreateServiceState();
}

class _CreateServiceState extends State<CreateService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: beige,
      appBar: AppBar(
        backgroundColor: beige,
        title: Text(
          "Create new service",
          style: TextStyle(
              fontSize: 22.0,
              fontFamily: 'IrishGrover',
              color: primary),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Container(
            height: 4.0,
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: primary,
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('ImagePicker'),
          ],
        ),
      ),
    );
  }
}
