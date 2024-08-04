import 'dart:convert';
import 'package:eventique_company_app/main.dart';
import 'package:eventique_company_app/models/one_review.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';


class Reviews with ChangeNotifier {
  final String token;
  Reviews(this.token);
  ReviewsService reviewsService=ReviewsService();
  PdfService pdfService=PdfService();

  final Map<int, List<OneReview>> _reviewsForServiceMap = {};


  Future<void> getReviewsForService(int serviceId) async {
    final reviews = await reviewsService.fetchReviews(token, serviceId);
    _reviewsForServiceMap[serviceId] = reviews;
    notifyListeners();
  }

   List<OneReview> reviewsForService(int serviceId) {
    return _reviewsForServiceMap[serviceId] ?? [];
  }

  Future<void> downloadPdf(String fileName) async {
    pdfService.downloadPdf(fileName,token);
  }


}


class ReviewsService{
final String apiUrl = '$host/api/reviews';

  Future<List<OneReview>> fetchReviews(String token,int serviceId) async {
    print('I am in fetchReviewsssssssssss ');
    final String apiUrl = '$host/api/reviews/$serviceId';

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Accept': 'application/json',
        'locale': 'ar',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      print('Successfully fetchReviewsssssssssss');
      final data = jsonDecode(response.body);
      final events = data['users'] as List;

      return events.map((e) {

        return OneReview(
          personName:e['name'] ,
          theComment:e['description']??'' ,
          rating: (e['rate'] as num).toDouble(),  // Convert rate to double
          imgurl: e['images'].isNotEmpty ? e['images'][0] : '',
          personId:e['user_id'] ,
        );
      }).toList();
    } else {
      print(response.body);
      throw Exception('Failed fetchReviewsssssssssss');
    }
  }

}

class PdfService{
  
Future<void> downloadPdf(String url, String fileName) async {
  // Request storage permissions
  if (await Permission.storage.request().isGranted) {
    try {
      // Make HTTP GET request
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Get the external storage directory to save the PDF file
        final directory = await getExternalStorageDirectory();
        final filePath = '${directory!.path}/$fileName';

        // Write the response body to a file
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        print('PDF saved to $filePath');

        // Open the PDF file
        // openPdf(filePath);
      } else {
        print('Failed to download PDF: ${response.statusCode}');
      }
    } catch (e) {
      print('Error downloading PDF: $e');
    }
  } else {
    print('Storage permission denied');
  }
  
}
}