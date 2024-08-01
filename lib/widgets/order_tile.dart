import 'package:cached_network_image/cached_network_image.dart';
import '/color.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  OrderTile(
      {super.key,
      this.fromProcessed,
      required this.serviceName,
      required this.orderedBy,
      required this.quantity,
      required this.dueDate,
      required this.isCustomized,
      required this.totalPrice,
      required this.url});
  final String serviceName, orderedBy;
  final int quantity;
  int? fromProcessed;
  final DateTime dueDate;
  final int isCustomized;
  final double totalPrice;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Color(0xff662465), width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.fromLTRB(0, 14, 0, 8),
      color: const Color(0xFFFFFDF0),
      elevation: 0,
      child: GestureDetector(
        // borderRadius: BorderRadius.circular(20),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: url,
                  height: MediaQuery.of(context).size.width * 0.2545,
                  width: MediaQuery.of(context).size.width * 0.2,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: const Color.fromARGB(255, 230, 230, 230),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: const Color.fromARGB(255, 230, 230, 230),
                  ),
                ),
              ),
              // All texts
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isCustomized == 0
                            ? serviceName
                            : '$serviceName (customized)',
                        softWrap: false,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: primary,
                          // fontFamily: 'IrishGrover',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Ordered by: $orderedBy',
                        softWrap: false,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: primary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        // 'due: $orderedBy',
                        'due:${dueDate.toLocal()}'.split(' ')[0],
                        softWrap: false,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: primary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            'Quantity: $quantity',
                            softWrap: false,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: primary,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Text(
                            'Price: $totalPrice\$',
                            softWrap: false,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: primary,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                        ],
                      ),
                      fromProcessed == null
                          ? Row(
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Accept',
                                    style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 56, 134, 59),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Reject',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 254, 162, 150),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Spacer(),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
