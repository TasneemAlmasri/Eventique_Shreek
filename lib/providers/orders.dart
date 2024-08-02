import 'dart:convert';

import '/color.dart';
import '/main.dart';
import '/models/service_in_order_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Orders with ChangeNotifier {
  final String token;
  Orders(this.token) {}

  final OrdersService _ordersService = OrdersService();

  List<ServiceInOrderDetails> _orders = [];
  List<ServiceInOrderDetails> _pendingOrders = [];
  List<ServiceInOrderDetails> _processdOrders = [];

  List<ServiceInOrderDetails> get orders => [..._orders];
  List<ServiceInOrderDetails> get pendingOrders => [..._pendingOrders];
  List<ServiceInOrderDetails> get proccecdOrders => [..._processdOrders];

  Future<void> fetchPendingOrders() async {
    final fetchedOrders = await _ordersService.fetchPendingOrders(token);
    _pendingOrders = fetchedOrders;
    notifyListeners();
  }

  Future<void> fetchProcessedOrders() async {
    final fetchedOrders = await _ordersService.fetchProcessedOrders(token);
    _processdOrders = fetchedOrders;
    notifyListeners();
  }

  Future<void> acceptService() async {
    _ordersService.acceptService(token);
  }

  Future<void> rejectService() async {
    _ordersService.rejectService(token);
  }
}

//..............http.......................
class OrdersService {
  Future<List<ServiceInOrderDetails>> fetchPendingOrders(String token) async {
    final String apiUrl = '$host/api/events';
    print('I am in fetchPendingOrderssssssss ');

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Accept': 'application/json',
        'locale': 'ar',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      print('Successfully fetched pending orders');
      final data = jsonDecode(response.body);
      final events = data['data'] as List;
      return events.map((e) {
        final date = DateTime.parse(e['date']);
        return ServiceInOrderDetails(
          dueDate: date,
          imgUrl: e['id'],
          isCustomized: e['id'],
          name: e['id'],
          orderServiceId: e['id'],
          orederdBy: e['id'],
          quantity: e['id'],
          status: e['id'],
          totalPrice: e['id'],
        );
      }).toList();
    } else {
      print(response.body);
      throw Exception('Failed showEventttttttt');
    }
  }

  Future<List<ServiceInOrderDetails>> fetchProcessedOrders(String token) async {
    final String apiUrl = '$host/api/events';
    print('I am in fetchProcessedOrdersssssss ');

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Accept': 'application/json',
        'locale': 'ar',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      print('Successfully fetched processed orders');
      final data = jsonDecode(response.body);
      final events = data['data'] as List;
      return events.map((e) {
        final date = DateTime.parse(e['date']);
        return ServiceInOrderDetails(
          dueDate: date,
          imgUrl: e['id'],
          isCustomized: e['id'],
          name: e['id'],
          orderServiceId: e['id'],
          orederdBy: e['id'],
          quantity: e['id'],
          status: e['id'],
          totalPrice: e['id'],
        );
      }).toList();
    } else {
      print(response.body);
      throw Exception('Failed');
    }
  }

   void acceptService(String token) async {
    final String apiUrl = '$host/api/events';
    print('I am in acceptService ');

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Accept': 'application/json',
        'locale': 'ar',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      print('Successfully acceptService');
     }else {
      print(response.body);
      throw Exception('Failed');
    }
  }

  void rejectService(String token) async {
    final String apiUrl = '$host/api/events';
    print('I am in rejectService ');

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Accept': 'application/json',
        'locale': 'ar',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      print('Successfully rejectService');
     }else {
      print(response.body);
      throw Exception('Failed');
    }
  }

}
