import 'dart:convert';

import 'package:eventique_company_app/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StatisticsProvider with ChangeNotifier {
  final String token;
  final int id;
  StatisticsProvider(this.token, this.id);
  int _amount = 100000000;
  var _statistics = {
    'customers': '1507',
    'services': '105',
    'rating': '4.5',
    'revenue': '1040'
  };

  Map<String, String> get statistics {
    return {..._statistics};
  }

  Future<void> getStatistics(DateTime date) async {
    final url = Uri.parse('$host/api/companies/update');
    print(url);
    try {
      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'locale': 'en'
        },
      );

      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['Status'] == 'Failed') {
        throw Exception(responseData['Error']);
      }

      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  int get walletAmount {
    return _amount;
  }

  Future<void> getWalletAmount() async {
    final url = Uri.parse('$host/api/companies/companyWallet');
    print(url);
    print(token);
    print(id);
    try {
      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      final responseData = json.decode(response.body);
      print(responseData);
      _amount = responseData['amount'];
      print(_amount);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
