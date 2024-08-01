import '/widgets/description.dart';
import '/widgets/reviews_grid.dart';
import 'package:flutter/material.dart';

class MyTabBarView extends StatelessWidget {
  const MyTabBarView({
    super.key,
    required this.tabController,
    required this.serviceId,
    required this.description,
    required this.vendorname,
    required this.serviceCategory,
    required this.serviceRating,
    required this.price,
  });
  final TabController tabController;
  final int serviceId;
  final String description;
  final String vendorname, serviceCategory;
  final double serviceRating, price;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: [
        // Tab 1 content
        ListView(
          padding: EdgeInsets.all(0),
          children: [
            Description(
              description: description,
              price: price,
            ),
          ],
        ),
        // Tab 2 content
        ReviewsGrid(serviceId: serviceId, serviceRating: serviceRating),
      ],
    );
  }
}
