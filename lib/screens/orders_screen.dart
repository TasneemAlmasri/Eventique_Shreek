import '/color.dart';
import '/models/service_in_order_details.dart';
import '/providers/orders.dart';
import '/widgets/order_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final List<ServiceInOrderDetails> orders = [
  // ServiceInOrderDetails(
  //     dueDate: DateTime.now(),
  //     imgUrl: 'dd',
  //     isCustomized: 1,
  //     name: 'test',
  //     orderServiceId: 1,
  //     orederdBy: 'lala',
  //     quantity: 43,
  //     status: 'pending',
  //     totalPrice: 53),
  // ServiceInOrderDetails(
  //     dueDate: DateTime.now(),
  //     imgUrl: 'ss',
  //     isCustomized: 0,
  //     name: 'rse',
  //     orderServiceId: 2,
  //     orederdBy: 'lalalo',
  //     quantity: 43,
  //     status: 'pending',
  //     totalPrice: 53),
];

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<Orders>(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: beige,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              backgroundColor: const Color(0xFFFFFDF0),
              // shadowColor: Color(0xFFFFFDF0),
              surfaceTintColor: const Color(0xFFFFFDF0),
              elevation: 0,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: Container(
                  padding: EdgeInsets.all(6),
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  decoration: BoxDecoration(
                    color: const Color(0xffEFEEEA),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TabBar(
                    dividerColor: const Color(0xffEFEEEA),
                    labelColor: primary,
                    unselectedLabelColor: const Color(0xffE791A5),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color(0xFFFFFDF0),
                    ),
                    tabs: const [
                      Tab(
                        child: Text(
                          'Pending',
                          style: TextStyle(
                              fontFamily: 'IrishGrover', fontSize: 20),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Processed',
                          style: TextStyle(
                              fontFamily: 'IrishGrover', fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                children: [
                  buildOrderList(
                      // orderProvider.pendingOrders
                      orders,
                      context,
                      null),
                  buildOrderList(
                      // orderProvider.proccecdOrders
                      orders,
                      context,
                      1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOrderList(List<ServiceInOrderDetails> orders,
      BuildContext context, int? fromProcessed) {
    return orders.isEmpty
        ? Center(
            child: Text(
              'No Orders Yet',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontFamily: 'IrishGrover',
                    fontSize: 22,
                    color: const Color.fromARGB(255, 227, 181, 193),
                  ),
            ),
          )
        : ListView.builder(
            padding: EdgeInsets.fromLTRB(18, 0, 18, 40),
            itemCount: orders.length,
            itemBuilder: (ctx, i) {
              return OrderTile(
                fromProcessed: fromProcessed,
                dueDate: orders[i].dueDate,
                // isCustomized: orders[i].isCustomized,
                // customDescription: ,
                orderedBy: orders[i].orederdBy,
                quantity: orders[i].quantity,
                serviceName: orders[i].name,
                totalPrice: orders[i].totalPrice,
                url: orders[i].imgUrl,
              );
            },
          );
  }
}
