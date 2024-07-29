import 'package:eventique_shreek/core/resources/color.dart';
import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  const Description(
      {super.key, required this.description, required this.price});
  final String description;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Text(
              'Price',
              style: TextStyle(
                  color: Color.fromARGB(255, 226, 147, 168),
                  fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Text(
              '\$$price',
              style: TextStyle(
                  color: primary, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            Spacer(),
            SizedBox(),
          ]),
          SizedBox(
            height: 8,
          ),
          Text(
            'Description',
            style: TextStyle(
                color: Color.fromARGB(255, 226, 147, 168),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 8,
          ),
          Text(description,
              style: TextStyle(color: primary, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
