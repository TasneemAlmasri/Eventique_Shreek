import 'dart:convert';

import 'package:eventique_shreek/core/resources/color.dart';
import 'package:eventique_shreek/main.dart';
import 'package:eventique_shreek/models/service_in_order_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Orders with ChangeNotifier{
  Orders(){

  }

  final OrdersService _ordersService=OrdersService();

  List<ServiceInOrderDetails> _orders=[];
  List<ServiceInOrderDetails> _pendingOrders=[];
  List<ServiceInOrderDetails> _processdOrders=[];

  List<ServiceInOrderDetails>get orders=>[..._orders];
  List<ServiceInOrderDetails>get pendingOrders=>[..._pendingOrders];
  List<ServiceInOrderDetails>get proccecdOrders=>[..._processdOrders];

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

  void acceptService(){
    // _ordersService.acceptService(token);
  }

  void rejectService(){
    // _ordersService.rejectService(token);
  }
}


//..............http.......................
class OrdersService{
  Future<List<ServiceInOrderDetails>> fetchPendingOrders(String token) async {
    final String apiUrl ='$host/api/events';
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
        return 
        ServiceInOrderDetails(
          dueDate:date ,
          imgUrl:  e['id'],
          isCustomized:  e['id'],
          name: e['id'] ,
          orderServiceId: e['id'] ,
          orederdBy: e['id'] ,
          quantity:  e['id'],
          status:  e['id'],
          totalPrice:  e['id'],
        );}).toList();
    } else {
      print(response.body);
      throw Exception('Failed showEventttttttt');
    }
  }

  Future<List<ServiceInOrderDetails>> fetchProcessedOrders(String token) async {
    final String apiUrl ='$host/api/events';
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
        return 
        ServiceInOrderDetails(
          dueDate:date ,
          imgUrl:  e['id'],
          isCustomized:  e['id'],
          name: e['id'] ,
          orderServiceId: e['id'] ,
          orederdBy: e['id'] ,
          quantity:  e['id'],
          status:  e['id'],
          totalPrice:  e['id'],
        );}).toList();
    } else {
      print(response.body);
      throw Exception('Failed showEventttttttt');
    }
  }
}