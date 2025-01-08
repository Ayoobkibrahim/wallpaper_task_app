// services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:walpapper_task_app/feature/model/photo_model.dart';

class ApiService {
  static const String baseUrl = 'https://api.unsplash.com';
  static const String apiKey = 'YOUR_UNSPLASH_ACCESS_KEY';

  Future<List<PhotoModel>> fetchPhotos({int page = 1, int perPage = 20}) async {
    final url = Uri.parse('$baseUrl/photos?page=$page&per_page=$perPage&order_by=popular');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Client-ID $apiKey',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((json) => PhotoModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }
}
