import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventique_company_app/color.dart';
import 'package:eventique_company_app/models/one_service.dart';
import 'package:eventique_company_app/providers/services_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateCustomizedService extends StatefulWidget {
  final int userId;
  CreateCustomizedService(this.userId);

  @override
  State<CreateCustomizedService> createState() =>
      _CreateCustomizedServiceState();
}

class _CreateCustomizedServiceState extends State<CreateCustomizedService> {
  final _formKey = GlobalKey<FormState>();
  OneService _selectedService = OneService();
  String _newDescription = '';
  double _newPrice = 0.0;

  void _saveCustomizedService() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final user = FirebaseAuth.instance.currentUser;
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();
      final vendorId = widget.userId;

      if (user != null) {
        FirebaseFirestore.instance.collection('customized_services').add({
          'service': _selectedService.name,
          'description': _newDescription,
          'price': _newPrice,
          'userId': user.uid,
          'vendorId': vendorId,
          'createdAt': Timestamp.now(),
        });

        FirebaseFirestore.instance.collection('chat').add({
          'text': 'Customized Service: ${_selectedService.name}',
          'service': _selectedService.name,
          'description': _newDescription,
          'price': _newPrice,
          'userId': user.uid,
          'userName': userData['username'],
          'userImage': userData['image_url'],
          'vendorId': vendorId,
          'createdAt': Timestamp.now(),
          'type': 'service'
        });
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<OneService> _services = Provider.of<AllServices>(context).allServices;
    return AlertDialog(
      backgroundColor: white,
      surfaceTintColor: white,
      content: SingleChildScrollView(
        child: Container(
          width: size.width * 0.8,
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Create customized service',
                  style: TextStyle(
                    fontFamily: 'IrishGrover',
                    fontSize: 22,
                    color: primary,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'User Customization',
                    style: TextStyle(
                      fontFamily: 'CENSCBK',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(87, 14, 87, 1),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                SingleChildScrollView(
                  child: SizedBox(
                    width: size.width * 0.7,
                    child: TextFormField(
                      key: ValueKey('description'),
                      keyboardType: TextInputType.text,
                      maxLines: 3,
                      validator: (description) {
                        if (description!.isEmpty) {
                          return 'This field is required';
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(15),
                        hintText: 'Description ...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onSaved: (description) {
                        _newDescription = description!;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'New price',
                    style: TextStyle(
                      fontFamily: 'CENSCBK',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(87, 14, 87, 1),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                SizedBox(
                  width: size.width * 0.7,
                  child: TextFormField(
                    key: ValueKey('price'),
                    keyboardType: TextInputType.number,
                    validator: (price) {
                      if (price!.isEmpty) {
                        return 'This field is required';
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(15),
                      hintText: 'Enter the new price...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onSaved: (price) {
                      _newPrice = double.parse(price!);
                    },
                  ),
                ),
                // SizedBox(
                //   height: size.height * 0.02,
                // ),
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: IconButton(
                //     onPressed: () {
                //       //if the field are empty will occured an error
                //     },
                //     icon: Icon(
                //       Icons.send,
                //     ),
                //     color: primary,
                //     iconSize: 30,
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('send'),
          onPressed: () {
            _saveCustomizedService();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}